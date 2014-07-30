/*
 * Par_Walking.cpp
 *
 * Created: 09/02/2014 17:57:33
 *  Author: Jose Victor
 */ 

#ifndef F_CPU
#define F_CPU 16000000UL
#endif

//#include <avr/io.h>

//******Librerias generales (cpp)
#include <avr/interrupt.h>
#include <util/delay.h>
#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <stdint.h>
#include <avr/eeprom.h>

//******Librerias dynamixel
#include "serial.h"
#include "dynamixel.h"
#include "zigbee.h"

//******Constantes
#define PI	3.141592f

//**Direcciones de la tabla de los dinamixels
#define P_TORQUE_ENABLE   		24
#define P_GOAL_POSITION_L		30
#define P_GOAL_POSITION_H		31
#define P_GOAL_SPEED_L			32
#define P_GOAL_SPEED_H			33
#define P_PRESENT_POSITION_L	36
#define P_PRESENT_POSITION_H	37
#define P_PRESENT_LOAD_L		40

// Velociidad de conexión con los dynamixels
#define DEFAULT_BAUDNUM		1 // 1Mbps
#define NUM_ACTUATOR		20 // Number of actuator

//funciones constantes para setear y limpiar un bit
#define cbi(REG8,BitNum) REG8 &= ~(_BV(BitNum)) //Limpia (=0) un bit de un registro de 8
#define sbi(REG8,BitNum) REG8 |= _BV(BitNum)	//Pone   (=1) un bit de un registro de 8

//***************************************
//Interrupciones para los timers
volatile unsigned long l_Timer=0;
ISR( TIMER1_COMPA_vect) { 
   // toggle led here 
   l_Timer++;
}

//***************************************
//Pre-Declaración de Funciones propias (metodos)
void InitTimer(void);

//Misc
void Flash_Led(int Veces);

//Comunicación
void EntraOpcion(void);
int Recibe1Dato(void);
void Envia1Dato(int Dato);
void RcvPrms(int Clave);
void SndPrms(int Clave);
void SND_Data(float t);

//Kinematics
void LP_IK(float rLA_Pelvis[3], float RotPelvis[9], int ThLLeg[6]);
void RP_IK(float rLA_Pelvis[3], float RotPelvis[9], int ThLLeg[6]);
void R2ths_CadD(float Rot[9], float ths[3]);
void R2ths_CadI(float Rot[9], float ths[3]);

//Rotations
void EulXZY_2_Rot(float Pi, float Ro, float Ya, float Rot[9]);

//Movimientos
void Ir_CP(float Pos[3], int Pitch);
void MoverPelvisYPieDerecho(void);
void MoverPelvisYPieIzquierdo(void);
void Zancada(int Tipo);
void MarchaDerecha(void);
void MarchaIzquierda(void);

//Cicloidales
float Cicloidal_1(float A,float T, float t);
float Cicloidal_2(float A,float T, float t);
float Cicloidal_3(float A,float T, float t);
float Cicloidal_4(float A,float T, float t);
float Cicloidal_5(float A,float T, float t);

//Mats
void V1mV2(float vec1[3], float vec2[3], float Res[3]);
void M_V(float Mat[9], float Vec[3], float VecSal[3]);
void Mat3_Multiply(float Mat_IN1[9], float Mat_IN2[9], float R[9]);
void Mat3_Traspose(float Mat_IN[9], float Mat_OUT[9]);
float Deg2Rad(int Angle);

//Robot
void a_m_on(void);
void a_m_off(void);
void MoveLegTime(int ThLeg[6], float Time, int Tipo);
void getThLeg(int ThLeg[6], int Tipo);
void MoveArmTime(int ThArm[3], float Time, int Tipo);
void getThArm(int ThArm[3], int Tipo);
void MoveLegVel(int ThLeg[6], int Vel, int Tipo);
void MoveArmVel(int ThArm[3], int Vel, int Tipo);
void MoveLeg(int ThLeg[6], int Tipo);

//***************************************
//Variables Globales

//Angulos de las piernas
int g_thRLeg[6];
int g_thLLeg[6];

//Angulos de los brazos
int g_thRArm[3];
int g_thLArm[3];

//Parametors principales
int g_Values_1_Int[12];
float g_Values_1_Flt[6];

//Parametors RRobot
int g_Values_2_Int[22];
float g_Values_2_Flt[6];

//Parametors Primer Paso
int g_Values_3_Int[26];
float g_Values_3_Flt[3];

//Posición cartesiana de la Pelvis, pie izquierdo y pie derecho
float g_LF_Pos[3];
int g_LF_Ori[3];
float g_RF_Pos[3];
int g_RF_Ori[3];
float g_P_Pos[3];
int g_P_Ori[3];

int g_Sens;

int g_Index_Step;

int main(void)
{
	zgb_initialize(0);
	dxl_initialize( 0, DEFAULT_BAUDNUM ); //Comunicacion con dynamixels
	sei();
	InitTimer();
		
    while(1)
    {
        EntraOpcion();
    }
}

void InitTimer(void)
{
	cbi(PRR0,PRTIM1);	//Enable Timer/Counter1 (TC1)

	cbi(TCCR1B,WGM13);	//CTC Mode
	sbi(TCCR1B,WGM12);
	cbi(TCCR1A,WGM11);
	cbi(TCCR1A,WGM10);

	cbi(TCCR1B,CS12);		//
	sbi(TCCR1B,CS11);		//N=64 Prescaler (CS12:0 = 3)
	sbi(TCCR1B,CS10);

	cbi(TCCR1B,ICNC1);	//Disable Noise Cancel (Not using imput compare)
	cbi(TCCR1B,ICES1);	//Detect Falling Edge

	cbi(TCCR1A,COM1A1);	//Disconnect Output Compare Pin OCnX (Normal Port operation)
	cbi(TCCR1A,COM1A0);

	cbi(TCCR1C,FOC1A);	//Not force output compare

	TCNT1=0x0000;				//Inicializa el Registro TCnt1

	OCR1A=249;		//F_OC1A = 1KHz  OCRnA=[16MHz/(N*1KHz)]-1

	sbi(TIMSK1,OCIE1A);	//Enable Interrupt when TCNT1A = OCF1A
}

void EntraOpcion()
{
	int Int_Opcion;
	char Opcion;
	
	Int_Opcion=Recibe1Dato();
	Opcion = Int_Opcion;
	
	int Clave;
	switch (Opcion)
	{
		case 's':
		Clave=Recibe1Dato();
		RcvPrms(Clave);
		break;
		case 'g':
		Clave=Recibe1Dato();
		SndPrms(Clave);
		break;
		case 'w':
		//EscribeEnEEPROM(Int_VarsWalk, Float_VarsWalk);
		break;
		case 'r':
		//LeeDeEEPROM(Int_VarsWalkOut, Float_VarsWalkOut);
		break;
		case '0':
			float Pos[3];
			int Pitch;
			Pos[0]=0.0;
			Pos[1]=0.0;
			Pos[2]=10.0;
			Pitch = 15;
			Ir_CP(Pos, Pitch);
			_delay_ms(2500);
			a_m_off();
		break;
		case '1':
			Pos[0]=g_Values_1_Flt[0];
			Pos[1]=0.0;
			Pos[2]=g_Values_1_Flt[1];
			Pitch = g_Values_1_Int[1];
			Ir_CP(Pos, Pitch);
		break;
		case '2':
		g_Sens=Recibe1Dato();
		if (g_Values_1_Int[0] > 1)
		{
			MarchaIzquierda();
		}
		break;
		case '3':
		g_Sens=Recibe1Dato();
		if (g_Values_1_Int[0] > 1 )
		{
			MarchaDerecha();
		}
		break;
	}
}


void Ir_CP(float Pos[3], int Pitch)
{
	float XPelvisD[6];
	XPelvisD[0]=Pos[0];
	XPelvisD[1]=Pos[1];
	XPelvisD[2]=Pos[2];
	XPelvisD[3]=Deg2Rad(0);
	XPelvisD[4]=Deg2Rad(Pitch);
	XPelvisD[5]=Deg2Rad(0);

	float RotPelvisD[9];
	EulXZY_2_Rot(XPelvisD[4],XPelvisD[3],XPelvisD[5], RotPelvisD);

	float rCenterPelvis[3];
	rCenterPelvis[0]=XPelvisD[1];
	rCenterPelvis[1]=XPelvisD[2];
	rCenterPelvis[2]=XPelvisD[0];

	//Right Leg
	float rCenterRA[3];
	rCenterRA[0]=-3.85+g_Values_2_Flt[4];
	rCenterRA[1]=0.0+g_Values_2_Flt[5];
	rCenterRA[2]=0.0+g_Values_2_Flt[3];

	float rRA_PelvisD[3];
	V1mV2(rCenterPelvis, rCenterRA, rRA_PelvisD);

	int ThRLeg[6];
	RP_IK(rRA_PelvisD,RotPelvisD,ThRLeg);

	//Left Leg
	float rCenterLA[3];
	rCenterLA[0]=3.85+g_Values_2_Flt[1];
	rCenterLA[1]=0.0+g_Values_2_Flt[2];
	rCenterLA[2]=0.0+g_Values_2_Flt[0];

	float rLA_PelvisD[3];
	V1mV2(rCenterPelvis, rCenterLA, rLA_PelvisD);

	int ThLLeg[6];
	LP_IK(rLA_PelvisD,RotPelvisD,ThLLeg);

	int ThLArm[3];
	int ThRArm[3];
	ThRArm[0]=-90+g_Values_1_Int[4];
	ThRArm[1]=-g_Values_1_Int[5];
	ThRArm[2]=-g_Values_1_Int[6];
	
	ThLArm[0]=90-g_Values_1_Int[4];
	ThLArm[1]=g_Values_1_Int[5];
	ThLArm[2]=g_Values_1_Int[6];
		
	a_m_on();																			//Activa los torques de todos los motores	
	_delay_ms(5);																				//Delay de 5ms
	
	int Vel;
	Vel=200;
	float T;
	T=2;
	/*
	MoveLegVel(ThRLeg, Vel, 1);														//Mover la pierna deracha
	MoveLegVel(ThLLeg, Vel, 2);														//Mover la pierna izquierda
	MoveArmVel(ThRArm, Vel, 1);														//Mover la brazo derecho
	MoveArmVel(ThLArm, Vel, 2);														//Mover la brazo izquierdo
	*/
	MoveLegTime(ThRLeg, T, 1);														//Mover la pierna deracha
	MoveLegTime(ThLLeg, T, 2);														//Mover la pierna izquierda
	MoveArmTime(ThRArm, T, 1);														//Mover la brazo derecho
	MoveArmTime(ThLArm, T, 2);														//Mover la brazo izquierdo
}

void EulXZY_2_Rot(float Pi, float Ro, float Ya, float Rot[9])
{
	Rot[0]=cos(Ro)*cos(Ya);
	Rot[1]=-sin(Ro);
	Rot[2]=cos(Ro)*sin(Ya);
	Rot[3]=sin(Pi)*sin(Ya) + cos(Pi)*cos(Ya)*sin(Ro);
	Rot[4]=cos(Pi)*cos(Ro);
	Rot[5]=cos(Pi)*sin(Ro)*sin(Ya) - cos(Ya)*sin(Pi);
	Rot[6]=cos(Ya)*sin(Pi)*sin(Ro) - cos(Pi)*sin(Ya);
	Rot[7]=cos(Ro)*sin(Pi);
	Rot[8]=cos(Pi)*cos(Ya) + sin(Pi)*sin(Ro)*sin(Ya);
}

void V1mV2(float vec1[3], float vec2[3], float Res[3])
{
	Res[0]=vec1[0]-vec2[0];
	Res[1]=vec1[1]-vec2[1];
	Res[2]=vec1[2]-vec2[2];
}

void M_V(float Mat[9], float Vec[3], float VecSal[3])
{
	VecSal[0]=Mat[0]*Vec[0] +Mat[1]*Vec[1] +Mat[2]*Vec[2];
	VecSal[1]=Mat[3]*Vec[0] +Mat[4]*Vec[1] +Mat[5]*Vec[2];
	VecSal[2]=Mat[6]*Vec[0] +Mat[7]*Vec[1] +Mat[8]*Vec[2];
}

void LP_IK(float rLA_Pelvis[3], float RotPelvis[9], int ThLLeg[6])
{
	float L1=31.0/10;
	float L5=77.0/10;
	float L7=75.0/10;
	float L8=14.5/10;
	float Lb=hypot(L7,L8);

	float rLHipPelvis[3];
	rLHipPelvis[0]=-L5/2;
	rLHipPelvis[1]=L1;
	rLHipPelvis[2]=0.0;

	float World_rLHipPel[3];
	M_V(RotPelvis, rLHipPelvis, World_rLHipPel);

	float rLA_RHip[3];
	V1mV2(rLA_Pelvis, World_rLHipPel, rLA_RHip);

	float LHipX,LHipY,LHipZ;			//Posición Cartesiana (cm)
	LHipX=rLA_RHip[2];	//Desired Hip Position X
	LHipY=rLA_RHip[0];	//Desired Hip Position Y
	LHipZ=rLA_RHip[1];	//Desired Hip Position Z
	
	float y1=LHipY;
	float x1=LHipX;
	float z1=LHipZ;

	float th18=-atan2(y1,z1);
	
	float l=sqrt(x1*x1+y1*y1+z1*z1);
	float cosG=-(l*l-2*Lb*Lb)/(2*Lb*Lb);
	float sinG=sqrt(1-cosG*cosG);
	float G=PI-atan2(sinG,cosG);
	float a0=atan2(L8,L7);

	float th14=(G+2*a0);

	float cosa1=(y1*y1+z1*z1)/(sqrt(y1*y1+z1*z1)*l);
	float sina1=sqrt(1-cosa1*cosa1);
	float pmOne=1;
	float signx1=copysign(pmOne,x1);
	float a1=-signx1*atan2(sina1,cosa1);
	float a2=(G)/2;
	float th16=a1-a2-a0;
	
	float LAnkle_R_LHip[9];
	
	LAnkle_R_LHip[0]=sin(th14 + th16)*sin(th18);
	LAnkle_R_LHip[1]=cos(th18);
	LAnkle_R_LHip[2]=cos(th14 + th16)*sin(th18);
	LAnkle_R_LHip[3]=-sin(th14 + th16)*cos(th18);
	LAnkle_R_LHip[4]=sin(th18);
	LAnkle_R_LHip[5]=-cos(th14 + th16)*cos(th18);
	LAnkle_R_LHip[6]=-cos(th14 + th16);
	LAnkle_R_LHip[7]=0.0;
	LAnkle_R_LHip[8]=sin(th14 + th16);

	float LAnkle_R_LHip_T[9];
	LAnkle_R_LHip_T[0]=LAnkle_R_LHip[0];
	LAnkle_R_LHip_T[1]=LAnkle_R_LHip[3];
	LAnkle_R_LHip_T[2]=LAnkle_R_LHip[6];
	LAnkle_R_LHip_T[3]=LAnkle_R_LHip[1];
	LAnkle_R_LHip_T[4]=LAnkle_R_LHip[4];
	LAnkle_R_LHip_T[5]=LAnkle_R_LHip[7];
	LAnkle_R_LHip_T[6]=LAnkle_R_LHip[2];
	LAnkle_R_LHip_T[7]=LAnkle_R_LHip[5];
	LAnkle_R_LHip_T[8]=LAnkle_R_LHip[8];
	
	float R[9];
	R[0]=LAnkle_R_LHip_T[0]*RotPelvis[0] +LAnkle_R_LHip_T[1]*RotPelvis[3] +LAnkle_R_LHip_T[2]*RotPelvis[6];
	R[1]=LAnkle_R_LHip_T[0]*RotPelvis[1] +LAnkle_R_LHip_T[1]*RotPelvis[4] +LAnkle_R_LHip_T[2]*RotPelvis[7];
	R[2]=LAnkle_R_LHip_T[0]*RotPelvis[2] +LAnkle_R_LHip_T[1]*RotPelvis[5] +LAnkle_R_LHip_T[2]*RotPelvis[8];
	R[3]=LAnkle_R_LHip_T[3]*RotPelvis[0] +LAnkle_R_LHip_T[4]*RotPelvis[3] +LAnkle_R_LHip_T[5]*RotPelvis[6];
	R[4]=LAnkle_R_LHip_T[3]*RotPelvis[1] +LAnkle_R_LHip_T[4]*RotPelvis[4] +LAnkle_R_LHip_T[5]*RotPelvis[7];
	R[5]=LAnkle_R_LHip_T[3]*RotPelvis[2] +LAnkle_R_LHip_T[4]*RotPelvis[5] +LAnkle_R_LHip_T[5]*RotPelvis[8];
	R[6]=LAnkle_R_LHip_T[6]*RotPelvis[0] +LAnkle_R_LHip_T[7]*RotPelvis[3] +LAnkle_R_LHip_T[8]*RotPelvis[6];
	R[7]=LAnkle_R_LHip_T[6]*RotPelvis[1] +LAnkle_R_LHip_T[7]*RotPelvis[4] +LAnkle_R_LHip_T[8]*RotPelvis[7];
	R[8]=LAnkle_R_LHip_T[6]*RotPelvis[2] +LAnkle_R_LHip_T[7]*RotPelvis[5] +LAnkle_R_LHip_T[8]*RotPelvis[8];

	float ths[3];
	R2ths_CadI(R, ths);

	float th8=ths[0];
	float th10=ths[1];
	float th12=ths[2];

	float th8d=round((th8*180)/PI);
	float th10d=round((th10*180)/PI);
	float th12d=round((th12*180)/PI);
	float th14d=round((th14*180)/PI);
	float th16d=round((th16*180)/PI);
	float th18d=round((th18*180)/PI);

	int th8d_int=(int) th8d;
	int th10d_int=(int) th10d;
	int th12d_int=(int) th12d;
	int th14d_int=(int) th14d;
	int th16d_int=(int) th16d;
	int th18d_int=(int) th18d;

	ThLLeg[0]=th8d_int;
	ThLLeg[1]=th10d_int;
	ThLLeg[2]=th12d_int;
	ThLLeg[3]=th14d_int;
	ThLLeg[4]=th16d_int;
	ThLLeg[5]=th18d_int;
}

void RP_IK(float rRA_Pelvis[3], float RotPelvis[9], int ThRLeg[6])
{
	float L1=31.0/10;
	float L5=77.0/10;
	float L7=75.0/10;
	float L8=14.5/10;
	float Lb=hypot(L7,L8);

	float rRHipPelvis[3];
	rRHipPelvis[0]=L5/2;
	rRHipPelvis[1]=L1;
	rRHipPelvis[2]=0.0;
	
	//printMatrix(RotPelvis);

	float World_rHipPel[3];
	M_V(RotPelvis, rRHipPelvis, World_rHipPel);

	float rRA_RHip[3];
	V1mV2(rRA_Pelvis, World_rHipPel, rRA_RHip);

	//Posicion de la Cadera

	float RHipX,RHipY,RHipZ;			//Posición Cartesiana (cm)
	RHipX=rRA_RHip[2];	//Desired Hip Position X
	RHipY=rRA_RHip[0];	//Desired Hip Position Y
	RHipZ=rRA_RHip[1];	//Desired Hip Position Z
	
	float y1=RHipY;
	float x1=RHipX;
	float z1=RHipZ;

	float th17=-atan2(y1,z1);

	float l=sqrt(x1*x1+y1*y1+z1*z1);
	float cosG=-(l*l-2*Lb*Lb)/(2*Lb*Lb);
	float sinG=sqrt(1-cosG*cosG);
	float G=PI-atan2(sinG,cosG);
	float a0=atan2(L8,L7);

	float th13=-(G+2*a0);

	float cosa1=(y1*y1+z1*z1)/(sqrt(y1*y1+z1*z1)*l);
	float sina1=sqrt(1-cosa1*cosa1);
	float pmOne=1;
	float signx1=copysign(pmOne,x1);
	float a1=-signx1*atan2(sina1,cosa1);
	float a2=(G)/2;
	float th15=-(a1-a2-a0);
	
	float RAnkle_R_RHip[9];
	
	RAnkle_R_RHip[0]=cos(th17);
	RAnkle_R_RHip[1]=sin(th13 + th15)*sin(th17);
	RAnkle_R_RHip[2]=-cos(th13 + th15)*sin(th17);
	RAnkle_R_RHip[3]=sin(th17);
	RAnkle_R_RHip[4]=-sin(th13 + th15)*cos(th17);
	RAnkle_R_RHip[5]=cos(th13 + th15)*cos(th17);
	RAnkle_R_RHip[6]=0.0;
	RAnkle_R_RHip[7]=cos(th13 + th15);
	RAnkle_R_RHip[8]=sin(th13 + th15);

	float RAnkle_R_RHip_T[9];
	RAnkle_R_RHip_T[0]=RAnkle_R_RHip[0];
	RAnkle_R_RHip_T[1]=RAnkle_R_RHip[3];
	RAnkle_R_RHip_T[2]=RAnkle_R_RHip[6];
	RAnkle_R_RHip_T[3]=RAnkle_R_RHip[1];
	RAnkle_R_RHip_T[4]=RAnkle_R_RHip[4];
	RAnkle_R_RHip_T[5]=RAnkle_R_RHip[7];
	RAnkle_R_RHip_T[6]=RAnkle_R_RHip[2];
	RAnkle_R_RHip_T[7]=RAnkle_R_RHip[5];
	RAnkle_R_RHip_T[8]=RAnkle_R_RHip[8];
	
	float R[9];
	R[0]=RAnkle_R_RHip_T[0]*RotPelvis[0] +RAnkle_R_RHip_T[1]*RotPelvis[3] +RAnkle_R_RHip_T[2]*RotPelvis[6];
	R[1]=RAnkle_R_RHip_T[0]*RotPelvis[1] +RAnkle_R_RHip_T[1]*RotPelvis[4] +RAnkle_R_RHip_T[2]*RotPelvis[7];
	R[2]=RAnkle_R_RHip_T[0]*RotPelvis[2] +RAnkle_R_RHip_T[1]*RotPelvis[5] +RAnkle_R_RHip_T[2]*RotPelvis[8];
	R[3]=RAnkle_R_RHip_T[3]*RotPelvis[0] +RAnkle_R_RHip_T[4]*RotPelvis[3] +RAnkle_R_RHip_T[5]*RotPelvis[6];
	R[4]=RAnkle_R_RHip_T[3]*RotPelvis[1] +RAnkle_R_RHip_T[4]*RotPelvis[4] +RAnkle_R_RHip_T[5]*RotPelvis[7];
	R[5]=RAnkle_R_RHip_T[3]*RotPelvis[2] +RAnkle_R_RHip_T[4]*RotPelvis[5] +RAnkle_R_RHip_T[5]*RotPelvis[8];
	R[6]=RAnkle_R_RHip_T[6]*RotPelvis[0] +RAnkle_R_RHip_T[7]*RotPelvis[3] +RAnkle_R_RHip_T[8]*RotPelvis[6];
	R[7]=RAnkle_R_RHip_T[6]*RotPelvis[1] +RAnkle_R_RHip_T[7]*RotPelvis[4] +RAnkle_R_RHip_T[8]*RotPelvis[7];
	R[8]=RAnkle_R_RHip_T[6]*RotPelvis[2] +RAnkle_R_RHip_T[7]*RotPelvis[5] +RAnkle_R_RHip_T[8]*RotPelvis[8];

	float ths[3];

	R2ths_CadD(R, ths);

	float th7=ths[0];
	float th9=ths[1];
	float th11=ths[2];

	float th7d=round((th7*180)/PI);
	float th9d=round((th9*180)/PI);
	float th11d=round((th11*180)/PI);
	float th13d=round((th13*180)/PI);
	float th15d=round((th15*180)/PI);
	float th17d=round((th17*180)/PI);

	int th7d_int=(int) th7d;
	int th9d_int=(int) th9d;
	int th11d_int=(int) th11d;
	int th13d_int=(int) th13d;
	int th15d_int=(int) th15d;
	int th17d_int=(int) th17d;

	ThRLeg[0]=th7d_int;
	ThRLeg[1]=th9d_int;
	ThRLeg[2]=th11d_int;
	ThRLeg[3]=th13d_int;
	ThRLeg[4]=th15d_int;
	ThRLeg[5]=th17d_int;
}

void R2ths_CadD(float Rot[9], float ths[3])
{
	float th9, th11, th7p;

	float val=Rot[1]-0.0001;
	if (abs(val) < 0)
	{
		th9=0.0;
		th11=atan2(Rot[8],Rot[5]);
		float val1=Rot[2]-0.0001;
		if (abs(val1) < 0)
		{
			th7p=0.0;
		}
		else
		{
			th7p=atan2(Rot[2],Rot[0]);
		}
	}
	else
	{
		float Sin9=Rot[1];
		float Cos9=sqrt(1-Sin9*Sin9);
		th9=atan2(Sin9,Cos9);
		th11=atan2(-Rot[4],Rot[7]);
		th7p=atan2(Rot[2],Rot[0]);
	}
	ths[0]=th7p-PI/4;
	ths[1]=th9;
	ths[2]=th11;
}

void R2ths_CadI(float Rot[9], float ths[3])
{
	float th12, th10, th8p;

	float val=Rot[3]-0.0001;
	float val1=Rot[5]-0.0001;
	if (abs(val) < 0)
	{
		if (abs(val1) < 0)
		{
			//printf("Problem with LLeg IK");
			th8p=0.0;
			th10=0.0;
			th12=0.0;
		}
	}
	else
	{
		float Sin10=Rot[4];
		float Cos10=sqrt(1-Sin10*Sin10);
		th10=atan2(Sin10,Cos10);
		th12=atan2(-Rot[1],-Rot[7]);
		th8p=atan2(Rot[5],Rot[3]);
	}
	ths[0]=th8p+PI/4;
	ths[1]=th10;
	ths[2]=th12;
}

void a_m_off(void)
{
	int CommStatus;
	dxl_write_byte(BROADCAST_ID,P_TORQUE_ENABLE,0);
	CommStatus = dxl_get_result();
}

void a_m_on(void)
{
	int CommStatus;
	dxl_write_byte(BROADCAST_ID,P_TORQUE_ENABLE,1);
	CommStatus = dxl_get_result();
}

int Recibe1Dato(void)
{
	int RcvdData;
	int Dato;

	RcvdData=0;
	while(!RcvdData)
	{
		if(zgb_rx_check() == 1)
		{
			RcvdData=1;
			Dato=zgb_rx_data();
			return Dato;
		}
	}
}

float Deg2Rad(int Angle)
{
	float Rad;
	Rad=(float) Angle*PI/180;
	return Rad;
}

void MoveLegTime(int ThLeg[6], float Time, int Tipo)
{
	int CommStatus;
	int IDLeg[6];
	if (Tipo==1)
	{
		IDLeg[0]=7;
		IDLeg[1]=9;
		IDLeg[2]=11;
		IDLeg[3]=13;
		IDLeg[4]=15;
		IDLeg[5]=17;
	}
	else
	{
		IDLeg[0]=8;
		IDLeg[1]=10;
		IDLeg[2]=12;
		IDLeg[3]=14;
		IDLeg[4]=16;
		IDLeg[5]=18;
	}

	int i;
	int ThLegCount[6];
	int RealThLeg[6];
	float DTh1;
	int DTh;

	getThLeg(RealThLeg, Tipo);
	dxl_set_txpacket_id(BROADCAST_ID);
	dxl_set_txpacket_instruction(INST_SYNC_WRITE);
	dxl_set_txpacket_parameter(0, P_GOAL_SPEED_L);
	dxl_set_txpacket_parameter(1, 2);
	for( i=0; i<6; i++ )
	{
		ThLegCount[i]=512+round((ThLeg[i])*(1023/300));
		if (RealThLeg[i] >= ThLegCount[i])
		{
			DTh1=(0.65)*(RealThLeg[i]-ThLegCount[i])/Time;	
		}
		else
		{
			DTh1=(0.65)*(ThLegCount[i]-RealThLeg[i])/Time;
		}
		DTh=(int) round(DTh1);
		//DTh= (int) DTh1;
		dxl_set_txpacket_parameter(2+(3*i), IDLeg[i]);
		dxl_set_txpacket_parameter(2+(3*i)+1, dxl_get_lowbyte(DTh));
		dxl_set_txpacket_parameter(2+(3*i)+2, dxl_get_highbyte(DTh));
		_delay_ms(5);
	}
	dxl_set_txpacket_length((2+1)*6+4);

	dxl_txrx_packet();
	CommStatus = dxl_get_result();

	// Set Position of the Motors
	dxl_set_txpacket_id(BROADCAST_ID);
	dxl_set_txpacket_instruction(INST_SYNC_WRITE);
	dxl_set_txpacket_parameter(0, P_GOAL_POSITION_L);
	dxl_set_txpacket_parameter(1, 2);
	for( i=0; i<6; i++ )
	{
		dxl_set_txpacket_parameter(2+3*i, IDLeg[i]);
		dxl_set_txpacket_parameter(2+3*i+1, dxl_get_lowbyte(ThLegCount[i]));
		dxl_set_txpacket_parameter(2+3*i+2, dxl_get_highbyte(ThLegCount[i]));
	}
	dxl_set_txpacket_length((2+1)*12+4);

	dxl_txrx_packet();
	CommStatus = dxl_get_result();
}

void MoveLegVel(int ThLeg[6], int Vel, int Tipo)
{
	int CommStatus;
	int IDLeg[6];
	int ThLegCount[6];
	
	if (Tipo==1)
	{
		IDLeg[0]=7;
		IDLeg[1]=9;
		IDLeg[2]=11;
		IDLeg[3]=13;
		IDLeg[4]=15;
		IDLeg[5]=17;
	}
	else
	{
		IDLeg[0]=8;
		IDLeg[1]=10;
		IDLeg[2]=12;
		IDLeg[3]=14;
		IDLeg[4]=16;
		IDLeg[5]=18;
	}

	dxl_write_word(BROADCAST_ID,P_GOAL_SPEED_L,Vel);
	CommStatus = dxl_get_result();

	// Set Position of the Motors
	dxl_set_txpacket_id(BROADCAST_ID);
	dxl_set_txpacket_instruction(INST_SYNC_WRITE);
	dxl_set_txpacket_parameter(0, P_GOAL_POSITION_L);
	dxl_set_txpacket_parameter(1, 2);
	for( int i=0; i<6; i++ )
	{
		ThLegCount[i]=512+round((ThLeg[i])*(1023/300));
		dxl_set_txpacket_parameter(2+3*i, IDLeg[i]);
		dxl_set_txpacket_parameter(2+3*i+1, dxl_get_lowbyte(ThLegCount[i]));
		dxl_set_txpacket_parameter(2+3*i+2, dxl_get_highbyte(ThLegCount[i]));
	}
	dxl_set_txpacket_length((2+1)*6+4);

	dxl_txrx_packet();
	CommStatus = dxl_get_result();
}

void MoveArmTime(int ThArm[3], float Time, int Tipo)
{
	int CommStatus;
	int IDArm[3];
	if (Tipo==1)
	{
		IDArm[0]=1;
		IDArm[1]=3;
		IDArm[2]=5;
	}
	else
	{
		IDArm[0]=2;
		IDArm[1]=4;
		IDArm[2]=6;
	}

	int i;
	int ThArmCount[3];
	int RealThArm[3];
	float DTh1;
	int DTh;

	getThLeg(RealThArm, Tipo);
	dxl_set_txpacket_id(BROADCAST_ID);
	dxl_set_txpacket_instruction(INST_SYNC_WRITE);
	dxl_set_txpacket_parameter(0, P_GOAL_SPEED_L);
	dxl_set_txpacket_parameter(1, 2);
	for( i=0; i<3; i++ )
	{
		ThArmCount[i]=512+round((ThArm[i])*(1023/300));
		DTh1=(0.65)*(RealThArm[i]-ThArmCount[i])/Time;
		DTh=abs( (int) DTh1 );
		dxl_set_txpacket_parameter(2+3*i, IDArm[i]);
		dxl_set_txpacket_parameter(2+3*i+1, dxl_get_lowbyte(DTh));
		dxl_set_txpacket_parameter(2+3*i+2, dxl_get_highbyte(DTh));
	}
	dxl_set_txpacket_length((2+1)*3+4);

	dxl_txrx_packet();
	CommStatus = dxl_get_result();

	// Set Position of the Motors
	dxl_set_txpacket_id(BROADCAST_ID);
	dxl_set_txpacket_instruction(INST_SYNC_WRITE);
	dxl_set_txpacket_parameter(0, P_GOAL_POSITION_L);
	dxl_set_txpacket_parameter(1, 2);
	for( i=0; i<3; i++ )
	{
		dxl_set_txpacket_parameter(2+3*i, IDArm[i]);
		dxl_set_txpacket_parameter(2+3*i+1, dxl_get_lowbyte(ThArmCount[i]));
		dxl_set_txpacket_parameter(2+3*i+2, dxl_get_highbyte(ThArmCount[i]));
	}
	dxl_set_txpacket_length((2+1)*3+4);

	dxl_txrx_packet();
	CommStatus = dxl_get_result();
}

void MoveArmVel(int ThArm[3], int Vel, int Tipo)
{
	int CommStatus;
	int IDArm[3];
	if (Tipo==1)
	{
		IDArm[0]=1;
		IDArm[1]=3;
		IDArm[2]=5;
	}
	else
	{
		IDArm[0]=2;
		IDArm[1]=4;
		IDArm[2]=6;
	}

	int i;
	int ThArmCount[3];

	dxl_set_txpacket_id(BROADCAST_ID);
	dxl_set_txpacket_instruction(INST_SYNC_WRITE);
	dxl_set_txpacket_parameter(0, P_GOAL_SPEED_L);
	dxl_set_txpacket_parameter(1, 2);
	for( i=0; i<3; i++ )
	{
		dxl_set_txpacket_parameter(2+3*i, IDArm[i]);
		dxl_set_txpacket_parameter(2+3*i+1, dxl_get_lowbyte(Vel));
		dxl_set_txpacket_parameter(2+3*i+2, dxl_get_highbyte(Vel));
	}
	dxl_set_txpacket_length((2+1)*3+4);

	dxl_txrx_packet();
	CommStatus = dxl_get_result();

	// Set Position of the Motors
	dxl_set_txpacket_id(BROADCAST_ID);
	dxl_set_txpacket_instruction(INST_SYNC_WRITE);
	dxl_set_txpacket_parameter(0, P_GOAL_POSITION_L);
	dxl_set_txpacket_parameter(1, 2);
	for( i=0; i<3; i++ )
	{
		dxl_set_txpacket_parameter(2+3*i, IDArm[i]);
		dxl_set_txpacket_parameter(2+3*i+1, dxl_get_lowbyte(ThArmCount[i]));
		dxl_set_txpacket_parameter(2+3*i+2, dxl_get_highbyte(ThArmCount[i]));
	}
	dxl_set_txpacket_length((2+1)*3+4);

	dxl_txrx_packet();
	CommStatus = dxl_get_result();
}

void getThLeg(int ThLeg[6], int Tipo)
{
	int i;
	int IDLeg[6];
	if (Tipo==1)
	{
		IDLeg[0]=7;
		IDLeg[1]=9;
		IDLeg[2]=11;
		IDLeg[3]=13;
		IDLeg[4]=15;
		IDLeg[5]=17;
	}
	else
	{
		IDLeg[0]=8;
		IDLeg[1]=10;
		IDLeg[2]=12;
		IDLeg[3]=14;
		IDLeg[4]=16;
		IDLeg[5]=18;
	}
	int CommStatus;
	for (i=0; i<6; i++)
	{
		ThLeg[i]=dxl_read_word(IDLeg[i],P_PRESENT_POSITION_L);
		CommStatus = dxl_get_result();
		_delay_ms(5);
	}
}

void getThArm(int ThArm[3], int Tipo)
{
	int i;
	int IDArm[3];
	if (Tipo==1)
	{
		IDArm[0]=1;
		IDArm[1]=3;
		IDArm[2]=5;
	}
	else
	{
		IDArm[0]=2;
		IDArm[1]=4;
		IDArm[2]=6;
	}
	int CommStatus;
	for (i=0; i<3; i++)
	{
		ThArm[i]=dxl_read_word(IDArm[i],P_PRESENT_POSITION_L);
		CommStatus = dxl_get_result();
	}
}

void RcvPrms(int Clave)
{
	switch (Clave)
	{
		case 'a':
			g_Values_1_Int[0]=Recibe1Dato();
			g_Values_1_Flt[0]=((float) Recibe1Dato())/10;
			g_Values_1_Flt[1]=((float) Recibe1Dato())/10;
			g_Values_1_Int[1]=Recibe1Dato();
			g_Values_1_Flt[2]=((float) Recibe1Dato())/10;
			g_Values_1_Int[2]=Recibe1Dato();
			g_Values_1_Flt[3]=((float) Recibe1Dato())/10;
			g_Values_1_Flt[4]=((float) Recibe1Dato())/10;
			g_Values_1_Flt[5]=((float) Recibe1Dato())/10;
			for (int i=3; i<12; i++)
			{
				g_Values_1_Int[i]=Recibe1Dato();	
			}
		break;
		case 'b':
			for (int i=0; i<3; i++)
			{
				g_Values_2_Flt[i]=((float) Recibe1Dato())/10;
			}
			for (int i=0; i<11; i++)
			{
				g_Values_2_Int[i]=Recibe1Dato();
			}
			for (int i=3; i<6; i++)
			{
				g_Values_2_Flt[i]=((float) Recibe1Dato())/10;
			}					
			for (int i=11; i<22; i++)
			{
				g_Values_2_Int[i]=Recibe1Dato();
			}			
		break;
		case 'c':
			g_Values_3_Flt[0]=((float) Recibe1Dato())/10;
			g_Values_3_Flt[1]=((float) Recibe1Dato())/10;
			g_Values_3_Int[0]=Recibe1Dato();
			g_Values_3_Flt[2]=((float) Recibe1Dato())/10;
			g_Values_3_Int[1]=Recibe1Dato();	
			for (int i=2; i<26; i++)
			{
				g_Values_3_Int[i]=Recibe1Dato();
			}				
		break;		
	}
}

void SndPrms(int Clave)
{
	switch (Clave)
	{
		case 'a':
			Envia1Dato(g_Values_1_Int[0]);
			Envia1Dato((int) (g_Values_1_Flt[0]*10));
			Envia1Dato((int) (g_Values_1_Flt[1]*10));
			Envia1Dato(g_Values_1_Int[1]);
			Envia1Dato((int) (g_Values_1_Flt[2]*10));
			Envia1Dato(g_Values_1_Int[2]);
			Envia1Dato((int) (g_Values_1_Flt[3]*10));
			Envia1Dato((int) (g_Values_1_Flt[4]*10));
			Envia1Dato((int) (g_Values_1_Flt[5]*10));
			for (int i=3; i<12; i++)
			{
				Envia1Dato(g_Values_1_Int[i]);
			}		
		break;
		case 'b':
			for (int i=0; i<3; i++)
			{
				Envia1Dato((int) (g_Values_2_Flt[i]*10));
			}
			for (int i=0; i<11; i++)
			{
				Envia1Dato(g_Values_2_Int[i]);
			}
			for (int i=3; i<6; i++)
			{
				Envia1Dato((int) (g_Values_2_Flt[i]*10));
			}
			for (int i=11; i<22; i++)
			{
				Envia1Dato(g_Values_2_Int[i]);
			}		
		break;
		case 'c':
			Envia1Dato((int) (g_Values_3_Flt[0]*10));
			Envia1Dato((int) (g_Values_3_Flt[1]*10));
			Envia1Dato(g_Values_3_Int[0]);
			Envia1Dato((int) (g_Values_3_Flt[2]*10));
			Envia1Dato(g_Values_3_Int[1]);
			for (int i=2; i<26; i++)
			{
				Envia1Dato(g_Values_3_Int[i]);
			}		
		break;		
	}
}

void Envia1Dato(int Dato)
{
	zgb_tx_data(Dato);
}

void Flash_Led(int Veces)
{
	DDRC  = 0x7F;
	PORTC = 0x7E;
	for (int i=0; i<Veces; i++)
	{
		sbi(PORTC,2);
		_delay_ms(5);
		cbi(PORTC,2);
		_delay_ms(1000);
		sbi(PORTC,2);
	}
}

void MarchaIzquierda()
{
	g_Index_Step=0;
	for (int i=1; i<=g_Values_1_Int[0]; i++)
	{
		if (i==1)
		{
			Zancada(2);
		}
		else {
			if (i<g_Values_1_Int[0])
			{
				if (i%2)
				Zancada(4);
				else
				Zancada(3);
			}
			else
			{
				if (i%2)
				Zancada(6);
				else
				Zancada(5);
			}
		}
	}
}

void MarchaDerecha()
{
	g_Index_Step=0;
	for (int i=1; i<=g_Values_1_Int[0]; i++)
	{
		if (i==1)
		{
			Zancada(1);
		}
		else {
			if (i<g_Values_1_Int[0])
			{
				if (i%2)
				Zancada(3);
				else
				Zancada(4);
			}
			else
			{
				if (i%2)
				Zancada(5);
				else
				Zancada(6);
			}
		}
	}
}

void Zancada(int Tipo)
{
	float E=0;
	switch (Tipo)
	{
		case 1:
		case 3:
		case 5:
			E=-1;
			break;
		case 2:
		case 4:
		case 6:
			E=1;
			break;
	}
	float CP_x=g_Values_1_Flt[0];
	float CP_z=g_Values_1_Flt[1];
	int i_CP_th=g_Values_1_Int[1];
	float CP_th=(float) i_CP_th;
	float DP_y=g_Values_1_Flt[2];
	int i_DP_phi=g_Values_1_Int[2];
	float DP_phi=(float) i_DP_phi;

	float DF_x=g_Values_1_Flt[3];
	float DF_y=g_Values_1_Flt[4];
	float DF_z=g_Values_1_Flt[5];
	int i_DF_psi=g_Values_1_Int[3];
	float DF_psi=(float) i_DF_psi;

	int i_CS_th=g_Values_1_Int[4];
	float CS_th=(float) i_CS_th;
	int i_DS_th=g_Values_1_Int[7];
	float DS_th=(float) i_DS_th;
	
	int i_T =g_Values_1_Int[8];
	float T= (float) i_T;
	int i_T_ds =g_Values_1_Int[9];
	float T_ds= (float) i_T_ds;
	int i_t_ini =g_Values_1_Int[10];
	float t_ini= (float) i_t_ini;
	int i_T_ss=g_Values_1_Int[11];	
	float T_ss= (float) i_T_ss;

	float L_1=4.8;
	float L_2=3.85;
	float c_th=cos(Deg2Rad(i_DF_psi));
	float s_th=sin(Deg2Rad(i_DF_psi));

	float D_x_TurnP=L_1*(-1+c_th);
	float D_y_TurnP=L_1*s_th;

	float D_x_Turn_fFin;
	float D_y_Turn_fFin;
	float D_x_Turn_fIni;
	float D_y_Turn_fIni;

	if (i_DF_psi>=0)
	{
		float D_x_Turn_fFin=L_1*(-1+c_th)-L_2*(s_th);
		float D_y_Turn_fFin=L_1*s_th     +L_2*(-1+c_th);
		float D_x_Turn_fIni=L_1*(-1+c_th)-L_2*s_th;
		float D_y_Turn_fIni=-L_1*s_th-L_2*(-1+c_th);		
	}
	else
	{
		float D_x_Turn_fFin=L_1*(-1+c_th)+L_2*(s_th);
		float D_y_Turn_fFin=L_1*s_th     -L_2*(-1+c_th);
		float D_x_Turn_fIni=L_1*(-1+c_th)+L_2*s_th;
		float D_y_Turn_fIni=-L_1*s_th+L_2*(-1+c_th);
	}

	int i_Th_RA=-90+CS_th;
	float Th_RA=(int) i_Th_RA;
	int i_Th_LA= 90-CS_th;
	float Th_LA=(int) i_Th_LA;
	
	float T1=((T-T_ds)/2);
	
	float T_local=0.0;
	float t_local;
	float T_local1;
	
	//Posición y orientación del pie fijo
	float Ff_x;
	float Ff_y;
	float Ff_z;
	float Ff_phi=0.0;
	float Ff_th=0.0;
	float Ff_psi;

	//Posición y orientación del pie movil
	float Mf_x;
	float Mf_y;
	float Mf_z;
	float Mf_phi=0.0;
	float Mf_th=0.0;
	float Mf_psi;

	//Posición y orientación de la pelvis
	float P_x;
	float P_y;
	float P_z=CP_z;
	float P_phi;
	float P_th;
	float P_psi;	
	
	//Amplitudes
	float Mf_Lx;
	float P_Ly1;
	float P_Ly2;
	
	//Tiempos
	l_Timer=0;
	float Timer=l_Timer;
	while (l_Timer < i_T)
	{
		int i_t=(int) l_Timer;
		float t=(float) i_t;
		//_________________________________________________________________
		//Cordenadas del pie fijo
		//_________________________________________________________________
		if (Tipo==1 || Tipo==2)
		{
			Ff_x=0;	
		}
		else
		{
			Ff_x=DF_x/4;	
		}
		Ff_y=-E*L_2;
		if (Tipo==1 || Tipo==2)
		{
			Ff_y=0.0;
		}
		else
		{
			if ((DF_y >=0) && (Tipo ==3 || Tipo == 5))
			{
				Ff_y=Ff_y+DF_y/2;
			}
			else
			{
				Ff_y=0.0;
			}
				
		}
		if (DF_y <=0 && (Tipo ==4 || Tipo == 6))
		{
			Ff_y=Ff_y+DF_y/2;	
		}
		Ff_psi=0.0;
		Ff_z=0.0;		
		//_________________________________________________________________
		//Desplazamiento del pie movil
		//_________________________________________________________________
		if (Tipo==1 || Tipo==2)
		{
			Mf_Lx=DF_x/2;
		}
		else
		{
			Mf_Lx=DF_x;
		}    
		if (t < t_ini)
		{
			if (Tipo==1 || Tipo==2)
			{
				Mf_x=0;
			}
			else
			{
				Mf_x=-Mf_Lx/4;
			}
			Mf_y=E*L_2;
			if ((DF_y >=0) && ((Tipo==3) || (Tipo==5)))
			{
				Mf_y=Mf_y-DF_y/2;
			}
			if ((DF_y < 0) && ((Tipo==4) || (Tipo==6)))
			{
				Mf_y=Mf_y-DF_y/2;
			}
			Mf_z=0;
			if (((g_Index_Step+1)%2) == 1)
			{
				Mf_psi=0;
			}
			else
			{
				Mf_psi=-DF_psi;
			}
		}
		else
		{
			if (t < t_ini+T_ss)
			{
				T_local= T_ss;
				t_local=t-t_ini;
				if (Tipo==1 || Tipo==2)
				{
					Mf_x=Cicloidal_1(Mf_Lx,T_local,t_local);
				}
				else
				{
					if (Tipo==3 || Tipo==4)
					{
					Mf_x=-Mf_Lx/4+Cicloidal_1(Mf_Lx,T_local,t_local);	
					}
					else
					{
						Mf_x=-Mf_Lx/4+Cicloidal_1(Mf_Lx/2,T_local,t_local);	
					}
				}
				if (Tipo==1 || Tipo==2)
				{
					Mf_y=Cicloidal_1(DF_y,T_local,t_local)+E*L_2;
				}
				else
				{
					if (((DF_y >= 0) && ((Tipo==4) || (Tipo==6)) ) || ( DF_y < 0 && Tipo==3))
					{
						Mf_y=Cicloidal_1(DF_y,T_local,t_local)+E*L_2;		
					}
					else
					{
						Mf_y=-DF_y/2+Cicloidal_1(DF_y,T_local,t_local)+E*L_2;	
					}
				}
				if ((g_Index_Step+1)%2 == 1)
				{
					Mf_x=Mf_x+Cicloidal_1(D_x_Turn_fFin,T_local,t_local);
					Mf_y=Mf_y+Cicloidal_1(D_y_Turn_fFin,T_local,t_local);
					Mf_psi=Cicloidal_1(DF_psi,T_local,t_local);
				}
				else
				{
					Mf_x=Mf_x-Cicloidal_1(D_x_Turn_fIni,T_local,t_local);
					Mf_y=Mf_y-Cicloidal_1(D_y_Turn_fIni,T_local,t_local);
					Mf_psi=-DF_psi+Cicloidal_1(DF_psi,T_local,t_local);
				}            
				Mf_z=Cicloidal_2(DF_z,T_local,t_local);
			}
			else
			{
				if (Tipo==1 || Tipo==2)
				{
					Mf_x=Mf_Lx;
				}
				else
				{
					if (Tipo==3 || Tipo==4)
					{
						Mf_x=3*Mf_Lx/4;
					}
					else
					{
						Mf_x=Mf_Lx/4;
					}
					
				}
				if (Tipo==1 || Tipo==2)
				{
					Mf_y=DF_y+E*L_2;
				}
				else
				{
					if (((DF_y >= 0) && ((Tipo==4) ||(Tipo==6)) ) || ( DF_y < 0 && Tipo==3))
					{
						Mf_y=DF_y+E*L_2;
					}
					else
					{
						Mf_y=DF_y/2+E*L_2;	
					}
				}				
				if (((g_Index_Step+1)%2) == 1)
				{
					Mf_x=Mf_x+D_x_Turn_fFin;
					Mf_y=Mf_y+D_y_Turn_fFin;
					Mf_psi=DF_psi;
				}
				else
				{
					Mf_x=Mf_x-D_x_Turn_fIni;
					Mf_y=Mf_y-D_y_Turn_fIni;                
					Mf_psi=0;
				}
				Mf_z=0.0;
			}
		}
		if (((g_Index_Step+1)%2) == 1)
		{
			
		}
		else
		{
			Mf_x=Mf_x+D_x_Turn_fIni;
			Mf_y=Mf_y+D_y_Turn_fIni;
		}
		//_________________________________________________________________
		//Desplazamiento de la pelvis
		//_________________________________________________________________
		float P_Lx=Mf_Lx/2;
		if ((Tipo==1) || (Tipo == 2))
		{
			P_x=Cicloidal_3(P_Lx+D_x_TurnP,T,t);	
		}
		else
		{
			if (Tipo==3 || Tipo == 4)
			{
				P_x=DF_x/2*(t/T);	
			}
			else
			{
				P_x=Cicloidal_4(DF_x/4,T,t);	
			}
		}
		if (((g_Index_Step+1)%2) == 1)
		{
			P_psi=Cicloidal_3(DF_psi,T,t);	
		}
		else
		{
			P_psi=0.0;	
		}
		float P_Ly=DF_y/2;
		if (((DF_y <=0) && (Tipo==3 || Tipo==5)) || ( (DF_y >=0) && (Tipo==4 || Tipo==6) ))
		{
			P_Ly1=-E*DP_y;	
		}
		else
		{
			if ( (DF_y >=0) && (Tipo==3 || Tipo==5))
			{
				P_Ly1=-E*(DP_y+P_Ly);
			}
			else
			{
				P_Ly1=-E*(DP_y-P_Ly);
			}
		}
		if (t < T1)
		{
			if (Tipo==1 || Tipo == 2)
			{
				P_y=-E*Cicloidal_1(DP_y,T1,t);	
			}
			else
			{
				P_y=Cicloidal_4(P_Ly1,T1,t);	
			}
			P_phi=E*Cicloidal_1(DP_phi,T1,t);			
		}
		else
		{
			if (t < T1+T_ds)
			{
				if (Tipo==1 || Tipo == 2)
				{
					P_y=-E*DP_y;	
				}
				else
				{
					P_y=P_Ly1;	
				}
				P_phi=E*DP_phi;	
			}
			else
			{
				T_local=T1;
				t_local=t-(T1+T_ds);
				if (Tipo==1 || Tipo == 2)
				{
					P_Ly2=P_Ly+E*DP_y;
					P_y=-E*DP_y+Cicloidal_3(P_Ly2,T_local,t_local);					
				}
				else
				{					
					if ( ((DF_y <= 0) && (Tipo==3 || Tipo==5)) || ((DF_y > 0) && (Tipo==4 || Tipo==6)) )
					{
						P_Ly2=-E*DP_y-P_Ly;
						P_y=-E*DP_y-Cicloidal_3(P_Ly2,T_local,t_local);									
					}
					else
					if ((DF_y >= 0 && (Tipo==3 || Tipo==5)))
					{
						P_y=P_Ly+Cicloidal_5(DP_y,T_local,t_local);	
					}
					else
					{
						P_Ly2=-(DP_y-P_Ly);
						P_y=P_Ly2+Cicloidal_3(DP_y,T_local,t_local);						
					}
				}
				if (Tipo==1 || Tipo == 2)
				{
					P_phi=E*(DP_phi-Cicloidal_1(DP_phi,T_local,t_local));	
				}
				else
				{
					P_phi=E*DP_phi-E*Cicloidal_1(DP_phi,T_local,t_local);	
				}
				if (((g_Index_Step+1)%2) == 1)
				{
					P_y=P_y+Cicloidal_1(D_y_TurnP,T_local,t_local);	
				}
				else
				{
					P_psi=0;	
				}
			}			
		}
		
		//_________________________________________________________________
		//Desplazamiento de los brazos
		//_________________________________________________________________
		if (t < T/4)
		{
			if (Tipo==1 || Tipo==2)
			{
				Th_RA=-90.0+ CS_th+Cicloidal_1(DS_th/2,T/4,t);
				Th_LA= 90.0- CS_th+Cicloidal_1(DS_th/2,T/4,t);				
			}
			else
			{
				Th_RA=-90.0+ CS_th+Cicloidal_4(DS_th/2,T/4,t);
				Th_LA= 90.0- CS_th+Cicloidal_4(DS_th/2,T/4,t);				
			}
		}
		else
		{
			if (t < T*(3/4))
			{
				t_local=t-T/4;
				Th_RA=-90.0+ CS_th+(DS_th/2+ Cicloidal_1(-DS_th,T/2,t_local));
				Th_LA= 90.0- CS_th+(DS_th/2+ Cicloidal_1(-DS_th,T/2,t_local));
			}
			else
			{
				t_local=t-T*(3/4);
				if (Tipo==5 || Tipo==6)
				{
					Th_RA=-90.0+ CS_th+(-DS_th/2+Cicloidal_1(DS_th/2,T/4,t_local));
					Th_LA= 90.0- CS_th+(-DS_th/2+Cicloidal_1(DS_th/2,T/4,t_local));					
				}
				else
				{
					Th_RA=-90.0+ CS_th+(-DS_th/2+Cicloidal_3(DS_th/2,T/4,t_local));
					Th_LA= 90.0- CS_th+(-DS_th/2+Cicloidal_3(DS_th/2,T/4,t_local));					
				}
			}
		}
				
		//Movimiento
		g_P_Pos[0]=P_x+CP_x;
		g_P_Pos[1]=P_y;
		g_P_Pos[2]=CP_z;
		g_P_Ori[0]=(int) P_phi;
		g_P_Ori[1]=(int) CP_th;
		g_P_Ori[2]=(int) P_psi;
		
		switch (Tipo)
		{
			case 1:
			case 3:
			case 5:
				g_LF_Pos[0]=Ff_x;
				g_LF_Pos[1]=Ff_y;
				g_LF_Pos[2]=Ff_z;
				g_LF_Ori[0]=0;
				g_LF_Ori[1]=0;
				g_LF_Ori[2]=(int) Ff_psi;
            
				g_RF_Pos[0]=Mf_x;
				g_RF_Pos[1]=Mf_y;
				g_RF_Pos[2]=Mf_z;
				g_RF_Ori[0]=0;
				g_RF_Ori[1]=0;
				g_RF_Ori[2]=(int) Mf_psi;
				MoverPelvisYPieDerecho();
			break;
			case 2:
			case 4:
			case 6:
				g_RF_Pos[0]=Ff_x;
				g_RF_Pos[1]=Ff_y;
				g_RF_Pos[2]=Ff_z;
				g_RF_Ori[0]=0;
				g_RF_Ori[1]=0;
				g_RF_Ori[2]=(int) Ff_psi;
				
				g_LF_Pos[0]=Mf_x;
				g_LF_Pos[1]=Mf_y;
				g_LF_Pos[2]=Mf_z;
				g_LF_Ori[0]=0;
				g_LF_Ori[1]=0;
				g_LF_Ori[2]=(int) Mf_psi;
				MoverPelvisYPieIzquierdo();
			break;
		}
		if (g_Sens != 'N')
		{
			SND_Data(t);
		}
	}
	g_Index_Step++;
}

float Cicloidal_1(float A,float T, float t)
{
	float f;
	f=A*(t/T-(1/(2*PI))*sin(2*PI*t/T));
	return f;
}

float Cicloidal_2(float A,float T, float t)
{
	float f;
	f=A*sin(PI/2*(2*t/T-(1/PI)*sin(2*PI*t/T)));
	return f;
}

float Cicloidal_3(float A,float T, float t)
{
	float f;
	f=A*(t/T-(1/PI)*sin(PI*t/T));
	return f;
}

float Cicloidal_4(float A,float T, float t)
{
	float f;
	f=A*(t/T +(1/PI)*sin(PI*t/T));
	return f;
}

float Cicloidal_5(float A,float T, float t)
{
	float f;
	f=A-A*(t/T-(1/PI)*sin(PI*t/T));
	return f;
}
void MoverPelvisYPieDerecho()
{
//Variables de Centro Pelvis
	float XPelvis[6];
	XPelvis[0]=g_P_Pos[0];
	XPelvis[1]=g_P_Pos[1];
	XPelvis[2]=g_P_Pos[2];
	XPelvis[3]=Deg2Rad(g_P_Ori[0]);
	XPelvis[4]=Deg2Rad(g_P_Ori[1]);
	XPelvis[5]=Deg2Rad(g_P_Ori[2]);

	//Left Leg
	float PieIzq_Rot_Pel_A[9];
	float PieIzq_Rot_Pel_B[9];
	float PieIzq_Rot_Pel[9];
	
	float Cero=0.0;
	EulXZY_2_Rot(Cero,Cero,XPelvis[5], PieIzq_Rot_Pel_A);
	EulXZY_2_Rot(XPelvis[4],XPelvis[3],Cero, PieIzq_Rot_Pel_B);
	Mat3_Multiply(PieIzq_Rot_Pel_A,PieIzq_Rot_Pel_B,PieIzq_Rot_Pel);
			
	float rCenterPelvis[3];
	rCenterPelvis[0]=XPelvis[1];
	rCenterPelvis[1]=XPelvis[2];
	rCenterPelvis[2]=XPelvis[0];

	float rCenterLA[3];
	/*
	rCenterLA[0]=Float_VarsWalk[8]+Float_ValsWalk_Actual[6];
	rCenterLA[1]=Float_VarsWalk[9]+Float_ValsWalk_Actual[7];
	rCenterLA[2]=Float_VarsWalk[7]+Float_ValsWalk_Actual[5];
	*/
	rCenterLA[0]=g_LF_Pos[1];
	rCenterLA[1]=g_LF_Pos[2];
	rCenterLA[2]=g_LF_Pos[0];
	
	float rLA_Pelvis[3];
	V1mV2(rCenterPelvis, rCenterLA, rLA_Pelvis);
	int ThLLeg[6];
	LP_IK(rLA_Pelvis,PieIzq_Rot_Pel,ThLLeg);
	/*
	int ThLLeg[6];
	ThLLeg[0]=ThLLeg_1[0]+Int_VarsWalk[15];
	ThLLeg[1]=ThLLeg_1[1];
	ThLLeg[2]=ThLLeg_1[2];
	ThLLeg[3]=ThLLeg_1[3];
	ThLLeg[4]=ThLLeg_1[4];
	ThLLeg[5]=ThLLeg_1[5];
	
	if (Int_ValsWalk_Actual[6])
	{
		ThLLeg[1]=ThLLeg_1[1]+Int_VarsWalk[21];
		ThLLeg[2]=ThLLeg_1[2]+Int_VarsWalk[19];
		ThLLeg[3]=ThLLeg_1[3]-Int_VarsWalk[18];
		ThLLeg[4]=ThLLeg_1[4]-Int_VarsWalk[17];
		ThLLeg[5]=ThLLeg_1[5]-Int_VarsWalk[20];
	}
	*/
	
	//Right Leg
	float W_Rot_PelvisDer[9];
	float PieIzq_Rot_Pel_Traspose[9];
	float Pel_Rot_PieDer[9];
	EulXZY_2_Rot(Cero,Cero,Deg2Rad(g_RF_Ori[2]), W_Rot_PelvisDer);
	Mat3_Traspose(PieIzq_Rot_Pel,PieIzq_Rot_Pel_Traspose);
	Mat3_Multiply(PieIzq_Rot_Pel_Traspose,W_Rot_PelvisDer,Pel_Rot_PieDer);
	
	float r_Center1_RA[3];
	/*
	r_Center1_RA[0]=Float_ValsWalk_Actual[3]-Float_VarsWalk[11];
	r_Center1_RA[1]=Float_ValsWalk_Actual[4]+Float_VarsWalk[12];
	r_Center1_RA[2]=Float_ValsWalk_Actual[2]+Float_VarsWalk[10];
	*/
	r_Center1_RA[0]=g_RF_Pos[1];
	r_Center1_RA[1]=g_RF_Pos[2];
	r_Center1_RA[2]=g_RF_Pos[0];
	
	float	r_RA_Pel[3];
	V1mV2(rCenterPelvis, r_Center1_RA, r_RA_Pel);
	int ThRLeg[6];
	RP_IK(r_RA_Pel,Pel_Rot_PieDer,ThRLeg);
	/*
	int ThRLeg[6];
	ThRLeg[0]=ThRLeg_1[0]-Int_VarsWalk[16];
	ThRLeg[1]=ThRLeg_1[1];
	ThRLeg[2]=ThRLeg_1[2];
	ThRLeg[3]=ThRLeg_1[3];
	ThRLeg[4]=ThRLeg_1[4];
	ThRLeg[5]=ThRLeg_1[5];
	if (Int_ValsWalk_Actual[7])
	{
		ThRLeg[1]=ThRLeg_1[1]-Int_VarsWalk[36];
		ThRLeg[2]=ThRLeg_1[2]-Int_VarsWalk[34];
		ThRLeg[3]=ThRLeg_1[3]-Int_VarsWalk[33];
		ThRLeg[4]=ThRLeg_1[4]-Int_VarsWalk[32];
		ThRLeg[5]=ThRLeg_1[5]+Int_VarsWalk[35];
	}
	ThBioloid[0]=Int_ValsWalk_Actual[2];
	ThBioloid[1]=Int_ValsWalk_Actual[3];
	ThBioloid[2]=-Int_VarsWalk[10];
	ThBioloid[3]=Int_VarsWalk[10];
	ThBioloid[4]=-Int_VarsWalk[11];
	ThBioloid[5]=Int_VarsWalk[11];
	int Ind_RLeg[6]={6, 8, 10, 12, 14, 16};
	int Ind_LLeg[6]={7, 9, 11, 13, 15, 17};
	for (int i=0; i<6; i++)
	{
		ThBioloid[Ind_RLeg[i]]=ThRLeg_1[i];		
		ThBioloid[Ind_LLeg[i]]=ThLLeg_1[i];
	}
	*/		
	MoveLeg(ThRLeg,1);														//Mover la pierna deracha
	MoveLeg(ThLLeg,2);														//Mover la pierna izquierda
	//MoveShldr(Int_ValsWalk_Actual[2],1);
	//MoveShldr(Int_ValsWalk_Actual[3],2);
}

void MoverPelvisYPieIzquierdo()
{
	float XPelvis[6];
	XPelvis[0]=g_P_Pos[0];
	XPelvis[1]=g_P_Pos[1];
	XPelvis[2]=g_P_Pos[2];

	XPelvis[3]=Deg2Rad(g_P_Ori[0]);
	XPelvis[4]=Deg2Rad(g_P_Ori[1]);
	XPelvis[5]=Deg2Rad(g_P_Ori[2]);

	float rCenterPelvis[3];
	rCenterPelvis[0]=XPelvis[1];
	rCenterPelvis[1]=XPelvis[2];
	rCenterPelvis[2]=XPelvis[0];

	//Right Leg
	float PieDer_Rot_Pel_1[9];
	float PieDer_Rot_Pel_2[9];
	float PieDer_Rot_Pel[9];
	float Cero=0.0;
	EulXZY_2_Rot(Cero,Cero,XPelvis[5], PieDer_Rot_Pel_1);
	EulXZY_2_Rot(XPelvis[4],XPelvis[3],Cero, PieDer_Rot_Pel_2);
	Mat3_Multiply(PieDer_Rot_Pel_1,PieDer_Rot_Pel_2,PieDer_Rot_Pel);
	
	float rCenterRA[3];
	/*
	rCenterRA[0]=-Float_VarsWalk[8]+Float_ValsWalk_Actual[3];
	rCenterRA[1]=Float_VarsWalk[9]+Float_ValsWalk_Actual[4];
	rCenterRA[2]=Float_VarsWalk[7]+Float_ValsWalk_Actual[2];
	*/
	rCenterRA[0]=g_RF_Pos[1];
	rCenterRA[1]=g_RF_Pos[2];
	rCenterRA[2]=g_RF_Pos[0];		
		
	float rRA_PelvisC[3];
	V1mV2(rCenterPelvis, rCenterRA, rRA_PelvisC);
	
	int ThRLeg[6];
	RP_IK(rRA_PelvisC,PieDer_Rot_Pel,ThRLeg);
	/*
	int ThRLeg[6];
	ThRLeg[0]=ThRLeg_1[0]-Int_VarsWalk[16];
	ThRLeg[1]=ThRLeg_1[1];
	ThRLeg[2]=ThRLeg_1[2];
	ThRLeg[3]=ThRLeg_1[3];
	ThRLeg[4]=ThRLeg_1[4];
	ThRLeg[5]=ThRLeg_1[5];
	if (Int_ValsWalk_Actual[8])
	{
		ThRLeg[1]=ThRLeg_1[1]-Int_VarsWalk[31];
		ThRLeg[2]=ThRLeg_1[2]-Int_VarsWalk[29];
		ThRLeg[3]=ThRLeg_1[3]+Int_VarsWalk[28];
		ThRLeg[4]=ThRLeg_1[4]+Int_VarsWalk[27];
		ThRLeg[5]=ThRLeg_1[5]+Int_VarsWalk[30];
	}
	*/
	//Left Leg
	float W_Rot_PieIzq[9];
	EulXZY_2_Rot(0,0,Deg2Rad(g_LF_Ori[2]), W_Rot_PieIzq);
	float Pel_Rot_PieIzq[9];
	float PieDer_Rot_Pel_Traspose[9];
	Mat3_Traspose(PieDer_Rot_Pel, PieDer_Rot_Pel_Traspose);
	Mat3_Multiply(PieDer_Rot_Pel_Traspose, W_Rot_PieIzq, Pel_Rot_PieIzq);
	
	float rCenterLA[3];
	/*
	rCenterLA[0]=Float_VarsWalk[8]+Float_ValsWalk_Actual[6];
	rCenterLA[1]=Float_VarsWalk[9]+Float_ValsWalk_Actual[7];
	rCenterLA[2]=Float_VarsWalk[7]+Float_ValsWalk_Actual[5];
	*/
	rCenterLA[0]=g_LF_Pos[1];
	rCenterLA[1]=g_LF_Pos[2];
	rCenterLA[2]=g_LF_Pos[0];
	
	float rLA_Pelvis[3];
	V1mV2(rCenterPelvis, rCenterLA, rLA_Pelvis);
	
	int ThLLeg[6];
	LP_IK(rLA_Pelvis,Pel_Rot_PieIzq,ThLLeg);
	/*
	int ThLLeg[6];
	ThLLeg[0]=ThLLeg_1[0]+Int_VarsWalk[15];
	ThLLeg[1]=ThLLeg_1[1];
	ThLLeg[2]=ThLLeg_1[2];
	ThLLeg[3]=ThLLeg_1[3];
	ThLLeg[4]=ThLLeg_1[4];
	ThLLeg[5]=ThLLeg_1[5];
	if (Int_ValsWalk_Actual[9])
	{
		ThLLeg[1]=ThLLeg_1[1]-Int_VarsWalk[26];
		ThLLeg[2]=ThLLeg_1[2]-Int_VarsWalk[24];
		ThLLeg[3]=ThLLeg_1[3]-Int_VarsWalk[23];
		ThLLeg[4]=ThLLeg_1[4]-Int_VarsWalk[22];
		ThLLeg[5]=ThLLeg_1[5]+Int_VarsWalk[25];
	}

	ThBioloid[0]=Int_ValsWalk_Actual[2];
	ThBioloid[1]=Int_ValsWalk_Actual[3];
	ThBioloid[2]=-Int_VarsWalk[10];
	ThBioloid[3]=Int_VarsWalk[10];
	ThBioloid[4]=-Int_VarsWalk[11];
	ThBioloid[5]=Int_VarsWalk[11];
	int Ind_RLeg[6]={6, 8, 10, 12, 14, 16};
	int Ind_LLeg[6]={7, 9, 11, 13, 15, 17};
	for (int i=0; i<6; i++)
	{
		ThBioloid[Ind_RLeg[i]]=ThRLeg_1[i];		
		ThBioloid[Ind_LLeg[i]]=ThLLeg_1[i];
	}	
	*/	
	MoveLeg(ThRLeg, 1);														//Mover la pierna deracha
	MoveLeg(ThLLeg, 2);														//Mover la pierna izquierda
	//MoveShldr(Int_ValsWalk_Actual[2],1);
	//MoveShldr(Int_ValsWalk_Actual[3],2);
}

void MoveLeg(int ThLeg[6], int Tipo)
{
	int IDLeg[6];
	if (Tipo==1)
	{
		IDLeg[0]=7;
		IDLeg[1]=9;
		IDLeg[2]=11;
		IDLeg[3]=13;
		IDLeg[4]=15;
		IDLeg[5]=17;
	}
	else
	{
		IDLeg[0]=8;
		IDLeg[1]=10;
		IDLeg[2]=12;
		IDLeg[3]=14;
		IDLeg[4]=16;
		IDLeg[5]=18;
	}
	int i;
	int CommStatus;
	int ThLegCount[6];

	//Set Velocity of the motors
	dxl_write_word(BROADCAST_ID,P_GOAL_SPEED_L,0);
	CommStatus = dxl_get_result();

	// Set Position of the Motors
	dxl_set_txpacket_id(BROADCAST_ID);
	dxl_set_txpacket_instruction(INST_SYNC_WRITE);
	dxl_set_txpacket_parameter(0, P_GOAL_POSITION_L);
	dxl_set_txpacket_parameter(1, 2);
	for( i=0; i<6; i++ )
	{
		if (Tipo == 1 && IDLeg[i]==13)
		{
			
		}
		else
		{
			ThLegCount[i]=512+round((ThLeg[i])*(1023/300));
			dxl_set_txpacket_parameter(2+3*i, IDLeg[i]);
			dxl_set_txpacket_parameter(2+3*i+1, dxl_get_lowbyte(ThLegCount[i]));
			dxl_set_txpacket_parameter(2+3*i+2, dxl_get_highbyte(ThLegCount[i]));
		}
	}
	dxl_set_txpacket_length((2+1)*6+4);

	dxl_txrx_packet();
	CommStatus = dxl_get_result();
}

void Mat3_Traspose(float Mat_IN[9], float Mat_OUT[9])
{
	Mat_OUT[0]=Mat_IN[0];
	Mat_OUT[1]=Mat_IN[3];
	Mat_OUT[2]=Mat_IN[6];
	Mat_OUT[3]=Mat_IN[1];
	Mat_OUT[4]=Mat_IN[4];
	Mat_OUT[5]=Mat_IN[7];
	Mat_OUT[6]=Mat_IN[2];
	Mat_OUT[7]=Mat_IN[5];
	Mat_OUT[8]=Mat_IN[8];
}

void Mat3_Multiply(float Mat_IN1[9], float Mat_IN2[9], float R[9])
{
	R[0]=Mat_IN1[0]*Mat_IN2[0] +Mat_IN1[1]*Mat_IN2[3] +Mat_IN1[2]*Mat_IN2[6];
	R[1]=Mat_IN1[0]*Mat_IN2[1] +Mat_IN1[1]*Mat_IN2[4] +Mat_IN1[2]*Mat_IN2[7];
	R[2]=Mat_IN1[0]*Mat_IN2[2] +Mat_IN1[1]*Mat_IN2[5] +Mat_IN1[2]*Mat_IN2[8];
	R[3]=Mat_IN1[3]*Mat_IN2[0] +Mat_IN1[4]*Mat_IN2[3] +Mat_IN1[5]*Mat_IN2[6];
	R[4]=Mat_IN1[3]*Mat_IN2[1] +Mat_IN1[4]*Mat_IN2[4] +Mat_IN1[5]*Mat_IN2[7];
	R[5]=Mat_IN1[3]*Mat_IN2[2] +Mat_IN1[4]*Mat_IN2[5] +Mat_IN1[5]*Mat_IN2[8];
	R[6]=Mat_IN1[6]*Mat_IN2[0] +Mat_IN1[7]*Mat_IN2[3] +Mat_IN1[8]*Mat_IN2[6];
	R[7]=Mat_IN1[6]*Mat_IN2[1] +Mat_IN1[7]*Mat_IN2[4] +Mat_IN1[8]*Mat_IN2[7];
	R[8]=Mat_IN1[6]*Mat_IN2[2] +Mat_IN1[7]*Mat_IN2[5] +Mat_IN1[8]*Mat_IN2[8];
}

void SND_Data(float t)
{
	//_delay_ms(1);
	int IDs[18];
	IDs[0]=1;
	IDs[1]=2;
	IDs[2]=3;
	IDs[3]=4;
	IDs[4]=5;
	IDs[5]=6;
	IDs[6]=7;
	IDs[7]=8;
	IDs[8]=9;
	IDs[9]=10;
	IDs[10]=11;
	IDs[11]=12;
	IDs[12]=13;
	IDs[13]=14;
	IDs[14]=15;
	IDs[15]=16;
	IDs[16]=17;
	IDs[17]=18;
	int clave;
	int Dynamixel;
	
	switch (g_Sens)
	{
		case 'A':
			clave='A';
			Dynamixel=0;
		break;
		case 'B':
			clave=P_GOAL_POSITION_L;
			Dynamixel=1;
		break;
		case 'C':
			clave=P_PRESENT_POSITION_L;
			Dynamixel=1;
		break;
		case 'D':
			clave=P_PRESENT_LOAD_L;
			Dynamixel=1;
		break;
		case 'E':
			clave='E';
			Dynamixel=0;
		break;
		case 'F':
			clave='F';
			Dynamixel=0;
		break;
		case 'G':
			clave='G';
			Dynamixel=0;
		break;
	}
	if (Dynamixel==1)
	{
		int result;
		result=zgb_tx_data((int) t);
		int CommStatus;
		int Dato[18];
		for (int i=0; i<18; i++)
		{
			Dato[i]=dxl_read_word(IDs[i],clave);
			CommStatus = dxl_get_result();
			if (CommStatus == COMM_TXSUCCESS || CommStatus == COMM_RXSUCCESS)
			{
				
			}
			else
			{
				Dato[i]=dxl_read_word(IDs[i],clave);
				CommStatus = dxl_get_result();
				if (CommStatus == COMM_TXSUCCESS || CommStatus == COMM_RXSUCCESS)
				{
					
				}
				else
				{
					Dato[i]=dxl_read_word(IDs[i],clave);
					CommStatus = dxl_get_result();
					if (CommStatus == COMM_TXSUCCESS || CommStatus == COMM_RXSUCCESS)
					{
						
					}
					else
					{
						Dato[i]=0xFFFF;
					}
				}
			}
			result=zgb_tx_data(Dato[i]);
		}
	}
	else
	{
		int result;
		switch(clave)
		{
			case 'A':
				result=zgb_tx_data((int) t);
				for (int i=0; i<18; i++)
				{
					//result=zgb_tx_data(ThBioloid[i]);
				}
			break;
			case 'E':
				Envia1Dato(0xFFFF);
				Envia1Dato(0xFFFF);
				Envia1Dato(0xFFFF);
				Envia1Dato((int) t);
				Envia1Dato(g_P_Pos[0]*10);
				Envia1Dato(g_P_Pos[1]*10);
				Envia1Dato(g_P_Pos[2]*10);
				Envia1Dato(g_P_Ori[0]);
				Envia1Dato(g_P_Ori[1]);
				Envia1Dato(g_P_Ori[2]);
			break;
			case 'F':
				Envia1Dato(0xFFFF);
				Envia1Dato(0xFFFF);
				Envia1Dato(0xFFFF);			
				result=zgb_tx_data((int) t);
				result=zgb_tx_data(g_RF_Pos[0]*10);
				result=zgb_tx_data(g_RF_Pos[1]*10);
				result=zgb_tx_data(g_RF_Pos[2]*10);
				result=zgb_tx_data(g_RF_Ori[0]);
				result=zgb_tx_data(g_RF_Ori[1]);
				result=zgb_tx_data(g_RF_Ori[2]);
			break;
			case 'G':
				Envia1Dato(0xFFFF);
				Envia1Dato(0xFFFF);
				Envia1Dato(0xFFFF);			
				result=zgb_tx_data((int) t);
				result=zgb_tx_data(g_LF_Pos[0]*10);
				result=zgb_tx_data(g_LF_Pos[1]*10);
				result=zgb_tx_data(g_LF_Pos[2]*10);
				result=zgb_tx_data(g_LF_Ori[0]);
				result=zgb_tx_data(g_LF_Ori[1]);
				result=zgb_tx_data(g_LF_Ori[2]);
			break;
		}
	}
}

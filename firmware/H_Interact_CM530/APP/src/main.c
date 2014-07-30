/************************* (C) COPYRIGHT 2010 UPSIN **************************
* File Name          : main.c
* Author             : jvnn
* Version            : V0.0.1
* Date               : 09/09/2013
* Description        : TeleOperation_MasterSide
*******************************************************************************/

/* Includes ------------------------------------------------------------------*/
#include "stm32f10x_lib.h"
#include "cm530_Nunez.h"
#include "stm32f10x_nvic.h"
#include "stm32f10x_it.h"
#include "stm32f10x_tim.h"
#include <C:\Program Files (x86)\GNU Tools ARM Embedded\4.8 2014q2\arm-none-eabi\include\math.h>
#include <C:\Program Files (x86)\GNU Tools ARM Embedded\4.8 2014q2\arm-none-eabi\include\stdlib.h>

/* Functions ------------------------------------------------------------------*/

void Init_Params(void);

//Comunications
void SndPrms(int Clave);
void RcvPrms(int Clave);
void EntraOpcion(void);
int Recibe1Dato(void);
void SND_Data(float t);

//Math
void M_V(float Mat[9], float Vec[3], float VecSal[3]);
void V1mV2(float vec1[3], float vec2[3], float Res[3]);
float Deg2Rad(int Angle);
void Mat3_Multiply(float Mat_IN1[9], float Mat_IN2[9], float R[9]);
void Mat3_Traspose(float Mat_IN[9], float Mat_OUT[9]);

//IK
void R2ths_CadI(float Rot[9], float ths[3]);
void R2ths_CadD(float Rot[9], float ths[3]);
void RP_IK(float rRA_Pelvis[3], float RotPelvis[9], int ThRLeg[6]);
void LP_IK(float rLA_Pelvis[3], float RotPelvis[9], int ThLLeg[6]);
void EulXZY_2_Rot(float Pi, float Ro, float Ya, float Rot[9]);

//Move Robot
void MoveLegTime(int ThLeg[6], float Time, int Tipo);
void MoveArmTime(int ThArm[3], float Time, int Tipo);
void Mov_CP(float Pos[3], int Pitch);
void getThArm(int ThArm[3], int Tipo);
void getThLeg(int ThLeg[6], int Tipo);
void a_m_on(void);
void a_m_off(void);
void Mov_P_RF(void);
void Mov_P_LF(void);
void Zancada(int Tipo);
void MarchaDerecha(void);
void MarchaIzquierda(void);
void Mov_L(int ThLeg[6], int Tipo);
void Mov_A(int ThArm[6], int Tipo);

//Cicloidales
float Cicloidal_1(float A,float T, float t);
float Cicloidal_2(float A,float T, float t);
float Cicloidal_3(float A,float T, float t);
float Cicloidal_4(float A,float T, float t);
float Cicloidal_5(float A,float T, float t);

/* Constantes ------------------------------------------------------------------*/
#define PI	3.141592f

/* Variables ------------------------------------------------------------------*/
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

//Parametors patada
int g_Values_4_Int[13];
float g_Values_4_Flt[6];

//Parametros para apoyo simple
int g_RSS;
int g_LSS;

//Posición cartesiana de la Pelvis, pie izquierdo y pie derecho
float g_LF_Pos[3];
int g_LF_Ori[3];
float g_RF_Pos[3];
int g_RF_Ori[3];
float g_P_Pos[3];
int g_P_Ori[3];

int g_Kick=0;
int g_Sens;

int g_Index_Step;

int Flag=0;
int timer;

/*******************************************************************************
* Function Name  : main
* Description    : Main program
* Input          : None
* Output         : None
* Return         : None
*******************************************************************************/
int main(void)
{
	SysInit();

	TIM_TimeBaseInitTypeDef TIM_TimeBaseStructure;

	RCC_APB1PeriphClockCmd(RCC_APB1Periph_TIM2 , ENABLE);

	TIM_TimeBaseStructInit (& TIM_TimeBaseStructure);
	TIM_TimeBaseStructure.TIM_Prescaler	= 71; // 0..719
	TIM_TimeBaseStructure.TIM_Period = 999; // 0..999
	TIM_TimeBaseStructure.TIM_CounterMode = TIM_CounterMode_Up;
	TIM_TimeBaseInit(TIM2 , &TIM_TimeBaseStructure);

	NVIC_PriorityGroupConfig(NVIC_PriorityGroup_0);

	//Configuración de interrupciones
	NVIC_InitTypeDef NVIC_InitStructureTIM2;
	NVIC_InitStructureTIM2.NVIC_IRQChannel = TIM2_IRQChannel;
	NVIC_InitStructureTIM2.NVIC_IRQChannelSubPriority = 3;
	NVIC_InitStructureTIM2.NVIC_IRQChannelPreemptionPriority = 0;
	NVIC_InitStructureTIM2.NVIC_IRQChannelCmd = ENABLE;
	NVIC_Init (&NVIC_InitStructureTIM2);

    //Habilita interrupciones
	TIM_ITConfig(TIM2 , TIM_IT_Update , ENABLE);
	//Activa el timer2

	TIM_Cmd(TIM2 , ENABLE);

	Init_Params();

	while(1)
    {
       EntraOpcion();
    }
		return 0;
}

void EntraOpcion()
{
	int Int_Opcion;
	char Opcion;

	Int_Opcion=Recibe1Dato();
	Opcion = Int_Opcion;

	int Clave;

	float Pos[3];
	int Pitch;

	switch (Opcion)
	{
		case 's':
		Clave=Recibe1Dato();
		RcvPrms(Clave);
		break;
		case 'g':
		Clave=Recibe1Dato();
		mDelay(300);
		SndPrms(Clave);
		break;
		case 'w':
		//EEPROM_w();
		break;
		case 'r':
		//EEPROM_r();
		break;
		case '0':
			Pos[0]=-1.0;
			Pos[1]=0.0;
			Pos[2]=10.0;
			Pitch = 10;
			Mov_CP(Pos, Pitch);
			mDelay(2500);
			a_m_off();
		break;
		case '1':
			Pos[0]=g_Values_1_Flt[0];
			Pos[1]=0.0;
			Pos[2]=g_Values_1_Flt[1];
			Pitch = g_Values_1_Int[1];
			Mov_CP(Pos, Pitch);
		break;
		case '2':
		g_Sens=Recibe1Dato();
		g_Kick=Recibe1Dato();
		if (g_Values_1_Int[0] > 1)
		{
			MarchaIzquierda();
		}
		break;
		case '3':
		g_Sens=Recibe1Dato();
		g_Kick=Recibe1Dato();
		if (g_Values_1_Int[0] > 1 )
		{
			MarchaDerecha();
		}
		break;
	}
}

void RcvPrms(int Clave)
{
	int Dato=0;
	float fDato= 0;
	switch (Clave)
	{
		case 'a':
			g_Values_1_Int[0]=Recibe1Dato();
			Dato=Recibe1Dato();
			if (Dato > 32767)
			{
				Dato=-((65535-Dato)+1);
			}
			fDato=(float) Dato;
			fDato=fDato/10;
			g_Values_1_Flt[0]=fDato;
			Dato=Recibe1Dato();
			if (Dato > 32767)
			{
				Dato=-((65535-Dato)+1);
			}
			fDato=(float) Dato;
			fDato=fDato/10;
			g_Values_1_Flt[1]=fDato;
			g_Values_1_Int[1]=Recibe1Dato();
			Dato=Recibe1Dato();
			if (Dato > 32767)
			{
				Dato=-((65535-Dato)+1);
			}
			fDato=(float) Dato;
			fDato=fDato/10;
			g_Values_1_Flt[2]=fDato;
			g_Values_1_Int[2]=Recibe1Dato();
			Dato=Recibe1Dato();
			if (Dato > 32767)
			{
				Dato=-((65535-Dato)+1);
			}
			fDato=(float) Dato;
			fDato=fDato/10;
			g_Values_1_Flt[3]=fDato;
			Dato=Recibe1Dato();
			if (Dato > 32767)
			{
				Dato=-((65535-Dato)+1);
			}
			fDato=(float) Dato;
			fDato=fDato/10;
			g_Values_1_Flt[4]=fDato;
			Dato=Recibe1Dato();
			if (Dato > 32767)
			{
				Dato=-((65535-Dato)+1);
			}
			fDato=(float) Dato;
			fDato=fDato/10;
			g_Values_1_Flt[5]=fDato;
			for (int i=3; i<12; i++)
			{
				g_Values_1_Int[i]=Recibe1Dato();
			}
		break;
		case 'b':
			for (int i=0; i<3; i++)
			{
				Dato=Recibe1Dato();
				if (Dato > 32767)
				{
					Dato=-((65535-Dato)+1);
				}
				fDato=(float) Dato;
				fDato=fDato/10;
				g_Values_2_Flt[i]=fDato;
			}
			for (int i=0; i<11; i++)
			{
				g_Values_2_Int[i]=Recibe1Dato();
			}
			for (int i=3; i<6; i++)
			{
				Dato=Recibe1Dato();
				if (Dato > 32767)
				{
					Dato=-((65535-Dato)+1);
				}
				fDato=(float) Dato;
				fDato=fDato/10;
				g_Values_2_Flt[i]=fDato;
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
		case 'd':
			g_Values_4_Int[0]=Recibe1Dato();
			Dato=Recibe1Dato();
			if (Dato > 32767)
			{
				Dato=-((65535-Dato)+1);
			}
			fDato=(float) Dato;
			fDato=fDato/10;
			g_Values_4_Flt[0]=fDato;
			Dato=Recibe1Dato();
			if (Dato > 32767)
			{
				Dato=-((65535-Dato)+1);
			}
			fDato=(float) Dato;
			fDato=fDato/10;
			g_Values_4_Flt[1]=fDato;
			g_Values_4_Int[1]=Recibe1Dato();
			Dato=Recibe1Dato();
			if (Dato > 32767)
			{
				Dato=-((65535-Dato)+1);
			}
			fDato=(float) Dato;
			fDato=fDato/10;
			g_Values_4_Flt[2]=fDato;
			g_Values_4_Int[2]=Recibe1Dato();
			Dato=Recibe1Dato();
			if (Dato > 32767)
			{
				Dato=-((65535-Dato)+1);
			}
			fDato=(float) Dato;
			fDato=fDato/10;
			g_Values_4_Flt[3]=fDato;
			Dato=Recibe1Dato();
			if (Dato > 32767)
			{
				Dato=-((65535-Dato)+1);
			}
			fDato=(float) Dato;
			fDato=fDato/10;
			g_Values_4_Flt[4]=fDato;
			Dato=Recibe1Dato();
			if (Dato > 32767)
			{
				Dato=-((65535-Dato)+1);
			}
			fDato=(float) Dato;
			fDato=fDato/10;
			g_Values_4_Flt[5]=fDato;
			for (int i=3; i<13; i++)
			{
				g_Values_4_Int[i]=Recibe1Dato();
			}
			break;
	}
}

void SndPrms(int Clave)
{
	switch (Clave)
	{
		case 'a':
			mDelay(3);
			zgb_tx_data(g_Values_1_Int[0]);
			mDelay(3);
			zgb_tx_data((int) (g_Values_1_Flt[0]*10));
			mDelay(3);
			zgb_tx_data((int) (g_Values_1_Flt[1]*10));
			mDelay(3);
			zgb_tx_data(g_Values_1_Int[1]);
			mDelay(3);
			zgb_tx_data((int) (g_Values_1_Flt[2]*10));
			mDelay(3);
			zgb_tx_data(g_Values_1_Int[2]);
			mDelay(3);
			zgb_tx_data((int) (g_Values_1_Flt[3]*10));
			mDelay(3);
			zgb_tx_data((int) (g_Values_1_Flt[4]*10));
			mDelay(3);
			zgb_tx_data((int) (g_Values_1_Flt[5]*10));
			for (int i=3; i<12; i++)
			{
				mDelay(3);
				zgb_tx_data(g_Values_1_Int[i]);
			}
		break;
		case 'b':
			for (int i=0; i<3; i++)
			{
				mDelay(3);
				zgb_tx_data((int) (g_Values_2_Flt[i]*10));
			}
			for (int i=0; i<11; i++)
			{
				mDelay(3);
				zgb_tx_data(g_Values_2_Int[i]);
			}
			for (int i=3; i<6; i++)
			{
				mDelay(3);
				zgb_tx_data((int) (g_Values_2_Flt[i]*10));
			}
			for (int i=11; i<22; i++)
			{
				mDelay(3);
				zgb_tx_data(g_Values_2_Int[i]);
			}
		break;
		case 'c':
			mDelay(3);
			zgb_tx_data((int) (g_Values_3_Flt[0]*10));
			mDelay(3);
			zgb_tx_data((int) (g_Values_3_Flt[1]*10));
			mDelay(3);
			zgb_tx_data(g_Values_3_Int[0]);
			mDelay(3);
			zgb_tx_data((int) (g_Values_3_Flt[2]*10));
			mDelay(3);
			zgb_tx_data(g_Values_3_Int[1]);
			for (int i=2; i<26; i++)
			{
				mDelay(3);
				zgb_tx_data(g_Values_3_Int[i]);
			}
		break;
		case 'd':
			mDelay(3);
			zgb_tx_data(g_Values_4_Int[0]);
			mDelay(3);
			zgb_tx_data((int) (g_Values_4_Flt[0]*10));
			mDelay(3);
			zgb_tx_data((int) (g_Values_4_Flt[1]*10));
			mDelay(3);
			zgb_tx_data(g_Values_4_Int[1]);
			mDelay(3);
			zgb_tx_data((int) (g_Values_4_Flt[2]*10));
			mDelay(3);
			zgb_tx_data(g_Values_4_Int[2]);
			mDelay(3);
			zgb_tx_data((int) (g_Values_4_Flt[3]*10));
			mDelay(3);
			zgb_tx_data((int) (g_Values_4_Flt[4]*10));
			mDelay(3);
			zgb_tx_data((int) (g_Values_4_Flt[5]*10));
			for (int i=3; i<13; i++)
			{
				mDelay(3);
				zgb_tx_data(g_Values_4_Int[i]);
			}
		break;
	}
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
	return 0;
}

void a_m_off(void)
{
	//int CommStatus=0;
	dxl_write_byte(BROADCAST_ID,AXM_TORQUE_ENABLE,0);
	//CommStatus = dxl_get_result();
}

void a_m_on(void)
{
	//int CommStatus;
	dxl_write_byte(BROADCAST_ID,AXM_TORQUE_ENABLE,1);
	//CommStatus = dxl_get_result();
}

void Mov_CP(float Pos[3], int Pitch)
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
	float Val=-1;
	/*
	Prints32d((int) Val);
	PrintString("  \r \n");

	Prints32d(g_Values_2_Flt[4]);
	PrintString("  \r \n");
	Prints32d(g_Values_2_Flt[5]);
	PrintString("  \r \n");
	Prints32d(g_Values_2_Flt[3]);
	PrintString("  \r \n");
	*/
	float rRA_PelvisD[3];
	V1mV2(rCenterPelvis, rCenterRA, rRA_PelvisD);

	int ThRLeg[6];
	RP_IK(rRA_PelvisD,RotPelvisD,ThRLeg);
	ThRLeg[0]=ThRLeg[0]+g_Values_2_Int[11];

	/*
	PrintString("  ----- IK RLeg --------\r \n");
	Prints32d(ThRLeg[0]);
	PrintString("  \r \n");
	Prints32d(ThRLeg[1]);
	PrintString("  \r \n");
	Prints32d(ThRLeg[2]);
	PrintString("  \r \n");
	Prints32d(ThRLeg[3]);
	PrintString("  \r \n");
	Prints32d(ThRLeg[4]);
	PrintString("  \r \n");
	Prints32d(ThRLeg[5]);
	PrintString("  \r \n ----- IK RLeg -------- \r \n");
	*/
	//Left Leg
	float rCenterLA[3];
	rCenterLA[0]=3.85+g_Values_2_Flt[1];
	rCenterLA[1]=0.0+g_Values_2_Flt[2];
	rCenterLA[2]=0.0+g_Values_2_Flt[0];

	/*
	Prints32d(g_Values_2_Flt[1]);
	PrintString("  \r \n");
	Prints32d(g_Values_2_Flt[2]);
	PrintString("  \r \n");
	Prints32d(g_Values_2_Flt[0]);
	PrintString("  \r \n");
	*/

	float rLA_PelvisD[3];
	V1mV2(rCenterPelvis, rCenterLA, rLA_PelvisD);

	int ThLLeg[6];
	LP_IK(rLA_PelvisD,RotPelvisD,ThLLeg);
	ThLLeg[0]=ThLLeg[0]+g_Values_2_Int[0];
	/*
	PrintString("  ----- IK RLeg --------\r \n");
	Prints32d(ThLLeg[0]);
	PrintString("  \r \n");
	Prints32d(ThLLeg[1]);
	PrintString("  \r \n");
	Prints32d(ThLLeg[2]);
	PrintString("  \r \n");
	Prints32d(ThLLeg[3]);
	PrintString("  \r \n");
	Prints32d(ThLLeg[4]);
	PrintString("  \r \n");
	Prints32d(ThLLeg[5]);
	PrintString("  \r \n ----- IK RLeg -------- \r \n");
	*/
	int ThLArm[3];
	int ThRArm[3];
	ThRArm[0]=-90+g_Values_1_Int[4];
	ThRArm[1]=-g_Values_1_Int[5];
	ThRArm[2]=-g_Values_1_Int[6];

	ThLArm[0]=90-g_Values_1_Int[4];
	ThLArm[1]=g_Values_1_Int[5];
	ThLArm[2]=g_Values_1_Int[6];

	a_m_on();																			//Activa los torques de todos los motores
	mDelay(5);																				//Delay de 5ms

	float T=2;

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

	float var1=x1*x1+y1*y1+z1*z1;
	float l=sqrt(var1);
	float cosG=-(l*l-2*Lb*Lb)/(2*Lb*Lb);
	float var2=1-cosG*cosG;
	float sinG=sqrt(var2);
	float G=PI-atan2(sinG,cosG);
	float a0=atan2(L8,L7);

	float th14=(G+2*a0);

	float cosa1=(y1*y1+z1*z1)/(sqrt(y1*y1+z1*z1)*l);
	float var3=1-cosa1*cosa1;
	float sina1=sqrt(var3);
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
	float var1=x1*x1+y1*y1+z1*z1;
	float l=sqrt(var1);
	float cosG=-(l*l-2*Lb*Lb)/(2*Lb*Lb);
	float var2=1-cosG*cosG;
	float sinG=sqrt(var2);
	float G=PI-atan2(sinG,cosG);
	float a0=atan2(L8,L7);

	float th13=-(G+2*a0);

	float cosa1=(y1*y1+z1*z1)/(sqrt(y1*y1+z1*z1)*l);
	float var3=1-cosa1*cosa1;
	float sina1=sqrt(var3);
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
	float th9=0;
	float th11=0;
	float th7p=0;

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
	float th12=0;
	float th10=0;
	float th8p=0;

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

float Deg2Rad(int Angle)
{
	float Rad;
	Rad=(float) Angle*PI/180;
	return Rad;
}

void MoveLegTime(int ThLeg[6], float Time, int Tipo)
{
	//int CommStatus;
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
	dxl_set_txpacket_parameter(0, AXM_MOVING_SPEED_L);
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
		mDelay(5);
	}
	dxl_set_txpacket_length((2+1)*6+4);

	dxl_txrx_packet();
	//CommStatus = dxl_get_result();

	// Set Position of the Motors
	dxl_set_txpacket_id(BROADCAST_ID);
	dxl_set_txpacket_instruction(INST_SYNC_WRITE);
	dxl_set_txpacket_parameter(0, AXM_GOAL_POSITION_L);
	dxl_set_txpacket_parameter(1, 2);
	for( i=0; i<6; i++ )
	{
		dxl_set_txpacket_parameter(2+3*i, IDLeg[i]);
		dxl_set_txpacket_parameter(2+3*i+1, dxl_get_lowbyte(ThLegCount[i]));
		dxl_set_txpacket_parameter(2+3*i+2, dxl_get_highbyte(ThLegCount[i]));
	}
	dxl_set_txpacket_length((2+1)*12+4);

	dxl_txrx_packet();
	//CommStatus = dxl_get_result();
}

void MoveArmTime(int ThArm[3], float Time, int Tipo)
{
	//int CommStatus;
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
	dxl_set_txpacket_parameter(0, AXM_MOVING_SPEED_L);
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
	//CommStatus = dxl_get_result();

	// Set Position of the Motors
	dxl_set_txpacket_id(BROADCAST_ID);
	dxl_set_txpacket_instruction(INST_SYNC_WRITE);
	dxl_set_txpacket_parameter(0, AXM_GOAL_POSITION_L);
	dxl_set_txpacket_parameter(1, 2);
	for( i=0; i<3; i++ )
	{
		dxl_set_txpacket_parameter(2+3*i, IDArm[i]);
		dxl_set_txpacket_parameter(2+3*i+1, dxl_get_lowbyte(ThArmCount[i]));
		dxl_set_txpacket_parameter(2+3*i+2, dxl_get_highbyte(ThArmCount[i]));
	}
	dxl_set_txpacket_length((2+1)*3+4);

	dxl_txrx_packet();
	//CommStatus = dxl_get_result();
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
	//int CommStatus;
	for (i=0; i<6; i++)
	{
		ThLeg[i]=dxl_read_word(IDLeg[i],AXM_PRESENT_POSITION_L);
		//CommStatus = dxl_get_result();
		mDelay(5);
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
	//int CommStatus;
	for (i=0; i<3; i++)
	{
		ThArm[i]=dxl_read_word(IDArm[i],AXM_PRESENT_POSITION_L);
		//CommStatus = dxl_get_result();
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

	//Parametors principales
	int Values_Int[12];
	float Values_Flt[6];
	int Flag_Kick=0;

	for (int i=0; i<12; i++)
	{
		Values_Int[i]=g_Values_1_Int[i];
	}
	for (int i=0; i<6; i++)
	{
		Values_Flt[i]=g_Values_1_Flt[i];
	}
	if ((g_Kick==1) && (g_Index_Step==Values_Int[0]-1))
	{
		for (int i=0; i<12; i++)
		{
			Values_Int[i]=g_Values_4_Int[i];
		}
		for (int i=0; i<6; i++)
		{
			Values_Flt[i]=g_Values_4_Flt[i];
		}
		Flag_Kick=1;
	}

	float CP_x=Values_Flt[0];
	float CP_z=Values_Flt[1];
	float DP_y=Values_Flt[2];
	int i_CP_th=Values_Int[1];
	float CP_th=(float) i_CP_th;
	int i_DP_phi=Values_Int[2];
	float DP_phi=(float) i_DP_phi;

	float DF_x=Values_Flt[3];
	float DF_y=Values_Flt[4];
	float DF_z=Values_Flt[5];
	int i_DF_psi=Values_Int[3];
	float DF_psi=(float) i_DF_psi;
	if (i_DF_psi > 32767)
	{
		DF_psi=-((65535-i_DF_psi)+1);
	}
	int i_CS_th=Values_Int[4];
	float CS_th=(float) i_CS_th;
	int i_DS_th=Values_Int[7];
	float DS_th=(float) i_DS_th;

	int i_T =Values_Int[8];
	float T= (float) i_T;
	int i_T_ds =Values_Int[9];
	float T_ds= (float) i_T_ds;
	int i_t_ini =Values_Int[10];
	float t_ini= (float) i_t_ini;
	int i_T_ss=Values_Int[11];
	float T_ss= (float) i_T_ss;

	float T_zFmax;
	float DF_xKick;

	if (Flag_Kick==1)
	{
	    DF_x=g_Values_1_Flt[3];
	    T_zFmax=(float) g_Values_4_Int[12];
	    DF_xKick=Values_Flt[3];
	}

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

	int i_Th_RA=-90+CS_th;
	float Th_RA=(float) i_Th_RA;
	int i_Th_LA= 90-CS_th;
	float Th_LA=(float) i_Th_LA;
	float T1=((T-T_ds)/2);

	float L_1=4.8;
	float L_2=3.85;
	float c_th=cos(Deg2Rad(i_DF_psi));
	float s_th=sin(Deg2Rad(i_DF_psi));

	float D_x_TurnP=L_1*(-1+c_th);
	float D_y_TurnP=L_1*s_th;

	float D_x_Turn_fFin=0;
	float D_y_Turn_fFin=0;
	float D_x_Turn_fIni=0;
	float D_y_Turn_fIni=0;

	if (i_DF_psi>=0)
	{
		D_x_Turn_fFin=L_1*(-1+c_th)-L_2*(s_th);
		D_y_Turn_fFin=L_1*s_th     +L_2*(-1+c_th);
		D_x_Turn_fIni=L_1*(-1+c_th)-L_2*s_th;
		D_y_Turn_fIni=-L_1*s_th-L_2*(-1+c_th);
	}
	else
	{
		D_x_Turn_fFin=L_1*(-1+c_th)+L_2*(s_th);
		D_y_Turn_fFin=L_1*s_th     -L_2*(-1+c_th);
		D_x_Turn_fIni=L_1*(-1+c_th)+L_2*s_th;
		D_y_Turn_fIni=-L_1*s_th+L_2*(-1+c_th);
	}

	float T_local=0.0;
	float t_local;

	//Posición y orientación del pie fijo
	float Ff_x;
	float Ff_y;
	float Ff_z;
	float Ff_psi;

	//Posición y orientación del pie movil
	float Mf_x;
	float Mf_y;
	float Mf_z;
	float Mf_psi;

	//Posición y orientación de la pelvis
	float P_x;
	float P_y;
	float P_phi;
	float P_psi;

	//Amplitudes
	float Mf_Lx;
	float P_Ly1;
	float P_Ly2;

	//Tiempos
	timer=0;

	g_RSS=0;
	g_LSS=0;
	int Ff_SS=0;

	while (timer <= i_T)
	{
		float t=(float) timer;
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
		}
		else
		{
			if ((DF_y >=0) && (Tipo ==3 || Tipo == 5))
			{
				Ff_y=Ff_y+DF_y/2;
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
			float T_ss1;
			if ((Tipo==5 || Tipo==6) && g_Kick==1)
			{
			    T_ss1=T_ss+ T_zFmax;
			}
			else
			{
				T_ss1=T_ss;
			}
			if (t < (t_ini+T_ss1))
			{
				Ff_SS=1;
				T_local= T_ss1;
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
						if (g_Kick==1)
						{
							if (t < (t_ini+T_ss/2))
							{
								T_local=T_ss/2;
						        Mf_x=-Mf_Lx/4+Cicloidal_3(Mf_Lx/2,T_local,t_local);
							}
						    else
						    {
						    	if (t <(t_ini+T_ss/2+T_zFmax/2))
						    	{
						    		T_local=T_zFmax/2;
						            t_local=t-(t_ini+T_ss/2);
						            Mf_x=Mf_Lx/4+Cicloidal_4(DF_xKick,T_local,t_local);
						    	}
						        else
						        {
						        	if (t < (t_ini+T_ss/2+T_zFmax))
						        	{
						        		t_local=t-(t_ini+T_ss/2+T_zFmax/2);
						                T_local=T_zFmax/2;
						                Mf_x=Mf_Lx/4+DF_xKick-Cicloidal_1(DF_xKick,T_local,t_local);
						        	}
						            else
						            {
						            	Mf_x=Mf_Lx/4;
						            }
						         }
						     }
						}
						else
						{
							Mf_x=-Mf_Lx/4+Cicloidal_1(Mf_Lx/2,T_local,t_local);
						}
					}
				}
				T_local=T_ss1;
				t_local=t-t_ini;
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
				if ((Tipo==5 || Tipo==6) && g_Kick==1)
				{
					if (t < (t_ini+T_ss/2))
					{
						T_local=T_ss/2;
				        Mf_z=Cicloidal_1(DF_z,T_local,t_local);
					}
				    else
				    {
				    	if (t <(t_ini+T_ss/2+T_zFmax))
				    	{
				                    Mf_z=DF_z;
				    	}
				        else
				        {
				        	T_local=T_ss/2;
				            t_local=t-(t_ini+T_ss/2+T_zFmax);
				            Mf_z=DF_z-Cicloidal_1(DF_z,T_local,t_local);
				        }
				    }
				}
				else
				{
					Mf_z=Cicloidal_2(DF_z,T_local,t_local);
				}
			}
			else
			{
				Ff_SS=0;
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
					{
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
		if (Tipo==1 || Tipo == 2)
		{
            Th_RA=-90.0+ CS_th+E*Cicloidal_1(DS_th/2,T,t);
            Th_LA= 90.0- CS_th+E*Cicloidal_1(DS_th/2,T,t);
		}
		if (Tipo==3 || Tipo == 4)
		{
            Th_RA=-90.0+ CS_th-E*(DS_th/2-Cicloidal_1(DS_th,T,t));
            Th_LA= 90.0- CS_th-E*(DS_th/2-Cicloidal_1(DS_th,T,t));
		}
		if (Tipo==5 || Tipo == 6)
		{
            Th_RA=-90.0+ CS_th-E*(DS_th/2-Cicloidal_1(DS_th/2,T,t));
            Th_LA= 90.0- CS_th-E*(DS_th/2-Cicloidal_1(DS_th/2,T,t));
		}

		//Movimiento
		g_P_Pos[0]=P_x+CP_x;
		g_P_Pos[1]=P_y;
		g_P_Pos[2]=CP_z;
		g_P_Ori[0]=(int) P_phi;
		g_P_Ori[1]=(int) CP_th;
		g_P_Ori[2]=(int) P_psi;

		g_thRArm[0]=(int) Th_RA;
		g_thRArm[1]=-Values_Int[5];
		g_thRArm[2]=-Values_Int[6];

		g_thLArm[0]=(int) Th_LA;
		g_thLArm[1]=Values_Int[5];
		g_thLArm[2]=Values_Int[6];

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
				g_LSS=Ff_SS;

				g_RF_Pos[0]=Mf_x;
				g_RF_Pos[1]=Mf_y;
				g_RF_Pos[2]=Mf_z;
				g_RF_Ori[0]=0;
				g_RF_Ori[1]=0;
				g_RF_Ori[2]=(int) Mf_psi;
				g_RSS=0;

				Mov_P_RF();
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
				g_RSS=Ff_SS;

				g_LF_Pos[0]=Mf_x;
				g_LF_Pos[1]=Mf_y;
				g_LF_Pos[2]=Mf_z;
				g_LF_Ori[0]=0;
				g_LF_Ori[1]=0;
				g_LF_Ori[2]=(int) Mf_psi;
				g_LSS=0;

				Mov_P_LF();
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
void Mov_P_RF()
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
	rCenterLA[0]=g_LF_Pos[1]+g_Values_2_Flt[1];
	rCenterLA[1]=g_LF_Pos[2]+g_Values_2_Flt[2];
	rCenterLA[2]=g_LF_Pos[0]+g_Values_2_Flt[0];

	float rLA_Pelvis[3];
	V1mV2(rCenterPelvis, rCenterLA, rLA_Pelvis);
	int ThLLeg[6];
	LP_IK(rLA_Pelvis,PieIzq_Rot_Pel,ThLLeg);
	ThLLeg[0]=ThLLeg[0]+g_Values_2_Int[0];
	if (g_LSS)
	{
		ThLLeg[1]=ThLLeg[1]+g_Values_2_Int[5];	//10	LHS_Lat
		ThLLeg[2]=ThLLeg[2]+g_Values_2_Int[3];	//12	LHS_Fr
		ThLLeg[3]=ThLLeg[3]-g_Values_2_Int[2];	//14	LKS_Fr
		ThLLeg[4]=ThLLeg[4]+g_Values_2_Int[1];	//16	LAS_Fr
		ThLLeg[5]=ThLLeg[5]-g_Values_2_Int[4];	//18    LAS_Lat
	}

	//Right Leg
	float W_Rot_PieDer[9];
	float PieIzq_Rot_Pel_Traspose[9];
	float Pel_Rot_PieDer[9];
	EulXZY_2_Rot(Cero,Cero,Deg2Rad(g_RF_Ori[2]), W_Rot_PieDer);
	Mat3_Traspose(PieIzq_Rot_Pel,PieIzq_Rot_Pel_Traspose);
	Mat3_Multiply(PieIzq_Rot_Pel_Traspose,W_Rot_PieDer,Pel_Rot_PieDer);

	float r_Center1_RA[3];
	r_Center1_RA[0]=g_RF_Pos[1]+g_Values_2_Flt[4];
	r_Center1_RA[1]=g_RF_Pos[2]+g_Values_2_Flt[5];
	r_Center1_RA[2]=g_RF_Pos[0]+g_Values_2_Flt[3];

	float	r_RA_Pel[3];
	V1mV2(rCenterPelvis, r_Center1_RA, r_RA_Pel);
	int ThRLeg[6];
	float Pel_Rot_PieDer_Tr[9];
	Mat3_Traspose(Pel_Rot_PieDer,Pel_Rot_PieDer_Tr);
	float r_RA_Pel_1[3];
	float W_Rot_PieDer_Tr[9];
	Mat3_Traspose(W_Rot_PieDer,W_Rot_PieDer_Tr);
	M_V(W_Rot_PieDer_Tr,r_RA_Pel,r_RA_Pel_1);
	RP_IK(r_RA_Pel_1,Pel_Rot_PieDer_Tr,ThRLeg);
	ThRLeg[0]=ThRLeg[0]+g_Values_2_Int[11];
	if (g_LSS)
	{
		ThRLeg[1]=ThRLeg[1]-g_Values_2_Int[21];	//9		RHNS_Lat
		ThRLeg[2]=ThRLeg[2]-g_Values_2_Int[19];	//11	RHNS_Fr
		ThRLeg[3]=ThRLeg[3]-g_Values_2_Int[18];	//13	RKNS_Fr
		ThRLeg[4]=ThRLeg[4]-g_Values_2_Int[17];	//15	RANS_Fr
		ThRLeg[5]=ThRLeg[5]+g_Values_2_Int[20];	//17	RANS_Lat
	}

	Mov_L(ThRLeg,1);														//Mover la pierna deracha
	Mov_L(ThLLeg,2);														//Mover la pierna izquierda
	Mov_A(g_thRArm,1);														//Mover la pierna deracha
	Mov_A(g_thLArm,2);														//Mover la pierna izquierda
}

void Mov_P_LF()
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
	rCenterRA[0]=g_RF_Pos[1]+g_Values_2_Flt[4];
	rCenterRA[1]=g_RF_Pos[2]+g_Values_2_Flt[5];
	rCenterRA[2]=g_RF_Pos[0]+g_Values_2_Flt[3];

	float rRA_PelvisC[3];
	V1mV2(rCenterPelvis, rCenterRA, rRA_PelvisC);

	int ThRLeg[6];
	RP_IK(rRA_PelvisC,PieDer_Rot_Pel,ThRLeg);
	ThRLeg[0]=ThRLeg[0]+g_Values_2_Int[11];
	if (g_RSS)
	{
		ThRLeg[1]=ThRLeg[1]-g_Values_2_Int[16]; //9   RHS_Lat
		ThRLeg[2]=ThRLeg[2]-g_Values_2_Int[14]; //11  RHS_Front
		ThRLeg[3]=ThRLeg[3]+g_Values_2_Int[13]; //13  RKS_Front
		ThRLeg[4]=ThRLeg[4]-g_Values_2_Int[12]; //15  RAS_Front
		ThRLeg[5]=ThRLeg[5]+g_Values_2_Int[15]; //17  RAS_Lat
	}
	//Left Leg
	float W_Rot_PieIzq[9];
	EulXZY_2_Rot(0,0,Deg2Rad(g_LF_Ori[2]), W_Rot_PieIzq);
	float Pel_Rot_PieIzq[9];
	float PieDer_Rot_Pel_Tr[9];
	Mat3_Traspose(PieDer_Rot_Pel, PieDer_Rot_Pel_Tr);
	Mat3_Multiply(PieDer_Rot_Pel_Tr, W_Rot_PieIzq, Pel_Rot_PieIzq);

	float rCenterLA[3];
	rCenterLA[0]=g_LF_Pos[1]+g_Values_2_Flt[1];
	rCenterLA[1]=g_LF_Pos[2]+g_Values_2_Flt[2];
	rCenterLA[2]=g_LF_Pos[0]+g_Values_2_Flt[0];

	float rLA_Pelvis[3];
	V1mV2(rCenterPelvis, rCenterLA, rLA_Pelvis);
	float rLA_Pelvis_1[3];

	float W_Rot_PieIzq_Tr[9];
	Mat3_Traspose(W_Rot_PieIzq,W_Rot_PieIzq_Tr);
	M_V(W_Rot_PieIzq_Tr,rLA_Pelvis,rLA_Pelvis_1);

	float Pel_Rot_PieIzq_Tr[9];
	Mat3_Traspose(Pel_Rot_PieIzq,Pel_Rot_PieIzq_Tr);

	int ThLLeg[6];
	LP_IK(rLA_Pelvis_1,Pel_Rot_PieIzq_Tr,ThLLeg);
	ThLLeg[0]=ThLLeg[0]+g_Values_2_Int[0];

	if (g_RSS)
	{
		ThLLeg[1]=ThLLeg[1]+g_Values_2_Int[10];		//10   LHNS_Lat
		ThLLeg[2]=ThLLeg[2]+g_Values_2_Int[8];		//12   LHNS_Frnt
		ThLLeg[3]=ThLLeg[3]+g_Values_2_Int[7];		//14   LKNS_Frnt
		ThLLeg[4]=ThLLeg[4]+g_Values_2_Int[6];		//16   LANS_Frnt
		ThLLeg[5]=ThLLeg[5]-g_Values_2_Int[9];		//18   LANS_Lat
	}
	Mov_L(ThRLeg, 1);														//Mover la pierna deracha
	Mov_L(ThLLeg, 2);														//Mover la pierna izquierda
	Mov_A(g_thRArm, 1);														//Mover la pierna deracha
	Mov_A(g_thLArm, 2);														//Mover la pierna izquierda
}

void Mov_L(int ThLeg[6], int Tipo)
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
	//int CommStatus;
	int ThLegCount[6];

	//Set Velocity of the motors
	dxl_write_word(BROADCAST_ID,AXM_MOVING_SPEED_L,1023);
	//CommStatus = dxl_get_result();

	// Set Position of the Motors
	dxl_set_txpacket_id(BROADCAST_ID);
	dxl_set_txpacket_instruction(INST_SYNC_WRITE);
	dxl_set_txpacket_parameter(0, AXM_GOAL_POSITION_L);
	dxl_set_txpacket_parameter(1, 2);
	for( i=0; i<6; i++ )
	{
		ThLegCount[i]=512+round((ThLeg[i])*(1023/300));
		dxl_set_txpacket_parameter(2+3*i, IDLeg[i]);
		dxl_set_txpacket_parameter(2+3*i+1, dxl_get_lowbyte(ThLegCount[i]));
		dxl_set_txpacket_parameter(2+3*i+2, dxl_get_highbyte(ThLegCount[i]));
	}
	dxl_set_txpacket_length((2+1)*6+4);

	dxl_txrx_packet();
	//CommStatus = dxl_get_result();
}

void Mov_A(int ThArm[6], int Tipo)
{
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
	//int CommStatus;
	int ThArmCount[3];

	//Set Velocity of the motors
	dxl_write_word(BROADCAST_ID,AXM_MOVING_SPEED_L,1023);
	//CommStatus = dxl_get_result();

	// Set Position of the Motors
	dxl_set_txpacket_id(BROADCAST_ID);
	dxl_set_txpacket_instruction(INST_SYNC_WRITE);
	dxl_set_txpacket_parameter(0, AXM_GOAL_POSITION_L);
	dxl_set_txpacket_parameter(1, 2);
	for( i=0; i<3; i++ )
	{
		ThArmCount[i]=512+round((ThArm[i])*(1023/300));
		dxl_set_txpacket_parameter(2+3*i, IDArm[i]);
		dxl_set_txpacket_parameter(2+3*i+1, dxl_get_lowbyte(ThArmCount[i]));
		dxl_set_txpacket_parameter(2+3*i+2, dxl_get_highbyte(ThArmCount[i]));
	}
	dxl_set_txpacket_length((2+1)*3+4);

	dxl_txrx_packet();
	//CommStatus = dxl_get_result();
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
	int clave=0;
	int Dynamixel=0;
	float Var1=0;
	int Var2=0;

	switch (g_Sens)
	{
		case 'A':
			clave='A';
			Dynamixel=0;
		break;
		case 'B':
			clave=AXM_GOAL_POSITION_L;
			Dynamixel=1;
		break;
		case 'C':
			clave=AXM_PRESENT_POSITION_L;
			Dynamixel=1;
		break;
		case 'D':
			clave=AXM_PRESENT_LOAD_L;
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
		//int result;
		//result=zgb_tx_data((int) t);
		zgb_tx_data((int) t);
		int CommStatus;
		int Dato[18];
		for (int i=0; i<18; i++)
		{
			Dato[i]=dxl_read_word(IDs[i],clave);
			CommStatus = dxl_get_result();
			if (CommStatus == DXL_TXSUCCESS || CommStatus == DXL_RXSUCCESS)
			{

			}
			else
			{
				Dato[i]=dxl_read_word(IDs[i],clave);
				CommStatus = dxl_get_result();
				if (CommStatus == DXL_TXSUCCESS || CommStatus == DXL_RXSUCCESS)
				{

				}
				else
				{
					Dato[i]=dxl_read_word(IDs[i],clave);
					CommStatus = dxl_get_result();
					if (CommStatus == DXL_TXSUCCESS || CommStatus == DXL_RXSUCCESS)
					{

					}
					else
					{
						Dato[i]=0xFFFF;
					}
				}
			}
			zgb_tx_data(Dato[i]);
		}
	}
	else
	{
		//int result;
		switch(clave)
		{
			case 'A':
				zgb_tx_data((int) t);
				for (int i=0; i<18; i++)
				{
					//zgb_tx_data(ThBioloid[i]);
				}
			break;
			case 'E':
				zgb_tx_data(0xFFFF);
				zgb_tx_data(0xFFFF);
				zgb_tx_data(0xFFFF);
				zgb_tx_data((int) t);

				Var1=g_P_Pos[0]*10;
				Var2= (int) Var1;
				zgb_tx_data(Var2);

				Var1=g_P_Pos[1]*10;
				Var2= (int) Var1;
				zgb_tx_data(Var2);

				Var1=g_P_Pos[2]*10;
				Var2= (int) Var1;
				zgb_tx_data(Var2);

				zgb_tx_data(g_P_Ori[0]);
				zgb_tx_data(g_P_Ori[1]);
				zgb_tx_data(g_P_Ori[2]);
			break;
			case 'F':
				zgb_tx_data(0xFFFF);
				zgb_tx_data(0xFFFF);
				zgb_tx_data(0xFFFF);
				zgb_tx_data((int) t);
				zgb_tx_data((int) g_RF_Pos[0]*10);
				zgb_tx_data((int) g_RF_Pos[1]*10);
				zgb_tx_data((int) g_RF_Pos[2]*10);
				zgb_tx_data(g_RF_Ori[0]);
				zgb_tx_data(g_RF_Ori[1]);
				zgb_tx_data(g_RF_Ori[2]);
			break;
			case 'G':
				zgb_tx_data(0xFFFF);
				zgb_tx_data(0xFFFF);
				zgb_tx_data(0xFFFF);
				zgb_tx_data((int) t);
				zgb_tx_data((int) g_LF_Pos[0]*10);
				zgb_tx_data((int) g_LF_Pos[1]*10);
				zgb_tx_data((int) g_LF_Pos[2]*10);
				zgb_tx_data(g_LF_Ori[0]);
				zgb_tx_data(g_LF_Ori[1]);
				zgb_tx_data(g_LF_Ori[2]);
			break;
		}
	}
}

void Init_Params()
{
	//Parametors principales
	g_Values_1_Int[0]=6;	//N
	g_Values_1_Int[1]=12;	//CP th
	g_Values_1_Int[2]=9;	//DP phi
	g_Values_1_Int[3]=0;	//DF psi
	g_Values_1_Int[4]=5;	//CS th
	g_Values_1_Int[5]=70;	//CS phi
	g_Values_1_Int[6]=30;	//CE phi
	g_Values_1_Int[7]=50;	//DS th
	g_Values_1_Int[8]=1200;	//T
	g_Values_1_Int[9]=100;	//T ymax
	g_Values_1_Int[10]=300;	//t ini
	g_Values_1_Int[11]=350;	//T ss

	g_Values_1_Flt[0]=1;		//CP x
	g_Values_1_Flt[1]=15.3;		//CP z
	g_Values_1_Flt[2]=3.3;		//DP y
	g_Values_1_Flt[3]=0;		//DF x
	g_Values_1_Flt[4]=0;		//DF y
	g_Values_1_Flt[5]=4;		//DF z

	//Parametors RRobot
	//int g_Values_2_Int[22];
	g_Values_2_Int[0]=5;
	g_Values_2_Int[1]=0;
	g_Values_2_Int[2]=6;
	g_Values_2_Int[3]=3;
	g_Values_2_Int[4]=4;
	g_Values_2_Int[5]=4;
	g_Values_2_Int[6]=1;
	g_Values_2_Int[7]=2;
	g_Values_2_Int[8]=0;
	g_Values_2_Int[9]=4;
	g_Values_2_Int[10]=4;
	g_Values_2_Int[11]=-4;
	g_Values_2_Int[12]=5;
	g_Values_2_Int[13]=7;
	g_Values_2_Int[14]=5;
	g_Values_2_Int[15]=6;
	g_Values_2_Int[16]=6;
	g_Values_2_Int[17]=0;
	g_Values_2_Int[18]=1;
	g_Values_2_Int[19]=2;
	g_Values_2_Int[20]=3;
	g_Values_2_Int[21]=3;

	g_Values_2_Flt[0]=0;
	g_Values_2_Flt[1]=0.4;
	g_Values_2_Flt[2]=0;
	g_Values_2_Flt[3]=-0.8;
	g_Values_2_Flt[4]=-0.4;
	g_Values_2_Flt[5]=0;

	//Parametors Primer Paso
	//int g_Values_3_Int[26];
	//float g_Values_3_Flt[3];

	//Parametors patada
	g_Values_4_Int[0]=6;	//N
	g_Values_4_Int[1]=12;	//CP th
	g_Values_4_Int[2]=12;	//DP phi
	g_Values_4_Int[3]=0;	//DF psi
	g_Values_4_Int[4]=5;	//CS th
	g_Values_4_Int[5]=70;	//CS phi
	g_Values_4_Int[6]=30;	//CE phi
	g_Values_4_Int[7]=50;	//DS th
	g_Values_4_Int[8]=1200;	//T
	g_Values_4_Int[9]=100;	//T ymax
	g_Values_4_Int[10]=300;	//t ini
	g_Values_4_Int[11]=350;	//T ss
	g_Values_4_Int[12]=100;	//T ss

	g_Values_4_Flt[0]=1;		//CP x
	g_Values_4_Flt[1]=15.3;		//CP z
	g_Values_4_Flt[2]=3.3;		//DP y
	g_Values_4_Flt[3]=0;		//DF x
	g_Values_4_Flt[4]=0;		//DF y
	g_Values_4_Flt[5]=4;		//DF z
}

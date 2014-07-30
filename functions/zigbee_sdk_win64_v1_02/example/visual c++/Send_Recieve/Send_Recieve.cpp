#include <windows.h>
#include <stdio.h>
#include <conio.h>
#include "zigbee.h"

#pragma comment(lib, "zigbee.lib")

// Defulat setting
#define DEFAULT_PORTNUM		3 // COM3
#define TIMEOUT_TIME		1000 // msec

int main()
{
	int TxData, RxData;
	int i;

	// Open device
	if( zgb_initialize(DEFAULT_PORTNUM) == 0 )
	{
		printf( "Failed to open Zig2Serial!\n" );
		printf( "Press any key to terminate...\n" );
		getch();
		return 0;
	}
	else
		printf( "Succeed to open Zig2Serial!\n" );

	while(1)
	{
		printf( "Press any key to continue!(press ESC to quit)\n" );
		if(getch() == 0x1b)
			break;

		// Wait user's input
		printf( "Input number to transmit: " );
		scanf("%d", &TxData);

		// Transmit data
		if(zgb_tx_data(TxData) == 0)
			printf( "Failed to transmit\n" );

		for( i=0; i<TIMEOUT_TIME; i++)
		{
			// Verify data recieved
			if(zgb_rx_check() == 1)
			{
				// Get data verified
				RxData = zgb_rx_data();
				printf( "Recieved: %d\n", RxData );
				break;
			}

			Sleep(1);
		}

		if(i == TIMEOUT_TIME)
			printf( "Timeout: Failed to recieve\n" );
	}

	// Close device
	zgb_terminate();
	printf( "Press any key to terminate...\n" );
	getch();
	return 0;
}
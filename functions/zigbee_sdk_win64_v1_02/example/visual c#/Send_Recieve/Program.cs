using System;
using System.Collections.Generic;
using System.Text;
using System.Threading;
using ROBOTIS;

namespace Send_Recieve
{
    class Program
    {
        // Defulat setting
        public const int DEFAULT_PORTNUM    = 3; // COM3
        public const int TIMEOUT_TIME = 1000; // msec

        static void Main(string[] args)
        {
            int TxData, RxData;
            int i;

            // Open device
            if (zigbee.zgb_initialize(DEFAULT_PORTNUM) == 0)
            {
                Console.WriteLine("Failed to open Zig2Serial!");
                Console.WriteLine("Press any key to terminate...");
                Console.ReadKey(true);
                return;
            }
            else
                Console.WriteLine("Succeed to open Zig2Serial!");

            while (true)
            {
                Console.WriteLine("Press any key to continue!(press ESC to quit)");
                if (Console.ReadKey(true).Key == ConsoleKey.Escape)
                    break;

                // Wait user's input
                Console.Write("Input number to transmit: ");
                TxData = int.Parse(Console.ReadLine());

                // Transmit data
                if (zigbee.zgb_tx_data(TxData) == 0)
                    Console.WriteLine("Failed to transmit");

                for (i = 0; i < TIMEOUT_TIME; i++)
                {
                    // Verify data recieved
                    if (zigbee.zgb_rx_check() == 1)
                    {
                        // Get data verified
                        RxData = zigbee.zgb_rx_data();
                        Console.WriteLine("Recieved: {0:d}", RxData);
                        break;
                    }

                    Thread.Sleep(1);
                }

                if (i == TIMEOUT_TIME)
                    Console.WriteLine("Timeout: Failed to recieve");
            }

            // Close device
            zigbee.zgb_terminate();
            Console.WriteLine("Press any key to terminate...");
            Console.ReadKey(true);
        }
    }
}

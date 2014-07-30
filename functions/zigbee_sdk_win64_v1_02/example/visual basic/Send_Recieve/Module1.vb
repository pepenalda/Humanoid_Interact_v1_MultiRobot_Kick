Module Module1

    'Sleep function
    Public Declare Sub Sleep Lib "kernel32.dll" (ByVal dwMilliseconds As Long)

    'Defulat setting
    Public Const DEFAULT_PORTNUM = 3 'COM3
    Public Const TIMEOUT_TIME = 1000 'msec

    Dim TxData, RxData, i As Integer

    Sub Main()

        'Open device
        If (zgb_initialize(DEFAULT_PORTNUM) = 0) Then

            Console.WriteLine("Failed to open Zig2Serial!")
            Console.WriteLine("Press any key to terminate...")
            Console.ReadKey(True)
            Exit Sub
        Else
            Console.WriteLine("Succeed to open Zig2Serial!")
        End If

        While (True)
            Console.WriteLine("Press any key to continue!(press ESC to quit)")
            If (Console.ReadKey(True).Key = ConsoleKey.Escape) Then
                Exit While
            End If

            'Wait user's input
            Console.Write("Input number to transmit: ")
            TxData = Integer.Parse(Console.ReadLine())

            'Transmit data
            If (zgb_tx_data(TxData) = 0) Then
                Console.WriteLine("Failed to transmit")
            End If

            For i = 1 To TIMEOUT_TIME
                'Verify data recieved
                If (zgb_rx_check() = 1) Then
                    'Get data verified
                    RxData = zgb_rx_data()
                    Console.WriteLine("Recieved: " & RxData & "")
                    Exit For
                End If
                Sleep(1)
            Next i

            If (i > TIMEOUT_TIME) Then
                Console.WriteLine("Timeout: Failed to recieve")
            End If
        End While

        'Close device
        zgb_terminate()
        Console.WriteLine("Press any key to terminate...")
        Console.ReadKey(True)
    End Sub

End Module

Welcome to NetworkMsngr, A free replacement to the net-send command that was removed a few Operating Systems ago.
----------------------------------------------------------------------------------------------
How To Use:
NetworkMsngr uses a text file to transfer messages between computers. A text file has to be shared between the PC(s) for this to work (Read/Write permissions required).
                                      To Create The Message Stream:
1. Open NetworkMsngr Sender and navigate to the choosen directory, then type in the name of the text file you want to create
2. Click on 'Open' the click 'Continue'
3. Enter anything you want in the next two boxes
4. CREATED (Thats it!)
                       To Scan A Message Stream For Messages:
1. Open NetworkMsngr
2. Locate the Message Stream file
3. FINISHED (NetworkMsngr will notify you when a new message is received)

                                    To Send A Message
1. Open NetworkMsngr Sender, locate the message stream file, click 'Open' (You might have to click 'Continue')
2. Enter the message you want to send, then enter the PC name you want to send (You can enter 'everyone' to send the message to everyone)
3. The PC(s) you specified will show a popup containing the message you sent

                                 TO AUTOMATE THIS PROCESS:
You can use the default configuration file for the NetworkMsngr receiver. HOW TO:
When NetworkMsngr Receiver is launched for the first time, it creates a folder 'SDS_Files'. In this directory it contains a file 'Settings.ini', you can edit that file to change the default settings.

You can also use command line options, these can be used in shortcuts of NetworkMsngr:


    NetworkMsngr Receiver Command Line Options:

          NetworkMsngr -----------------------------------------------------------------------
          A Simple Messaging System For Windows, All Operations Performed Using Batch File CMD
          ------------------------------------------------------------------------------------

          NetworkMsngr.exe [StreamFile] [RefreshSpeed]
              StreamFile     The File Which Transfers Message Data To Other Computers
              RefreshSpeed   The Amount Of Time (In Seconds) It Waits To Check For New Messages (0 Is The Quickest 99999 Is The Slowest)


              examples:
          NetworkMsngr.exe "D:\Windows OS\Windows 10\HelloWorld.NetworkMsngr" 0
          NetworkMsngr.exe "C:\Users\SD-Storage\Desktop\NetworkMsngr.NetworkMsngr" 10
    ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    NetworkMsngr *SENDER* Command Line Options:

          NetworkMsngr -----------------------------------------------------------------------
          A Simple Messaging System For Windows, All Operations Performed Using Batch File CMD
          ------------------------------------------------------------------------------------

          NetworkMsngr_Sender.exe [StreamFile] [Message] [Recipents] [Sender] [Serial]
              StreamFile     The File Which Transfers Message Data To Other Computers
              Message        The Message That You Want To Send To An Other PC
              Recipent       The Computer(s) That Should Receive Your Messages
              Sender         The Name That You Want The Message To Be From (Default Is The Computers Name)
              Serial         You Can Spoof Your Serial Number By Using This Option (Default Is The Drive Serial Number, If You Override This, Then The Notify API WONT Show That The Message Was Sent Successfully)


              examples:
          NetworkMsngr_Sender.exe "E:\My Conversations\MessageStream.NetworkMsngr" "Hello World" "Everyone"
          NetworkMsngr_Sender.exe Messages.NetworkMsngr "Test, That Only Appears On This PC" "%computername%"
          NetworkMsngr_Sender.exe Messages.NetworkMsngr "Test, That Only Appears On This PC" "%computername%" "%username%" "Override_Serial_Checking"
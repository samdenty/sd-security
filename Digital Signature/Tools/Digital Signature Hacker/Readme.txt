The program DigitalSignatureTweaker is a PoC for making modifications to a signed executable without invalidating the embedded digital signature. It is taking advantage of some design issues with how Authenticode works. The truth is, it is possible to hide data inside the signature itself. In order to do so we must also remember to adjust a few things in the PE header as well as the header of the actual signature. Our data is basically added at EOF on executable, and then increasing the size of the signature to cover up for the extra data added.

The steps necessary to do this manually:
1. Grab 1 arbitrary signed executable from your system. Preferrably a Microsoft one to make the test more catching.
2. Append garbage data at EOF, but make sure it's size is a multiple of FileAlignment (found in the Optional Header). Use hex editor or just "copy /b source.exe+garbage.data new.exe"
3. Increase the size of the certificate as given by its entry in the Data Directories. Increased the value by what you added in step 2. Most easily done with a PE editor. Beware though that minor differences exist in 32-bit and 64-bit executables.
4. Also increase the size of the certificate as given inside the certificate itself. It's the first 4 bytes. Do this with a hex editor.
5. Finally, also update the checksum as found in the Optional Header. This last step is likely only necessary if you're modifying a boot application.

So the program basically just automates those 5 steps.

Additionally in the new version there are lots of stuff added compared to the previous version:
- Preserve filesystem timestamps on executable.
- Optionally compress data.
- Optionally AES256 encrypt the data.
- Now with a GUI that shows more verbose information in a lower pane.
- Added a custom header in front of hidden data so identification of it is possible.
- Added a separate program to extract data from signatures.

The program should work equally well on x86 and x64 arch executables. It also should work equally well for exe's, dll's and sys's, as their all just PE file that are signed in the same way. I've tested signed exe's on both 32-bit and 64-bit, which works. On 32-bit Windows 8 I modified both winload.exe and ntoskrnl.exe and no complaints during the boot process in any way. And the same on 64-bit Windows 7.

Both x86 and x64 compiled binaries included.

Note:
Configuration of encryption also implies compression. Preservation of filesystem timestamps are not 100% on NTFS, since it is only the $STANDARD_INFORMATION  that is modified. The $FILE_NAME is thus not touched. However I know several ways to solve that too, but it will not be implemented due to possible complications.

How much data can be hidden?
Actually rather much, as 0xFFFFFFFF - size of original signature, seems to be the theoretical limit. That equates to more than 4 GB! However, I only tested up to 100 MB without problems. Keep in mind that in the current implementation in AutoIt, you will get a memory issue if approaching several hundred MB's. That can in the meantime be easily solved by switching from the DllStruct* functions and over to Windows' own "copy /b ....".

So what's the whole point?
First and foremost it is for showing that modifications can be done without invalidating the signature. For real-world use, it seems best as a steganographic solution (like hiding data). Keep in mind that the signature appears fine, as well as the executable working just fine. When thinking about it, it is rather disturbing that you can hide data (malware and illegal content for instance) inside the Windows kernel, without the system complaining about the executable having been tampered with. I'll show another example: Take AutoIt compiled scripts. They have a base interpreter that will load the encoded script. This encoded script is usually added at EOF, or as a resource in the Resource section. By signing just the interpreter (which in itself is not a program that can do much), one can turn the signed executable into different programs without invalidating its signature. Check the signature in the included base.exe and try executing it. Nothing much happens besides an error message. Then try my program and inject HelloWorld.bin into its signature, and voila.. Or try to inject DigitalSignatureTweaker.bin into the signature of a clean base.exe.

Possible issue:
I'm not sure, but for executables with FileAlignment other than 0x200 there might be a problem. I have not tested this, and besides 0x200 is most common anyway I think.

Discussions follow in this thread; http://reboot.pro/15889/page__pid__142801#entry142801

Signed Office documents.
Although not the same, I thought it's worth mentioning that Microsoft Office 2007/2010 signed documents also can hold injected data without invalidating the signature. Again it is about file format exploration, and in this case it is ooXML (zip). It is much information to it, but I made another program some months ago to do this, so I'll just give a link; http://www.forensicfocus.com/index.php?name=Forums&file=viewtopic&t=7918  That is also a Proof of Concept, but I just now realized that also signed documents are good. So the drawback with the method, that injected data don't survive a save operation within Office, is not at all a problem with signed documents since such documents are locked for editing anyway!! Try for yourself by creating a docx, xlsx or pptx and then go through the inbuilt wizard in MS Office to sign the document. Then use my program to inject data to it, and lastly verify the documents and its signature by opening it in MS Office.

ToDo:
- Add more error checking.
- Solve the memory issue with large payload files, or switch over to "copy /b ...".
- Add configurable custom signature for the custom header.
- Clean up lots of stuff.

Log:
v1.0.0.6
- Added blocking for large files (above 95.000.000 bytes) to prevent large payloads crashing the program.
- Some more verbose messages and error checking.

v1.0.0.5
- Fixed bug inside filesystem timestamp manipulation on x64 OS. Turned out some datatypes needed to be changed.
- Fixed small bug with the tickbox for keeping timestamps.

v1.0.0.4
Temporarily deactivated timestamp manipulation on x64 host OS. Problem is caused by how NtQueryInformationFile and NtSetInformationFile are used. Ie DigitalSignatureTweaker will again run on 64-bit host OS.
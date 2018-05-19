# RGB-Fusion-Tool-PS
Powershell that use RGB Fusion CLI to associate profiles with Windows Processes

This script includes:
1) Tylerszabo's RGB Fusion Tool - https://github.com/tylerszabo/RGB-Fusion-Tool/releases (The compiled code and src is packaged w/ the release)
2) Example XML files Generated/Exported via RGB Fusions GUI - Examples of Default, Notepad, Overwatch and Farcry5 are included. The Default mode is the mode the computer switches to, if profile processes are running, in my default only things attached to the LED analog header will show as blue.

Instructions:
1) Extract zip to C:\Program Files (x86). The Powershell script includes both the compiled and source of Tyler Szabo's tool.
2) Create custom profiles in RGB Fusion. Make sure you name the XML file the exact name of the Process you want it to monitor. Alternatively you can set the destination of the profiles to look to by modifying the variable in the ps1 script. A commented example points to the normal install directory of RGB Fusion.
3) Copy the startup.bat to C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp, so it loads when windows comes up.
4) Restart Computer

Currently there is no mechnicism to restart the tool, so any new profiles can be applied, you must restart the computer at this time. We are still also working on an off and restart switch for the tool

Troubleshooting: 
1) In some cases the lights change or have issues changing all the way, you can exit the game and re-enter it to see if that fixes it. Seeing if we can fix the problem.
2) If lights don't respond at all, even in RGB Fusion, the system will have to be powered off and the switch or power cable must be pulled to clear the buffer. 

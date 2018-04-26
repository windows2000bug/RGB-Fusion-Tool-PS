# RGB-Fusion-Tool-PS
Powershell that use RGB Fusion CLI to associate profiles with Windows Processes

This script requires two things:
1) Tylerszabo's RGB Fusion Tool - https://github.com/tylerszabo/RGB-Fusion-Tool/releases (The compiled code and src is packaged w/ the release)
2) XML files Generated/Exported via RGB Fusions GUI - Two examples of Overwatch and Farcry5 are included

Instructions:
1) Extract zip to a location. The Powershell script includes both the compiled and source of Tyler Szabo's tool.
2) Create custom profiles in RGB Fusion. Make sure you name the XML file the exact name of the Process you want it to monitor. When you set the XML, you then copy it to the profiles/ folder located in the RGB Fusion Tool.
3) Run the powershell script

Troubleshooting: 
1) In some cases the lights change or have issues changing all the way, you can exit the game and re-enter it to see if that fixes it. Seeing if we can fix the problem.
2) If lights don't respond at all, even in RGB Fusion, the system will have to be powered off and the switch or power cable must be pulled to clear the buffer. 

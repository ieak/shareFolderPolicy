# shareFolderPolicy
This script is written to search folders shared with "everyone" in a computer, list them, then remove share from that folders automatically.

#---#
# Description and Scope

ShareFolderPolicy application is created to control shared files on a computer 
with Everyone to prevent security gaps.

 1 - It searches shared files (with ListAllSharedFolderPermission Powershell script)
 2 - Pick shared with Everyone (with readFile Powershell script)
 3 - Remove share from directory
 4 - Keep a report file on network to monitor activities.
 
#---#
# Author and Contact

Author	: Iffet Kurukose
Contact	: oguz.iffet@gmail.com

#---#
# How to run
# Basically double click for "runShareFolderPolicy.bat" script. 
# For a correct configuration please follow the steps below:

 1 - Open "runShareFolderPolicy.bat" file on notepad.
 
 2 - Define a convenient network path for "LOG_ARCHIVE_FOLDER" variable.
		( Default is : LOG_ARCHIVE_FOLDER="D:\\" )

 3 - If you like to remove shares automacally by script, comment out following line:
		"REM for /F "tokens=*" %%A in (%SHARED_FOLDERS_NAME%) do net share %%A /DELETE >> %LOG_FILE%"
		(Hint: Delete just "REM")
		
 3 - run "runShareFolderPolicy.bat" Batch script on command prompt of your Windows PC.
 
 4 - You may schedule "runShareFolderPolicy.bat" script on Task Scheduler for daily run for a complete automation.
 
 5 - You can check following three log files from directory and network address defined on "LOG_ARCHIVE_FOLDER" variable.
		Main Log File					: LogForShareFolderPolicy.log
		Detailed Share List				: shareList.txt
		Shared Files List with Everyone			: sharedFilesWithEveryone

#---#
# "ListAllSharedFolderPermission.ps1" file is retrieved from the address below:
# https://gallery.technet.microsoft.com/scriptcenter/Lists-all-the-shared-5ebb395a

# Good Luck, Be Safe!

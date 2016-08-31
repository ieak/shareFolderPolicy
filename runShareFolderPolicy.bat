REM ###############################################################################
REM ### Header ###
REM # This script is written to search folders shared with everyone in a computer
REM # And list them, then remove share from that folders automatically.
REM # author        "iffet Kurukose"
REM # date          15.08.2016
REM # contact       oguz.iffet@gmail.com
REM ###############################################################################
REM ### Definitions ###

REM Log Archive Folder (Need to be SET)::::::::::::::::::::::::::::::::::::::::::::

set LOG_ARCHIVE_FOLDER="D:\\"

REM Generated Lists::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

set SHARED_FOLDERS_NAME=sharedFilesWithEveryone.txt
set SHARE_LIST=detailedShareList.txt

REM Log File:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

set LOG_FILE=LogForShareFolderPolicy.log

REM Powershell Scripts:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

set LISTING_SCRIPT=ListAllSharedFolderPermission.ps1
set READING_SCRIPT=readFile.ps1

REM -------------------------------------------------------------------------------

echo "================================ %Date:~-4,4%-%Date:~-7,2%-%Date:~-10,2% / %Time% =================================" >> %LOG_FILE%
echo[  >> %LOG_FILE%
echo "Log File Name 						: " %LOG_FILE% >> %LOG_FILE%
echo "Shared with Everone Folders Name List : " %SHARED_FOLDERS_NAME% >> %LOG_FILE%

REM Find the Computer Name:::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo[  >> %LOG_FILE%
For /f "delims=" %%a in ('systeminfo ^| findstr /c:"Host Name"')do set myvar=%%a
For /f "tokens=1-3 delims= " %%a in ("%myvar%") do (
set removal1=%%a
set removal2=%%b
set compName=%%c
) 

set COMPUTER_NAME=%compName%

echo "COMPUTER NAME 				 : " %compName% >> %LOG_FILE%
echo "Double Check for COMPUTER NAME : " %COMPUTER_NAME% >> %LOG_FILE%
echo[ >> %LOG_FILE%


echo ---------------------------------------------------------------- >> %LOG_FILE%

REM Clean Up Ex Generated Lists  ::::::::::::::::::::::::::::::::::::::::::::::::::
delete %SHARED_FOLDERS_NAME% >> %LOG_FILE%
delete %SHARE_LIST% >> %LOG_FILE%
echo[  >> %LOG_FILE%

echo ---------------------------------------------------------------- >> %LOG_FILE%

REM List All Shared Files on the Computer::::::::::::::::::::::::::::::::::::::::::
echo[  >> %LOG_FILE%
echo Detailed List of All Shared Folders: >> %LOG_FILE%
echo[  >> %LOG_FILE%
Powershell -executionpolicy remotesigned -file %LISTING_SCRIPT% -ComputerName  %COMPUTER_NAME% > %SHARE_LIST%
for /F "tokens=*" %%A in (%SHARE_LIST%) do echo %%A >> %LOG_FILE%
echo[  >> %LOG_FILE%

echo ---------------------------------------------------------------- >> %LOG_FILE%

REM Find the file Name Shared with Everyone::::::::::::::::::::::::::::::::::::::::
echo[  >> %LOG_FILE%
echo Shared (with Everyone) Folder Names: >> %LOG_FILE%
echo[  >> %LOG_FILE%
Powershell -executionpolicy remotesigned -file %READING_SCRIPT% > %SHARED_FOLDERS_NAME%
for /F "tokens=*" %%A in (%SHARED_FOLDERS_NAME%) do echo %%A >> %LOG_FILE%
echo[  >> %LOG_FILE%

echo ---------------------------------------------------------------- >> %LOG_FILE%

echo[  >> %LOG_FILE%
REM Remove (Everyone) Share from the Folder::::::::::::::::::::::::::::::::::::::::
REM for /F "tokens=*" %%A in (%SHARED_FOLDERS_NAME%) do net share %%A /DELETE >> %LOG_FILE%
echo[  >> %LOG_FILE%

echo ---------------------------------------------------------------- >> %LOG_FILE%

echo[  >> %LOG_FILE%
REM Rename folder with Date, Time, ComputerName Stamps and Send to A Folder in the Network:::::::::::::::::::::::::::::::::::::::::::::::::::

echo "Log Archieve Address : " %LOG_ARCHIVE_FOLDER% >> %LOG_FILE%
echo[  >> %LOG_FILE%
mkdir %LOG_ARCHIVE_FOLDER%\%COMPUTER_NAME%_%Date:~-4,4%-%Date:~-7,2%-%Date:~-10,2%_%time:~0,2%-%time:~3,2% >> %LOG_FILE%
copy %LOG_FILE% %LOG_ARCHIVE_FOLDER%\%COMPUTER_NAME%_%Date:~-4,4%-%Date:~-7,2%-%Date:~-10,2%_%time:~0,2%-%time:~3,2% >> %LOG_FILE%
copy %SHARED_FOLDERS_NAME% %LOG_ARCHIVE_FOLDER%\%COMPUTER_NAME%_%Date:~-4,4%-%Date:~-7,2%-%Date:~-10,2%_%time:~0,2%-%time:~3,2% >> %LOG_FILE%
copy %SHARE_LIST% %LOG_ARCHIVE_FOLDER%\%COMPUTER_NAME%_%Date:~-4,4%-%Date:~-7,2%-%Date:~-10,2%_%time:~0,2%-%time:~3,2% >> %LOG_FILE%
echo[  >> %LOG_FILE%
echo ---------------------------------------------------------------- >> %LOG_FILE%
echo[  >> %LOG_FILE%

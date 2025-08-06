@echo off

echo WARNING: To avoid breaking the local system environment, sessions targeting the
echo portable environment should ONLY be run via a corresponding portable terminal.

:: Default value definitions for the Cygwin "portable" user
IF "%CYGWIN_PORTABLE_USER_NAME%" == "" (
  SET CYGWIN_PORTABLE_USER_NAME=root
)
IF "%CYGWIN_PORTABLE_USER_ID%" == "" (
  SET CYGWIN_PORTABLE_USER_ID=1001
)
IF "%CYGWIN_PORTABLE_USER_HOME%" == "" (
  SET CYGWIN_PORTABLE_USER_HOME=/home/%CYGWIN_PORTABLE_USER_NAME%
)


:: Determine the processor architecture.  Possible options include the following:
:: - x68, AMD64, IA64, ARM64, EM64T
:: Sources:
:: - https://learn.microsoft.com/en-us/windows/win32/winprog64/wow64-implementation-details
:: - https://learn.microsoft.com/en-us/troubleshoot/windows-server/setup-upgrade-and-drivers/determine-the-type-of-processor
:: - https://learn.microsoft.com/en-us/archive/blogs/david.wang/howto-detect-process-bitness
IF NOT "%PROCESSOR_ARCHITEW6432%" == "" (
  SET CYGWIN_LOCAL_ARCHITECTURE=%PROCESSOR_ARCHITEW6432%
) ELSE (
  SET CYGWIN_LOCAL_ARCHITECTURE=%PROCESSOR_ARCHITECTURE%
)


:: Setup path variables
SET CYGWIN_PORTABLE_ROOT=%~dp0
SET CYGWIN_PORTABLE_ROOT=%CYGWIN_PORTABLE_ROOT:~0,-1%
SET CYGWIN_PORTABLE_ARCH_ROOT=%CYGWIN_PORTABLE_ROOT%\arch-%CYGWIN_LOCAL_ARCHITECTURE%

SET CYGWIN_PORTABLE_PASSWD_PATH=%CYGWIN_PORTABLE_ARCH_ROOT%\etc\passwd


:: Account mapping for "portable" user
FOR /F "usebackq delims=: tokens=1-7" %%a IN (`"%CYGWIN_PORTABLE_ARCH_ROOT%\bin\mkpasswd" -c`) DO (
  SET CYGWIN_LOCAL_USER_NAME=%%a
  SET CYGWIN_LOCAL_USER_PASSWORD=%%b
  SET CYGWIN_LOCAL_USER_ID=%%c
  SET CYGWIN_LOCAL_USER_GROUP_ID=%%d
  SET CYGWIN_LOCAL_USER_SID=%%e
  SET CYGWIN_LOCAL_USER_HOME=%%f
  SET CYGWIN_LOCAL_USER_SHELL=%%g
)

findstr /M ":%CYGWIN_LOCAL_USER_SID%:" "%CYGWIN_PORTABLE_PASSWD_PATH%" >NUL 2>&1

IF NOT "%ErrorLevel%" == "0" (
  SET CYGWIN_USER_MAPPING_ENTRY=%CYGWIN_PORTABLE_USER_NAME%:*:%CYGWIN_PORTABLE_USER_ID%:%CYGWIN_LOCAL_USER_GROUP_ID%:%CYGWIN_LOCAL_USER_SID%:%CYGWIN_PORTABLE_USER_HOME%:%CYGWIN_LOCAL_USER_SHELL%
)

IF "%CYGWIN_USER_MAPPING_ENTRY%" == "" (
  REM echo User mapping for portable user "%CYGWIN_PORTABLE_USER_NAME%" already exists.
) ELSE (
  REM echo Creating user mapping for portable user "%CYGWIN_PORTABLE_USER_NAME%"
  REM echo Adding /etc/passwd entry: "%CYGWIN_USER_MAPPING_ENTRY%"
  
  :: Use the Cygwin version of "echo" to write the appropriate end-of-line character
  "%CYGWIN_PORTABLE_ARCH_ROOT%\bin\echo" "%CYGWIN_USER_MAPPING_ENTRY%" >> "%CYGWIN_PORTABLE_PASSWD_PATH%"
)


:: Run the commands from the core Cygwin batch file
cd /d "%CYGWIN_PORTABLE_ARCH_ROOT%"
Call Cygwin.bat

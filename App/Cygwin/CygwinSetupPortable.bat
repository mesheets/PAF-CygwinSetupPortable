@echo off

SET CYGWIN_PORTABLE_SETUP_ROOT=%~dp0
SET CYGWIN_PORTABLE_SETUP_ROOT=%CYGWIN_PORTABLE_SETUP_ROOT:~0,-1%

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
SET CYGWIN_PORTABLE_ROOT=%PortableApps.comRoot%\Cygwin
SET CYGWIN_PORTABLE_ARCH_ROOT=%CYGWIN_PORTABLE_ROOT%\arch-%CYGWIN_LOCAL_ARCHITECTURE%


:: Run Cygwin Setup
"%CYGWIN_PORTABLE_SETUP_ROOT%\arch-%CYGWIN_LOCAL_ARCHITECTURE%\CygwinSetup.exe"  --no-admin --no-shortcuts --no-write-registry --no-replaceonreboot --package-manager --root "%PortableApps.comRoot%\Cygwin\arch-%CYGWIN_LOCAL_ARCHITECTURE%"  --local-package-dir "%PortableApps.comRoot%\Cygwin\packages" --wait 


:: Copy over the bootstrap batch file used by portable consoles or terminals to run Cygwin portably
copy /Y "%CYGWIN_PORTABLE_SETUP_ROOT%\Cygwin-Portable.bat" "%CYGWIN_PORTABLE_ROOT%\"

:: Copy over the latest default Cygwin.bat file
copy /Y "%CYGWIN_PORTABLE_ARCH_ROOT%\etc\defaults\Cygwin.bat" "%CYGWIN_PORTABLE_ARCH_ROOT%\"

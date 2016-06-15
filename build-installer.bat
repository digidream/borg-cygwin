REM --- Change to use different CygWin platform and final install path

set CYGSETUP=setup-x86_64.exe
set TARGETPATH=.

REM --- NSIS must be installed!  Get NSIS from http://nsis.sourceforge.net/Download

set MAKENSIS=C:\Program Files (x86)\NSIS\makensis.exe
set POWERSHELL=%windir%\System32\WindowsPowerShell\v1.0\powershell.exe

REM --- Fetch Cygwin setup from internet using powershell

"%POWERSHELL%" -Command "(New-Object Net.WebClient).DownloadFile('https://cygwin.com/setup-x86_64.exe', 'setup-x86_64.exe')"

REM --- Install build version of CygWin in a subfolder

set OURPATH=%cd%
set CYGBUILD=%OURPATH%\CygWin
set CYGMIRROR=ftp://ftp.funet.fi/pub/mirrors/cygwin.com/pub/cygwin/
set BUILDPKGS=python3,python3-setuptools,binutils,gcc-g++,libopenssl,openssl-devel,git,make,openssh,liblz4-devel,liblz4_1

%CYGSETUP% -q -B -o -n -R %CYGBUILD% -L -D -s %CYGMIRROR% -P %BUILDPKGS%

REM --- Build borgbackup

cd %CYGBUILD%
bin\bash --login -c 'easy_install-3.4 pip'
bin\bash --login -c 'pip install borgbackup'
cd %OURPATH%

REM --- Install release version of CygWin in a subfolder

set CYGPATH=%OURPATH%\Borg-installer
set INSTALLPKGS=python3,openssh,liblz4_1
set REMOVEPKGS=csih,gawk,lynx,man-db,groff,vim-minimal,tzcode,ncurses,info,util-linux

%CYGSETUP% -q -B -o -n -L -R %CYGPATH% -P %INSTALLPKGS% -x %REMOVEPKGS%

REM --- Adjust final CygWin environment

echo @"%TARGETPATH%\bin\bash" --login -c "cd $(cygpath '%cd%'); /bin/borg %%*" >%CYGPATH%\borg.bat
copy nsswitch.conf %CYGPATH%\etc\

REM --- Copy built packages into release path

cd %CYGBUILD%

copy bin\borg %CYGPATH%\bin
for /d %%d in (lib\python3.4\site-packages\borg*) do xcopy /s %%d %CYGPATH%\%%d\
for /d %%d in (lib\python3.4\site-packages\msgpack*) do xcopy /s %%d %CYGPATH%\%%d\
for /d %%d in (lib\python3.4\site-packages\pkg_resources) do xcopy /s %%d %CYGPATH%\%%d\

REM --- Remove all locales except EN (borg does not use them)

del /s /q %CYGPATH%\usr\share\locale\
for /d %%d in (usr\share\locale\en*) do xcopy /s %%d %CYGPATH%\%%d\

REM --- Remove all documentation

del /s /q %CYGPATH%\usr\share\doc\
del /s /q %CYGPATH%\usr\share\info\
del /s /q %CYGPATH%\usr\share\man\

REM --- Build Installer using NSIS

cd %OURPATH%

"%MAKENSIS%" nsis-installer.nsi


set CYGPATH=D:\CygWin\
set CYGMIRROR=ftp://ftp.funet.fi/pub/mirrors/cygwin.com/pub/cygwin/
set BUILDPKGS=python3,python3-setuptools,binutils,gcc-g++,libopenssl,openssl-devel,git,make,openssh,liblz4-devel,liblz4_1

setup-x86_64.exe -q -B -R %CYGPATH% -L -D -s %CYGMIRROR% -P '%BUILDPKGS%'
copy borg.bat %CYGPATH%

cd %CYGPATH%
bin\bash --login -c 'easy_install-3.4 pip'
bin\bash --login -c 'pip install borgbackup'


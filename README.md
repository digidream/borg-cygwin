# borg-cygwin
Automated installation of [borg backup](https://github.com/borgbackup/borg) under Windows/CygWin

* Create a temporary build folder and place the files from this repository there
* Download `setup-x86_64.exe` from [CygWin Home Page](https://cygwin.com/setup-x86_64.exe) into build folder
* Run `install.bat`, after a while you should end up with CygWin installation in `Borg` subfolder
* To install, copy the `Borg` subfolder into `C:\Program Files\` (this will require Administrator rights)
* Optionally, add `C:\Program Files\Borg` into your Windows `PATH` variable
* Delete completely the build folder

To install into other folder or prepare 32-bit build, edit `install.bat` and use different CygWin setup executable.

After installation, use borg like this:

```
borg init /cygdrive/D/Borg
borg create -C lz4 /cygdrive/D/Borg::Test /cygdrive/C/Photos/
```

The install script first builds borg inside temporary CygWin subfolder, then installs much smaller release version into Borg subfolder. Built packages are copied over, unnecessary files removed.

Tested with CygWin 2.4.1, borgbackup 1.0.0 on Windows 7 64-bit.

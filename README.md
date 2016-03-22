# borg-cygwin
Automated installation of borgbackup under Windows/CygWin

* Download `setup-x86_64.exe` from [CygWin Home Page](https://cygwin.com/setup-x86_64.exe)
* Place it to the same folder as the files from this repository
* Run `install.bat`, after a while you should end up with CygWin installation in `D:\CygWin\`
* Delete working folder

To install into other folder or prepare 32-bit build, edit `install.bat` and use different CygWin setup executable.

After installation, use borg like this:

```
D:\CygWin> borg init /cygdrive/D/Borg
D:\CygWin> borg create -C lz4 /cygdrive/D/Borg::Test /cygdrive/C/Photos/
```

The install script first builds borg inside temporary CygWin subfolder, then installs much smaller release CygWin into specified destination. Built packages are copied over, unnecessary files removed.

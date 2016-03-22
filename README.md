# borg-cygwin
Automated installation of borgbackup under Windows/CygWin

* Download `setup-x86_64.exe` from [CygWin Home Page](https://cygwin.com/setup-x86_64.exe)
* Place both `borg.bat` and `install.bat` into the same folder
* Run `install.bat`, you should end up with CygWin installation in `D:\CygWin\` (edit `install.bat` for different path)

Example use:

```
D:\CygWin\> borg init /cygdrive/D/Borg
D:\CygWin\> borg create -C lz4 /cygdrive/D/Borg::Test /cygdrive/C/Photos/
```

Note that the CygWin folder is currently too large (>700MB). Working on pruning code.

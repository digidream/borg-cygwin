# borg-cygwin

This creates a standard Windows installer for Borg Backup on 64bit Windows 7 and above.

* The only prerequisite is NSIS installed, available at http://nsis.sourceforge.net/Download
* About 1 GB free disk space required to build installer
* Borg install itself will only require about 150 MB
* Tested on Windows 7 64-bit

---

Create the installer by running install.bat. After creating the installer, run it to install Borg.

Then use borg like this, noting that all file paths are in Cygwin notation e.g. /cygdrive/c/path/to/my/files

```
borg init /cygdrive/D/Borg
borg create -C lz4 /cygdrive/D/Borg::Test /cygdrive/C/Photos/
```

The install script first builds borg inside temporary CygWin subfolder, then installs a much smaller release version into the Borg-installer subfolder. Built packages are copied over, unnecessary files removed, and then NSIS is run.

Tested with CygWin 2.4.1, borgbackup 1.0.0 on Windows 7 64-bit.

:: Required: git, Visual Studio 10.0 Express, Visual Studio 9 Express,
::           Windows 7 SDK (.NET 4), Windows 7 SDK (.NET 3.5), Anaconda/Miniconda

:::::::::::::::::::::::::::::::::::
:: User configurable stuff start ::
:::::::::::::::::::::::::::::::::::

:: These depends on where you installed Anaconda.
:: Python2 or Python3 doesn't matter but you need both 32bit and 64bit versions.
set ANACONDA_BASE=C:\Users\YOURUSERNAME\Anaconda3
set ANACONDA_BASE64=C:\Users\YOURUSERNAME\Anaconda3_64

:: Location of your package, can be a directory or a git repo.

A directory
set PKG_REPO=C:\Users\YOURUSERNAME\YOURPACKAGE

:: A git repo
:: set PKG_REPO=git+https://github.com/myproject/mycode.git

:::::::::::::::::::::::::::::::::
:: User configurable stuff end ::
:::::::::::::::::::::::::::::::::

:: Save original path so we can restore it
set BASEPATH=%PATH%

:: Set up your conda environments like this, do it for both 32bit and 64bit.
:: navigate to the Anaconda\Scripts / Anaconda-64\Scripts directory to avoid setting any Paths
:: conda create -n py3.6 python=3.6 numpy pip mingw
:: conda create -n py3.4 python=3.4 numpy pip mingw
:: conda create -n py3.3 python=3.3 numpy pip mingw
:: conda create -n py2.7 python=2.7 numpy pip mingw


:: These depend on what you named your environments above
set ENV27=envs\py2.7
set ENV33=envs\py3.3
set ENV34=envs\py3.4
set ENV36=envs\py3.6

:: Tell Python to select correct SDK version
set DISTUTILS_USE_SDK=1
set MSSdk=1

:: Set 32-bit environment
call "C:\Program Files\Microsoft SDKs\Windows\v7.1\Bin\SetEnv.Cmd" /Release /x86

:: Python 2.7 32bit
:: Python2 requires Visual Studio 2008 compiler present (Express version is fine)
call "C:\Program Files (x86)\Microsoft Visual Studio 9.0\VC\vcvarsall.bat"
set CPATH=%PATH%
set PATH=%ANACONDA_BASE%\%ENV27%;%ANACONDA_BASE%\%ENV27%\Scripts;%CPATH%
pip install wheel -q
pip wheel --no-deps %PKG_REPO%

:: Set 64-bit environment
call "C:\Program Files\Microsoft SDKs\Windows\v7.1\Bin\SetEnv.Cmd" /Release /x64

:: Python 2.7 64bit
:: 64-bit cl.exe is here
set CPATH=C:\Program Files (x86)\Microsoft Visual Studio 9.0\VC\bin\x86_amd64;%CPATH%
set PATH=%ANACONDA_BASE64%\%ENV27%;%ANACONDA_BASE64%\%ENV27%\Scripts;%CPATH%
pip install wheel -q
pip wheel --no-deps %PKG_REPO%


:: Set 32-bit environment
call "C:\Program Files\Microsoft SDKs\Windows\v7.1\Bin\SetEnv.Cmd" /Release /x86


:: Python3 requires Visual Studio 2010 compiler present (Express version is fine)
set PATH=%BASEPATH%
call "C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\vcvarsall.bat"
set CPATH=%PATH%

:: Python3.6 32bit
set PATH=%ANACONDA_BASE%\%ENV36%;%ANACONDA_BASE%\%ENV36%\Scripts;%CPATH%
pip install wheel -q
pip wheel --no-deps %PKG_REPO%

:: Python3.4 32bit
set PATH=%ANACONDA_BASE%\%ENV34%;%ANACONDA_BASE%\%ENV34%\Scripts;%CPATH%
pip install wheel -q
pip wheel --no-deps %PKG_REPO%

:: Python3.3 32bit
set PATH=%ANACONDA_BASE%\%ENV33%;%ANACONDA_BASE%\%ENV33%\Scripts;%CPATH%
pip install wheel -q
pip wheel --no-deps %PKG_REPO%


:: Set 64-bit environment
call "C:\Program Files\Microsoft SDKs\Windows\v7.1\Bin\SetEnv.Cmd" /Release /x64


:: Python3.4 64bit
:: 64-bit cl.exe is here
set CPATH=C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\bin\x86_amd64;%CPATH%

set PATH=%ANACONDA_BASE64%\%ENV36%;%ANACONDA_BASE64%\%ENV36%\Scripts;%CPATH%
pip install wheel -q
pip wheel --no-deps %PKG_REPO% 

set PATH=%ANACONDA_BASE64%\%ENV34%;%ANACONDA_BASE64%\%ENV34%\Scripts;%CPATH%
pip install wheel -q
pip wheel --no-deps %PKG_REPO% 


:: Python3.3 64bit
set PATH=%ANACONDA_BASE64%\%ENV33%;%ANACONDA_BASE64%\%ENV33%\Scripts;%CPATH%
pip install wheel -q
pip wheel --no-deps %PKG_REPO%


:: Restore path
set PATH=%BASEPATH%

:END

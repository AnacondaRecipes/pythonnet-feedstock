REM Install the latest dotnet-core and SDK using dotnet-install scripts.
mkdir %BUILD_PREFIX% 2> NUL
if exist %BUILD_PREFIX%\dotnet ( rmdir %BUILD_PREFIX%\dotnet /s /q )
curl -L -o %BUILD_PREFIX%\dotnet-install.ps1 https://dot.net/v1/dotnet-install.ps1
powershell %BUILD_PREFIX%\dotnet-install.ps1 -InstallDir %BUILD_PREFIX%\dotnet -Version latest
set PATH=%BUILD_PREFIX%\dotnet;%PATH%

REM Now install the package
%PYTHON% -m pip install . --no-deps -vv
REM Remember to shutdown the build server so that future builds aren't affected.
dotnet build-server shutdown

REM Install the latest dotnet-core and SDK using dotnet-install scripts.
REM For some reason, builders have problem deleting the `dotnet` directory that's created
REM in this step, meaning only one build is guaranteed to succeed while others will
REM fail because the directory exists but is unusable due to some deleted files.
REM The solution is to create a random directory to store the dotnet SDK files.
mkdir %BUILD_PREFIX% 2> NUL
curl -L -o %BUILD_PREFIX%\dotnet-install.ps1 https://dot.net/v1/dotnet-install.ps1
set suffix=%random%
powershell %BUILD_PREFIX%\dotnet-install.ps1 -InstallDir %BUILD_PREFIX%\dotnet-%suffix% -Version latest
set PATH=%BUILD_PREFIX%\dotnet-%suffix%;%PATH%

REM Now install the package
%PYTHON% -m pip install . --no-deps -vv
REM Remember to shutdown the build server so that future builds aren't affected.
dotnet build-server shutdown

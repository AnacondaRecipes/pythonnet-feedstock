# Install the latest dotnet-core and SDK using dotnet-install scripts.
mkdir -p $BUILD_PREFIX
curl -L -o $BUILD_PREFIX/dotnet-install.sh https://dot.net/v1/dotnet-install.sh && chmod +x $BUILD_PREFIX/dotnet-install.sh
source $BUILD_PREFIX/dotnet-install.sh --install-dir $BUILD_PREFIX/dotnet --version latest
export PATH="$BUILD_PREFIX/dotnet:$PATH"
export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1

# Now install the package.
$PYTHON -m pip install . --no-deps -vv

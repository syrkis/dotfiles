pyenv init - | source

# Set up paths for OpenBLAS
set -gx LDFLAGS "-L/opt/homebrew/opt/openblas/lib"
set -gx CPPFLAGS "-I/opt/homebrew/opt/openblas/include"
set -gx PKG_CONFIG_PATH "/opt/homebrew/opt/openblas/lib/pkgconfig"

# Set up Fortran compiler
set -gx FC gfortran

# BARTIB
set -x BARTIB_FILE "/home/username/activities.bartib"

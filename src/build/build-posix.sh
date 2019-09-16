unameOut="$(uname -s)"

case "${unameOut}" in
    Linux*) CFLAGS="CFLAGS=-fPIC" LIBNAME="libvim.so" LIBFLAGS="-lncurses -ldl -lm";;
    *)      CFLAGS="" LIBNAME="libvim.dylib" LIBFLAGS="-liconv -lncurses -framework CoreFoundation -framework AppKit";;
esac

./configure --disable-selinux ${CFLAGS}
make installlibvim DESTDIR=$cur__install LIBNAME=${LIBNAME} LIBFLAGS="${LIBFLAGS}"

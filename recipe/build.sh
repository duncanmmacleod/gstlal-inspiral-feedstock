#!/bin/bash

set -ex

mkdir -p _build
pushd _build

# conda-forge/conda-forge.github.io#621
#find ${PREFIX} -name "*.la" -delete

# only link libraries we actually use
export GSL_LIBS="-L${PREFIX}/lib -lgsl"
export GSTLAL_LIBS="-L${PREFIX}/lib -lgstlal -lgstlaltags -lgstlaltypes"
export LAL_LIBS="-L${PREFIX}/lib -llal -llalinspiral"

# configure
${SRC_DIR}/configure \
  --disable-massmodel \
  --enable-introspection=yes \
  --enable-gtk-doc=no \
  --enable-gtk-doc-html=no \
  --enable-gtk-doc-pdf=no \
  --prefix=${PREFIX} \
  --without-doxygen \
;

# build
export CPU_COUNT="1"
make -j ${CPU_COUNT} V=1 VERBOSE=1

# install
make -j ${CPU_COUNT} V=1 VERBOSE=1 install

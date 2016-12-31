#!/bin/bash
ln -sf "`hab pkg path core/glibc`/lib/ld-linux-x86-64.so.2" /lib/
export LD_LIBRARY_PATH="`hab pkg path core/gmp`/lib:`hab pkg path core/libffi`/lib:`hab pkg path core/gcc-libs`/lib"

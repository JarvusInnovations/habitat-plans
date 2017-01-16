pkg_name=xorg-macros
pkg_origin=core
pkg_version=1.19.0
pkg_description="X.org macros utilities"
pkg_upstream_url=https://cgit.freedesktop.org/xorg/util/macros
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://www.x.org/archive/individual/util/util-macros-${pkg_version}.tar.bz2
pkg_shasum=2835b11829ee634e19fa56517b4cfc52ef39acea0cd82e15f68096e27cbed0ba
pkg_dirname="util-macros-${pkg_version}"
pkg_build_deps=(
  core/make
)
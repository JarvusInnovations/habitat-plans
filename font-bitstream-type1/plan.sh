#
# This package is NOT officially support by the Xorg project.  Please
# report bugs related to this package on GitHub:
#
# https://github.com/stevendanna/habitat-plans
#
pkg_name=font-bitstream-type1
pkg_origin=xorg
pkg_version=1.0.3
pkg_maintainer="Steven Danna <steve@chef.io>"
pkg_description="X.Org Fonts: font bitstream type1"
pkg_upstream_url="https://www.x.org/"
pkg_license=('MIT')
pkg_source="https://www.x.org/releases/current/src/everything/${pkg_name}-${pkg_version}.tar.bz2"
pkg_shasum=c6ea0569adad2c577f140328dc3302e729cb1b1ea90cd0025caf380625f8a688
pkg_build_deps=(core/gcc core/make core/pkg-config xorg/util-macros xorg/mkfontdir xorg/mkfontscale xorg/font-util xorg/bdftopcf)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_bin_dirs=(bin)

do_build() {
  ./configure --prefix="${pkg_prefix}" \
              --sysconfdir="${pkg_prefix}/etc" \
              --localstatedir="${pkg_prefix}/var" \
              --with-fontrootdir="${pkg_prefix}/share/fonts/X11"

  make
}
pkg_name=multirun
pkg_origin=jarvus
pkg_version="0.3.2"
pkg_maintainer="Chris Alfano <chris@jarv.us>"
pkg_license=("MIT")
pkg_source="https://github.com/nicolas-van/${pkg_name}/archive/${pkg_version}.tar.gz"
pkg_shasum="fb408c23feee4f11b85f91fd22276efe5993af4e28aef2b695342b540706fcd0"
pkg_deps=(core/glibc)
pkg_build_deps=(core/make core/gcc)

pkg_bin_dirs=(bin)

do_build() {
  make
}

do_check() {
  make test
}

do_install() {
  cp -v multirun "${pkg_prefix}/bin/"
}

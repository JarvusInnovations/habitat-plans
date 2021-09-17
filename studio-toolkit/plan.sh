pkg_name=studio-toolkit
pkg_origin=jarvus
pkg_version=1.1.2
pkg_maintainer="Chris Alfano <chris@jarv.us>"
pkg_license=('MIT')
pkg_description="Toolkit for providing development environments via Chef Habitat Studios"
pkg_build_deps=(
)
pkg_deps=(
  core/bash
  core/busybox-static
)

do_build() {
  return 0
}

do_install() {
  cp -v "studio.sh" "${pkg_prefix}/"
}

do_strip() {
  return 0
}

pkg_name="csvkit"
pkg_origin="jarvus"
pkg_version="1.0.4"
pkg_description="A suite of utilities for converting to and working with CSV, the king of tabular file formats."
pkg_upstream_url="https://github.com/wireservice/csvkit"
pkg_license=("MIT")
pkg_maintainer="Chris Alfano <chris@jarv.us>"
pkg_source="${pkg_upstream_url}/archive/${pkg_version}.tar.gz"
pkg_shasum="e19c609894c42e850c25af1ca9082753f76f231450f70a70c46344bec45c1a66"

pkg_build_deps=(
  core/gcc
)
pkg_deps=(
  core/python
)

pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)

do_setup_environment() {
  push_runtime_env PYTHONPATH "$(pkg_path_for core/python)/lib/python3.7/site-packages"
  push_runtime_env PYTHONPATH "${pkg_prefix}/lib/python3.7/site-packages"
  set_runtime_env PYTHONIOENCODING "utf8"
}

do_prepare() {
  mkdir -p "${pkg_prefix}/lib/python3.7/site-packages"
}

do_build() {
  python setup.py build
}

do_install() {
  python setup.py install --prefix="${pkg_prefix}" --optimize=1 --skip-build
}
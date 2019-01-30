pkg_name=linode-cli
pkg_origin=core
pkg_version=2.0.18
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('BSD-3-Clause')
pkg_description="The Linode CLI"
pkg_upstream_url="https://pypi.org/project/linode-cli/"
pkg_build_deps=(
)
pkg_deps=(
  core/python
  core/kubectl
  core/terraform
)
pkg_bin_dirs=(bin)

do_prepare() {
  python -m venv "${pkg_prefix}"
  source "${pkg_prefix}/bin/activate"
}

do_build() {
  return 0
}

do_install() {
  pip install "${pkg_name}==${pkg_version}"
  # Write out versions of all pip packages to package
  pip freeze > "${pkg_prefix}/requirements.txt"
}

do_strip() {
  return 0
}

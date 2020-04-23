pkg_name=mkdocs
pkg_origin=jarvus
pkg_version=1.1
pkg_maintainer="Chris Alfano <chris@jarv.us>"
pkg_license=('BSD-2-Clause')
pkg_description="Project documentation with Markdown"
pkg_upstream_url="https://www.mkdocs.org/"
pkg_build_deps=(
)
pkg_deps=(
  core/python
)
pkg_bin_dirs=(bin)

do_prepare() {
  python -m venv "$pkg_prefix"
  source "$pkg_prefix/bin/activate"
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

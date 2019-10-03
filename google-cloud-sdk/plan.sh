pkg_name=google-cloud-sdk
pkg_origin=jarvus
pkg_version="264.0.0"
pkg_maintainer="Chris Alfano <chris@jarv.us>"
pkg_plan_source="https://github.com/JarvusInnovations/habitat-plans/tree/master/google-cloud-sdk"
pkg_upstream_url="https://cloud.google.com/sdk"
pkg_source="https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/${pkg_name}-${pkg_version}-linux-x86_64.tar.gz"
pkg_filename="${pkg_name}-${pkg_version}-linux-x86_64.tar.gz"
pkg_dirname="${pkg_name}"
pkg_shasum="7a1644dc98348ca515f78eac54f4b777e9840f47d597b59e30bb85c64744b9f4"
pkg_deps=(
  core/bash
  core/python2
  core/kubectl
  core/git
  core/openssh
)

pkg_bin_dirs=(bin)


# Callback Functions
do_setup_environment() {
  push_runtime_env CLOUDSDK_PYTHON "$(pkg_path_for core/python2)/bin/python"
  push_runtime_env CLOUDSDK_ROOT_DIR "${pkg_prefix}"
}

do_build() {
  build_line "Fixing bash interpreters"
  fix_interpreter 'bin/*' core/bash bin/sh

  build_line "Fixing python interpreters"
  {
    find -L './bin' -type f -executable -print;
    grep -rwl -m1 './lib' -e 'env python' ;
  } | xargs sed -e "s#^\#\!\s*/usr/bin/env python#\#\!$(pkg_path_for python2)/bin/python#" --in-place
}

do_install() {
  cp -r ./* "${pkg_prefix}/"
}

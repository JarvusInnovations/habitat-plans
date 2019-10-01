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
)

pkg_bin_dirs=(bin)


# Callback Functions
do_build() {
  build_line "Fixing interpreters"
  fix_interpreter bin/gcloud core/bash bin/sh
  sed -e "s#\#\!/usr/bin/env python#\#\!$(pkg_path_for python2)/bin/python#" --in-place "lib/gcloud.py"
}

do_install() {
  cp -v bin/gcloud "${pkg_prefix}/bin/"
  cp -r lib/ "${pkg_prefix}/"
}

pkg_name=lapidus
pkg_origin=jarvus
pkg_maintainer="Chris Alfano <chris@jarv.us>"
pkg_upstream_url=https://github.com/JarvusInnovations/lapidus
pkg_license=(MIT)
pkg_source=https://github.com/JarvusInnovations/lapidus.git
pkg_version=undefined
pkg_branch=master
pkg_deps=(jarvus/node)
pkg_build_deps=(core/coreutils core/git)


do_begin() {
  export GIT_DIR="${HAB_CACHE_SRC_PATH}/${pkg_name}.git"
}

do_download() {
  if [ -d "${GIT_DIR}" ]; then
    git fetch --all
  else
    git clone --bare "${pkg_source}" "${GIT_DIR}"
  fi

  pkg_commit="$(git rev-parse --short ${pkg_branch})"
  pkg_last_tag="$(git describe --tags --abbrev=0 ${pkg_commit})"
  pkg_last_version=${pkg_last_tag#v}
  pkg_version="${pkg_last_version}+$(git rev-list ${pkg_last_tag}..${pkg_commit} --count).${pkg_commit}"
  pkg_dirname="${pkg_name}-${pkg_version}"
  pkg_prefix="$HAB_PKG_PATH/${pkg_origin}/${pkg_name}/${pkg_version}/${pkg_release}"
  pkg_artifact="$HAB_CACHE_ARTIFACT_PATH/${pkg_origin}-${pkg_name}-${pkg_version}-${pkg_release}-${pkg_target}.${_artifact_ext}"

  return 0
}

do_verify() {
  return 0
}

do_unpack() {
  mkdir "${HAB_CACHE_SRC_PATH}/${pkg_dirname}"

  pushd "${HAB_CACHE_SRC_PATH}/${pkg_dirname}" > /dev/null
  git --work-tree=. checkout --force "${pkg_commit}"
  git --work-tree=. submodule update --init --recursive
  popd > /dev/null

  return $?
}

do_prepare() {
  # This hack deals with some npm package build scripts having
  # /usr/bin/env hardcoded instead of using env from PATH by
  # temporarily creating a symlink at /usr/bin/env within
  # the build environment that links to the env executable
  # provided by the coreutils package
  #
  # Habitat provides a minimal environment for builds where every
  # available package has its bin folder added to PATH rather than
  # its contents copied to a global /usr/bin directory

  if [[ ! -r /usr/bin/env ]]; then
    ln -sv "$(pkg_path_for coreutils)/bin/env" /usr/bin/env
    _clean_env=true
  fi
}

do_build() {
  cd $HAB_CACHE_SRC_PATH/$pkg_dirname
  npm install
}

do_install() {
  cp -R * "${pkg_prefix}/"
}

do_end() {
  # Clean up the `env` link, if we set it up.
  if [[ -n "$_clean_env" ]]; then
    rm -fv /usr/bin/env
  fi
}

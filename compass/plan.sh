pkg_name=compass
pkg_origin=core
pkg_version=1.0.3
pkg_license=('MIT')
pkg_source=https://github.com/Compass/compass/archive/${pkg_version}.tar.gz
pkg_shasum=ede883c770714a694859a1b41c0b099f988085558872b734f3c2511df94a54f9
pkg_bin_dirs=(bin)
pkg_deps=(
  core/ruby
  core/bash
)

pkg_build_deps=(
  core/gcc
  core/make
  core/libffi
)

do_prepare() {
  export GEM_HOME="$pkg_prefix"
  build_line "Setting GEM_HOME='$GEM_HOME'"
  export GEM_PATH="$GEM_HOME"
  build_line "Setting GEM_PATH='$GEM_PATH'"
}

do_build() {
  return 0
}

do_install() {
  build_line "Installing from RubyGems"
  gem install "$pkg_name" -v "$pkg_version" --no-ri --no-rdoc
  # Note: We are not cleaning the gem cache as this artifact
  # is reused by other packages for speed.
  wrap_ruby_bin "$pkg_prefix/bin/compass"
  wrap_ruby_bin "$pkg_prefix/bin/sass"
  wrap_ruby_bin "$pkg_prefix/bin/scss"
  wrap_ruby_bin "$pkg_prefix/bin/sass-convert"
}

wrap_ruby_bin() {
  local bin="$1"
  build_line "Adding wrapper $bin to ${bin}.real"
  mv -v "$bin" "${bin}.real"
  cat <<EOF > "$bin"
#!$(pkg_path_for bash)/bin/sh
set -e
if test -n "$DEBUG"; then set -x; fi

export GEM_HOME="$GEM_HOME"
export GEM_PATH="$GEM_PATH"
unset RUBYOPT GEMRC

exec $(pkg_path_for ruby)/bin/ruby ${bin}.real \$@
EOF
  chmod -v 755 "$bin"
}

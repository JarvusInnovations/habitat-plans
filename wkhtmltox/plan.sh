pkg_name=wkhtmltox
pkg_origin=core
pkg_version=0.12.4
pkg_description="wkhtmltopdf and wkhtmltoimage are command line tools to render HTML into PDF and various image formats using the QT Webkit rendering engine. These run entirely \"headless\" and do not require a display or display service."
pkg_upstream_url=https://github.com/wkhtmltopdf/wkhtmltopdf
pkg_license=('LGPL-3.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=http://download.gna.org/wkhtmltopdf/${pkg_version%.*}/${pkg_version}/wkhtmltox-${pkg_version}_linux-generic-amd64.tar.xz
pkg_shasum=049b2cdec9a8254f0ef8ac273afaf54f7e25459a273e27189591edc7d7cf29db
pkg_dirname=${pkg_name}
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_build_deps=(
  core/patchelf
)
pkg_deps=(
  core/glibc
  core/gcc-libs
  core/zlib
  core/fontconfig
  core/freetype
  core/expat

  xorg/xlib
  xorg/libxrender
  xorg/libxext
)


do_build() {
  build_line "Fixing interpreter and rpath for binaries:"

  find . -type f -executable \
    -exec sh -c 'file -i "$1" | grep -q "x-executable; charset=binary"' _ {} \; \
    -print \
    -exec patchelf --interpreter "$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2" --set-rpath "${LD_RUN_PATH}" {} \;

  build_line "Fixing rpath for libraries:"

  find . -type f -executable \
    -exec sh -c 'file -i "$1" | grep -q "x-sharedlib; charset=binary"' _ {} \; \
    -print \
    -exec patchelf --set-rpath "${LD_RUN_PATH}" {} \;
}

do_install() {
  cp -rv * "${pkg_prefix}"

  build_line "Generating dummy fonts config and directory"
  mkdir "${pkg_prefix}/fonts"
  cat > "${pkg_prefix}/fonts.conf" <<- END_OF_CONF
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
  <dir>${pkg_prefix}/fonts</dir>
</fontconfig>
END_OF_CONF
}

do_strip() {
  # skip stripping binary as it may cause issues with patched binaries
  return 0
}

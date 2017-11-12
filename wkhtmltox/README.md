# wkhtmltox

## Running within a container

To use the `wkhtmltopdf` or `wkhtmltoimage` binaries within a container, ensure that the
environment variable `FONTCONFIG_FILE` is pointed at a `fonts.conf` file that indicates at
least one fonts directory.

A dummy `fonts.conf` pointing at an empty included `fonts/` directory that can be used to
avoid the segfault that results from none being available:

    export FONTCONFIG_FILE="`hab pkg path jarvus/wkhtmltox`/fonts.conf"

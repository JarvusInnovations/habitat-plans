# gitbook

## SOLVED: Incompatibility with node versions > 12.9.0

Current hacks keep this plan outputting a functional gitbook CLI, but attempts to increase the node version result in the following error on `gitbook build`:

```console
info: 7 plugins are installed
info: 6 explicitly listed
info: loading plugin "highlight"... OK
info: loading plugin "search"... OK
info: loading plugin "lunr"... OK
info: loading plugin "sharing"... OK
info: loading plugin "fontsettings"... OK
info: loading plugin "theme-default"... OK
info: found 5 pages
info: found 37 asset files
_stream_readable.js:656
  switch (state.pipesCount) {
                ^

TypeError: Cannot read property 'pipesCount' of undefined
    at ReadStream.Readable.pipe (_stream_readable.js:656:17)
    at /hab/pkgs/jarvus/gitbook/2.3.4/20200211001705/node_modules/cpr/lib/index.js:163:22
    at /hab/pkgs/jarvus/gitbook/2.3.4/20200211001705/node_modules/cpr/node_modules/graceful-fs/polyfills.js:282:31
    at callback (/hab/pkgs/jarvus/gitbook/2.3.4/20200211001705/node_modules/npm/node_modules/graceful-fs/polyfills.js:289:20)
    at callback (/hab/pkgs/core/node/12.14.1/20200130135056/lib/node_modules/npm/node_modules/graceful-fs/polyfills.js:295:20)
    at FSReqCallback.oncomplete (fs.js:158:21)
```

Have attempted to hot-upgrade cpr, graceful-fs, and npm packages within both gitbook-cli and gitbook to no avail

# netdata

[Netdata](https://github.com/firehol/netdata) is a system for distributed real-time performance and health monitoring.

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>

## Usage

Netdata strives to be as useful as possible without configuration, so to get started you just need to load the service:

```bash
hab svc load core/netdata
```

Once it's running, open up the web interface on port 19999: [http://localhost:19999](http://localhost:19999)

## Debugging go modules

Adapting from [go.d.plugin: Troubleshooting](https://docs.netdata.cloud/collectors/go.d.plugin/#troubleshooting):

```bash
hab pkg exec core/netdata $(hab pkg path core/netdata)/libexec/netdata/plugins.d/go.d.plugin \
    --config=/hab/svc/netdata/config \
    --debug \
    --modules=mysql
```

## Debugging python modules

Adapting from [python.d.plugin: How to debug a python module](https://docs.netdata.cloud/collectors/python.d.plugin/#how-to-debug-a-python-module):

```bash
export NETDATA_USER_CONFIG_DIR=/hab/svc/netdata/config
hab pkg exec core/netdata $(hab pkg path core/netdata)/libexec/netdata/plugins.d/python.d.plugin mysql debug trace
```

## Enabling additional python modules

Check the tables on [Install Netdata on Linux manually](https://docs.netdata.cloud/packaging/installer/methods/manual/#prepare-your-system) to see if any additional dependencies are required by the desired plugin.

If they are, you will need to fork `plan.sh` to add items to `pkg_deps`. For python dependencies, you will also need to add to the `pip install <pkg1> <pkg2>` line.

## Debugging local node modules

```bash
export NETDATA_PLUGINS_DIR=/hab/svc/netdata/plugins.d
export NETDATA_USER_CONFIG_DIR=/hab/svc/netdata/config
hab pkg exec core/netdata $(hab pkg path core/netdata)/libexec/netdata/plugins.d/node.d.plugin debug 1 emergence
```

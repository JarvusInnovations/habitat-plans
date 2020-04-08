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

## Debugging python modules

Adapting from [python.d.plugin: How to debug a python module](https://docs.netdata.cloud/collectors/python.d.plugin/#how-to-debug-a-python-module):

```bash
export NETDATA_USER_CONFIG_DIR=/hab/svc/netdata/config
hab pkg exec jarvus/netdata $(hab pkg path jarvus/netdata)/libexec/netdata/plugins.d/python.d.plugin mysql debug trace
```

## Enabling additional python modules

Check the tables on [Install Netdata on Linux manually](https://docs.netdata.cloud/packaging/installer/methods/manual/#prepare-your-system) to see if any additional dependencies are required by the desired plugin.

If they are, you will need to fork `plan.sh` to add items to `pkg_deps`. For python dependencies, you will also need to add to the `pip install <pkg1> <pkg2>` line.

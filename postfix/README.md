# jarvus/postfix habitat service

A habitat plan for building and running postfix as a supervised service

## Logging

Postfix is hardcoded to use syslog via `/dev/log`, which is not available by default in studio or container environments.

`busybox-static` contains `syslogd` which can provide a minimal logging interface that writes to `/var/log/messages`. Start it within a studio before starting postfix with `hab pkg exec core/busybox-static syslogd -n &`

## Testing

To test with the default configuration, ensure that `localhost.localdomain` is an additional name for your `localhost` entry in your host machine's `/etc/hosts`


## References

- http://www.postfix.org/INSTALL.html
- http://www.postfix.org/DB_README.html
- http://www.postfix.org/BASIC_CONFIGURATION_README.html
- http://www.postfix.org/postconf.5.html
- http://www.postfix.org/VIRTUAL_README.html
- https://github.com/alezzandro/postfix-docker
- http://www.postfix.org/master.8.html
- https://mediatemple.net/community/products/dv/204404584/sending-or-viewing-emails-using-telnet
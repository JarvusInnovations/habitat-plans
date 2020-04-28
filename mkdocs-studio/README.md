# mkdocs-studio

## Adding to a project

Add to your project's `.studiorc` file:

```bash
#!/bin/bash

# install studio packages
hab pkg install jarvus/mkdocs-studio

# load MkDocs studio
source "$(hab pkg path jarvus/mkdocs-studio)/studio.sh"
```

## Using Studio

Open studio with port 8000 forwarded somewhere:

```bash
HAB_DOCKER_OPTS="-p 8000:8000" hab studio enter -D
```

Then, run `watch-docs` to install dependencies and start MkDocs' watch server in the foreground. To run the service in the background instead and direct output to `/hab/cache/mkdocs.log`, use the provided variant `bg-watch-docs`

## Adding mkdocs plugins

If `.holo/branches/${DOCS_HOLOBRANCH:-gh-pages}.lenses/mkdocs.toml` is found, a list of mkdocs plugins to install will automatically be loaded from the `hololens.requirements` key.

In any other environment, `$DOCS_REQUIREMENTS` may be exported to the environment instead with contents similar to `requirements.txt`

# rederly
* This repo is intended to be a parent directory for all of the components of rederly for easier clone and setup
* Currently this repo is only used for tracking documents and resources (i.e. nginx configurations on the server)

## Adding submodules
```bash
# git submodule add $GIT_URL $PATH
git submodule add git@github.com:rederlyhq/rederly-utils.git source/rederly-utils
```
# Updating
```bash
git submodule update --init --recursive

# From dev
git submodule foreach --recursive "git fetch && (git checkout dev || git checkout master || git checkout main) && git pull"

# From master
git submodule foreach --recursive "git fetch && (git checkout master || git checkout main) && git pull"

# From docker
git submodule foreach --recursive "git fetch && (git checkout docker || git checkout master || git checkout main) && git pull"
```

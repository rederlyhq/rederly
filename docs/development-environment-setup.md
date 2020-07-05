# Development setup

## Environment
```bash
node -v
# v12.18.2
sudo su postgres -c "psql --version"
# psql (PostgreSQL) 12.2 (Ubuntu 12.2-4)
```

## Description
I am running a lubuntu (lightweight ubuntu) VM with postgres and node

## Host tools
### VirtualBox
* Download and install VirtualBox from: https://www.virtualbox.org/wiki/Downloads
* I am using version 6.0

### PGadmin
* Download and install from: https://www.pgadmin.org/download/
* I am using version 4.23 (exe says 4 v4)

### Visual studio code
* Download and install from: https://code.visualstudio.com/download

#### Plugins
* Install the plugin `Remote Development` (includes wsl, remote ssh and containers)
* Setup a remote connection for the vm after it is setup (just use the ssh command for the vm)

#### SSH keys
* This is recommended so you can ssh into the VM without a password
* More importantly you won't have to put your password in with remote vscode (it can happen several times)
* Your VM should have a different set of ssh keys then your host machine

```bash
ssh-keygen # This can be done on unix based or windows systems
# Append the contents of `~/.ssh/id_rsa.pub` on the host machine to `~/.ssh/authorized_keys` on the vm
# Authorized keys need `700` permission
```

## Setting up the VM

### VirtualBox configurations
* Ram: With everything running it should use about 3gb of ram, so i've given it 4GB (4096MB)
* Storage: I've given my VM 100GB dynamically allocated storage
* Port forwarding: Set in settings after VM creation, optional or can be different
this is what I use not to have conflicts with host machine
  * Backend: Host 33001 ==> Guest 3001 (only required if you want to hit backend directly)
  * Frontend Host 33002 ==> Guest 3002
  * Postgres: Host 35432 ==> Guest 5432
  * SSH: Host 3222 ==> Guest 22
    * SSH command looks like `ssh -p 3222 user@localhost`

### OS setup
* For these instructions any debian system should work, furthermore if you use a different
kernel of linux you would just need to make sure the versions of the software are available
and transpose the commands to the package manager available (i.e. edge)
* I used lubuntu (lightweight ubuntu) which can be downloaded here: https://lubuntu.me/downloads/
* Create a vm from the iso, start it up and click the install lubuntu executable on the desktop
* I recommend installing `guest additions` (insert guest additions in virtualbox menus, run linux.run file in the cd)

### Install software

#### ssh server
```bash
sudo apt install -y openssh-server
```

#### Curl
```bash
sudo apt install -y curl
```
#### Git
```
apt-get install -y git
```

##### Git client
I use git-cola since it is cross platform and I only use it for staging and committing
```bash
apt-get install -y git-cola
```

#### Docker
Source: https://docs.docker.com/engine/install/ubuntu/
```bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io
```

#### Node
```bash
# Install node and NPM
sudo apt install -y nodejs
sudo apt install -y npm
# Update node
sudo npm install -g n
sudo n lts
```

#### Postgres
```bash
# Install
sudo apt install -y postgresql-12
# Configure (https://stackoverflow.com/questions/50772899/cant-connect-to-postgres-using-pgadmin)
sudo su postgres
cd /etc/postgresql/12/main
vi postgres.conf
# Change the following line (located at line 59, with vim can jump by using esc and typing the line number):
# listen_addresses = 'localhost'                       # what IP address(es) to listen on;
# to (make sure it is uncommented):
# listen_addresses = '*'                       # what IP address(es) to listen on;
vi pg_hba.conf
# Add the following line (without the comment):
# host    all             all             0.0.0.0/0               md5
```

### Additional steps

#### SSH keys
```bash
ssh-keygen # Fill out prompts
# Copy the contents of the public key to github (~/.ssh/id_rsa.pub)
```

#### Setup repos
* https://github.com/rederly/renderer
* https://github.com/rederly/backend
* https://github.com/rederly/frontend

##### Backend
```bash
git clone git@github.com:rederly/backend.git
cd backend
npm start:debug:watch # Run with nodemon, debug mode
# I recommend using the launch from vscode so that the debugger attaches instead
```

##### Frontend
```bash
git clone git@github.com:rederly/frontend.git
cd frontend
npm start
```

##### Renderer
I made a folder for `renderer` and put the following script in there
```bash
#!/bin/bash

# Comment out after first run, just used for setup
mkdir volumes
mkdir container
git clone --depth 1 https://github.com/openwebwork/pg volumes/PG
git clone --depth 1 https://github.com/openwebwork/webwork-open-problem-library volumes/webwork-open-problem-library
git clone --depth 1 https://github.com/rederly/renderer container/

# Comment out if there are not updates to the renderer
sudo docker build --tag renderer:1.0 ./container

# Never comment this out, use for running
sudo docker run -d \
          --publish 3000:3000 \
          --mount type=bind,source="$(pwd)"/volumes/PG,target=/usr/app/lib/PG \
          --mount type=bind,source="$(pwd)"/volumes/webwork-open-problem-library/,target=/usr/app/webwork-open-problem-library \
          renderer:1.0
```

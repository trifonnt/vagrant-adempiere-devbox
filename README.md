# ADempiere official "development box"

## Introduction

This is a [Vagrant](https://www.vagrantup.com/) configuration to set up a complete, virtualized development environment for JHipster users.

1. [Usage](#usage)
2. [Installation](#setup)
3. [Customize your virtual machine](#customize)
4. [Configure your new box and install new software](#configure)

## <a name="usage"></a> Usage

The ADempiere "development box" is a complete development environment for ADempiere users.

It requires to have [Vagrant](https://www.vagrantup.com/) installed on your machine.

It is fully based on Open Source software, most importantly:

- Ubuntu
- OpenJDK (Oracle JDK can't be used because of license issues)
- Docker and Docker Compose (see the [ADempiere Docker Compose documentation](http://trifonnt.github.io/docker-compose/) to learn how to run your application, database or even a full micro-service architecture with Docker)
- [Ubuntu Make](https://wiki.ubuntu.com/ubuntu-make) so you can easily install your favorite IDE (type `umake ide idea` for Intellij IDEA or `umake ide eclipse` for Eclipse)
- Chromium and Firefox Web browsers

This "development box" also have all client applications useful for working with a ADempiere application:

- MySQL Workbench
- pgAdmin 3

## <a name="setup"></a> Installation

The "Quick installation" provides a pre-build Virtual Machine, and the "Manual installation" let you build your Virtual Machine yourself. We recommend you use the "Quick installation" if you don't know which option to choose.

### Quick installation

Pre-built distributions of this "development box" are available on [Atlas](https://atlas.hashicorp.com/adempiere).

To install the latest distribution, please run:

On Mac or Linux

`vagrant init adempiere/adempiere-devbox; vagrant up --provider virtualbox`

On Windows

`vagrant init adempiere/adempiere-devbox`

`vagrant up --provider virtualbox`

You can then tune your installation, by following the next sections on customizing and configuring your "development box".

### Manual installation

This generates a new "development box" directly from this repository.

- Clone this repository: `git clone https://github.com/adempiere/vagrant-adempiere-devbox.git`
- It is wise to use a tag to have a stable version: the ADempiere DevBox tags are the same as the ADempiere ERP tags, so using the DevBox v3.8.0 also means using the ADempiere ERP v3.8.0
- Run `vagrant up`

## <a name="customize"></a> Customize your virtual machine

This is very important! Modify your system properties, depending on your host's hardware. We recommend, at least:

- 4 CPUs
- 8 Gb of RAM
- 128 Mb of video RAM

## <a name="configure"></a> Configure your new box and install new software

Start up the new box:

- Login using the `vagrant` user (not the 'Ubuntu' user which is selected by default)
  - Password is `vagrant` (please note that default keyboard layout is US!)
- Configure your keyboard, if you are not using an English keyboard, once you have logged in:
  - Go to `Settings > Keyboard`
  - Open the `Layout` tab
  - Untick the `Use system default` box
  - Use the `+` sign to add your keyboard layout
- Configure your IDE
  - Use [Ubuntu Make](https://wiki.ubuntu.com/ubuntu-make) so you can easily install your favorite IDE:
    - Type `umake ide idea` for Intellij IDEA
    - Type `umake ide eclipse` for Eclipse
- Configure you browser
  - Firefox is installed
  - Chromium, which is the Open-Source version of Google Chrome, is also installed
- Other available tools
  - [Guake](http://guake-project.org/) is installed, hit "F12" to have your terminal
  - The [Atom](https://atom.io/) text editor is installed
- Configure your database
  - Run your database with Docker. For example, for MySQL use `docker-compose -f src/main/docker/mysql.yml up`

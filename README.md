fizsh
=====

FIZSH is the Friendly Interactive ZSHell. It is a front end to ZSH. It provides the user of ZSH with interactive syntax-highting and Matlab-like history search. It also has a both short and informative prompt.


install
=======

In order to install FIZSH, you may run the following:

    user@localmachine$ mkdir ./fizsh

    user@localmachine$ git clone https://github.com/zsh-users/fizsh.git
    Initialized empty Git repository in /path/to/fizsh/.git/
    ...

    user@localmachine$ cd ./fizsh

    user@localmachine$ ./configure

    user@localmachine$ # or ./configure --prefix=/usr --includedir=/usr/include --datadir=/usr/share \
                                        --bindir=/usr/bin --libexecdir=/usr/lib/fizsh \
                                        --localstatedir=/var --sysconfdir=/etc/

    checking for a BSD-compatible install... /usr/bin/install -c
    ...

    user@localmachine$ make # gmake for those on BSD
    Making all in src
    ...

    user@localmachine$ sudo make install
    Making install in src
    ...

    user@localmachine$ fizsh
    Welcome to fizsh, the friendly interactive zshell
    Type man fizsh for instructions on how to use fizsh
    user@localmachine /p/t/fizsh>


Those without access to a privileged account may install fizsh in their home directory:

    user@localmachine$ export PATH=$PATH:$HOME/bin && ./configure --prefix=$HOME && make && make install
    ...

    user@localmachine$ fizsh
    Welcome to fizsh, the friendly interactive zshell
    Type man fizsh for instructions on how to use fizsh
    user@localmachine /p/t/fizsh>


Users on Debian based systems can install the latest binary package from [Sourceforge][1]:

    user@localmachine$ wget --no-check-certificate --output-document=fizsh_1.0.9-1_all.deb \
                           "https://downloads.sourceforge.net/project/fizsh/fizsh_1.0.9-1_all.deb"

    user@localmachine$ sudo dpkg -i ./fizsh_1.0.9-1_all.deb
    Selecting previously deselected package fizsh.
    ...

    user@localmachine$ fizsh
    Welcome to fizsh, the friendly interactive zshell
    Type man fizsh for instructions on how to use fizsh
    user@localmachine /p/t/current_dir>


Users of "Debian" and "Ubuntu" may simply run:

    user@localmachine$ sudo apt-get install fizsh
    Reading package lists... Done
    Building dependency tree
    Reading state information... Done
    The following NEW packages will be installed:
    ...


Debian / Sid tends to contain a more recent version of Fizsh.

Users of "Arch" can find a package at https://aur.archlinux.org/packages/fizsh-git/.
To install it run:

    user@localmachine$ wget "https://aur.archlinux.org/cgit/aur.git/snapshot/fizsh-git.tar.gz"
    user@localmachine$ tar xvfz fizsh-git.tar.gz
    user@localmachine$ cd fizsh-git
    user@localmachine$ makepkg -s
    user@localmachine$ sudo pacman -U fizsh-git-1.0.8.r8.g95d0050-1-any.pkg.tar.xz

Please notice that the name of package archive ("fizsh-git-1.0.8.r8.g95d0050-1-any.pkg.tar.xz" in the example above) can change from version to version.

uninstall
=========

In order to uninstall FIZSH, run:

    user@localmachine /p/t/fizsh> sudo make uninstall
    Making uninstall in src
    ...


Those who have installed fizsh through a Debian-based package manager, such as dpkg or apt-get, may run:

    user@localmachine /p/t/current_dir> sudo apt-get remove fizsh
    (Reading database ... 399874 files and directories currently installed.)
    ...

To delete the fizsh package on "Arch" users can run:

    user@localmachine /p/t/current_dir> sudo pacman -R fizsh-git

or

    user@localmachine /p/t/current_dir> sudo pacman -Rs fizsh-git

to delete the package with all its dependencies.

[1]: http://sourceforge.net/projects/fizsh

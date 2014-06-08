fizsh
=====

FIZSH is the Friendly Interactive ZSHell. It is a front end to ZSH. It provides the user of ZSH with interactive syntax-highting and Matlab-like history search. It also has a both short and informative prompt.


install
=======

In order to install FIZSH, you may run the following: 

    user@localmachine$ mkdir ./fizsh 

    user@localmachine$ git clone git@github.com:zsh-users/fizsh
    Initialized empty Git repository in /path/to/fizsh/.git/
    ...

    user@localmachine$ cd ./fizsh/fizsh-dev

    user@localmachine$ ./configure # or ./configure --bindir=/usr/bin/ \
                           --mandir=/usr/share/man/ --sysconfdir=/etc/fizsh \
			   on Debian based systems
    checking for a BSD-compatible install... /usr/bin/install -c
    ...

    user@localmachine$ make
    Making all in src
    ...

    user@localmachine$ sudo make install
    Making install in src
    ...

    user@localmachine$ fizsh     
    Welcome to fizsh, the friendly interactive zshell
    Type man fizsh for instructions on how to use fizsh
    user@localmachine /p/t/f/fizsh-dev> 


Those without access to a privileged account may install fizsh in their home directory:

    user@localmachine$ export PATH=$PATH:$HOME/bin && ./configure --prefix=$HOME && make && make install
    ...

    user@localmachine$ fizsh     
    Welcome to fizsh, the friendly interactive zshell
    Type man fizsh for instructions on how to use fizsh
    user@localmachine /p/t/f/fizsh-dev> 


Users on Debian based systems can install the latest binary package from [Sourceforge][1]: 

    user@localmachine$ wget --no-check-certificate --output-document=fizsh_1.0.6-1_all.deb \ 
                           "https://downloads.sourceforge.net/project/fizsh/fizsh_1.0.6-1_all.deb"

    user@localmachine$ sudo dpkg -i ./fizsh_1.0.6-1_all.deb
    Selecting previously deselected package fizsh.
    ...

    user@localmachine$ fizsh
    Welcome to fizsh, the friendly interactive zshell
    Type man fizsh for instructions on how to use fizsh
    user@localmachine /p/t/current_dir> 


Users of "Debian" and "Ubunu" may simply run: 

    user@localmachine$ sudo apt-get install fizsh
    Reading package lists... Done
    Building dependency tree
    Reading state information... Done
    The following NEW packages will be installed:
    ...


Debian / Sid tends to contain a more recent version of Fizsh.

uninstall
=========

In order to uninstall FIZSH, run:

    user@localmachine /p/t/f/fizsh-dev> sudo make uninstall
    Making uninstall in src
    ...


Those who have installed fizsh through a Debian-based package manager, such as dpkg or apt-get, may run:

    user@localmachine /p/t/current_dir> sudo apt-get remove fizsh
    (Reading database ... 399874 files and directories currently installed.)
    ...


[1]: http://sourceforge.net/projects/fizsh

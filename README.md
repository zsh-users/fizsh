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

user@localmachine$ cd ./fizsh/fizsh-1.0.2

user@localmachine$ ./configure # or ./configure --bindir=/usr/bin/ --mandir=/usr/share/man/ for those on Debian based systems

checking for a BSD-compatible install... /usr/bin/install -c

...

user@localmachine$ make

Making all in src

...

user@localmachine$ sudo make install

(Reading database ... 399874 files and directories currently installed.)

...

Making install in src

...

user@localmachine$ fizsh # or fizsh -r if you installed fizsh previously and you want to update its configuration file

Welcome to fizsh, the friendly interactive zshell

Type man fizsh for instructions on how to use fizsh

user@localmachine /p/t/f/fizsh-1.0.2> 


Users on Debian based systems can install the latest binary package from http://sourceforge.net/projects/fizsh : 

user@localmachine$ wget --no-check-certificate --output-document=fizsh_1.0.2-1_all.deb "https://downloads.sourceforge.net/project/fizsh/fizsh_1.0.2-1_all.deb?r=&ts=1294513167&use_mirror=garr"

user@localmachine$ sudo dpkg -i ./fizsh_1.0.2-1_all.deb

Selecting previously deselected package fizsh.

...

user@localmachine$ fizsh # or "fizsh -r" if you installed fizsh previously and you want to update its configuration file

Welcome to fizsh, the friendly interactive zshell

Type man fizsh for instructions on how to use fizsh

user@localmachine ~/p/t/current_dir> 


uninstall
=========

In order to uninstall FIZSH, run:

user@localmachine ~/p/t/f/fizsh-1.0.2> sudo make uninstall

Making uninstall in src

...


Those who have installed a ".deb" file may run:

user@localmachine ~/p/t/current_dir> sudo apt-get remove fizsh

(Reading database ... 399874 files and directories currently installed.)

...
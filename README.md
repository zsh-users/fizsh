fizsh
=====

FIZSH is the Friendly Interactive ZSHell. It is a front end to ZSH. It provides the user of ZSH with interactive syntax-highting and Matlab-like history search. It also has a both short and informative prompt.


Install
=======

In order to install FIZSH, you can run the following: 

`user@localmachine$ mkdir fizsh`
`user@localmachine$ git clone git@github.com:zsh-users/fizsh`
`user@localmachine$ cd fizsh/fizsh-1.0.2` 
`user@localmachine$ ./configure` # or `./configure --bindir=/usr/bin/ --mandir=/usr/share/man/` for those on Debian based systems` 
`user@localmachine$ make` 
`user@localmachine$ sudo make install`
`user@localmachine$ fizsh` # or `fizsh -r` if you installed fizsh previously and you want to update its configuration file 
Welcome to fizsh, the friendly interactive zshell
Type man fizsh for instructions on how to use fizsh
`user@localmachine ~> `

Users on Debian based systems can install the latest binary package from http://sourceforge.net/projects/fizsh/files/: 

`user@localmachine$ wget --no-check-certificate --output-document=fizsh_1.0.2-1_all.deb "https://downloads.sourceforge.net/project/fizsh/fizsh_1.0.2-1_all.deb?r=&ts=1294513167&use_mirror=garr"` 
`user@localmachine$ sudo dpkg -i ./fizsh_1.0.2-1_all.deb`
`user@localmachine$ fizsh` # or `fizsh -r` if you installed fizsh previously and you want to update its configuration file 
Welcome to fizsh, the friendly interactive zshell
Type man fizsh for instructions on how to use fizsh
`user@localmachine ~> `


Uninstall
=========

In order to uninstall FIZSH, run: 

`user@localmachine ~/fizsh/build/directory> sudo make uninstall` 

Those who have installed a ".deb" file may run: 

`user@localmachine ~> sudo apt-get remove fizsh` 

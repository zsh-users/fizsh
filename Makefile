#!/usr/bin/env make 

.PHONY: default 
default: 
	@./test_requirements.sh

.PHONY: install
install: 
	@cp -rf ./usr /
	@cp -rf ./etc /
	@modify_etc_shells --add /usr/bin/fizsh 
	@echo fizsh version 0.0.1-1 has been installed 

.PHONY: uninstall
uninstall: 
	@modify_etc_shells --remove /usr/bin/fizsh 
	@rm -f /usr/bin/fizsh 
	@rm -f /usr/share/man/man1/fizsh.1.gz 
	@rm -rf /etc/fizsh/
	@rm -rf /usr/share/doc/fizsh/
	@echo fizsh version 0.0.1-1 has been uninstalled 



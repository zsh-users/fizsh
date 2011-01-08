#!/usr/bin/env make 

.PHONY: default 
default: 
	@echo "#!/usr/bin/env sh " > ./test.sh
	@echo "if [ X\`which zsh\` = X ]; then " >> ./test.sh
	@echo "echo Zsh seems unavailable. Install it prior to installing fizsh. " >> ./test.sh
	@echo "fi" >> ./test.sh
	@echo "if [ X\`which md5sum\` = X ]; then " >> ./test.sh
	@echo "echo Coreutils seems unavailable. Install it prior to installing fizsh. " >> ./test.sh
	@echo "fi" >> ./test.sh
	@echo "if [ ! X\`which zsh\` = X ]; then " >> ./test.sh
	@echo "if [ ! X\`which md5sum\` = X ]; then " >> ./test.sh
	@echo "echo All fizsh\'s requirements seem to be satisfied. " >> ./test.sh
	@echo "fi" >> ./test.sh
	@echo "fi" >> ./test.sh
	@chmod +x ./test.sh
	@./test.sh
	@rm -rf ./test.sh

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



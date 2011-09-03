AUTOMAKE_OPTIONS = gnu
SUBDIRS = src doc examples man scripts

install-data-local:
	$(srcdir)/scripts/modify-etc-shells.zsh --add $(bindir)/fizsh

uninstall-local:
	$(srcdir)/scripts/modify-etc-shells.zsh --remove $(bindir)/fizsh


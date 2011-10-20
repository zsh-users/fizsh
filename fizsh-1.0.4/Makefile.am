AUTOMAKE_OPTIONS = gnu
SUBDIRS = src doc examples man scripts

install-data-local:
	$(srcdir)/scripts/modify-etc-shells.sh --add $(bindir)/fizsh || true

uninstall-local:
	$(srcdir)/scripts/modify-etc-shells.sh --remove $(bindir)/fizsh || true

AUTOMAKE_OPTIONS = gnu
SUBDIRS = src doc examples man scripts

install-data-local:
	$(srcdir)/scripts/modify-etc-shells.sh --add $(bindir)/fizsh || true
	$(srcdir)/scripts/modify-version-number.sh --add $(sysconfdir)/fizsh/.fizsh-version || true

uninstall-local:
	$(srcdir)/scripts/modify-etc-shells.sh --remove $(bindir)/fizsh || true
	$(srcdir)/scripts/modify-version-number.sh --remove $(sysconfdir)/fizsh/.fizsh-version || true

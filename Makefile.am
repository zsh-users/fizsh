AUTOMAKE_OPTIONS = gnu
SUBDIRS = doc man scripts
EXTRA_DIST = doc man scripts
dist-hook:
	rm -rf $(distdir)/Makefile $(distdir)/doc/Makefile $(distdir)/man/Makefile $(distdir)/scripts/Makefile $(distdir)/debian $(distdir)/man/fizsh.1 $(distdir)/autom4te.cache $(distdir)/config.status $(distdir)/config.log

install-data-local:
	$(srcdir)/scripts/modify-etc-shells.sh --add $(bindir)/fizsh || true

uninstall-local:
	$(srcdir)/scripts/modify-etc-shells.sh --remove $(bindir)/fizsh || true

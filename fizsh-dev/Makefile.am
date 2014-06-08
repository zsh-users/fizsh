AUTOMAKE_OPTIONS = gnu
SUBDIRS = src doc man scripts examples

dist_pkgdata_DATA = $(srcdir)/scripts/*.zsh $(srcdir)/scripts/modify-etc-shells.sh $(srcdir)/scripts/fizsh $(srcdir)/man/fizsh.pod $(srcdir)/doc/copyright $(srcdir)/doc/changelog

EXTRA_DIST = man
dist-hook:
	rm -f $(distdir)/man/fizsh.1

install-data-local:
	$(srcdir)/scripts/modify-etc-shells.sh --add $(bindir)/fizsh || true

uninstall-local:
	$(srcdir)/scripts/modify-etc-shells.sh --remove $(bindir)/fizsh || true

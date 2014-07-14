man1_MANS = fizsh.1

$(srcdir)/fizsh.1: $(srcdir)/fizsh.pod
	-pod2man --utf8 -c "" -r "fizsh 1.0.7" $(srcdir)/fizsh.pod > $(srcdir)/fizsh.1

clean:
	-rm -rf $(srcdir)/fizsh.1

# Use any of these:
#scheme = guile -s
scheme = mzscheme -r
#scheme = tinyscheme

# This -nostdlib flag is optional; it just makes a smaller output
# file.  (It's unusual to have an assembly file that can compile both
# with and without -nostdlib, but this is one.)
asflags = -nostdlib -Wa,-adhlns=$<.lst
all: test
test: a.out
	./a.out
a.out: tmp.s
	$(CC) $(asflags) $<
tmp.s: compiler.scm
	$(scheme) $< > $@
	mv $@.ref $@.ref.old ||:
	cp $@ $@.ref
	diff -u $@.ref.old $@.ref ||:
clean:
	rm -f a.out tmp.s

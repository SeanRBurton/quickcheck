install:
	cargo-lite install

docs:
	rm -rf doc
	rustdoc src/lib.rs
	# WTF is rustdoc doing?
	chmod 755 doc
	in-dir doc fix-perms
	rscp ./doc/* gopher:~/www/burntsushi.net/rustdoc/

test: quickcheck-test src/lib.rs
	RUST_TEST_TASKS=1 RUST_LOG=quickcheck=4 ./quickcheck-test

quickcheck-test:
	rustc --test src/lib.rs -o quickcheck-test

test-clean:
	rm -rf ./quickcheck-test

push:
	git push origin master
	git push github master

VERSION := $(subst v,,$(lastword $(shell git tag -l 'v*' )))
PACKAGE_NAME = wordpress-scripts
RELEASE = $(PACKAGE_NAME)-$(VERSION)
REMOTE_HOST = moe.warp.es
REMOTE_PATH = public_html/wordpress-scripts
FILES = README.markdown \
		publish.sh \
		wp-import \
		wp-dump

release: pkg/$(RELEASE).tar.gz
	@echo "Released version $(VERSION)"
	
pkg/$(PACKAGE_NAME)-%.tar.gz:
	mkdir -p pkg/
	git archive --format=tar --prefix=$(RELEASE)/ v$(VERSION) | gzip -c9 > $(RELEASE).tar.gz
	md5 < $(RELEASE).tar.gz > $(RELEASE).tar.gz.md5
	gpg --sign $(RELEASE).tar.gz.md5
	mv $(RELEASE).* pkg/
	ls -lR pkg/ | grep -v ls-lR > pkg/ls-lR
	@echo "Package ready in pkg/$(RELEASE).tar.gz"
	
upload: release
	scp pkg/$(RELEASE).* $(REMOTE_HOST):$(REMOTE_PATH)/

clean:
	rm -rf pkg
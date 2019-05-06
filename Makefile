.PHONY: install
build:
	GOOS=linux GOARCH=amd64 go build -o website main.go

.PHONY: package
package:
	zip -r website.zip website

.PHONY: install
install:
	@$(MAKE) -s build
	@$(MAKE) -s package
	@mv website.zip terraform/website.zip

# TODO Add lambda update target

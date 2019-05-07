.PHONY: build
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

.PHONY: update-lambda
update-lambda:
	@$(MAKE) install
	aws lambda update-function-code --function-name handle_request --zip-file "fileb:///$(shell pwd)/terraform/website.zip"

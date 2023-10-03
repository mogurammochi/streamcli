.PHONY: login
login:
	@echo login gh
	gh auth login -h github.com -s write:packages -s delete:packages

.PHONY: podman-login
podman-login:
	gh auth token | podman login ghcr.io -u mogurammochi --password-stdin

.PHONY: build
build:
	@echo build podman image
	podman build . -t ghcr.io/mogurammochi/streamcli

.PHONY: push
push:
	@echo push to github packages
	podman push ghcr.io/mogurammochi/streamcli:latest

.PHONY: init
init:
	@echo Initialize container
	podman run \
		--mount type=bind,source="$$(pwd)/.streamcli",target=/root \
		ghcr.io/mogurammochi/streamcli /bin/sh -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

.PHONY: link
link:
	@echo Link home
	ln -s "$$(pwd)/.streamcli" ~/.streamcli

.PHONY: run
run:
	@echo run container current directory
	podman run -it --rm \
		--mount type=bind,source="$(PWD)",target=/projects \
		--mount type=bind,source="$$(pwd)/.streamcli",target=/root \
		ghcr.io/mogurammochi/streamcli /bin/zsh

.PHONY: list
list:
	@echo list podman images
	podman images

.PHONY: echo
echo:
	@echo "function streamcli () {"
	@echo '  podman run -it --rm \'
	@echo '    --mount type=bind,source="$${HOME}/.streamcli",target=/root \'
	@echo '    --mount type=bind,source="$$(pwd)/",target=/projects \'
	@echo '    ghcr.io/mogurammochi/streamcli /bin/zsh'
	@echo "}"


.PHONY: build
build:
	@echo build podman image
	podman build . -t streamcli

.PHONY: init
init:
	@echo Initialize container
	mkdir -p $${HOME}/.streamcli
	podman run \
		--mount type=bind,source="$${HOME}/.streamcli",target=/root \
		streamcli /bin/sh -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

.PHONY: run
run:
	@echo run container current directory
	podman run -it \
		--mount type=bind,source="$(PWD)",target=/projects \
		streamcli /bin/zsh

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
	@echo '    streamcli /bin/zsh'
	@echo "}"


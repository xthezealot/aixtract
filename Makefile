CRYSTAL_IMAGE := 84codes/crystal:latest-debian-bookworm
BINARY_NAME := aixtract

build-darwin-arm64:
	mkdir -p build
	crystal build $(BINARY_NAME).cr --release --no-debug -o build/$(BINARY_NAME)-darwin-arm64

build-linux-arm64:
	mkdir -p build
	docker run --rm -v $(PWD):/app -w /app --platform linux/arm64 $(CRYSTAL_IMAGE) build $(BINARY_NAME).cr --release --no-debug -o build/$(BINARY_NAME)-linux-arm64

build-linux-amd64:
	mkdir -p build
	docker run --rm -v $(PWD):/app -w /app --platform linux/amd64 $(CRYSTAL_IMAGE) build $(BINARY_NAME).cr --release --no-debug -o build/$(BINARY_NAME)-linux-amd64


build: build-darwin-arm64 build-linux-arm64 build-linux-amd64

clean:
	rm -r build

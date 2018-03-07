ARCH=         amd64
DOCKER_TAG=   nginx
ACI_VERSION=  1.13.9

build: stage

stage:
	mkdir -p stage.tmp
	cp deps/build.sh stage.tmp
	cp deps/Dockerfile.stage0 stage.tmp/Dockerfile
	cd stage.tmp && ./build.sh
	mkdir -p bin
	mv stage.tmp/nginx bin/
	@echo "--------------------------------"
	@echo " nginx binary moved to bin/"
	@echo "--------------------------------"

aci:
	@test -s bin/nginx || { echo "bin/nginx does not exist. Build nginx before continuing."; exit 1; }
	mkdir -p nginx-layout/rootfs/
	cp deps/manifest.json nginx-layout/manifest
	sed -i "s/<ACI_VERSION>/$(ACI_VERSION)/g" nginx-layout/manifest
	tar -xzf deps/rootfs.tar.gz -C nginx-layout/rootfs/
	cp bin/nginx nginx-layout/rootfs/bin/
	actool build nginx-layout nginx.aci
	@echo "---------------------------------------------"
	@echo " aci built, see readme for config settings"
	@echo "---------------------------------------------"

travisaci:
	wget https://github.com/appc/spec/releases/download/v0.8.7/appc-v0.8.7.tar.gz
	tar -zxf appc-v0.8.7.tar.gz
	mkdir -p nginx-layout/rootfs/
	cp deps/manifest.json nginx-layout/manifest
	sed -i "s/<ACI_VERSION>/$(ACI_VERSION)/g" nginx-layout/manifest
	tar -xzf deps/rootfs.tar.gz -C nginx-layout/rootfs/
	cp bin/nginx nginx-layout/rootfs/bin/
	appc-v0.8.7/actool build nginx-layout nginx.aci
	@echo "---------------------------------------------"
	@echo " aci built, see readme for config settings"
	@echo "---------------------------------------------"

gpgsign:
	mv nginx.aci nginx-$(ACI_VERSION)-linux-$(ARCH).aci
	mv deps/sign.sh .
	chmod +x sign.sh
	./sign.sh nginx-$(ACI_VERSION)-linux-$(ARCH) $(GPG_SEC)

importaci:
	sudo rkt fetch nginx.aci --insecure-options=image

docker:
	@test -s bin/nginx || { echo "bin/nginx does not exist. Build nginx before continuing."; exit 1; }
	rm -rf stage.tmp/
	mkdir -p stage.tmp/
	cp deps/Dockerfile.stage1 stage.tmp/Dockerfile
	cp deps/rootfs.tar.gz stage.tmp/
	cp bin/nginx stage.tmp/
	cd stage.tmp && sudo docker build --no-cache -t $(DOCKER_TAG) .
	@echo "----------------------------------------------"
	@echo " image: '$(DOCKER_TAG)' built"
	@echo "----------------------------------------------"

rundocker:
	cd deps/test/ && \
			./testdocker.sh

runrkt:
	cd deps/test/ && \
			./testrkt.sh

clean:
	rm -rf nginx-layout/
	rm -rf stage.tmp/
	rm -f nginx.aci

clean-all: clean
	rm -rf bin/

DOCKER_TAG=		nginx
stage:
	cd stage.0 && ./build.sh
	cd stage.0 && cp nginx ../stage.1/aci/ && \
	mv nginx ../stage.1/docker/
	@echo "------------------------------------------------------"
	@echo " nginx binary moved to stage.1/aci and stage.1/docker"
	@echo "------------------------------------------------------"

build:
	cd stage.0 && ./build.sh
	mv stage.0/nginx .
	@echo "----------------"
	@echo " binary built"
	@echo "----------------"

aci:
	cp nginx stage.1/aci/nginx-layout/rootfs/bin/
	cd stage.1/aci/ && \
		cp manifest.json nginx-layout/manifest && \
		cp nginx nginx-layout/rootfs/bin && \
		actool build nginx-layout nginx.aci
	cp stage.1/aci/nginx.aci .
	@echo "---------------------------------------------"
	@echo " aci built, see readme for config settings"
	@echo "---------------------------------------------"

docker:
	cd stage.1/docker/ && sudo docker build --no-cache -t $(DOCKER_TAG) .
	@echo "----------------------------------------------"
	@echo " docker built, see readme for config settings"
	@echo "----------------------------------------------"

run:
	cd test/ && \
			./test.sh

clean:
	rm -f nginx
	rm -f stage.0/nginx
	rm -f nginx.aci
	rm -f stage.1/docker/nginx
	rm -f stage.1/aci/nginx
	rm -f stage.1/aci/nginx.aci
	rm -f stage.1/aci/nginx-layout/manifest
	rm -f stage.1/aci/nginx-layout/rootfs/bin/nginx

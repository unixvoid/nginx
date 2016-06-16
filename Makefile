DOCKER_TAG=		nginx
stage:
	cd stage.0 && ./build.sh
	cd stage.0 && cp nginx ../stage.1/aci/nginx-layout/rootfs/bin/ && \
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
	cd stage.1/aci/ && \
		cp manifest.json nginx-layout/manifest && \
		actool build nginx-layout nginx.aci
	mv stage.1/aci/nginx.aci .
	@echo "---------------------------------------------"
	@echo " aci built, see readme for config settings"
	@echo "---------------------------------------------"

importaci:
	sudo rkt fetch nginx.aci --insecure-options=image

docker:
	cd stage.1/docker/ && sudo docker build --no-cache -t $(DOCKER_TAG) .
	@echo "----------------------------------------------"
	@echo " docker built, see readme for config settings"
	@echo "----------------------------------------------"

rundocker:
	cd test/ && \
			./testdocker.sh

runrkt:
	cd test/ && \
			./testrkt.sh

clean:
	rm -f nginx
	rm -f stage.0/nginx
	rm -f nginx.aci
	rm -f stage.1/docker/nginx
	rm -f stage.1/aci/nginx
	rm -f stage.1/aci/nginx.aci
	rm -f stage.1/aci/nginx-layout/manifest
	rm -f stage.1/aci/nginx-layout/rootfs/bin/nginx

stage:
	cd stage.0 && ./build.sh

aci:
	cd stage.1/aci/ && \
		cp manifest.json nginx-layout/manifest && \
		cp nginx nginx-layout/rootfs/bin && \
		actool build nginx-layout nginx.aci
	cp stage.1/aci/nginx.aci .
	@echo "---------------------------------------------"
	@echo " aci built, see readme for config settings"
	@echo "---------------------------------------------"

docker:
	cd stage.1/docker/ && sudo docker build -t nginx .
	@echo "----------------------------------------------"
	@echo " docker built, see readme for config settings"
	@echo "----------------------------------------------"

clean:
	rm -f stage.0/nginx
	rm -f nginx.aci
	rm -f stage.1/docker/nginx
	rm -f stage.1/aci/nginx
	rm -f stage.1/aci/nginx.aci
	rm -f stage.1/aci/nginx-layout/manifest
	rm -f stage.1/aci/nginx-layout/rootfs/bin/nginx

FROM scratch

ADD rootfs.tar.gz /

COPY nginx /bin/
COPY nginx.conf /nginx/
COPY index.html /nginx/data/

ENTRYPOINT ["/bin/nginx"]

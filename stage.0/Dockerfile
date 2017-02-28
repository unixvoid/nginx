FROM alpine

ENV NGINX_VER nginx-1.11.10
ENV LIBRESSL_VER libressl-2.5.1

RUN apk update
RUN apk add \
  linux-headers \
  pcre-dev \
  zlib-dev \
  g++ \
  make \
  perl \
  wget

RUN wget http://nginx.org/download/$NGINX_VER.tar.gz && \
    tar -xzf /$NGINX_VER.tar.gz && \
    cd /$NGINX_VER/ && \
    wget https://ftp.openbsd.org/pub/OpenBSD/LibreSSL/$LIBRESSL_VER.tar.gz --no-check-certificate && \
    tar -xzf $LIBRESSL_VER.tar.gz && \
	wget https://github.com/openresty/headers-more-nginx-module/archive/v0.30.tar.gz --no-check-certificate && \
	tar -xzf v0.30.tar.gz && \
	mv headers-more-nginx-module-0.30 headers-more

RUN cd /$NGINX_VER && ./configure \
    --with-ld-opt="-static" \
    --sbin-path=/bin/nginx \
    --prefix=/nginx/ \
    --with-http_gzip_static_module \
    --conf-path=/nginx/nginx.conf \
    --error-log-path=/nginx/log/error.log \
    --http-log-path=/nginx/log/access.log \
    --http-client-body-temp-path=/nginx/log/client_body_temp \
    --pid-path=/nginx/log/nginx.pid \
    --lock-path=/nginx/log/nginx.lock \
    --with-http_ssl_module \
    --with-stream \
    --with-stream_ssl_module \
    --add-module=/$NGINX_VER/headers-more \
    --with-openssl=./$LIBRESSL_VER

RUN cd /$NGINX_VER && make && make install
CMD ["cp", "/bin/nginx", "/stage/"]

FROM alpine

ENV NGINX_VER nginx-1.11.3
ENV OPENSSL_VER openssl-1.0.2h
ENV FANCYINDEX_VER v0.4.0
#ENV OPENSSL_VER openssl-1.1.0-pre6
# apk add linux-headers

RUN apk update
RUN apk add \
  pcre-dev \
  zlib-dev \
  g++ \
  make \
  perl \
  ca-certificates \
  tar \
  wget

RUN wget http://nginx.org/download/$NGINX_VER.tar.gz && \
    tar -xzf /$NGINX_VER.tar.gz && \
    cd /$NGINX_VER/ && \
    wget https://www.openssl.org/source/$OPENSSL_VER.tar.gz && \
    tar -xzf $OPENSSL_VER.tar.gz && \
	wget https://github.com/openresty/headers-more-nginx-module/archive/v0.30.tar.gz && \
	tar -xzf v0.30.tar.gz && \
	mv headers-more-nginx-module-0.30 headers-more && \
    wget https://github.com/aperezdc/ngx-fancyindex/archive/$FANCYINDEX_VER.tar.gz && \
        mkdir ngx-fancyindex && \
    	tar -xzf $FANCYINDEX_VER.tar.gz -C ngx-fancyindex --strip-components 1

RUN cd /$NGINX_VER && ./configure \
    --with-ld-opt="-static" \
    --sbin-path=/bin/nginx \
    --prefix=/cryo/ \
    --with-http_gzip_static_module \
    --conf-path=/cryo/conf/nginx.conf \
    --error-log-path=/cryo/log/error.log \
    --http-log-path=/cryo/log/access.log \
    --http-client-body-temp-path=/cryo/log/client_body_temp \
    --pid-path=/cryo/log/nginx.pid \
    --lock-path=/cryo/log/nginx.lock \
    --with-http_ssl_module \
    --with-stream \
    --with-stream_ssl_module \
    --with-openssl=./$OPENSSL_VER \
    --add-module=/$NGINX_VER/headers-more \
    --add-module=/$NGINX_VER/ngx-fancyindex

RUN cd /$NGINX_VER && make && make install
CMD ["cp", "/bin/nginx", "/stage/"]

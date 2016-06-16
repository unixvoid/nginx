FROM alpine

RUN apk update
RUN apk add \
  pcre-dev \
  zlib-dev \
  g++ \
  make \
  perl \
  wget

RUN wget http://nginx.org/download/nginx-1.11.1.tar.gz && \
    tar -xzf /nginx-1.11.1.tar.gz && \
    cd /nginx-1.11.1/ && \
    wget https://www.openssl.org/source/openssl-1.0.2h.tar.gz --no-check-certificate && \
    tar -xzf openssl-1.0.2h.tar.gz && \
	wget https://github.com/openresty/headers-more-nginx-module/archive/v0.30.tar.gz --no-check-certificate && \
	tar -xzf v0.30.tar.gz

RUN cd /nginx-1.11.1 && ./configure \
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
    --with-stream \
    --add-module=./headers-more-nginx-module-0.30 \
    --with-http_ssl_module \
    --with-openssl=./openssl-1.0.2h

RUN cd /nginx-1.11.1 && make && make install
CMD ["cp", "/bin/nginx", "/stage/"]

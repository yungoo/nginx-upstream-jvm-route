V=1.6.0 \
&& tar zxvf nginx-$V.tar.gz \
&& cd nginx-$V \
&& sed -i.bak 's/^CFLAGS="$CFLAGS -g"/#&/' auto/cc/gcc \
&& patch -p0 < ../nginx-upstream-jvm-route-master/jvm_route.patch \
&& ./configure --user=nginx --group=nginx \
--prefix=/usr/local/nginx \
--http-log-path=/var/log/nginx/access.log \
--error-log-path=/var/log/nginx/error.log \
--http-client-body-temp-path=/var/cache/nginx/client_temp \
--http-proxy-temp-path=/var/cache/nginx/proxy_temp \
--http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
--http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
--http-scgi-temp-path=/var/cache/nginx/scgi_temp \
--pid-path=/var/run/nginx.pid \
--with-http_realip_module \
--with-http_stub_status_module \
--with-http_gzip_static_module \
--with-http_ssl_module \
--add-module=../nginx-upstream-jvm-route-master \
--with-cc-opt='-O2 -g' \
&& make && make install

[ -f /usr/sbin/nginx ] && mv /usr/sbin/nginx{,.backup}
ln -sfT /usr/local/nginx/sbin/nginx /usr/sbin/nginx
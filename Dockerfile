ARG TAG=latest
FROM connormanning/entwine:$TAG

MAINTAINER John Wass <jwass3@gmail.com>

ENV EPT_BUILDER_VERSION 0.1
ENV EPT_HTTP_PORT 8080

LABEL io.k8s.display-name="EPT Builder" \
      io.k8s.description="Entwine Point Tile (EPT) Building and Serving Platform" \
      io.openshift.expose-services="${EPT_HTTP_PORT}:http" \
      io.openshift.tags="builder,ept,entwine,pointcloud" \
      io.openshift.s2i.scripts-url="image:///usr/libexec/s2i"

COPY s2i/bin/ /usr/libexec/s2i
COPY --from=nginx /etc/nginx /etc/nginx
COPY --from=nginx /usr/sbin/nginx /usr/sbin/nginx
COPY nginx/nginx.conf /etc/nginx
COPY nginx/default.conf /etc/nginx/conf.d

RUN mkdir /opt/app-root /entwine /var/log/nginx \
 && chown -R 1001:0 /entwine /usr/libexec/s2i /opt/app-root /var/log/nginx \
 && chmod -R g+rwX  /entwine /usr/libexec/s2i /opt/app-root /var/log/nginx

WORKDIR /opt/app-root

USER 1001

EXPOSE ${EPT_HTTP_PORT}

ENTRYPOINT []
CMD ["/usr/libexec/s2i/usage"]

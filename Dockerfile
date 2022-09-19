FROM python:3 AS builder
LABEL author="ASW"
LABEL description="Base Laboratorio VXLAN & EVPN de LACNOG"
LABEL version="1.0"
WORKDIR /web/
COPY . .
RUN pip install -r requirements.txt && mkdocs build
#
FROM nginx:stable
LABEL author="ASW"
LABEL description="Laboratorio VXLAN & EVPN de LACNOG"
LABEL version="1.0"
WORKDIR /usr/share/nginx/html
COPY --from=builder /web/site .
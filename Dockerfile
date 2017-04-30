FROM alpine:3.5

LABEL Description="Eclipse Mosquitto MQTT Broker"

RUN groupadd -r -g 1010 mosquitto \
    && useradd -r -u 1010 -g 1010 -d /mosquitto -m mosquitto
	

RUN apk --no-cache add mosquitto=1.4.10-r2 && \
    mkdir -p /mosquitto/config /mosquitto/data /mosquitto/log && \
    cp /etc/mosquitto/mosquitto.conf /mosquitto/config && \
    chown -R mosquitto:mosquitto /mosquitto

COPY docker-entrypoint.sh /
RUN chmod 755 /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/sbin/mosquitto", "-c", "/mosquitto/config/mosquitto.conf"]
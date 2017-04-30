#!/bin/ash
set -e

USER="mosquitto"

echo "mosquitto settings"
echo "===================="
echo
echo "  User:       ${USER}"
echo "  UID:        ${MOSQUITTO_UID:=666}"
echo "  GID:        ${MOSQUITTO_GID:=666}"
echo

printf "Updating UID / GID... "
[[ $(id -u ${USER}) == ${MOSQUITTO_UID} ]] || usermod  -o -u ${MOSQUITTO_UID} ${USER}
[[ $(id -g ${USER}) == ${MOSQUITTO_GID} ]] || groupmod -o -g ${MOSQUITTO_GID} ${USER}
echo "[DONE]"
	
printf "Setting permissions... "
chown -R ${USER}: /mosquitto/config
chown ${USER}: /mosquitto/data
chown ${USER}: /mosquitto/log
echo "[DONE]"
	
#exec su -pc "$@"

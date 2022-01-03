FROM openjdk:18-alpine

WORKDIR /opt/

ENV MIN_MEM=512m MAX_MEM=4G

ARG VERSION=1.18.1

# download+unpack & move configs to 1 folder
# this allows for less volumes
# ty @Roemer for the idea
RUN apk add curl && \
    curl -sSL $(curl -sSL https://mcversions.net/download/${VERSION} | grep -o 'https://launcher.mojang.com.*server.jar') -o server.jar && \
    apk del curl && \
    echo "eula=true" > eula.txt && \
    mkdir config && \
    touch config/server.properties config/ops.json config/whitelist.json config/banned-ips.json config/banned-players.json && \
    ln -s config/server.properties server.properties && \
    ln -s config/ops.json ops.json && \
    ln -s config/whitelist.json whitelist.json && \
    ln -s config/banned-ips.json banned-ips.json && \
    ln -s config/banned-players.json banned-players.json

CMD java -Xms${MIN_MEM} -Xmx${MAX_MEM} -jar server.jar nogui

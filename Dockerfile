FROM openjdk:8-alpine

WORKDIR /opt/

ENV MIN_MEM=1 MAX_MEM=16

# download+unpack & move configs to 1 folder
# this allows for less volumes
# ty @Roemer for the idea
RUN apk add curl && \
    curl -sSL https://launcher.mojang.com/v1/objects/b58b2ceb36e01bcd8dbf49c8fb66c55a9f0676cd/server.jar -o server.jar && \
    apk del curl && \
    echo "eula=true" > eula.txt && \
    mkdir config && \
    touch config/server.properties config/ops.json config/whitelist.json config/banned-ips.json config/banned-players.json && \
    ln -s config/server.properties server.properties && \
    ln -s config/ops.json ops.json && \
    ln -s config/whitelist.json whitelist.json && \
    ln -s config/banned-ips.json banned-ips.json && \
    ln -s config/banned-players.json banned-players.json

CMD java -Xms${MIN_MEM}G -Xmx${MAX_MEM}G -jar server.jar nogui

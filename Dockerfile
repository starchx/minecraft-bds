FROM ubuntu:18.04

RUN apt update -y && apt install -y curl unzip

WORKDIR /root/bedrock

RUN curl -o bedrock-server.zip https://minecraft.azureedge.net/bin-linux/bedrock-server-1.10.0.7.zip && \
    unzip bedrock-server.zip && \
    rm -f bedrock-server.zip

COPY permissions.json .
COPY server.properties .
COPY whitelist.json .

# Lucky Blocks Race
WORKDIR /root/bedrock/worlds/LuckyBlocksRace
RUN curl -o LuckyBlocksRace.zip https://s3-ap-southeast-2.amazonaws.com/chenit-resources/mcbds-maps/LuckyBlocksRaceV6.1.mcworld && \
    unzip LuckyBlocksRace.zip && rm LuckyBlocksRace.zip && \
    echo 'LuckyBlocksRace' > levelname.txt

# Parkour Islands
WORKDIR /root/bedrock/worlds/ParkourIslands
RUN curl -o ParkourIslands.zip https://s3-ap-southeast-2.amazonaws.com/chenit-resources/mcbds-maps/ParkourIslandsV0.1.4.2.mcworld && \
    unzip ParkourIslands.zip && rm ParkourIslands.zip && \
    echo 'ParkourIslands' > levelname.txt

# DefendTheCastle
WORKDIR /root/bedrock/worlds/DefendTheCastle
RUN curl -o DefendTheCastle.zip https://s3-ap-southeast-2.amazonaws.com/chenit-resources/mcbds-maps/DefendTheCastle.mcworld && \
    unzip DefendTheCastle.zip && rm DefendTheCastle.zip && \
    echo 'DefendTheCastle' > levelname.txt

# Set the server default level
WORKDIR /root/bedrock
ENV LD_LIBRARY_PATH=.
ENV default_level=LuckyBlocksRace

CMD sed -i "s/level-name=.*/level-name=${default_level}/g" server.properties ; LD_LIBRARY_PATH=. ; ./bedrock_server

#docker run -d -p 19132:19132/udp starchx/minecraft-bds:v1.10
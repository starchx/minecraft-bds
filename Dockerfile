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
RUN curl -o LuckyBlocksRace.zip https://download2268.mediafire.com/4lu0k4kvouig/delhqss4y83pr50/LuckyBlocksRaceV6.1.mcworld && \
    unzip LuckyBlocksRace.zip && rm LuckyBlocksRace.zip && \
    echo 'LuckyBlocksRace' > levelname.txt

# Parkour Islands
WORKDIR /root/bedrock/worlds/ParkourIslands
RUN curl -o ParkourIslands.zip http://download2260.mediafire.com/u5ku07yno0bg/4f91u2n4fdp6df0/%C2%A74Parkour+Islands+v0.1.4.2.mcworld && \
    unzip ParkourIslands.zip && rm ParkourIslands.zip && \
    echo 'ParkourIslands' > levelname.txt

# Set the server default level
WORKDIR /root/bedrock
ENV LD_LIBRARY_PATH=.
ENV default_level=LuckyBlocksRace

CMD ["sed -i 's/level-name=.*/level-name=${default_level}/g' server.properties && ./bedrock_server"]

#docker run -d -p 19132:19132/udp starchx/minecraft-bds:v1.10
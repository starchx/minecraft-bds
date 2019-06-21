FROM ubuntu:18.04

RUN apt update -y && apt install -y curl unzip

WORKDIR /root/bedrock

RUN curl -o bedrock-server.zip https://minecraft.azureedge.net/bin-linux/bedrock-server-1.11.2.1.zip && \
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

# DefendTheCastle - this world is broken for now
WORKDIR /root/bedrock/worlds/DefendTheCastle
RUN curl -o DefendTheCastle.zip https://s3-ap-southeast-2.amazonaws.com/chenit-resources/mcbds-maps/DefendTheCastle.mcworld && \
    unzip DefendTheCastle.zip && rm DefendTheCastle.zip && \
    echo 'DefendTheCastle' > levelname.txt

# PrisonBreak
WORKDIR /root/bedrock/worlds/PrisonBreak
RUN curl -o PrisonBreak.zip https://s3.us-east-2.amazonaws.com/mcpedl/worlds/1078/Prison-Break.mcworld && \
    unzip PrisonBreak.zip && rm PrisonBreak.zip && \
    echo 'PrisonBreak' > levelname.txt

# subnautica - this world is broken for now
# WORKDIR /root/bedrock/worlds/subnautica
# RUN curl -o subnautica.zip https://s3-ap-southeast-2.amazonaws.com/chenit-resources/mcbds-maps/subnautica.mcworld && \
#     unzip subnautica.zip && rm subnautica.zip && \
#     echo 'subnautica' > levelname.txt

# lastever360world - this world is broken for now
WORKDIR /root/bedrock/worlds/lastever360world
RUN curl -o lastever360world.zip https://s3-ap-southeast-2.amazonaws.com/chenit-resources/mcbds-maps/lastever360world.mcworld && \
    unzip lastever360world.zip && rm lastever360world.zip && \
    echo 'lastever360world' > levelname.txt

# CastleSiege
WORKDIR /root/bedrock/worlds/CastleSiege
RUN curl -o CastleSiege.zip https://minecraft.net/assets/addons/castle-siege.mcworld && \
    unzip CastleSiege.zip && rm CastleSiege.zip && \
    echo 'CastleSiege' > levelname.txt

# TheGames
WORKDIR /root/bedrock/worlds/TheGames
RUN curl -o TheGames.zip https://s3-ap-southeast-2.amazonaws.com/chenit-resources/mcbds-maps/TheGames.zip && \
    unzip TheGames.zip && rm TheGames.zip && \
    echo 'TheGames' > levelname.txt

# MegaSkyblock
WORKDIR /root/bedrock/worlds/MegaSkyblock
RUN curl -o MegaSkyblock.zip https://s3-ap-southeast-2.amazonaws.com/chenit-resources/mcbds-maps/Mega_Skyblock_v6.2_By_TGC__BU.mcworld && \
    unzip MegaSkyblock.zip || true && rm MegaSkyblock.zip && \
    echo 'MegaSkyblock' > levelname.txt

# Jurassic
WORKDIR /root/bedrock/worlds/Jurassic
RUN curl -o Jurassic.zip https://chenit-resources.s3-ap-southeast-2.amazonaws.com/mcbds-maps/Jurassic/Jurassic+World+April+2019.mcworld && \
    unzip Jurassic.zip || true && rm Jurassic.zip && \
    echo 'Jurassic' > levelname.txt
WORKDIR /root/bedrock/resource_packs/Jurassic_Craft_Resources
RUN curl -o Jurassic_Craft_Resources.zip https://chenit-resources.s3-ap-southeast-2.amazonaws.com/mcbds-maps/Jurassic/Jurassic+Craft+Resources.mcpack && \
    unzip Jurassic_Craft_Resources.zip || true && rm Jurassic_Craft_Resources.zip
WORKDIR /root/bedrock/resource_packs/
RUN curl -o Decoration_Addon.zip https://chenit-resources.s3-ap-southeast-2.amazonaws.com/mcbds-maps/Jurassic/Decoration+addon+ROBERTGAMER69.mcaddon && \
    unzip Decoration_Addon.zip || true && rm Decoration_Addon.zip
WORKDIR /root/bedrock/resource_packs/FLOWS_HD
RUN curl -o FLOWS_HD.zip https://chenit-resources.s3-ap-southeast-2.amazonaws.com/mcbds-maps/Jurassic/FLOWS+HD+128x128+OFICIAL.mcpack && \
    unzip FLOWS_HD.zip || true && rm FLOWS_HD.zip
WORKDIR /root/bedrock/behavior_packs/Jurassic_Craft_Behaviors
RUN curl -o Jurassic_Craft_Behaviors.zip https://chenit-resources.s3-ap-southeast-2.amazonaws.com/mcbds-maps/Jurassic/Jurassic+Craft+Behaviors.mcpack && \
    unzip Jurassic_Craft_Behaviors.zip || true && rm Jurassic_Craft_Behaviors.zip

# Set the server default level
WORKDIR /root/bedrock
ENV LD_LIBRARY_PATH=.
ENV default_level=LuckyBlocksRace

CMD sed -i "s/level-name=.*/level-name=${default_level}/g" server.properties ; LD_LIBRARY_PATH=. ; ./bedrock_server

#docker run -d -p 19132:19132/udp starchx/minecraft-bds:v1.10
#!/bin/bash

echo "[1/5] Downloading BuildTools.jar..."
curl -o BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar

echo "[2/5] Building Spigot 1.20.1 (this may take a few minutes)..."
java -jar BuildTools.jar --rev 1.20.1

echo "[3/5] Renaming output to server.jar..."
mv spigot-1.20.1.jar server.jar

echo "[4/5] Accepting EULA..."
echo "eula=true" > eula.txt

echo "[5/5] Starting Spigot Server..."
java -Xms1G -Xmx2G -jar server.jar nogui

#!/bin/bash

echo "[1/6] Downloading BuildTools.jar..."
curl -o BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar

echo "[2/6] Building Spigot 1.20.1 (this may take several minutes)..."
java -jar BuildTools.jar --rev 1.20.1

echo "[3/6] Searching and renaming spigot jar to server.jar..."
spigot_jar=$(find . -maxdepth 1 -type f -name "spigot-1.20.1*.jar" | head -n 1)
if [ -f "$spigot_jar" ]; then
    mv "$spigot_jar" server.jar
else
    echo "Error: Could not find the built Spigot jar."
    exit 1
fi

echo "[4/6] Accepting EULA..."
echo "eula=true" > eula.txt

echo "[5/6] Moving server.jar and creating echo.txt in parent folder..."
parent_dir="$(dirname "$PWD")"
cp server.jar "$parent_dir"/server.jar
echo "Spigot 1.20.1 setup complete!" > "$parent_dir"/echo.txt

echo "[6/6] Cleaning up everything else including this script..."
cd "$parent_dir"
rm -rf "$(basename "$PWD")"

echo "Final setup done. Only server.jar and echo.txt remain in: $(pwd)"

#!/usr/bin/env sh
launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.mongodb1.plist
launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.mongodb2.plist
launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.mongodb3.plist

pkill -f mongod

rm -f ~/Library/LaunchAgents/homebrew.mxcl.mongodb*.plist

cp -f *.plist /usr/local/opt/mongodb/
cp -f *.conf /usr/local/etc/
cp -f replsetcontrol /usr/local/bin/

mkdir -p /usr/local/var/log/mongodb1
mkdir -p /usr/local/var/log/mongodb2
mkdir -p /usr/local/var/log/mongodb3
mkdir -p /usr/local/var/mongodb1
mkdir -p /usr/local/var/mongodb2
mkdir -p /usr/local/var/mongodb3

ln -sfv /usr/local/opt/mongodb/homebrew.mxcl.mongodb*.plist ~/Library/LaunchAgents/

rm -f ~/Library/LaunchAgents/homebrew.mxcl.mongodb.plist

launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mongodb1.plist
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mongodb2.plist
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mongodb3.plist

echo "Waiting for replica set..."
sleep 10

mongo --host localhost <<EOF

var cfg = {
    "_id": "rs",
    "version": 1,
    "members": [
        {
            "_id": 0,
            "host": "127.0.0.1:27017",
            "priority": 1
        },
        {
            "_id": 1,
            "host": "127.0.0.1:27018",
            "priority": .5
        },
        {
            "_id": 2,
            "host": "127.0.0.1:27019",
            "priority": .5
        }
    ]
};

rs.initiate(cfg);
rs.reconfig(cfg)

EOF

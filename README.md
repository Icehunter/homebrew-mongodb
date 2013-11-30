homebrew-mongodb
================

Simple setup scripts to get a mongodb replica set up and running on OSX for development work.

### Requirements
* Homebrew installed. You can find it at [http://brew.sh/](http://brew.sh/)
* mongodb installed

You can install mongodb with the following command in terminal:
``` pre
brew install mongodb
```

### Files

* homebrew.mxcl.mongodb#.plist
* mongod#.conf

### Directories Created
* /usr/local/var/log/mongodb#/
* /usr/local/var/mongodb#/

Note: *# == 1,2,3*

### Usage
Run the following commands in terminal:
``` pre
git clone https://github.com/Icehunter/homebrew-mongodb.git
cd homebrew-mongodb
sh ./setup.sh
```
### Verification
You can verify your install by opening a mongo prompt with:
``` pre
mongo
```
It should say the following at the mongo prompt:
``` pre
rs.PRIMARY>
```

Congratulations! You now have a working local replica set with mongodb.
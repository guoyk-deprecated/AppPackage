AppPackage
---

AppPacket is a template to package h5 app into a standardlized format.

### Start

install `node`

`sudo npm install -g grunt-cli`
`sudo npm install -g bower`
`npm install`
`bower install`
`grunt`

### Warnning

All filenames should be downcased

HTML files should be at top level only

make file structure as flatten as possible

NO file rev for vendored libs, use version in path instead

### manifest.json

```json
{
  "version":"1.0.0",                                          // current version
  "platform": {                                               // Supported platform version
    "YMXianiOS":"1.3.0",
    "YMXianAndroid":"1.2.1"
  },
  "main":"index.12hdnbt.html",                                // main html file
  "nextCheckAt":"1970-01-17T14:07:49.840Z",                   // nextCheckAt for better performance, 10d max
  "downloadBaseUrl":"http://what.s3.amazonaws.com/dsafasdf/", // Base url for download and sync
  "files":[                                                   // files can be downloaded from downloadBaseUrl
    "index.12hdnbt.html",
    "index2.de3dnbt.html",
    "js/main.11233.js",
    "css/main.2234c.css",
    "vendor/bootstrap-3.1.1/bootstrap.css"
  ],
  "platformFiles": {                                          // files platform should provide and auto copy to position
    "cordova-3.8.js":"js/cordova-3.8.js"
  }
}
```

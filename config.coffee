module.exports =
  manifest:
    version: '1.1.0'
    expire: '10'                                            # Expires in Day
    main: 'index.html'                                      # Entry file
    downloadBaseUrl: 'http://what.s3.amazonaws.com/app/'    # download base url
    platform:                                               # Platform
      YMXianiOS: '1.2.0'
      YMXianAndroid: '1.2.0'
    platformFiles:
      "cordova-3.8.js":"js/cordova-3.8.js"
  bower:
    root: __dirname + '/bower_components/'
    libs:
      angular:
        js:   'angular.js'
      'angular-bootstrap':
        js:   'ui-bootstrap-tpls.js'
      bootstrap:
        css:  'dist/bootstrap.css'
        fonts:'dist/fonts/**/*'
      ngCordova:
        js:  'ng-cordova.js'

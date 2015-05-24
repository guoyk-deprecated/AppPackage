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
    root: 'bower_components'
    libs:
      angular:
        js:   'angular.min.js'
      'angular-bootstrap':
        js:   'ui-bootstrap-tpls.min.js'
      bootstrap:
        css:  'dist/css/bootstrap.min.css'
        fonts:'dist/fonts/*'
      ngCordova:
        js:  'dist/ng-cordova.min.js'

config = require 'tbirds/app-config'
config.userMenuApp = require './user-menu-view'
config.hasUser = true
config.appletRoutes.profile = 'userprofile'

config.brand.label = 'Flathead'
config.brand.url = '#'

config.authToken = {}
config.authToken.refreshInterval = '5m'
config.authToken.refreshIntervalMultiple = 3

fileexchange_upload_url = \
  "http://bulksell.ebay.com/ws/eBayISAPI.dll?FileExchangeUploadForm"

misc_menu =
  label: 'Misc Applets'
  menu: [
    {
      label: 'Themes'
      url: '#frontdoor/themes'
    }
    {
      label: 'Sofi'
      url: '#sofi'
      needUser: true
    }
    {
      label: 'Ebcsv'
      url: '#ebcsv'
      needUser: true
    }
    {
      label: 'Bumblr'
      url: '#bumblr'
    }
    {
      label: 'Hubby'
      url: '#hubby'
    }
    {
      label: 'Todos'
      url: '#todos'
      needUser: true
    }
    {
      label: 'TestUpload'
      url: '#frontdoor/upload'
      needUser: true
    }
  ]

ebcsv_menu =
  needUser: true
  label: 'Ebcsv'
  menu: [
    {
      label: 'Main View'
      url: '#ebcsv'
    }
    {
      label: 'List Configs'
      url: '#ebcsv/cfg/list'
    }
    {
      label: 'List Descriptions'
      url: '#ebcsv/dsc/list'
    }
    {
      label: 'Upload Comic XML'
      url: '#ebcsv/xml/upload'
    }
    {
      label: 'Create CSV'
      url: '#ebcsv/csv/create'
    }
    {
      label: 'Create New Config'
      url: '#ebcsv/cfg/add'
    }
  ]

config.navbarEntries = [
  ebcsv_menu
  {
    label: 'File Exchange'
    url: fileexchange_upload_url
    needUser: true
  }
  misc_menu
  ]


module.exports = config

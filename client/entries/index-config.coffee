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

sofi_menu =
  needUser: true
  label: 'Sofi'
  menu: [
    {
      label: 'Main View'
      url: '#sofi'
    }
    {
      label: 'Database Comics'
      url: '#sofi/comics'
    }
    {
      label: 'Workspaces'
      url: '#sofi/comics/workspace'
    }
    {
      label: 'Upload Comic XML'
      url: '#sofi/xml/upload'
    }
    {
      label: 'Create CSV'
      url: '#sofi/csv/create'
    }
    {
      label: 'List Configs'
      url: '#sofi/cfg/list'
    }
    {
      label: 'List Descriptions'
      url: '#sofi/dsc/list'
    }
  ]

config.navbarEntries = [
  sofi_menu
  {
    label: 'File Exchange'
    url: fileexchange_upload_url
    needUser: true
  }
  misc_menu
  ]


module.exports = config

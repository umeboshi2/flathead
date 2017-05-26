config = require 'tbirds/app-config'
config.userMenuApp = require './user-menu-view'
config.hasUser = true

config.brand.label = 'Flathead'
config.brand.url = '#'
misc_menu =
  label: 'Misc Applets'
  menu: [
    {
      label: 'Ebcsv'
      url: '#ebcsv'
    }
    {
      label: 'Bumblr'
      url: '#bumblr'
    }
    {
      label: 'Hubby'
      url: '#hubby'
    }
  ]

config.navbarEntries = [
  {
    label: 'Ebcsv'
    url: '#ebcsv'
  }
  {
    label: 'Themes'
    url: '#frontdoor/themes'
  }
  misc_menu
  ]


module.exports = config

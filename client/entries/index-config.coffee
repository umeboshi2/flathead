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
    label: 'Admin'
    url: '/admin'
  }
  {
    label: 'Ebcsv'
    url: '#ebcsv'
  }
  {
    label: 'Themes'
    url: '#frontdoor/themes'
  }
  {
    label: 'Fantasy'
    url: '/#fantasy'
  }
  {
    label: 'Annex'
    url: '#annex'
  }
  {
    label: 'Dbdocs'
    url: '#dbdocs'
  }
  misc_menu
  {
    label: 'Another'
    menu: [
      {
        label: 'Crud'
        url: '#crud'
      }
      {
        label: 'MS Code'
        url: '#mscode'
      }
      {
        label: 'MSLeg'
        url: '#msleg'
      }
    ]
  }
  ]


module.exports = config

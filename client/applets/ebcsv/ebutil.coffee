Backbone = require 'backbone'
xml = require 'xml2js-parseonly/src/xml2js'
ms = require 'ms'
dateFormat = require 'dateformat'

capitalize = require 'tbirds/util/capitalize'

MessageChannel = Backbone.Radio.channel 'messages'
AppChannel = Backbone.Radio.channel 'ebcsv'

ComicAges =
  platinum:
    start: 1897
    end: 1937
  golden:
    start: 1938
    end: 1955
  silver:
    start: 1956
    end: 1969
  bronze:
    start: 1970
    end: 1983
  copper:
    start: 1984
    end: 1991
  modern:
    start: 1992
    # FIXME magic number for end of modern age
    end: 2100

get_comic_age = (year) ->
  for age of ComicAges
    ad = ComicAges[age]
    #console.log "Checking age", age, ad.start, ad.end
    if (year >= ad.start and year <= ad.end)
      return age
  return false
  
AppChannel.reply 'get-comic-ages', ->
  ComicAges

AppChannel.reply 'find-age', (year) ->
  get_comic_age year


get_heroes_by_age = (year, herolist) ->
  age = get_comic_age year
  newlist = []
  herolist.forEach (row) ->
    if row.age == age
      newlist.push row
  return newlist
  
# Most of these are not required fields!
EbayFields = [
  'Title'
  'PicURL'
  'Description'
  'Product:EAN'
  'Product:UPC'
  'Product:ISBN',
  '*Category'
  ]
  
ReqFieldNames = [
  'format'
  'location'
  'returnsacceptedoption'
  'duration'
  'quantity'
  'startprice'
  'dispatchtimemax'
  'conditionid'
  ]

AppChannel.reply 'csv-req-fieldnames', ->
  ReqFieldNames

OptFieldNames = [
  'postalcode'
  'paymentprofilename'
  'returnprofilename'
  'shippingprofilename'
  'scheduletime'
  ]
  
AppChannel.reply 'csv-opt-fieldnames', ->
  OptFieldNames
  

XmlParser = new xml.Parser
  explicitArray: false
  async: false

AppChannel.reply 'get-xmlparser', ->
  XmlParser
  

class XmlComic extends Backbone.Model

class XmlComicCollection extends Backbone.Collection
  model: XmlComic

CurrentCollection = new XmlComicCollection

AppChannel.reply 'set-comics', (comics) ->
  CurrentCollection.set comics

AppChannel.reply 'get-comics', ->
  CurrentCollection

AppChannel.reply 'parse-comics-xml', (content, cb) ->
  XmlParser.parseString content, (err, json) ->
    comics = json.comicinfo.comiclist.comic
    AppChannel.request 'set-comics', comics
    cb()


#######################################################
# makeCommonData (config)
#######################################################

create_common_data = (options) ->
  row = {}
  cfg = options.cfg.get 'content'
  row.action = options.action
  ReqFieldNames.forEach (field) ->
    row[field] = cfg[field]
  OptFieldNames.forEach (field) ->
    row[field] = cfg[field]
  return row
  
#######################################################
# makeEbayInfo (config, comic, opts, mgr)
#######################################################
create_csv_row_object = (options) ->
  comic = options.comic
  cfg = options.cfg.get 'content'
  # make common data
  # from required and optional fields
  row = create_common_data options
  # then adjust these fields -->

  # quantity is from config(1) unless comic.quantity > 1
  # csv header should be *Quantity
  if row.quantity != comic.quantity
    row.quantity = comic.quantity

  # default startprice in config
  # csv header should be *Startprice
  # if comic.currentprice exists use
  # that instead
  if comic?.currentprice
    currentprice = comic.currentprice
    while currentprice.startsWith '$'
      currentprice = currentprice.substring 1, currentprice.length
    row.startprice = currentprice
    
    
  # parse scheduletime in config
  # if scheduletime is 0 then
  # set row.scheduletime = ''
  timedelta = ms row.scheduletime
  if timedelta
    now = new Date()
    nt = now.valueOf() + timedelta
    later = new Date nt
    #pyformat = "%Y-%m-%d %H:%M:%S"
    sformat = "yyyy-mm-dd HH:MM:ss"
    row.scheduletime = dateFormat later, sformat

  #
  # --------> then add fields
  
  # set upc
  # if comic.isbn then set Product:UPC
  # if upc.length == 14 then return upc[:-2]
  # if upc.length == 13 then return upc[1:]
  if comic?.isbn
    upc = comic.isbn
    if upc.length == 14
      upc = upc.substring(0, upc.length - 2)
    if upc.length == 13
      upc = upc.substring(1, upc.length)
    row['Product:UPC'] = upc
    
    
  #
  # get categoryID
  # csv header should be *Category
  shmodel = AppChannel.request 'get-superheroes-model'
  hlist = shmodel.get 'rows'
  # FIXME this might fail and year needs to be 2017
  year = comic.publicationdate?.year
  if not year
    year = comic.releasedate.year
    console.warn "Using releasedate"
  if not year
    console.warn "Bad date for comic", comic
    MessageChannel.request "danger", "Bad Date for comic #{comic.id}"
  year = parseInt year.displayname
  console.log "YEAR", year
  seriesname = comic.mainsection.series.displayname.toLowerCase()
  age = AppChannel.request 'find-age', year
  #console.log "age, year", age, year
  hrows = get_heroes_by_age year, hlist
  other_row = undefined
  heroes = {}
  for hrow in hrows
    if hrow.superhero.startsWith 'Other '
      other_row = hrow
    field = hrow.superhero.toLowerCase()
    heroes[field] = hrow
  if not other_row?
    MessageChannel.request 'danger', "No category found for #{age}"
  found_row = other_row
  for h of heroes
    #console.log "Checking hero", h, seriesname
    if (seriesname.indexOf(h) >= 0)
      found_row = heroes[h]
      break
  row['*Category'] = found_row.id
  
  #console.log "hrows", hrows
    
  #
  # set picurl
  urls = AppChannel.request 'get-comic-image-urls'
  url = comic.links.link.url
  #console.log "URLS", urls
  image_src = urls[url]
  #console.log "url->", url, "image_src", image_src
  row['PicURL'] = urls[comic.links.link.url]

  # make title
  #
  # make description
  #
  #console.log "row", row, options

  return row

AppChannel.reply 'create-csv-row-object', (action, comic, cfg, desc) ->
  create_csv_row_object action, comic, cfg, desc
  

create_csv_header = ->
  header = {action: "*Action"}
  for field in ReqFieldNames
    header[field] = "*#{capitalize field}"
  for field in OptFieldNames
    header[field] = field
  for field in EbayFields
    header[field] = field
  return header

AppChannel.reply 'create-csv-header', ->
  create-csv-header()
  
CSV_HEADER = create_csv_header()
AppChannel.reply 'get-csv-header', ->
  CSV_HEADER
  
class CsvRowModel extends Backbone.Model
  set_comic: (options) ->
    comic = options.comic
    config = options.config
    desc = options.description
    
    

CurrentCsvRowCollection = undefined
    



module.exports = {}

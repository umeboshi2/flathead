Backbone = require 'backbone'
xml = require 'xml2js-parseonly/src/xml2js'

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
  
# These are not required fields!
EbayFields = [
  'Title'
  'PicURL'
  'Description'
  'Product:EAN'
  'Product:UPC'
  'Product:ISBN',
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



#######################################################
# makeEbayInfo (config, comic, opts, mgr)
#######################################################



# set upc
# if comic.isbn then set Product:UPC
# if upc.length == 14 then return upc[:-2]
# if upc.length == 13 then return upc[1:]
#

# quantity is comic.quantity
# csv header should be *Quantity


# get categoryID
# csv header should be *Category
#

# default startprice in config
# csv header should be *Startprice
# if comic.currentprice exists use
# that instead



create_csv_header = ->
  header = {}
  for field in ReqFieldNames
    header[field] = "*#{capitalize field}"
  for field in OptFieldNames
    header[field] = field
  return header

class CsvRowModel extends Backbone.Model
  set_comic: (options) ->
    comic = options.comic
    config = options.config
    desc = options.description
    

CurrentCsvRowCollection = undefined
    



module.exports = {}

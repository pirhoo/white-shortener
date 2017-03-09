cors    = require('cors')
express = require('express')
_       = require('lodash')
request = require('superagent')
# Bit ly constants
SHORTENER_HOST   = process.env.SHORTENER_HOST or 'www.googleapis.com'
SHORTENER_APIKEY = process.env.SHORTENER_APIKEY
# List of allowed domain
ALLOWED_DOMAINS = _.map (process.env.ALLOWED_DOMAINS or '').split(','), _.trim
# Create a simple express app
app = do express
# This application allows CORS
app.use cors()

# Extract domain from a given URL
# @src http://stackoverflow.com/questions/8498592/extract-root-domain-name-from-string
extractDomain = (url) ->
  # Find & remove protocol (http, ftp, etc.) and get domain
  if url.indexOf('://') > -1
    domain = url.split('/')[2]
  else
    domain = url.split('/')[0]
  # Find & remove port number
  domain = domain.split(':')[0]

# Main (and only) route
app.get '/', (req, res)->
  # URL to shorten
  url = req.query.url
  # Extract the domain from the URL
  url_domain = extractDomain url
  # Call the bit.ly API
  allowed = _.any ALLOWED_DOMAINS, (domain)-> domain is url_domain
  # Stop if not allowed
  return res.send(401) unless allowed
  # Build the request to the shortner API
  request
    .post 'https://' + SHORTENER_HOST + '/urlshortener/v1/url'
    # Authenticate request
    .query key: SHORTENER_APIKEY
    # Request query params
    .send longUrl: url
    .end (err, result)->
      # Simply send the request body
      res.jsonp result.body

# Then start listening
server = app.listen process.env.PORT or 3000

cors    = require('cors')
express = require('express')
_       = require('lodash')
request = require('superagent')
# Bit ly constants
BITLY_HOST   = process.env.BITLY_HOST or 'api.bitly.com'
BITLY_LOGIN  = process.env.BITLY_LOGIN
BITLY_APIKEY = process.env.BITLY_APIKEY
# List of allowed domain
ALLOWED_DOMAINS = _.map (process.env.ALLOWED_DOMAINS or '').split(','), _.trim
# Create a simple express app
app = do express
# This application allows CORS
app.use cors()

# Extract domain from a given URL
# @src http://stackoverflow.com/questions/8498592/extract-root-domain-name-from-string
extractDomain = (url) ->
  domain = undefined
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
    # Build the request to the bit.ly API
    request
      .get 'http://' + BITLY_HOST + '/v3/shorten'
      .query
        # Request query params
        format : 'json'
        login  : BITLY_LOGIN
        apiKey : BITLY_APIKEY
        longUrl: encodeURIComponent(url)
      .end (err, result)->
        # Simply send the request body
        res.jsonp result.body

# Then start listening
server = app.listen process.env.PORT or 3000

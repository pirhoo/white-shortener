# White Shortener

This very simple URL-shortener uses goo.gl through a whitelist of domains. This might be useful for client-side URL shortenin without leaking API keys.

## Demo

We configured the whitelist to allow URLs from the domain `pirhoo.com`. This URL will be shortened:

```http
GET https://white-shortener.herokuapp.com/?url=http://pirhoo.com
```

```json
{
  "kind": "urlshortener#url",
  "id": "http://goo.gl/f0Fo50",
  "longUrl": "http://pirhoo.com/"
}
```

When this one will be rejected:


```http
https://white-shortener.herokuapp.com/?url=http://google.com
```

```http
401 Unauthorized
```

## Install

```
npm install
```

## Configure

Use environement variables to configure this app.


Variable | Description | Default
--- | --- | ---
`ALLOWED_DOMAINS` | A list of allowed domains |
`SHORTENER_APIKEY` | Shortener's API key |
`SHORTENER_HOST` | Shortener's hostname | *www.googleapis.com*
`PORT` | Server listening port | *3000*

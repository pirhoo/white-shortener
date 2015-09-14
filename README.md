# White Shortener

This very simple URL-shortener uses bit.ly through a whitelist of domains. This might be useful for client-side URL shortenin without leaking API keys.

## Install

```
npm install
```

## Configure

Use environement variables to configure this app.


Variable | Description | Default
--- | --- | ---
`ALLOWED_DOMAINS` | A list of allowed domains |
`BITLY_APIKEY` | Shortener's API key |
`BITLY_HOST` | Shortener's hostname | *www.googleapis.com*
`PORT` | Server listening port | *3000*

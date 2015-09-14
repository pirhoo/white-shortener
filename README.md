# White Shortener

This very simple URL-shortener uses bit.ly through a whitelist of domains.

## Install

```
npm install
```

## Configure

Use environement variables to configure this app.


Variable | Description | Default
--- | --- | ---
`ALLOWED_DOMAINS` | A list of allowed domains |
`BITLY_LOGIN` | Bit.ly's login |
`BITLY_APIKEY` | Bit.ly's API key |
`BITLY_HOST` | Bit.ly's hostname | *api.bitly.com*
`PORT` | Server listening port | *3000*

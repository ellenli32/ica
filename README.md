
# Interactive Conversation Archive [![Build Status][travis_img]][travis_url]

## Dependencies

- Apache
- PHP ^5.4
- MySQL ^5.5

Development dependencies please check in [`package.json`](package.json).

## Setting Up

- Install development dependencies: `npm install`

- Make a copy of [`app/.htaccess.example`](app/.htaccess.example) as `app/.htaccess` in the same directory.

  Then replace `<http-host>` with the local host, e.g. `localhost`, if the website is hosted on `http://localhost/*`.

- Make a copy of [`app/config.oauth2.php.example`](app/config.oauth2.php.example) as `app/config.oauth2.php` in the same directory.

  Then replace `<http-host>` with the local host same as above, e.g. `localhost`, if the website is hosted on `http://localhost/*`.

  Currently, the login mechanism utilizes [OAuth 2](https://oauth.net/2/) at `https://accounts.mintkit.net/`. `OAUTH2_CLIENT_ID` and `OAUTH2_CLIENT_SECRET` may be updated if necessary. Please contact `sethlu@mintkit.net` for custom client id and secret.

- Make a copy of [`app/config.php.example`](app/config.php.example) as `app/config.php` in the same directory.

  Then replace `<http-host>` with the local host same as above, e.g. `localhost`, if the website is hosted on `http://localhost/*`.

  Then replace `<mysql-host>`, `<mysql-database>`, `<mysql-user>` and `<mysql-password>` with the corresponding database information.

  A database seed is available at `db/seed.sql`.

- Make a copy of [`config.json.example`](config.json.example) as `config.json` in the same directory.

  Then replace `<server-proxy>` with the url to the locally hosted website, e.g. `http://localhost/`, under which is the `app/` contents.

- Front-end build: `gulp build`.

  Or start the front-end build and watch for changes: `gulp` or `gulp proxy`.

## Notes on Architecture

- [`Component`](scripts/component/): A syntactical sugar for the JavaScript class.

[travis_img]: https://travis-ci.org/many-to-many/ica.svg?branch=master
[travis_url]: https://travis-ci.org/many-to-many/ica

# icesConnect 1.2.0 (2026-10-20)

* tokens are now created by logging in at https://data.ices.dk/token, which
  uses two-factor authentication. Tokens can no longer be requested from R
  using a username and password, and can not be refreshed from R. This
  removes the token request code that caused the errors reported in #2 and
  addressed by #3.
* add function set_token() to store a token copied from
  https://data.ices.dk/token. A username is no longer needed, and
  set_username() now does nothing except print a message (#5).
* ices_token() now explains how to get a new token, and gives the expiry date
  when the stored token has expired.
* the token file is now only readable by the user.
* bugfix: decode_token() could fail on valid tokens, as the token payload is
  base64url encoded. decode_token() now warns and returns an empty list for
  tokens that can not be decoded.
* request functions now fail gracefully: if the request can not be made (for
  example, no internet connection), a message is given and NULL is returned.
  ices_get() and ices_post() also return NULL, rather than trying to parse the
  response, when the server returns an error status (#6).
* the messages for HTTP 401 and 403 responses now point to
  https://data.ices.dk/token.
* remove dependency on askpass

## icesConnect 1.1.4 (2025-04-30)

* allow encoding to be set in ices_post()

## icesConnect 1.1.3 (2025-04-03)

* remove dependency on askPass

## icesConnect 1.1.1 (2025-04-03)

* convert to holding token in DCF file

## icesConnect 1.0.0 (2022-02-09)

* Same as previous version.

## icesConnect 0.0.0.9007 (2022-02-09)

* add JWT argument to allow no authentication requests
* add encoding to request functions
* add refresh argument to ices_token()
* export token decoding functions
* add function set_username()
* added function ices_get_jwt()
* initial commit with ices_token() and clear_token() functions

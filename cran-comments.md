## R CMD check results

Checked using
* R version 4.5.3 (2026-03-11)
* using platform: x86_64-pc-linux-gnu
* running under: Ubuntu 24.04.4 LTS
* using options '--as-cran --run-donttest'

0 errors | 0 warnings | 1 note

* checking for future file timestamps ... NOTE
  unable to verify current time

  This note is due to the check machine not being able to reach the time
  server.

* This is an update of an existing release.

## Comments

* ICES web services now issue user tokens from a web page that requires
  two-factor authentication, so tokens can no longer be requested from R
  using a username and password. This release removes that code and adds
  set_token() to store a token copied from the web page.
* Functions that use internet resources now fail gracefully, with an
  informative message, if the resource is not available.
* The token is only written to the user configuration directory given by
  tools::R_user_dir(), and only when the user calls set_token().

## Reverse dependencies

Reverse dependencies (icesDatsu, icesSAG, icesSD, icesTAF, icesVocab) were checked.

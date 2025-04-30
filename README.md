[![CRAN
Status](http://r-pkg.org/badges/version/icesConnect)](https://cran.r-project.org/package=icesConnect)
[![CRAN
Monthly](http://cranlogs.r-pkg.org/badges/icesConnect)](https://cran.r-project.org/package=icesConnect)
[![CRAN
Total](http://cranlogs.r-pkg.org/badges/grand-total/icesConnect)](https://cran.r-project.org/package=icesConnect)
[![License](https://img.shields.io/badge/license-GPL%20(%3E%3D%202)-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.en.html)

[<img align="right" alt="ICES Logo" width="17%" height="17%" src="http://ices.dk/_layouts/15/1033/images/icesimg/iceslogo.png">](http://ices.dk)

### icesConnect

icesConnect provides GET, POST and PUT functions for users wishing to
connect to ICES web services. The package provides the option to use
tokens for ICES web services that require authentication and
authorization. The token can be fetched using the users, username and
password, or by setting the token manually.

icesConnect is implemented as an [R](https://www.r-project.org) package
and available on [CRAN](https://cran.r-project.org/package=icesConnect).

### Installation

icesConnect can be installed from CRAN using the `install.packages`
command:

``` r
install.packages("icesConnect")
```

### Usage

For a summary of the package:

``` r
library(icesConnect)
?icesConnect
```

### Examples

To perform a normal get request:

``` r
ices_get_jwt("https://taf.ices.dk/vms/api/gearwidths", jwt = "")
```

    ## GETing ... https://taf.ices.dk/vms/api/gearwidths

    ## no token used

    ## OK (HTTP 200).

    ## Response [https://taf.ices.dk/vms/api/gearwidths]
    ##   Date: 2025-04-30 16:09
    ##   Status: 200
    ##   Content-Type: application/json; charset=utf-8
    ##   Size: 3.72 kB

To perform a get request using a token, it is recommended to set your
username first.

``` r
ices_get_jwt("https://taf.ices.dk/vms/api/gearwidths")
```

The first time this function is called, or if the currently stored token
has expired the user will be instructed how to set or update their
token.

### Development

icesConnect is developed openly on
[GitHub](https://github.com/ices-tools-prod/icesConnect).

Feel free to open an
[issue](https://github.com/ices-tools-prod/icesConnect/issues) there if
you encounter problems or have suggestions for future versions.

The current development version can be installed using:

``` r
# Download and install icesConnect in R
install.packages(
  "icesConnect",
  repos = c(
    icestoolsprod = "https://ices-tools-prod.r-universe.dev",
    CRAN = "https://cloud.r-project.org"
    )
)
```

devtools::use_data_raw()

devtools::use_package("jsonlite")

routes <- jsonlite::fromJSON("https://applications002.brest-metropole.fr/WIPOD01/Transport/REST/getRoutes?format=json")
devtools::use_data(routes)

devtools::use_vignette("packageapi")
devtools::build_vignettes()

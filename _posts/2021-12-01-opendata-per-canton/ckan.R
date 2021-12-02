library(ckanr)



tmp <- tempdir()
ziptemp <- file.path(tmp, "data.zip")
download.file("http://data.geo.admin.ch/ch.swisstopo.swissboundaries3d-kanton-flaeche.fill/data.zip",ziptemp)

unzip(ziptemp,exdir = tmp)

read_sf(file.path(tmp, ))


ckanr_setup(url = "https://opendata.swiss")

orgs <- organization_list(as = 'table',limit = 100)

str(orgs)
unnest(orgs, display_name)

# https://stackoverflow.com/questions/52764496/unnesting-a-dataframe-within-a-dataframe
orgs2 <- do.call(data.frame, orgs) 

names(orgs2)

kantone <- orgs2 %>%
  filter(str_detect(display_name.de, "[kK]anton"))

kantone %>%
  select(display_name.de, package_count)
ggplot(aes(display_name.de, package_count))

kantone$package_count
# kantone_show <- map(kantone$id, ~organization_show(.x,include_datasets = FALSE, as = "table"))


kantone$display_name


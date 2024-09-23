CoordFixR v1.0.0

The first release of the package 'CoordFixR'.

**Keywords**
R package, Coordinate converting, geospatial data

**To install from GitHub:**
devtools::install_github("HP-AWI/CoordfixR")

**Description:**
This package calculates or converts coordinates of (nearly) all possible notations into decimal degrees.

It does not matter whether degree, minute or second signs are included (e.g. '°'), whether spaces, underscores or slashes occur, whether designations such as North, South, West and East or minus signs (“-”) are included. 

Coordinates that contain text components such as “degrees”, “minutes” or “seconds” are also converted correctly without any problems.

The user can select and load an excel file, slect the columns containing the longitude and latitude data, click on 'Calculate' and two new columns will be created containing the decimal degrees.

Then the user can use this converted coordinates and click on 'Plot map' and can see where the points are located on a leaflet map.

If wanted, the new table can be saved as an excel file.

**Examples:**

'48° 51' 52.978" N' will be converted to '48.86471611111111'

'-22 degree 59 minutes 0 seconds' will be converted to '-22.98333333333333'

'38_deg_53_min_23.298_sec' will be converted to '38.889805'

'-77 deg 0 min 32.6016 sec' will be converted to '-77.009056'
etc'

More than 460 different spellings of coordinates were tested and could be converted into decimal degrees.

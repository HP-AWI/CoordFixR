**CoordFixR v1.0.0**

**Description:**
The **CoordFixR** package provides an R Shiny app that processes and converts coordinates from a wide variety of notations and converts them to decimal degress (DD).

It supports a wide range of formats, including those with 
- degree, minute and second symbols (°, ', ''),
- specification in word form such as 'degree', 'minute', second' or
- their abbreviations ('deg', 'min', 'sec')
- even spelling mistakes (e.g. 'deegree') or slight changes (e.g. 'degrees' instead of 'degree') are processed by the app without any problems

The **CoordFixR** app can process various separators such as 
- spaces (e.g. -9° 5'23''), 
- slashes (e.g. -9°/5'/23'') or 
- underscores (e.g. -9°_5'_23'') or
- combinations of these (e.g. 9°_5'_23''/S)

The application also accepts various decimal separators ('.' or ','). 
The comma as a decimal separator is widely used in continental Europe (Germany, France, Italy, Poland, etc.) and South America (e.g. Argentina, Chile, Brazil, etc.).

**Here are the most important functions**

**Load Excel data**: Users can select and upload an Excel file from their computer.

**Column selections**: Users can select the columns of the loaded table that contain the geographical coordinates.

**Coordinate conversion**: The app converts various coordinate formats (e.g. DMS, DDM) into decimal degress (DD) and creates new columns with the converted values.

**Visualisation**: After conversion, users can plot the converted coordinates (points) on a interactive leaflet map to visualize their position. In this way, errors (e.g. confusion of x and y) or incorrect or missing hemisphere information can be quickly recognized and corrected.

**Results storage**: The modified table, which now contains two new columns with the decimal coordinates, can be saved in the user's system as an Excel file.

The package is designed to simplify coordinate transfer for users who frequewntly deal with mixed-format geographic data.


**To install from GitHub:**
install(devtools) # if not already installed
devtools::install_github("HP-AWI/CoordfixR")


**Examples:**

'48° 51' 52.978" North'    will be converted to    '48.86471611111111'

'-22 degree 59 minutes 0 seconds'    will be converted to    '-22.98333333333333'

'W_38_deg_53_min_23.298_sec'    will be converted to    '-38.889805'

'S77 deg 0 min 32.6016 sec'    will be converted to    '-77.009056'
etc'

More than 460 different spellings of coordinates were tested and could be converted into decimal degrees.

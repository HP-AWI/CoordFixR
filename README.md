# **CoordFixR v1.0.0**

## Table of Contents
- [Description](#Description)
- [Functions](#Functions)
- [Installation](#Installation)
- [Usage](#Usage)
- [Examples](#Examples)
- [Author](#Authors)
- [Changelog](#Changelog)
- [Contact](#Contact)



## **Description**


The **CoordFixR** package provides an **R Shiny App** that processes coordinates from a variety of notations and converts them to **decimal degrees** (see **Examples**).

It supports a wide range of formats, including those with 
- **degree, minute** and **second symbols** (°, ', ''),
- specification in word form such as '**degree**', '**minutes**', **seconds**' or
- their abbreviations ('**deg**', '**min**', '**sec**').

**Typos or slight changes:** Even spelling mistakes (e.g. 'deegrees') or slight changes (e.g. 'degree' or 'Degrees' instead of 'degrees') are processed by the app without any problems.

**Different hemisphere designations::** The app can also process different types of hemisphere designations such as 
- 'North or N', 
- 'South or S', 
- 'East or E' or,
- 'West or W'.
 
The app also correctly interprets simple **minus signs ('-')** for the southern and western hemispheres.

**Separators:** The **CoordFixR** app can process various separators such as 
- spaces (e.g. -9° 5' 23.5''), 
- slashes (e.g. -9°/5'/23.5''),
- back slashes (e.g. -9°\5'\23.5''),
- underscores (e.g. -9°_5'_23.5'') or
- combinations of these (e.g. 9°_5'_23.5''\S)

**Leading zeros:** The app **CoordFixR** can also process coordinates which contain leading zeros (e.g. -009° 05'23'').

**Decimal separators:** The application accepts both **points ('.')** and **commas (',')** as decimal separators ('-9 deg 5 min 23.5 sec' or '-9 deg 5 min 23,5 sec').
The comma as a decimal separator is widely used in continental Europe (e.g. Germany, France, Italy, Poland, etc.) and South America (e.g. Argentina, Chile, Brazil, etc.).

The new (converted) decimal degrees will have a decimal point (e.g. -9.089861). 



## **Functions**

**Load Excel data:** Users can select and upload an Excel file from their hard drive or other storage device.

**Column selections:** Users can select the columns of the loaded table that contain the geographical coordinates.

**Coordinate conversion** The app converts various coordinate formats (e.g. DMS, DDM) into decimal degress (DD) and creates new columns with the converted values.

**Visualisation:** After conversion, users can plot the converted coordinates (points) on a interactive leaflet map to visualize their position. In this way, errors (e.g. confusion of x and y) or incorrect or missing hemisphere information can be quickly recognized and corrected.

**Interactivity:** Because CoordFixR is an R-shiny application, the user can change his entries over and over again and these changes are immediately displayed interactively.

**Results storage:** The modified table, which now contains two new columns with the decimal coordinates, can be saved in the user's system as an Excel file.

The package is designed to simplify coordinate transfer for users who frequewntly deal with mixed-format geographic data.



## **Installation**

install("devtools") # if not already installed

devtools::install_github("HP-AWI/CoordfixR")


## **Usage**

You run the app just type the following command:

library(CoordfixR)

CoordfixR::launch_app()


## **Examples**

'48° 51' 52.978" North'    will be converted to    '48.86471611111111'

'-22 degree 59 minutes 0 seconds'    will be converted to    '-22.98333333333333'

'W_38_deg_53_min_23.298_sec'    will be converted to    '-38.889805'

'S77 deg 0 min 32.6016 sec'    will be converted to    '-77.009056'

More than 460 different spellings of coordinates were tested and could be converted into decimal degrees.


## **Author**

**CoordFixR** was created by **[Hendrik Pehlke](https://github.com/uHP-AWI)**.


## **Changelog**

- **0.1.0:** Initial release
- **0.1.1:** Fixed a bug in the build process
- **0.2.0:** Added a new feature
- **0.2.1:** Fixed a bug in the new feature


## **Contact**

If you have any questions or comments about the package **CoordFixR**, please contact **[Hendrik Pehlke](hendrik.pehlke@awi.de)**.

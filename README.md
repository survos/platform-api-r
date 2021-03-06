# Platform API for R

R Package for access the Survos Platform API.

The package "survos" now installs as an R package. 

The package "devtools" must be installed first.

You can manually use the following to install the package:

```R
devtools::install_github("survos/platform-api-r")
```
However, the example below automatically checks for the package "devtools" and will attempt to install it if missing.

The DESCRIPTION file contains library requirements and installation will check for this automatically. They are:

    RCurl (>= 1.95-4.7)
    jsonlite (>= 0.9.17)
    curl (>= 0.9.3)

Once installed, the following R script logs in and returns data from the "jobs" endpoint. Please enter your correct username and password in the appropriate place.

```R
##################################################
# Run this test script with: Rscript getJobs.R 
# This will output errors, comments and progress
##################################################

# Check for the availability of devtools. If not installed, do so
if(!require("devtools")){
  # If devtools fails with zero exit status due to unable to install xml2 library, 
  # check libxml2-dev is installed on local machine
  install.packages("devtools")
  library("devtools")
  devtools::install_github("survos/platform-api-r")
  library("survos")
 
# Force install newest version of survos package.
} else {
  library("devtools")
  devtools::install_github("survos/platform-api-r")
  library("survos")
}

# Load additional libraries. 
# These should all have been installed with the survos package if not previously.
library("RCurl")
library("jsonlite")
library("httr")
library("plyr")
library("dplyr")

# Load external file containing username, password and API endpoint data. 
# File must be saved in active working directory. See parameters.R.dist for example format
source("parameters.R")

# Login
loginSurvos(username, password)

# Extract jobs data
jobsOut <- jobs(projectCode="nyu_demo")

# A list of all job ids for project code "nyu_demo" now in this variable
jobsOut$id

# A data frame containing all user data, from across 29 pages
users <- users()

# Returns all assignment data associated with job_id 163
assignments <- assignments(163)

# Write a nice little csv to check output 
write.csv(jobsOut$id, file = "jobsOut.csv")

# Returns all data from members endpoint for project code "nyu_demo"
members <- members(projectCode="nyu_demo")

# Test Locations. This will return a lot of data! Check username and password in parameters.R
locations <- locations(projectCode="truth_posse", memberId="5380", maxPerPage="100")

# Also look for getJobs.Rout file if running from command line with R CMD BATCH. 
# This will show result of running script and any errors.

```
See also the [Survos recipe repository](https://github.com/survos/platform-recipes) for this example script and the parameters.R.dist example file.

#!/bin/sh -e

# Move to script directory.
DATASET_DIR="$(dirname ${0})"

# pwd
# exit

# College scorecard:

mkdir college_scorecard
cd college_scorecard
curl -O https://ed-public-download.scorecard.network/downloads/College_Scorecard_Raw_Data_01162025.zip
if [ "$(sha256sum College_Scorecard_Raw_Data_01162025.zip | sed 's/ .*//')" != "4109f05f64ce8e23ee504c6c691ac7b378c64a3c2b49041d7c05fe35c52c68bc" ]; then
	exit
fi
unzip College_Scorecard_Raw_Data_01162025.zip
rm College_Scorecard_Raw_Data_01162025.zip

# NCAA data on student athletes’ academic progress and graduation rates
# requires PSU account to download
# https://www.icpsr.umich.edu/web/ICPSR/studies/30022#;
# Saved under `./athlete_academic_success`.

# _The Huffington post_ and _Chronicle of higher education_'s data on how college's finance their athletics:

cd "$DATASET_DIR"
mkdir college_athletics_financing
cd college_athletics_financing
curl -O http://hpin.s3.amazonaws.com/ncaa-financials/ncaa-financials-data.zip
unzip ncaa-financials-data.zip
rm ncaa-financials-data.zip
rm -r __MACOSX/


# _Department of education_'s data on foreign gifts to and contracts with US colleges:

cd "$DATASET_DIR"
mkdir foreign_gifts
cd foreign_gifts
wget --user-agent="" https://studentaid.gov/sites/default/files/ForeignGifts.xls
# `in2csv` is part of CSVKit (https://github.com/wireservice/csvkit), which might be in `brew`
in2csv ForeignGifts.xls > foreign_gifts.csv
rm ForeignGifts.xls

# _The census bureau_’s "Historic quarterly state and local government tax revenue":

cd "$DATASET_DIR"
mkdir historic_tax_revenue
cd historic_tax_revenue
wget https://www2.census.gov/programs-surveys/qtax/tables/historical/2009Q1-2024Q3-QTAX-Table1.xlsx
in2csv 2009Q1-2024Q3-QTAX-Table1.xlsx > 2009Q1--2024Q3_tax_revenue.csv
rm 2009Q1-2024Q3-QTAX-Table1.xlsx

# Aggregate data on federal student loan default rates _US department of education_.
# Available for FY2015Q4--FY2018Q4, with a missing FY2018Q1.

# cd "$DATASET_DIR"
# mkdir loan_defaults
# cd loan_defaults

# https://studentaid.gov/data-center/student/default

# _Department of education_'s annual school- and team-level datasets on college sports' finances.
# https://ope.ed.gov/athletics/#/datafile/list

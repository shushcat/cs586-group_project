# CS586 group project

--------

# Roadmap

- [x] Go over the datasets once, accepting or rejecting
- [x] Tidy up the reference links
- [x] Check whether they can be downloaded, collecting links and rejecting datasets that aren't available
- [x] Deliverable 1 (due 2025-02-14)
    - [x] Pick subject area.  What is this database about?  Write 1--2 paragraphs giving a general description and background information.
    - [x] List 20 questions as examples the database might help to answer.
    - [x] Describe sources and ingestion scheme.  We will need at least several hundred rows of data.  Present this as a paragraph.  Be specific.
- [x] Collect datasets
- [x] Make dictionary for each dataset & select datasets
	- [x] college_scorecard
	- [x] foreign_gifts
	- [x] college_athletics_financing
	- [x] equity_athletics_data_analysis/
- [x] Revisit college_scorecard
	- [x] Split files
	- [x] Narrow to 2010--2015
- [x] Remove unused datasets
- [x] Select relevant fields from each dataset
	- [x] Check which are promising
- [x] Prune to overlapping data range (2014?)
	- [x] Prune to narrowed ranges:
		- [x] college_scorecard: 2010--2015
		- [x] foreign_gifts: 2014-01--2020-06
		- [x] college_athletics_financing: 2010--2014
		- [x] equity_athletics_data_analysis: 2011--2016
	- [x] Check reporting protocols to make sure date ranges are reported for the same spans
		- [x] college_scorecard: 2010--2015
		- [x] foreign_gifts: 2014-01--2020-06
		- [x] college_athletics_financing: 2010--2014
		- [x] equity_athletics_data_analysis: 2011--2016
- [x] Make sure retrieval and normalization steps are described (at least roughly) for used datasets
- [x] Deliverable 2 (due 2025-03-07)
	- [x] 6--10 tables
	- [x] translation to relational schema, including
		- [x] primary keys
		- [x] unique keys
		- [x] foreign keys
	- [x] load real data into database
		- [x] at least 5 rows per table
		- [x] aim for summed row count of at least 1,000
	- [x] at least 1 view joining at least 3 tables
	- [x] ER diagram
	- [x] 20-some questions
		- [x] explain revisions
		- [x] some questions must involve multiple tables
		- [x] at least a few must join at least 4 tables
- [ ] Deliverable 3 (due 2025-03-14)
	- [ ] Write-up the project including:
		- [x] A revised ER diagram to reflect the actual implementation;
		- [x] Create statements for all tables with
			- [x] primary keys,
			- [x] unique keys, and
			- [x] foreign keys, and for all
			- [x] view statements (of which there must be at least one);
		- [ ] A listing of 5 rows and a report of total row count for each table.
		- ~~Create statements for all indexes~~ (no indexes used);
		- [ ] "A *thorough* description of how you populated the database,";
		- [x] For each of the questions, include
			- [x] the question in english,
			- [x] it's translation to SQL,
			- [ ] the answer to the query (truncated to 10 rows),
			- [ ] originals and rationals for all changed questions;
		- [ ] Do the same for the view

# Database design

All very tentative so far.

- Time
  - Marker for completeness by time?
- State
- College

Use a `VIEW` to calculate


	subsidyproportion float --Subsidy divided by athletic revenues; calculated.
	institutional_subsidy bigint --Direct institutional support plus indirect facil admin support.
	institutionalsubsidy_proportion float --Institutional subsidy divided by athletic revenues.
	external_revenue bigint --Athletic revenues minus subsidy.

from `college_athletics_financing` data.

Since `\COPY` requires that all columns be handled, and since we've already used CSVKit, we used the `csvcut` tool from CSVKit to extract columns from some datasets.
We placed extracted columns in files specific to each table.

	csvcut -c UNITID,OPEID,INSTNM,STABBR,CITY,ZIP,LATITUDE,LONGITUDE,ADM_RATE_ALL merged.csv > institutions.csv

Scripted replacement of OPEID with UNITID in `foreign_gifts`.

# Dataset retrieval, normalization & selection

- [x] college_scorecard/
	- 1996--2023
- [x] foreign_gifts/
	- 2014--2020
 	- Considering just the years 2013 to 2015
  	- Useful columns ( ID | Institution Name | City | State | Foreign Gift Amount | Gift Type | Country of Giftor | Giftor Name )
  	- Not useful columns ( OPEID | Foreign Gift Received Date )
- [x] equity_athletics_data_analysis/
	- 2002--2023
 	- Useful columns ( unitid | institution_name | city_txt	| state_cd | EFMaleCount | EFFemaleCount | EFTotalCount | sector_cd | sector_name | STAID_MEN | STAID_WOMEN | STAID_COED | STUDENTAID_TOTAL)
  	- Can be ignored ( addr1_txt | addr2_txt )
- [x] college_athletics_financing/
	- 2010--2014
 	- Useful columns ( unitid | instnm | chronname | conference | city | state | nickname | year | url | full_time_enrollment )
  	- Can be ignored ( inflationadjusted columns )

Steps taken to collect and normalize each dataset appear under each dataset's heading.
To convert datasets that were only available as XLS or XLSX files as of March 2025, we used the tool `in2csv`, which is part of [CSVKit](https://github.com/wireservice/csvkit).

Removed from `foreign_gifts` since not in `college_scorecard`:

	27708,00672500,University of Tennessee Health Science Center,Memphis,TN,2014-03-01,156000,Contract,IRELAND,Neotype Biosciences Limited
	27709,00672500,University of Tennessee Health Science Center,Memphis,TN,2014-04-01,525000,Contract,CHINA,First Hospital of Qiqihaer

## Data import and schema design

- [x] college_scorecard/
	- 1996--2023
- [x] foreign_gifts/
	- 2014--2020
 	- Considering just the years 2013 to 2015
  	- Useful columns ( ID | Institution Name | City | State | Foreign Gift Amount | Gift Type | Country of Giftor | Giftor Name )
  	- Not useful columns ( OPEID | Foreign Gift Received Date )
- [x] equity_athletics_data_analysis/
	- 2002--2023
 	- Useful columns ( unitid | institution_name | city_txt	| state_cd | EFMaleCount | EFFemaleCount | EFTotalCount | sector_cd | sector_name | STAID_MEN | STAID_WOMEN | STAID_COED | STUDENTAID_TOTAL)
  	- Can be ignored ( addr1_txt | addr2_txt )
- [x] college_athletics_financing/
	- 2010--2014
 	- Useful columns ( unitid | instnm | chronname | conference | city | state | nickname | year | url | full_time_enrollment )
  	- Can be ignored ( inflationadjusted columns )

## College scorecard

- Date range: 1996--2024

The [College scorecard](https://collegescorecard.ed.gov/data) data, while [off by an average of 10% in reported graduation rates among Pell-grant recipients](https://hechingerreport.org/theres-finally-federal-data-on-low-income-college-graduation-rates-but-its-wrong/), give a comprehensive view of universities in the US as a whole.
- **link**: https://ed-public-download.scorecard.network/downloads/College_Scorecard_Raw_Data_01162025.zip
- see retrieval commands for links to dictionaries, technical information, and errata

```sh
mkdir college_scorecard
cd college_scorecard
wget https://ed-public-download.scorecard.network/downloads/Most-Recent-Cohorts-Institution_01162025.zip
unzip Most-Recent-Cohorts-Institution_01162025.zip
rm Most-Recent-Cohorts-Institution_01162025.zip
wget https://collegescorecard.ed.gov/files/CollegeScorecardDataDictionary.xlsx
wget https://collegescorecard.ed.gov/files/InstitutionDataDocumentation.pdf
wget https://collegescorecard.ed.gov/files/EarningsDataErrata.pdf

```

### Retrieving the complete dataset

I've decided not to use the entire dataset; all we need is the institution-level data.

```sh
mkdir college_scorecard
cd college_scorecard
wget https://ed-public-download.scorecard.network/downloads/College_Scorecard_Raw_Data_01162025.zip
if [ "$(sha256sum College_Scorecard_Raw_Data_01162025.zip | sed 's/ .*//')" != "4109f05f64ce8e23ee504c6c691ac7b378c64a3c2b49041d7c05fe35c52c68bc" ]; then
	exit
fi
unzip College_Scorecard_Raw_Data_01162025.zip
rm -rf College_Scorecard_Raw_Data_01162025.zip
rm -rf __MACOSX/
```

## _The Huffington post_ and _Chronicle of higher education_'s data on how colleges finance their athletics; `college_athletics_financing`

[Dataset folder](datasets/college_athletics_financing/)

```sh
cd "$DATASET_DIR"
mkdir college_athletics_financing
cd college_athletics_financing
wget http://hpin.s3.amazonaws.com/ncaa-financials/ncaa-financials-data.zip
unzip ncaa-financials-data.zip
rm ncaa-financials-data.zip
rm -rf __MACOSX/
cd ncaa-financials-data
mv * ..
cd ..
rm -rf ncaa-financials-data
in2csv CHE_RealScoredatadictionary.xlsx > data_dictionary.csv
rm CHE_RealScoredatadictionary.xlsx
```

- [x] _The Huffington post_ and _Chronicle of higher education_ teamed up to investigate have collected [data on how college's finance their athletics](http://projects.huffingtonpost.com/ncaa/reporters-note)
	- **link**: http://hpin.s3.amazonaws.com/ncaa-financials/ncaa-financials-data.zip
	- See [their report](http://projects.huffingtonpost.com/projects/ncaa/sports-at-any-cost) and
	- [_The Washington post_'s report on the unprofitability of college athletics](http://www.washingtonpost.com/sf/sports/wp/2015/11/23/running-up-the-bills/)

## _Department of education_'s data on foreign gifts to and contracts with US colleges `foreign_gifts`

[Dataset folder](datasets/foreign_gifts)

"Foreign Gift and Contracts Report with Date Range 01/01/2014 to 06/30/2020

Data Source: Postsecondary Education Participation System 10/19/2020"

The [_Department of education_'s data on foreign gifts to and contracts with US colleges](https://studentaid.ed.gov/sa/about/data-center/school/foreign-gifts)
	- **link**: https://studentaid.gov/sites/default/files/ForeignGifts.xls
		- from: https://catalog.data.gov/dataset/foreign-gifts-and-contracts-report-e353d
	- See [their database on such gifts and contracts](https://catalog.data.gov/dataset/foreign-gifts-and-contracts-report-2011), and
	- See a report from the _Associated press_ on Saudi-Arabia's financial ties to US colleges: https://www.apnews.com/4d56411af6a8490e8030eacab4401571

```sh
cd "$DATASET_DIR"
mkdir foreign_gifts
cd foreign_gifts
wget --user-agent="" https://studentaid.gov/sites/default/files/ForeignGifts.xls
# `in2csv` is part of CSVKit (https://github.com/wireservice/csvkit), which might be in `brew`
in2csv ForeignGifts.xls > foreign_gifts.csv
rm ForeignGifts.xls
```

- Data for 2020--2024: https://fsapartners.ed.gov/knowledge-center/topics/section-117-foreign-gift-and-contract-reporting/section-117-foreign-gift-and-contract-data
- Data for october of 2024: https://fsapartners.ed.gov/knowledge-center/topics/section-117-foreign-gift-and-contract-reporting/section-117-foreign-gift-and-contract-data

## _Equity in athletics data analysis_ (EADA): Institution-level financial information for college sports `equity_athletics_data_analysis`

[Dataset folder](datasets/equity_athletics_data_analysis)

Information released per the [Equity in athletics disclosure act](https://www.ed.gov/laws-and-policy/higher-education-laws-and-policy/policy-initiatives/equity-in-athletics-disclosure-act) and available by year for all institutions at [](https://ope.ed.gov/athletics/#/datafile/list).

Removed all files in formats other than doc and XLS, then filtered to retain only doc or XLS files that aggregate data at the institutional level.
Since file and sheet names were inconsistent from year to year, we manually reviewed each of the remaining files before converting each one to a CSV file with `in2csv`.
We converted data dictionaries that were provided in doc format by using LibreOffice to export them to an intermediate format, then using Pandoc to convert those files to plain text.

- [x] The [_Department of education_'s annual school- and team-level datasets on college sports' finances](https://ope.ed.gov/athletics/)
	- **link** (2003--2023): https://ope.ed.gov/athletics/#/datafile/list
	- See _USAFacts_' reporting which uses the data to examine college football finances: https://usafacts.org/articles/coronavirus-college-football-profit-sec-acc-pac-12-big-ten-millions-fall-2020/

# Archived resources

All resources below this point are unused.

--------

- The [_Urban institute_'s education data explorer](https://educationdata.urban.org/data-explorer/) has normed
	- the _Department of education_'s
		- [Common core of data](https://nces.ed.gov/ccd/), [Civil rights data collection](https://ocrdata.ed.gov/),
		- [Integrated postsecondary education data system](https://nces.ed.gov/ipeds/), and
		- [College Scorecard](https://collegescorecard.ed.gov/), along with
	- the _Census bureau_'s
		- [Small Area Income and Poverty Estimates](https://www.census.gov/programs-surveys/saipe.html);
	- the data can be downloaded in bulk for both
		- [elementary and secondary schools](https://educationdata.urban.org/documentation/schools.html), [school districts](https://educationdata.urban.org/documentation/school-districts.html) and
		- [colleges](https://educationdata.urban.org/documentation/colleges.html)


- The [College athletics financial information database](http://cafidatabase.knightcommission.org) list sources of revenue and expenses for many colleges
	- For how the data was obtained, see: http://cafidatabase.knightcommission.org/about-the-data and https://sports.usatoday.com/2020/07/05/methodology-for-2019-ncaa-athletic-department-revenue-database/

- [_The chronicle of higher education_'s tracker of federal investigations into sexual assault on college campuses](http://projects.chronicle.com/titleix/)
	- [an API to access the data more easily](http://projects.chronicle.com/titleix/api/v1/docs/)

- The [Stanford common data set](https://irds.stanford.edu/data-findings/cds) collects data in a common format to make comparing higher education institutions easier.

- American infrastructure datasets from the _Department of homeland security_:
    - [infrastructure-related datasets](https://hifld-dhs-gii.opendata.arcgis.com)
    - [educational facilities](https://hifld-dhs-gii.opendata.arcgis.com/datasets?group_id=1b542a2d4fda47aea7e52cbc4fe9fd65)
    - [sports venues](https://hifld-dhs-gii.opendata.arcgis.com/datasets/85d3d0fc64924edbbd7c62e319d8a791_0)

- [_USA today_'s data on college football assistant-coaches' salaries](http://sports.usatoday.com/ncaa/salaries/football/assistant).
- [_USA today_'s data on college football head-coaches' salaries](http://sports.usatoday.com/ncaa/salaries/football/coach)
	- Also see http://deadspin.com/infographic-is-your-states-highest-paid-employee-a-co-489635228)

## Collections of datasets

- [Kaggle's open datasets](https://www.kaggle.com/datasets)
- [Data is plural](https://www.data-is-plural.com/)
  - [A spreadsheet linking to datasets](https://docs.google.com/spreadsheets/d/1wZhPLMCHKJvwOkP4juclhjFgqIY8fQFMemwKL2c64vk/edit?gid=0#gid=0)
  - [A git repository with datasets and their descriptions in markdown files](https://github.com/data-is-plural/newsletter-archive/)
- [The UK's _Office of national statistics_](https://www.ons.gov.uk/)
- [A dataset collection prepared by the _University of Tampa_'s library](https://utopia.ut.edu/c.php?g=887297&p=6377135)
- [Our world in data](https://ourworldindata.org/data?topics=Education+and+Knowledge); CSV data can downloaded from individual articles.

## Miscellaneous rejected datasets

- UK _Office for national statistics_:
  - https://www.ons.gov.uk/employmentandlabourmarket/peopleinwork/employmentandemployeetypes/articles/whichskillsareemployersseekinginyourarea/2024-11-05

>__Women’s college basketball rosters.__ Students in [Derek Willis](https://merrill.umd.edu/directory/derek-willis)’s “[Sports Data Analysis & Visualization](https://app.testudo.umd.edu/soc/202208/JOUR/JOUR479X)” course at the University of Maryland’s journalism school have [assembled](https://twitter.com/derekwillis/status/1600946516272861185) data on [13,000+ players on women’s college basketball teams](https://github.com/Sports-Roster-Data/womens-college-basketball), sourced from 900+ rosters for the 2022–23 NCAA season. Their main dataset lists each player’s name, team, position, jersey number, height, year, hometown, high school, and more.

### "Historic quarterly state and local government tax revenue"; _US census bureau_

"National totals of state and local government tax revenue, by type of tax"

Data shown in millions of dollars; `tqrr` and `cv` in percentages.

>Total Tax Revenue is the total of only the 4 major taxes.
"Estimated measures of sampling variability are based on estimates not adjusted for seasonal variation, trading day differences, or moving holidays."
Abbreviations and symbols:
	- Corporate: Corporation Net Income
	- tqrr: Total Quantity Response Rate
	- cv: Coefficient of Variation
"The tqrr and cv of Property, Individual Income, and Corporate Income taxes are unavailable for 2009 and 2010 due to unavailability of respondent data from 2009 and 2010."
R-Revised from previously published amount
Details may not add to the total due to independent rounding.
"Source: U.S. Census Bureau, Quarterly Summary of State and Local Government Tax Revenue."


[Dataset folder](datasets/historic_tax_revenue).

```sh
cd "$DATASET_DIR"
mkdir historic_tax_revenue
cd historic_tax_revenue
wget https://www2.census.gov/programs-surveys/qtax/tables/historical/2009Q1-2024Q3-QTAX-Table1.xlsx
in2csv 2009Q1-2024Q3-QTAX-Table1.xlsx > 2009Q1--2024Q3_tax_revenue.csv
rm 2009Q1-2024Q3-QTAX-Table1.xlsx
```

- [x] [_The census bureau_’s "Quarterly summary of state and local government tax revenue](https://www.census.gov/programs-surveys/qtax.html)
	- **link** to "Historic quarterly state and local government tax revenue": https://www2.census.gov/programs-surveys/qtax/tables/historical/2009Q1-2024Q3-QTAX-Table1.xlsx
	- [Monthly data for a subset of those taxes](https://www.census.gov/data/experimental-data-products/selected-monthly-state-sales-tax-collections.html), including sports gambling
		- (See https://www.washingtonpost.com/business/2024/06/07/sports-betting-lottery-state-budgets/)


### "NCAA division I and II graduation success rate and academic success rate, 1995-2008 cohorts" `athlete_academic_success`
- 1995--2008

[Dataset folder](datasets/athlete_academic_success).

Requires PSU account to download.
See https://www.icpsr.umich.edu/web/ICPSR/studies/30022#.

- [x] [NCAA data on student athletes’ academic progress and graduation rates](https://www.icpsr.umich.edu/icpsrweb/content/NCAA/data.html), aggregated by school and sport; **dead link** but may be archived somewhere.
	- **link**: https://www.icpsr.umich.edu/web/ICPSR/studies/30022#;
		- requires PSU account to download
	- Saved under ignored subfolder `./datasets/icpsr`


### Cohort default rates

Included in the "College scorecard" data.

- [ ] Aggregate data on federal student loan default rates _US department of education_?
	- [ ] Find for institutions; start at https://fsapartners.ed.gov/knowledge-center/topics/default-management/official-cohort-default-rates-schools

Aggregate data on federal student loan default rates _US department of education_?

Available for FY2015Q4--FY2018Q4, with a missing FY2018Q1.

```sh
cd "$DATASET_DIR"
mkdir loan_defaults
cd loan_defaults
```

https://studentaid.gov/data-center/student/default


- [ ] [The _US department of education_'s cohort default rate](https://fsapartners.ed.gov/knowledge-center/topics/default-management/official-cohort-default-rates-schools)
	- **link** for 2021: https://fsapartners.ed.gov/sites/default/files/2024-09/PEPS300ReportFY21Official.xlsx

- [x] [Aggregate data on federal student loans from the _US department of education_](https://studentaid.gov/data-center/student)
	- [student loan default rates](https://studentaid.gov/data-center/student/default)
		- **link** (2015--2018): https://studentaid.gov/data-center/student/default
	- [Amounts outstanding](https://studentaid.gov/data-center/student/portfolio)
	- [volumes of financial aid requested](https://studentaid.gov/data-center/student/application-volume)
	- [volumes of financial aid awarded](https://studentaid.gov/data-center/student/title-iv)
	- [student loan forgiveness rates](https://studentaid.gov/data-center/student/loan-forgiveness)

### Datasets from PSU

- The [Common data set archive](https://www.pdx.edu/research-planning/common-data-set-archive) is a bunch of PDFs.
- The [Data cookbook](http://pdx.datacookbook.com/)
- The [Cognos](https://www.pdx.edu/technology/cognos) data reporting tool.
- [Oregon evictions data tracking](https://www.pdx.edu/urban-studies/oregon-evictions-data-tracking)
- The [Statistical look](https://www.pdx.edu/research-planning/statistical-look) page collects links to various other resources; bizarrely, the _Enrollment modeling_ section reports using markov chains to predict enrollment; see https://www.pdx.edu/research-planning/sites/researchplanning.web.wdt.pdx.edu/files/2024-10/Enrollment%20Forecast%20-%20OIRP.pdf.
- [PSU's annual financial reports](https://www.pdx.edu/financial-services/annual-financial-reports) are available as PDFs.
- [PSU's financial report dashboard](https://www.pdx.edu/finance-administration/financial-reports-and-dashboards)
- [PSU's financial services department](https://www.pdx.edu/financial-services/)
- [This page](https://www.psuf.org/s/1904/21/page.aspx?sid=1904&gid=2&pgid=797) says that the _PSU foundation_'s financial information may be available upon request.


### Eduction, but not universities and colleges as such

>__Private schools.__ The [National Center for Education Statistics](https://nces.ed.gov/)’s [Private School Universe Survey](https://nces.ed.gov/surveys/pss/index.asp) has been gathering [data about private elementary and secondary schools](https://nces.ed.gov/surveys/pss/pssdata.asp) every two years since the 1989–90 school year. It collects information on “religious orientation; level of school; size of school; length of school year, length of school day; total enrollment (K-12); number of high school graduates, whether a school is single-sexed or coeducational and enrollment by sex; number of teachers employed; program emphasis” and more. In the latest data, covering the 2021–22 school year, “there were 29,727 private schools, enrolling 4,731,303 students and employing 482,571 full-time teachers”. __As seen in__: ProPublica’s [Private School Demographics lookup tool](https://projects.propublica.org/private-school-demographics) ([webinar scheduled for January 31](https://www.propublica.org/events/how-to-use-our-private-school-demographics-news-app)) and its [reporting on “segregation academies”](https://www.propublica.org/series/segregation-academies).

>__Educational attainment.__ Researchers at the Vienna-based [Wittgenstein Centre for Demography and Global Human Capital](http://www.wittgensteincentre.org/en/index.htm) have developed a dataset of [historical and projected education levels for 171 countries](https://www.cambridge.org/core/journals/journal-of-demographic-economics/article/a-harmonized-dataset-on-global-educational-attainment-between-1970-and-2060-an-analytical-window-into-recent-trends-and-future-prospects-in-human-capital-development/D5540E2C23E4CB89AF08ECD9379B38FD). For five-year age groups in each country, the project estimates the percentage of people in each of several categories of educational attainment — no education, primary education, secondary education, post-secondary education, and a few gradations in between. The dataset is available to browse and download via the [Wittgenstein Centre Data Explorer](http://www.oeaw.ac.at/fileadmin/subsites/Institute/VID/dataexplorer/index.html) – look for “Educational Attainment Distribution” in the “indicators” dropdown.

>__Critical infrastructure density.__ [Sadhana Nirandjan et al.](https://www.nature.com/articles/s41597-022-01218-4) have developed “a first-of-its-kind globally harmonized spatial dataset” representing the density of critical infrastructure, built with [OpenStreetMap](https://www.openstreetmap.org/) data (and [noting its limitations](https://www.nature.com/articles/s41597-022-01218-4#Sec16)). The researchers selected 39 kinds of structures (railways, landfills, pharmacies, etc.), grouped into seven categories: education, energy, health, telecommunication, transportation, waste, and water. Then they [calculated](https://github.com/snirandjan/CISI) those categories’ [concentrations at 0.10°- and 0.25°-grid resolutions](https://zenodo.org/record/4957647). __Previously__: [US infrastructure, from the Department of Homeland Security](https://hifld-geoplatform.opendata.arcgis.com/) ([DIP 2016.03.02](https://www.data-is-plural.com/archive/2016-03-02-edition/)). [h/t [Arthur Turrell](http://aeturrell.com/)]

>__Minority-serving colleges.__ The [MSI Data Project](https://www.msidata.org/) provides a [dashboard](https://www.msidata.org/data) and [dataset](https://www.msidata.org/publications) focused on colleges and universities that qualify federally as [minority-serving institutions](https://www.msidata.org/msis) either through their mission (e.g., [HBCUs](https://en.wikipedia.org/wiki/Historically_black_colleges_and_universities)) or through enrollment. The project examines institutions’ funding status, location, student body, and degree granting for 2017–2021. It draws on records from the Department of Education’s “[eligibility matrices](https://www2.ed.gov/about/offices/list/ope/idues/eligibility.html)” for each MSI designation and the agency’s [Integrated Postsecondary Education Data System](https://nces.ed.gov/ipeds/) (IPEDS). __As seen in__: “[Beyond the Rankings: The College Welcome Guide](https://hechingerreport.org/beyond-the-rankings-the-college-welcome-guide/),” by The Hechinger Report’s [Fazil Khan](https://hechingerreport.org/author/fazil-khan/), incorporating data from both IPEDS and the MSI Data Project. [h/t [Sarah Butrymowicz](https://hechingerreport.org/author/sarah-butrymowicz/)]

>__Standardized testing trends.__  Stanford University’s [Educational Opportunity Project](https://edopportunity.org/) uses restricted-access data on standardized test results [to estimate trends in academic performance and learning rates](https://edopportunity.org/methods) in grades 3–8 across US schools, school districts, counties, states, and other geographies, and with respect to race, gender, and economic status. Last week the project [released v4.1](https://edopportunity.org/whats-new/) of [their public dataset](https://edopportunity.org/about/), adding estimates for Native American students and [Bureau of Indian Education](https://www.bie.edu/) schools. __As seen in__: “[The Bureau of Indian Education Hasn’t Told the Public How Its Schools Are Performing. So We Did It Instead](https://www.propublica.org/article/the-bureau-of-indian-information-hasnt-told-the-public-how-its-schools-are-performing),” from ProPublica and the Arizona Republic, [which compiled data for the new estimates](https://www.propublica.org/article/how-we-analyzed-the-performance-of-bureau-of-indian-education-schools). [h/t [Otis Anderson](https://twitter.com/oldjacket)]

>__Education and civil rights.__ For decades, the US Department of Education’s [Civil Rights Data Collection](https://www2.ed.gov/about/offices/list/ocr/data.html) has compiled “data on key education and civil rights issues in our nation’s public schools,” including “student enrollment and educational programs and services, most of which is disaggregated by race/ethnicity, sex, limited English proficiency, and disability.” Last month, the department [released](https://www.ed.gov/news/press-releases/us-department-education-releases-2017-18-civil-rights-data-collection) the [CRDC for the 2017–18 school year](https://www2.ed.gov/about/offices/list/ocr/docs/crdc-2017-18.html). __Related__: ProPublica has used CRDC data to investigate [racial inequality](https://projects.propublica.org/miseducation/methodology) and [the use of restraints and seclusions](https://www.propublica.org/getinvolved/reporting-recipe-investigating-restraint-and-seclusion-in-us-schools). [h/t [Andrew McCartney](https://twitter.com/wouldeye125)]

>__State spending on kids.__ A [new dataset](https://datacatalog.urban.org/dataset/state-state-spending-kids-dataset) from the [Urban Institute](https://www.urban.org/) “provides a comprehensive accounting of public spending on children from 1997 through 2016.” Drawing on the US Census Bureau’s [Annual Survey of State and Local Government Finances](https://www.census.gov/programs-surveys/gov-finances.html) and other sources, the dataset summarizes “state-by-state spending on education, income security, health, and other areas.” [h/t [Erica Greenberg](https://twitter.com/EricaHGreenberg/status/1300540133427613701)]

>__High-school financial education.__ In a [recent paper](https://www.cambridge.org/core/journals/journal-of-financial-literacy-and-wellbeing/article/high-school-financial-education-courses-in-the-united-states-what-is-the-importance-of-setting-state-policies/ABD577136362C0289884C41676341271), economists [Allison Oldham Luedtke](https://sites.google.com/stolaf.edu/aoluedtke/home/) and [Carly Urban](https://www.carlyurban.com/) introduce a [dataset](https://osf.io/ksah9/) of 19,000+ high-school classes that teach financial literacy, manually collected from thousands of online course catalogs. Each row provides details about the school (e.g., name, location, enrollment) and course, including its title, description, duration, requirement status, and whether financial literacy was the main focus or smaller component. An [auxiliary dataset](https://www.cambridge.org/core/journals/journal-of-financial-literacy-and-wellbeing/article/high-school-financial-education-courses-in-the-united-states-what-is-the-importance-of-setting-state-policies/ABD577136362C0289884C41676341271#s2-3) indicates, annually for 1970–2024, which states required such coursework for high school graduation.


>__COVID-era school enrollments.__ A collaboration led by Stanford University’s [Big Local News](https://biglocalnews.org) has gathered (and standardized) recent enrollment figures from 33 state education departments. The resulting dataset, which spans ~70,000 public schools, can be [downloaded in bulk](https://purl.stanford.edu/zf406jp4427) and [explored online](https://stanford-school-enrollment-project.datasette.io/). Most states provided data down to the grade level; some also provided student counts by gender, race, ethnicity, ELL status, homelessness, economic status, and/or disability. The timeframes vary, but include at least the 2019–20 and 2020–21 school years for each state. See the [documentation](https://docs.google.com/document/d/1WRm4KZPDGL1USPaf0E1AIa7gbyeKncv04Pg_rM1N7po/edit) for details. __As seen in__: “[The Kindergarten Exodus](https://www.nytimes.com/2021/08/07/us/covid-kindergarten-enrollment.html)” (NYT), “[How going remote led to dramatic drops in public school students](https://edsource.org/2021/how-going-remote-led-to-dramatic-drops-in-public-school-students/659005)” (EdSource), and a [new academic study](https://cepa.stanford.edu/content/revealed-preferences-school-reopening-evidence-public-school-disenrollment). [h/t [Simon Willison](https://simonwillison.net/2021/Aug/8/school-enrollment/) + [Cheryl Phillips](https://twitter.com/cephillips/status/1424048330150072323)]


>__Home schooling.__ The Washington Post has gathered [data on home-school enrollment figures](https://github.com/washingtonpost/data_home_schooling) in dozens of US states and 6,700+ school districts over the past six academic years. Post reporters, with help from students at American University, “trawled state websites, contacted education officials in all 50 states and the District of Columbia and submitted multiple public records requests” to build the dataset, [released last week](https://www.washingtonpost.com/pr/2023/11/09/tracking-home-schooling-an-expansive-data-set-exclusively-washington-post/). Each entry [indicates](https://github.com/washingtonpost/data_home_schooling/blob/main/home_school_data_dictionary.csv) the state/district, school year, and the number of students registered for home schooling. __Read more__: [The Post’s analysis](https://www.washingtonpost.com/education/interactive/2023/homeschooling-growth-data-by-district/), which “reveals that a dramatic rise in home schooling at the onset of the pandemic has largely sustained itself through the 2022-23 academic year, defying predictions […].” [h/t [Meghan Hoyer](https://www.washingtonpost.com/people/meghan-hoyer/)]

>__Per-pupil spending.__ The [National Education Resource Database on Schools](https://edunomicslab.org/nerds/) (“*NERD$*”) describes itself as the “first-ever national dataset of public K-12 spending by school.” Its researchers, based at Georgetown University, aggregate and standardize the [expenditure disclosures](https://edunomicslab.org/2018/03/28/interstate-financial-reporting/) that the [Every Student Succeeds Act](https://www.ed.gov/ESSA/) requires states to publish. You can explore and download the data they’ve processed for fiscal year 2019, including spending totals, enrollment counts, and normalized figures that facilitate cross-state comparisons. For 2020–22, you can access “the raw files we obtain from states while our team conducts validation checks and norms the data.” __As seen in__: “[How much money do states spend on education?](https://usafacts.org/articles/how-much-money-do-states-spend-on-education/)” (USAFacts). [h/t [Douglas Hummel-Price](https://twitter.com/DataDHP/status/1564333211261476864)]

>__School testing.__ The Department of Education’s [EDFacts data](http://www2.ed.gov/about/inits/ed/edfacts/data-files/index.html) tracks public grade schools’ participation and proficiency rates on standardized math and reading/language exams. The files provide data on all students who took the tests, broken down by race/ethnicity, sex, disability status, homelessness, and more. A related set of data files, available on the same page, tracks high-school graduation rates.

>__SAT, ACT, and AP scores.__ The California Department of Education publishes [aggregate scores on these high-school tests](http://www.cde.ca.gov/ds/sp/ai/) for each county, district, and school going back to the late 1990s. One hitch: For more than two months, the 2016 AP data “contained 350,000 more tests than had actually been taken,” [according to inewsource.org’s Megan Wood](http://inewsource.org/2017/06/13/state-admits-posting-faulty-data/), who spotted the discrepancies (and others) and got the department to fix them. Similar datasets are available from other states, including [Texas](http://tea.texas.gov/acctres/sat_act_index.html), [Florida](http://www.fldoe.org/accountability/accountability-reporting/act-sat-ap-data/index.stml), and [Pennsylvania](http://www.education.pa.gov/K-12/Assessment%20and%20Accountability/Pages/SAT-and-ACT.aspx#tab-1). __Bonus:__ inewsource.org’s has also published easy-to-search tables of the California [AP](http://data.inewsource.org/interactives/california-ap-scores-2011-2016/), [SAT](http://data.inewsource.org/interactives/california-sat-scores-2011-2016/), and [ACT](http://data.inewsource.org/interactives/california-act-scores-2011-2016/) scores.

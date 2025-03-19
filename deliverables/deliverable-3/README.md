---
title: CS586---funding colleges through sport and foreign influence, being mainly a series of exceedingly tenuous connections
author: Navya Sri Ambati & John O Brickley
hauthor: Ambati & Brickley
instructor: Jesse Chaney
course: Database management systems
date: \today
---

This project gathers some data about US schools---"schools" here including 2-year and 4-year colleges, universities, and some trade schools---during the year 2014.
Specifically, we have collected the 2014 data for foreign gifts to US schools and college sports financing, as well as the _College scorecard_ data for that year.
Lest they be interpreted as our having some particular axe to grind, the datasets were selected by combing through the _Data is plural_ archives^[<https://www.data-is-plural.com/>] as collected by Jeremy Singer-Vine, searching for anything to do with US colleges and universities.
As a consequence of this somewhat scattershot approach to dataset collection, the questions that can be asked using our database aren't quite as interesting as we would've preferred.
Given the chance to do it all again, we probably would've focused on importing as near to the entirety of the _College scorecard_ data as we could manage since that data is already provided in a consistent format and is, as far as we know, as close to a complete picture of the higher education system in the US as is currently available.
As it stand, our questions concern the kinds of things our database allow us to ask questions about---as is always the case, but to somewhat more jarring effect here than you may be accustomed to.

Since the submission form on "Canvas" does not allow files other than doc, docX, and PDF, we have made the repository we used to coordinate our work publicly available at <https://github.com/shushcat/cs586-group_project>.
There you will find our datasets under the `datasets/` directory, our table and view creation statement in the `colleges_2014.sql` file, and our queries in `queries.sql`.
Two further notes are in order.
First, our table creation statements use relative paths, so you should be able to execute them in place as long as the rest of the repository's directory structure is preserved.
Second, owing to our early experiments with some very large datasets, the repository is very large.
Accordingly, you'll probably want to download a zip archive of the repository, available under the green "Code" button on the right-ish side of the screen.

![Table relationships](img/ERD.png)

### Table-creation statements

```sql
CREATE TABLE colleges_2014.institutions ( --from `college_scorecard`
	unitid int PRIMARY KEY, --UNITID
	opeid varchar(16), --OPEID
	name varchar(128) NOT NULL, --INSTNM
	state varchar(2), --STABBR
	city varchar(64), --CITY
	zip_code varchar(10), --ZIP
	latitude float, --Latitude
	longitude float, --Longitude
	adm_rate_all float, --Admission rate for all campuses rolled up to the 6-digit OPE ID
	undergraduate_enrollment integer, --UGDS; number of undergraduate students
	grad_enrollment integer, --GRADS; number of graduate students
	student_faculty_ratio float, --STUFACR; undergraduate student to instructional faculty ratio
	adm_rate_supp float --Admission rate, suppressed for n<30
);

SELECT * FROM colleges_2014.institutions;
```

	unitid |  opeid   |                name                 | state... 
	-------+----------+-------------------------------------+------...
	100654 | 00100200 | Alabama A & M University            | AL   ... 
	100663 | 00105200 | University of Alabama at Birmingham | AL   ... 
	100690 | 02503400 | Amridge University                  | AL   ... 
	100706 | 00105500 | University of Alabama in Huntsville | AL   ... 
	100724 | 00100500 | Alabama State University            | AL   ... 
	...
	(7766 rows)

```sql
CREATE TABLE colleges_2014.student_backgrounds ( --from `college_scorecard`
	id SERIAL PRIMARY KEY,
	unitid int REFERENCES colleges_2014.institutions(unitid), --UNITID
	pct_ba float, --Percent of people over age 25 from students' zip codes with bachelor's degrees.
	pct_grad_prof float, --Percent of people over age 25 from students' zip codes with professional degrees.
	pct_born_us float, --Percent of people from students' zip codes that were born in the US.
	ugds_men float, --Total share of enrollment of undergraduate degree-seeking students who are men.
	ugds_women float --Total share of enrollment of undergraduate degree-seeking students who are women.
);

SELECT * FROM colleges_2014.student_backgrounds LIMIT 5;
```

	 id | unitid | pct_ba | pct_grad_prof | pct_born_us | ugds_men | ugds_women...
	----+--------+--------+---------------+-------------+----------+-----------...
	  1 | 100654 |        |               |             |   0.4831 |     0.5169...
	  2 | 100663 |        |               |             |   0.4169 |     0.5831...
	  3 | 100690 |        |               |             |   0.3986 |     0.6014...
	  4 | 100706 |        |               |             |   0.5733 |     0.4267...
	  5 | 100724 |        |               |             |   0.3877 |     0.6123...
	...
	(7766 rows)


```sql
CREATE TABLE colleges_2014.student_academic_profile ( --from `college_scorecard`
	id SERIAL PRIMARY KEY,
	unitid int REFERENCES colleges_2014.institutions(unitid), --UNITID
	sat_mid_read float, --SATVRMID
	sat_mid_math float, --SATMTMID
	sat_mid_write float, --SATWRMID
	sat_avg float, --SAT_AVG
	sat_avg_all float, --Average SAT equivalent score of students admitted for all campuses rolled up to the 6-digit OPE ID
	completion_rate float, --C200_4_POOLED_SUPP
	median_completion_rate float, --MDCOMP_ALL; overall median of completion rate
	non_traditional float --UG25ABV; percentage of undergraduates aged 25 and above
);

SELECT * FROM colleges_2014.student_academic_profile LIMIT 5;
```

	id | unitid | sat_mid_read | sat_mid_math | sat_mid_write | sat_avg ...
	---+--------+--------------+--------------+---------------+---------...
	 1 | 100654 |          424 |          420 |           420 |     827 ...
	 2 | 100663 |          570 |          565 |               |    1107 ...
	 3 | 100690 |              |              |               |         ...
	 4 | 100706 |          595 |          590 |               |    1219 ...
	 5 | 100724 |          425 |          430 |               |     851 ...
	 ...
	 (7766 rows)

```sql
CREATE TABLE colleges_2014.student_financial_profile ( --from `college_scorecard`
	id SERIAL PRIMARY KEY,
	unitid int REFERENCES colleges_2014.institutions(unitid), --UNITID
	median_cost float, --MDCOST_ALL; overall median for average net price.
	grad_debt_mdn float, --The median debt for students who have completed.
	female_debt_mdn float, --The median debt for female students.
	male_debt_mdn float, --The median debt for male students.
	mdearn_pd float, --Median earnings of students working and not enrolled 10 years after entry.
	count_nwne_1yr float, --Number of graduates working and not enrolled 1 year after completing.
	count_wne_1yr float, --Number of graduates not working and not enrolled 1 year after completing.
	pct_pell_students float, --PCTPELL
	default_rate2 float, --CDR2
	default_rate3 float, --CDR3
	pell_ever float, --PELL_EVER; share of students who received a Pell Grant while in school.
	shrinking_loans float, --RPY_7YR_RT
	earning_over_highschool float, --GT_THRESHOLD_P11; students earning more than a high school graduate 11 years after entry.
	count_ed integer, --Count of students in the earnings cohort.
	age_entry float, --Average age of entry.
	female float, --Share of female students.
	married float, --Share of married students.
	dependent float, --Share of dependent students.
	veteran float, --Share of veteran students.
	first_gen float, --Share of first-generation students.
	faminc float, --Average family income.
	poverty_rate float, --Poverty rate, via Census data.
	unemp_rate float --Unemployment rate, via Census data.
);

SELECT male_debt_mdn FROM colleges_2014.student_financial_profile limit 5;

```

	id | unitid | median_cost | grad_debt_mdn | female_debt_mdn | male_debt_mdn...
	---+--------+-------------+---------------+-----------------+--------------...
	 1 | 100654 |             |         32750 |           14250 | 12000        ...
	 2 | 100663 |             |         20750 |         12537.5 | 12500        ...
	 3 | 100690 |             |         22829 |            8481 | 7125         ...
	 4 | 100706 |             |         23250 |           15000 | 13500        ...
	 5 | 100724 |             |         32500 |           13228 | 11250        ...
	 ...
	(7766 rows)

```sql
CREATE TABLE colleges_2014.institutional_financial_profile ( --from `college_scorecard`
	id SERIAL PRIMARY KEY,
	unitid int REFERENCES colleges_2014.institutions(unitid),
	in_state_cost integer, --TUITIONFEE_IN
	out_state_cost integer, --TUITIONFEE_OUT
	average_faculty_salary integer, --AVGFACSAL; average faculty salary
	instruction_spend_per_student int, --INEXPFTE
	endowbegin decimal(15, 2), --Value of school's endowment at the beginning of the fiscal year
	endowend decimal(15, 2) --Value of school's endowment at the end of the fiscal year
);

SELECT * FROM colleges_2014.institutional_financial_profile;
```

	id | unitid | in_state_cost | out_state_cost | average_faculty_salary ...
	---+--------+---------------+----------------+------------------------...
	 1 | 100654 |          9096 |          16596 |                   6892 ...
	 2 | 100663 |          7510 |          17062 |                   9957 ...
	 3 | 100690 |          6900 |           6900 |                   3430 ...
	 4 | 100706 |          9158 |          21232 |                   9302 ...
	 5 | 100724 |          8720 |          15656 |                   6609 ...
	 ...
	(7766 rows)

```sql
CREATE TABLE colleges_2014.foreign_gifts ( --from `foreign_gifts`
	id SERIAL PRIMARY KEY,
	unitid int REFERENCES colleges_2014.institutions(unitid),
	donor_country varchar(50), --"Country of Giftor"
	donor_name varchar(100), --"Giftor Name"
	gift_amount decimal(16, 2), --"Foreign Gift Amount"
	gift_date date, --"Foreign Gift Received"
	gift_type varchar(32) --"Gift Type"
);

SELECT * FROM colleges_2014.foreign_gifts;

```

	 id | unitid | donor_country |            donor_name            | gift_amount ...
	----+--------+---------------+----------------------------------+-------------...
	  1 | 104151 | QATAR         | RasGas Company Limited           |    12126.00 ...
	  2 | 104151 | JAPAN         | Asia University                  |     5763.00 ...
	  3 | 104151 | JAPAN         | Asia University                  |   121023.00 ...
	  4 | 104151 | CANADA        | University of Western Ontario    |   136381.00 ...
	  5 | 104151 | VIETNAM       | Intel Products Vietnam Co., Ltd. |   379106.00 ...
	...
	(3584 rows)

```sql
CREATE TABLE colleges_2014.athletics_financing ( --from `college_athletics_financing`
	id SERIAL PRIMARY KEY,
	unitid int REFERENCES colleges_2014.institutions(unitid), --UNITID
	athletic_revenues decimal(15, 2), --Total revenue.
	royalties bigint, --Revenue from royalties.
	tv_revenue bigint, --Revenue from radio and television broadcasts.
	ticket_sales bigint, --Revenue received for sales of admissions to athletics events.
	subsidy int, --Direct state and institution subsidies.
	direct_state_govt_support bigint, --Direct support from state government.
	ncaa_distributions bigint, --Revenue received from participation in games.
	indirect_facil_admin_support bigint, --Facilities and services provided by the institution but not charged to athletics.
	endowments bigint, --Revenue from endowments and investments.
	other_revenues bigint, --Other revenues.
	athletic_expenses decimal(15, 2), --Total expenses.
	student_fees bigint, --Student fees for college athletics; reference from `student_financial_profile`.
	net_revenue bigint, --Athletic revenues minus athletic expenses.
	year int DEFAULT 2014 CHECK (year = 2014)
);

SELECT * FROM colleges_2014.athletics_financing;
```

	 id | unitid | athletic_revenues | royalties | tv_revenue | ticket_sales ...
	----+--------+-------------------+-----------+------------+--------------...
	  1 | 100751 |      153234273.00 |  15471366 |   13662940 |     37219343 ...
	  2 | 100858 |      113716004.00 |   5275554 |    6357837 |     29833441 ...
	  3 | 104151 |       74729269.00 |  10148054 |          0 |     12885134 ...
	  4 | 104179 |       99911034.00 |   6308525 |          0 |     14931449 ...
	  5 | 106397 |       96793972.00 |  11813916 |          0 |     34284318 ...
	  ...
	(201 rows)

### View-creation statement

This view summarizes the ratios of students-to-faculty and males-to-females at each university that reported that data.
We did not revise this view for the final deliverable.

```sql
SELECT i.name, i.state, i.city, i.student_faculty_ratio,
	ifp.in_state_cost, ifp.out_state_cost,
	sb.ugds_men, sb.ugds_women,
	sap.sat_avg_all
FROM colleges_2014.institutions AS i
JOIN colleges_2014.student_backgrounds AS sb ON i.unitid = sb.unitid
JOIN colleges_2014.student_academic_profile AS sap ON sb.unitid = sap.unitid
JOIN colleges_2014.institutional_financial_profile AS ifp ON sap.unitid = ifp.unitid
WHERE sap.sat_avg_all IS NOT NULL
	AND i.student_faculty_ratio IS NOT NULL
	AND ifp.in_state_cost IS NOT NULL
	AND ifp.out_state_cost IS NOT NULL;

SELECT * FROM colleges_2014.faculty_and_sex_ratios limit 5;

```

	               name                 |...| student_faculty_ratio ...
	------------------------------------+---+-----------------------...
	Alabama A & M University            |...|                    20 ...
	University of Alabama at Birmingham |...|                    18 ...
	University of Alabama in Huntsville |...|                    16 ...
	Alabama State University            |...|                    16 ...
	The University of Alabama           |...|                    21 ...
	...
	(1358 rows)

### How we populated the database

Of the datasets we reported having collected in the first deliverable, we retained the following:

- The "College scorecard data"^[<https://collegescorecard.ed.gov/data>] (`college_scorecard`);
- _The Huffington post_ and _Chronicle of higher education_'s data on how colleges finance their athletics^[Described at <http://projects.huffingtonpost.com/ncaa/reporters-note> and directly downloadable from <http://hpin.s3.amazonaws.com/ncaa-financials/ncaa-financials-data>.zip.](`college_athletics_financing`); and
- The _Department of education_'s data on foreign gifts to and contracts with US colleges^[Described at <https://studentaid.ed.gov/sa/about/data-center/school/foreign-gifts> and downloadable from <https://studentaid.gov/sites/default/files/ForeignGifts.xls>.] (`foreign_gifts`).

We rejected each of the other databases that we initially reported having collected owing either to its redundancy or to its mismatch with the date-ranges or reporting protocols of our other databases.
For instance, the dataset available from _Equity in athletics data analysis_ (EADA)^[Downloadable for selected years from <https://ope.ed.gov/athletics/#/datafile/list>.] reports data aggregated at the end of each academic year rather than at the end of the year proper.

We found that extensive pre-processing was required for each of our datasets despite limiting our study to the year 2014, which is the only year for which our chosen datasets overlap.
Broadly speaking, we prepared each dataset by converting it to CSV (if necessary), then producing a smaller CSV containing only selected columns.
To convert datasets that were only available as XLS or XLSX files as of March 2025 to CSVs, we used the tool `in2csv`, which is part of [CSVKit](<https://github.com/wireservice/csvkit>).

Additionally, we removed two rows corresponding to colleges that do not appear in `college_scorecard` from `foreign_gifts`:

	27708,00672500,University of Tennessee Health Science Center,Memphis,TN,2014-03-01,156000,Contract,IRELAND,Neotype Biosciences Limited
	27709,00672500,University of Tennessee Health Science Center,Memphis,TN,2014-04-01,525000,Contract,CHINA,First Hospital of Qiqihaer

For a brief summary of each dataset, along with some of the steps taken to retrieve it, see below.
Note that in the following three sections, all commands were performed relative to the `datasets/` directory of our project.

#### `college_scorecard`

- Date range: 1996--2024

The [College scorecard](<https://collegescorecard.ed.gov/data>) data, while [off by an average of 10% in reported graduation rates among Pell-grant recipients](<https://hechingerreport.org/theres-finally-federal-data-on-low-income-college-graduation-rates-but-its-wrong/>), give a comprehensive view of universities in the US as a whole.
- **link**: <https://ed-public-download.scorecard.network/downloads/College_Scorecard_Raw_Data_01162025.zip>

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

#### `college_athletics_financing`

- Date range: 2010--2014.

_The Huffington post_ and _Chronicle of higher education_ teamed up to investigate have collected [data on how college's finance their athletics](<http://projects.huffingtonpost.com/ncaa/reporters-note>)
	- **link**: <http://hpin.s3.amazonaws.com/ncaa-financials/ncaa-financials-data.zip>
	- See [their report](<http://projects.huffingtonpost.com/projects/ncaa/sports-at-any-cost>) and
	- [_The Washington post_'s report on the unprofitability of college athletics](<http://www.washingtonpost.com/sf/sports/wp/2015/11/23/running-up-the-bills/>)

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

#### `foreign_gifts`

- Date range: 2014--2020.

The [_Department of education_'s data on foreign gifts to and contracts with US colleges](<https://studentaid.ed.gov/sa/about/data-center/school/foreign-gifts>)
	- **link**: <https://studentaid.gov/sites/default/files/ForeignGifts.xls>
		- from: <https://catalog.data.gov/dataset/foreign-gifts-and-contracts-report-e353d>
	- See [their database on such gifts and contracts](<https://catalog.data.gov/dataset/foreign-gifts-and-contracts-report-2011>).

```sh
mkdir foreign_gifts
cd foreign_gifts
wget --user-agent="" https://studentaid.gov/sites/default/files/ForeignGifts.xls
# `in2csv` is part of CSVKit (https://github.com/wireservice/csvkit), which might be in `brew`
in2csv ForeignGifts.xls > foreign_gifts.csv
rm ForeignGifts.xls
```

### Questions, their formulations in english and SQL, the database's answers, along with any needful rationalization

We updated almost all of our questions, and came up with many new ones, to both better fit the limitations of our dataset and to reframe questions that could not be answered without additional statistical analysis
I've said it before and I'll say it again: this is a "Man searches for keys under streetlamp" situation.

#### Q1: Which schools have the highest undergraduate student enrollment?

```sql
SELECT i.name, i.state, i.city, i.undergraduate_enrollment
FROM colleges_2014.institutions AS i
WHERE i.undergraduate_enrollment IS NOT null
ORDER BY i.undergraduate_enrollment DESC;
```

![](/img/Q01.png)

#### Q2: Which schools have the highest graduate student enrollment?

```sql
SELECT i.name, i.state, i.city, i.grad_enrollment
FROM colleges_2014.institutions AS i
WHERE i.grad_enrollment IS NOT null
ORDER BY i.grad_enrollment DESC;
```

![](/img/Q02.png)

#### Q3: Which schools report charging the highest in-state tuition?

```sql
SELECT i.name, i.state, i.city, ifp.in_state_cost
FROM colleges_2014.institutional_financial_profile AS ifp
JOIN colleges_2014.institutions AS i ON ifp.unitid = i.unitid
WHERE ifp.in_state_cost IS NOT NULL
ORDER BY ifp.in_state_cost DESC
LIMIT 10;
```

![](/img/Q03.png)

#### Q4: Which schools report lowest ratios between in-state and out-of-state tuition?

```sql
SELECT i.name, i.state, i.city, cast((cast(ifp.in_state_cost as float)/ifp.out_state_cost) AS numeric(7,6)) AS in_to_out
FROM colleges_2014.institutional_financial_profile AS ifp
JOIN colleges_2014.institutions AS i ON ifp.unitid = i.unitid
WHERE ifp.in_state_cost IS NOT NULL
ORDER BY in_to_out ASC;
```

![](/img/Q04.png)

#### Q5: How much education have people endured in the areas where the students at institutions with the lowest in-state to out-of-state tuition ratios come from?

The present dataset doesn't allow for answering this question because apparently `pct_ba` and `pct_grad_prof` weren't being reported or gathered in 2014.

```sql
SELECT i.name, i.state, i.city,
	cast((cast(ifp.in_state_cost AS float)/ifp.out_state_cost)
		AS numeric(7,6)) AS in_to_out,
	sb.pct_ba, sb.pct_grad_prof
FROM colleges_2014.institutional_financial_profile AS ifp
JOIN colleges_2014.institutions AS i ON ifp.unitid = i.unitid
JOIN colleges_2014.student_backgrounds AS sb ON ifp.unitid = sb.unitid
WHERE ifp.in_state_cost IS NOT NULL
ORDER BY in_to_out ASC;
```


#### Q6: What are SAT scores like in the reported schools with the lowest ratios of in-state to out-of-state tuition?

```sql
SELECT i.name, i.state, i.city,
	cast((cast(ifp.in_state_cost AS float)/ifp.out_state_cost)
		AS numeric(7,6)) AS in_to_out,
	sap.sat_avg_all
FROM colleges_2014.institutional_financial_profile AS ifp
JOIN colleges_2014.institutions AS i ON ifp.unitid = i.unitid
JOIN colleges_2014.student_academic_profile AS sap ON ifp.unitid = sap.unitid
WHERE ifp.in_state_cost IS NOT NULL AND sap.sat_avg_all IS NOT NULL
ORDER BY in_to_out ASC;
```

![](/img/Q06.png)

#### Q7: Which schools accepted the most money from foreign donors in 2014?

```sql
SELECT i.name, i.state, sum(fg.gift_amount) AS gift_sum
FROM colleges_2014.foreign_gifts AS fg
JOIN colleges_2014.institutions AS i ON fg.unitid = i.unitid
GROUP BY i.unitid
ORDER BY gift_sum DESC
LIMIT 10;
```

![](/img/Q07.png)

#### Q8: What is instructional spending like at those schools?

```sql
SELECT i.name, i.state, sum(fg.gift_amount) AS gift_sum, ifp.instruction_spend_per_student
FROM colleges_2014.foreign_gifts AS fg
JOIN colleges_2014.institutions AS i ON fg.unitid = i.unitid
JOIN colleges_2014.institutional_financial_profile AS ifp ON fg.unitid = ifp.unitid
GROUP BY i.unitid, ifp.instruction_spend_per_student
ORDER BY gift_sum DESC
LIMIT 10;
```

![](/img/Q08.png)

#### Q9: How profitable are sports at schools that reported foreign gifts?

```sql
SELECT i.name, i.state, sum(fg.gift_amount) AS gift_sum,
	cast(ifp.instruction_spend_per_student AS numeric(9,2)), af.net_revenue AS net_revenue
FROM colleges_2014.foreign_gifts AS fg
JOIN colleges_2014.institutions AS i ON fg.unitid = i.unitid
JOIN colleges_2014.institutional_financial_profile AS ifp ON fg.unitid = ifp.unitid
JOIN colleges_2014.athletics_financing AS af ON fg.unitid = af.unitid
GROUP BY i.unitid, ifp.instruction_spend_per_student,
	af.athletic_revenues, af.athletic_expenses, af.net_revenue
ORDER BY gift_sum DESC;
```

![](/img/Q09.png)

#### Q10: How profitable are sports at schools that gave a report as to whether or not their sports-related doings are profitable?

```sql
SELECT i.name, i.state, cast(ifp.instruction_spend_per_student AS numeric(9,2)),
	af.net_revenue AS net_revenue
FROM colleges_2014.institutions AS i
JOIN colleges_2014.institutional_financial_profile AS ifp ON i.unitid = ifp.unitid
JOIN colleges_2014.athletics_financing AS af ON i.unitid = af.unitid
GROUP BY i.unitid, ifp.instruction_spend_per_student,
	af.athletic_revenues, af.athletic_expenses, af.net_revenue
ORDER BY ifp.instruction_spend_per_student DESC;
```

![](/img/Q10.png)

#### Q11: How is the profitibility of sports distributed among schools?

```sql
SELECT cast(avg(af.net_revenue) AS numeric(10,2)) AS mean,
	cast(percentile_cont(0.5) WITHIN GROUP
		(ORDER BY af.net_revenue) AS numeric(10,2)) AS median,
	cast(MODE() WITHIN GROUP (ORDER BY af.net_revenue) AS numeric(10,2)) AS mode,
	cast(stddev(af.net_revenue) AS numeric(10,2)) AS standard_deviation
FROM colleges_2014.athletics_financing as af;
```

![](/img/Q11.png)

#### Q12: Which country donated most frequently to each school that reported foreign gifts?

```sql
SELECT i.name, fg.unitid,
	MODE() WITHIN GROUP (ORDER BY fg.donor_country) AS top_donor
FROM colleges_2014.foreign_gifts AS fg
join colleges_2014.institutions as i on fg.unitid = i.unitid
GROUP BY i.name, fg.unitid;
```

![](/img/Q12.png)

#### Q13: And again, but with a CTE:

```sql
WITH top_donor AS (
	SELECT fg.unitid,
		MODE() WITHIN GROUP (ORDER BY fg.donor_country) AS top_donor
	FROM colleges_2014.foreign_gifts AS fg
	GROUP BY fg.unitid
)
SELECT i.name, td.top_donor
FROM colleges_2014.foreign_gifts AS fg
JOIN colleges_2014.institutions AS i ON fg.unitid = i.unitid
JOIN top_donor AS td ON fg.unitid = td.unitid
GROUP BY i.name, td.top_donor;
```

![](/img/Q13.png)

#### Q14: And again in still more convoluted fashion, but this time listing the top three donor countries for each university.

```sql
WITH donor_ranks AS (
	SELECT fg.unitid, fg.donor_country, count(*) AS n_gifts,
		ROW_NUMBER() OVER (PARTITION BY fg.unitid ORDER BY count(*) DESC,
			fg.donor_country) AS rank,
		sum(fg.gift_amount) AS total
	FROM colleges_2014.foreign_gifts as fg
	GROUP BY unitid, donor_country
)
SELECT i.name, dr.donor_country AS top_donor, dr.total, rank
FROM donor_ranks AS dr
JOIN colleges_2014.institutions AS i on dr.unitid = i.unitid
WHERE rank = 1 OR rank = 2 OR rank = 3
ORDER BY i.name ASC, dr.total DESC;
```

![](/img/Q14.png)

#### Q15: Which countries donated the most money, and how much did each one donate?

```sql
SELECT fg.donor_country, sum(gift_amount) AS donated
FROM colleges_2014.foreign_gifts AS fg
GROUP BY fg.donor_country
ORDER BY donated DESC
LIMIT 10;
```

![](/img/Q15.png)

#### Q16: Which country donated most often?

```sql
SELECT MODE() WITHIN GROUP (ORDER BY fg.donor_country) AS donor
FROM colleges_2014.foreign_gifts AS fg;
```

![](/img/Q16.png)

#### Q17: Which of the schools in Oregon that report average SAT scores, in-state tuition, and out-of-state tuition have the lowest student-to-faculty ratios?

```sql
SELECT i.name, i.state, i.city, i.student_faculty_ratio
FROM colleges_2014.institutions AS i
JOIN colleges_2014.student_backgrounds AS sb ON i.unitid = sb.unitid
JOIN colleges_2014.student_academic_profile AS sap ON sb.unitid = sap.unitid
JOIN colleges_2014.institutional_financial_profile AS ifp ON sap.unitid = ifp.unitid
WHERE sap.sat_avg_all IS NOT NULL
	AND i.student_faculty_ratio IS NOT NULL
	AND ifp.in_state_cost IS NOT NULL
	AND ifp.out_state_cost IS NOT NULL
	AND i.state = 'OR'
ORDER BY i.student_faculty_ratio;
```

![](/img/Q17.png)

#### Q18: How much does each of those schools spend directly on instructing students?

```sql
SELECT i.name, i.state, i.city, i.student_faculty_ratio, ifp.instruction_spend_per_student
FROM colleges_2014.institutions AS i
JOIN colleges_2014.student_backgrounds AS sb ON i.unitid = sb.unitid
JOIN colleges_2014.student_academic_profile AS sap ON sb.unitid = sap.unitid
JOIN colleges_2014.institutional_financial_profile AS ifp ON sap.unitid = ifp.unitid
WHERE sap.sat_avg_all IS NOT NULL
	AND i.student_faculty_ratio IS NOT NULL
	AND ifp.in_state_cost IS NOT NULL
	AND ifp.out_state_cost IS NOT NULL
	AND i.state = 'OR'
ORDER BY i.student_faculty_ratio;
```

![](/img/Q18.png)

#### Q19: Of those, which are included in the athletics financing database and what are their net revenues from athletics, broadly construed?

```sql
SELECT i.name, i.state, i.city, i.student_faculty_ratio,
	af.athletic_revenues, af.athletic_expenses,
	(af.athletic_revenues - af.athletic_expenses) AS net
FROM colleges_2014.institutions AS i
JOIN colleges_2014.student_backgrounds AS sb ON i.unitid = sb.unitid
JOIN colleges_2014.student_academic_profile AS sap ON sb.unitid = sap.unitid
JOIN colleges_2014.institutional_financial_profile AS ifp ON sap.unitid = ifp.unitid
JOIN colleges_2014.athletics_financing AS af ON i.unitid = af.unitid
WHERE sap.sat_avg_all IS NOT NULL
	AND i.student_faculty_ratio IS NOT NULL
	AND ifp.in_state_cost IS NOT NULL
	AND ifp.out_state_cost IS NOT NULL
	AND i.state = 'OR'
ORDER BY i.student_faculty_ratio;
```

![](/img/Q19.png)

#### Q20: Which schools' graduates have the highest median debt?

```sql
SELECT i.name, i.state, i.city, sfp.grad_debt_mdn
FROM colleges_2014.student_financial_profile AS sfp
JOIN colleges_2014.institutions AS i on sfp.unitid = i.unitid
WHERE sfp.grad_debt_mdn IS NOT NULL
ORDER BY sfp.grad_debt_mdn DESC
LIMIT 10;
```

![](/img/Q20.png)

#### Q21: Do the schools with the largest sports subsidies have fewer students from low income or first-to-attend-college backgrounds?

(There doesn't seem to be any correlation.)

```sql
SELECT i.name, i.state, sfp.pell_ever, sfp.first_gen, af.subsidy
FROM colleges_2014.student_financial_profile AS sfp
JOIN colleges_2014.institutions AS i ON sfp.unitid = i.unitid
JOIN colleges_2014.athletics_financing AS af ON af.unitid = i.unitid;
```

![](/img/Q21.png)

#### Q22: Do schools that spend more on student instruction have higher faculty salaries?

(They have more money, so yes.)

```sql
SELECT i.name, i.state, ifp.average_faculty_salary, ifp.instruction_spend_per_student
FROM colleges_2014.institutional_financial_profile AS ifp
JOIN colleges_2014.institutions AS i ON ifp.unitid = i.unitid;
```

![](/img/Q22.png)

#### Q23: Which of the colleges that responded pay the most per student sports in the undergrad program?

```sql
SELECT i.name, (af.athletic_expenses - af.student_fees) / i.undergraduate_enrollment AS sports_pay_per_student
FROM colleges_2014.institutions i
JOIN colleges_2014.athletics_financing af ON i.unitid = af.unitid
WHERE af.athletic_expenses IS NOT NULL
    AND i.undergraduate_enrollment > 0
ORDER by sports_pay_per_student DESC
LIMIT 10;
```

![](/img/Q23.png)

#### Q24: Which of the colleges that responded pay the most per student sports in the grad program?

```sql
SELECT i.name,(af.athletic_expenses - af.student_fees) / i.grad_enrollment AS sports_pay_per_student
FROM colleges_2014.institutions i
JOIN colleges_2014.athletics_financing af ON i.unitid = af.unitid
WHERE af.athletic_expenses IS NOT NULL
    AND i.grad_enrollment > 0
ORDER by sports_pay_per_student DESC
LIMIT 10;
```

![](/img/Q24.png)

#### Q25: How many students are involved in both academics and sports?

```sql
SELECT i.name as college_name, SUM(i.undergraduate_enrollment) AS no_of_students_in_sports
FROM colleges_2014.institutions i
WHERE i.unitid IN (SELECT DISTINCT unitid FROM colleges_2014.athletics_financing)
GROUP BY i.name
ORDER BY no_of_students_in_sports DESC;
```

![](/img/Q25.png)

#### Q26: Which schools and colleges that also report students' sexes report the lowest student-faculty ratios?

This question relies on the `faculty_and_sex_ratios` view.

```sql
SELECT fsr.name, fsr.state, fsr.city, fsr.student_faculty_ratio
FROM faculty_and_sex_ratios AS fsr
WHERE fsr.student_faculty_ratio IS NOT NULL
ORDER BY fsr.student_faculty_ratio ASC
LIMIT 15;
```

![](/img/Q26.png)

#### Unused questions from our original list

Some of these questions affected the queries we formulated.
See the brief note below each question.

- How many students are in high school, under grad, grad etc programs?
	- Changed to consider undergraduate and graduate programs separately.  See Q1 and Q2.
- Which colleges have the highest fees?
	- Changed to consider in-state and out-of-state tuition separately.  See Q3 and Q4.  Additionally, used as part of the answer to questions Q4 and Q6.
- What is the connection between college sports and academics?
	- This question was too vague to answer with a database.
- Does spending on college sports affect student's academic performances?
	- We didn't formulate this question, but could have asked something similar---something like, "Are SAT scores correlated with spending on sports?"
- How is cost of attendance affected by funding for college sports?
	- We didn't formulate this question either, but, again, we could've.
- How does increased funding for college sports affect universities, colleges, and the areas surrounding them?
	- This question was too vague, and would've required importing tax revenue data; without a more focused question, it wasn't worth pursuing.
- Does sports gambling correlate with subsidies to college sports?
	- As with the previous question, answering this would've required including tax revenue data.
- Is there a connection between subsidies to college sports teams and Title-IX investigations?
	- Answering this question would've required including the EADA data, which we collected, but did not import since our database has already outgrown the scope of this assignment.
- How many students are involved in both academics and sports?
	- One would hope that everyone who is a student is involved in academics.
- What are the top 15 schools and colleges that have good ratings?
	- Answering this question as such would've required collecting additional data, but we asked a similar question in our queries about student--faculty ratios. See Q17, Q18, Q19, and Q26.
- Which schools and colleges support financing for academically oriented students?
  - Finding out the extent to which different schools provide financial support to students would've required collecting additional data.
- Which schools and colleges support financing for students involved in sports?
  - As with the previous question, answering this question would've required collection of additional data.
- How many students are involved in college sports?
  - There has been talk of Q25 in this connexion, but I have my doubts.
- What kinds of funding are offered to students at schools and colleges?
- How much funding is offered to students when comparing between states?
- Which schools and colleges are highly supportive of sports?
  - Adapted for Q21.
- What is the variation in funding for education versus sports?
  - I suppose we could've asked this by selecting instructional spending per student and institutional spending on sports, then getting the variance of both.
- Which schools and colleges participate and encourage students in more than 1 sport?
  - Answering this question would've required importing the EADA data.
- What is the average of students who are good at both sports and academics?
  - Maybe we could've answered a question somewhat, if you really squinted, like this by gathering data on the number of sports and academic scholarships distributed to distinct students per institution.
- How many consecutive wins have various college sports team had?
  - It may be that the EADA data includes game result data, in which case its inclusion would've helped to answer this question.
- How many students, by school, have received funding based on athletics participation?
  - This is another EADA question.
- What is the average amount or scholarship money offered per year in each category?
  - Additional information on scholarships might've enabled answering this question.
- Is there a difference in the average funding for male and female college sports teams?
  - The EADA data includes information on this subject.
- How does any difference in the previous question compare to differences in funding based on academic merit?
  - To answer this question, we would've had to've collected more information on scholarships.

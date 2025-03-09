CREATE DATABASE colleges_2014;
\c colleges_2014

--from `college_scorecard`
CREATE TABLE institutions (
	unitid int PRIMARY KEY, --UNITID
	opeid varchar(16) UNIQUE, --OPEID
	name varchar(128) NOT NULL, --INSTNM
	state varchar(2), --STABBR
	city varchar(64), --CITY
	zip_code varchar(10), --ZIP
	latitude float, --Latitude
	longitude float, --Longitude
	adm_rate_all float, --Admission rate for all campuses rolled up to the 6-digit OPE ID
	undergraduate_enrollment, integer --UG; Enrollment of all undergraduate students
	grad_enrollment integer --GRADS; number of graduate students
	student_faculty_ratio float --STUFACR; undergraduate student to instructional faculty ratio
);

--from `college_scorecard`
CREATE TABLE student_academic_profile (
	id SERIAL PRIMARY KEY,
	unitid int REFERENCES institutions(unitid), --UNITID
	sat_mid_read float, --SATVRMID
	sat_mid_math float, --SATMTMID
	sat_mid_write float, --SATWRMID
	sat_avg float, --SAT_AVG
	sat_avg_all float, --Average SAT equivalent score of students admitted for all campuses rolled up to the 6-digit OPE ID
	completion_rate float, --C200_4_POOLED_SUPP
	non_traditional float, --UG25ABV; percentage of undergraduates aged 25 and above
	median_completion_rate float, --MDCOMP_ALL; overall median of completion rate
);

--from `college_scorecard`
CREATE TABLE student_background (
	pct_ba float --Percent of the population from students' zip codes with a bachelor's degree over the age 25, via Census data
	pct_grad_prof float --Percent of the population from students' zip codes over 25 with a professional degree, via Census data
	pct_born_us float --Percent of the population from students' zip codes that was born in the US, via Census data
);

--from `college_scorecard`
CREATE TABLE student_financial_profile (
	id SERIAL PRIMARY KEY,
	unitid int REFERENCES institutions(unitid), --UNITID
	median_cost float, --MDCOST_ALL; overall median for average net price 
	grad_debt_mdn float, --The median debt for students who have completed
	female_debt_mdn float, --The median debt for female students
	male_debt_mdn float, --The median debt for male students

	pct_pell_students float, --PCTPELL
	default_rate2 float, --CDR2
	default_rate3 float, --CDR3
	pell_ever float --PELL_EVER; Share of students who received a Pell Grant while in school
	shrinking_loans float --RPY_7YR_RT
	earning_over_highschool float, --GT_THRESHOLD_P11; students earning more than a high school graduate 11 years after entry

	count_ed integer --Count of students in the earnings cohort
	age_entry integer --Average age of entry
	female float --Share of female students
	married float --Share of married students
	dependent float --Share of dependent students
	veteran float --Share of veteran students
	first_gen float --Share of first-generation students
	faminc integer --Average family income
	md_faminc integer --Median family income
	faminc_ind integer --Average family income for independent students 
	median_hh_inc integer --Median household income
	poverty_rate float --Poverty rate, via Census data
	unemp_rate float --Unemployment rate, via Census data



);

--from `college_scorecard`
CREATE TABLE institutional_financial_profile (
	id SERIAL PRIMARY KEY,
	unitid int REFERENCES institutions(unitid),
	enrollment int, --UG
	in_state_cost integer, --TUITIONFEE_IN
	out_state_cost integer, --TUITIONFEE_OUT
	year int DEFAULT 2014 CHECK (year = 2014),
	average_faculty_salary integer, --AVGFACSAL; average faculty salary
	instruction_spend_per_student int, --INTEXPFTE
);

--from `foreign_gifts`
CREATE TABLE foreign_gifts (
	id SERIAL PRIMARY KEY,
	opeid varchar(16) REFERENCES institutions(opeid), --OPEID
	donor_country varchar(50), --"Country of Giftor"
	donor_name varchar(100), --"Giftor Name"
	gift_amount decimal(16, 2), --"Foreign Gift Amount"
	gift_date date, --"Foreign Gift Received"
	gift_type varchar(32) --"Gift Type"
);

--from `college_athletics_financing`
CREATE TABLE athletics_financing (
	id SERIAL PRIMARY KEY,
	unitid int REFERENCES institutions(unitid), --unitid
	total_revenue decimal(15, 2),
	total_expenses decimal(15, 2),
	year int DEFAULT 2014 CHECK (year = 2014)
);

COPY scorecards (
COPY college_scorecards (institution_id, enrollment, avg_tuition, grad_rate, median_debt, year)
FROM './datasets/college_scorecard/2014data00.csv' DELIMITER ',' CSV HEADER;

--college_scorecard/

debt_mdn_supp float --Median debt, suppressed for n=30
grad_debt_mdn_supp float --Median debt of completers, suppressed for n=30
grad_debt_mdn10yr_supp float --Median debt of completers expressed in 10-year monthly payments, suppressed for n=30

ugds_men float --Total share of enrollment of undergraduate degree-seeking students who are men
ugds_women float --Total share of enrollment of undergraduate degree-seeking students who are women

endowbegin long --Value of school's endowment at the beginning of the fiscal year
endowend long --Value of school's endowment at the end of the fiscal year

mdearn_pd float --Median earnings of students working and not enrolled 10 years after entry
mdearn_all float --Overall median earnings of students working and not enrolled 10 years after entry

count_nwne_1yr integer --Number of graduates working and not enrolled 1 year after completing
count_wne_1yr integer --Number of graduates not working and not enrolled 1 year after completing

adm_rate_supp float --Admission rate, suppressed for n<30

--foreign_gifts
-- Useful columns ( ID | Institution Name | City | State | Foreign Gift Amount | Gift Type | Country of Giftor | Giftor Name )
-- OPEID: foreign key to university
-- `WHERE` clause for inclusion: foreign gift received data
id int
OPEID varchar(6)
institution_name varchar(255)
city varchar(64)
state varchar(64)
date_received varchar(10)
amount float
gift_type varchar(64)
giftor_country varchar(64)
giftor_name varchar(64)

--college_athletics_financing
-- Useful columns ( unitid | instnm | chronname | conference | city | state | nickname | year | url | full_time_enrollment )
-- Can be ignored ( inflationadjusted columns ) 
unitid int --"Dept. of Education, The Integrated Postsecondary Education Data System (Ipeds) ID"
instnm varchar(255) --Dept. of Education, The Integrated Postsecondary Education Data System (Ipeds)"
chronname varchar(255) --Chronicle Institution Name
conference varchar(255) --2013-2014 Conference based on Basketball Team Affiliation,ESPN/Institution Website
city varchar(255)
state  varchar(255)
nickname varchar(255) --Nickname of the instituition
year int --Year of the data
url varchar(255) --Raw report filename, appended to http://chronicle.s3.amazonaws.com/DI/ncaa_subsidies/
full_time_enrollment int --2013--2014 enrollment for all full-time students
inflation_adjusted_ticket_sales bigint --Ticket sales revenue.
inflation_adjusted_student_fees bigint --Student fees assessed to support college athletics.
inflation_adjusted_direct_state_govt_support bigint
inflation_adjusted_direct_institutional_support bigint --Value of institutional resources and unristricted funds
inflation_adjusted_indirect_facil_admin_support bigint --Value of indirect support
inflation_adjusted_ncaa_distributions bigint --Revenue received from participation in games.
inflation_adjusted_royalties bigint --Revenue from royalties.
inflation_adjusted_tv_revenue bigint --Revenue from radio and television broadcasts.
inflation_adjusted_endowments bigint --Revenue from endowments and investments.
other_revenues bigint --Other revenues.
inflation_adjusted_athletic_revenues bigint --Total revenue.
inflation_adjusted_athletic_expenses bigint --Total expenses.
inflation_adjusted_subsidy bigint --Total state government and institutional subsidy.
inflation_adjusted_subsidyproportion float --Subsidy divided by athletic revenues.
inflation_adjusted_institutional_subsidy bigint --Direct institutional support plus indirect facil admin support.
inflation_adjusted_institutionalsubsidy_proportion float --Institutional subsidy divided by athletic revenues.
inflation_adjusted_net_revenue bigint --Athletic revenues minus athletic expenses.
inflation_adjusted_net_revenue_before_subsidy bigint --Net revenue minus subsidy.
inflation_adjusted_external_revenue bigint --Athletic revenues minus subsidy.
ticket_sales bigint --Revenue received for sales of admissions to athletics events.
student_fees bigint --Student fees for college athletics.
direct_state_govt_support bigint --Direct support from state government.
direct_institutional_support bigint --Institutional resources plus unrestricted university funds.
ndirect_facil_admin_support bigint --Facilities and services provided by the institution but not charged to athletics.
ncaa_distributions bigint --Revenue received from participation in games.
royalties bigint --Revenue from royalties.
tv_revenue bigint --Revenue from radio and television broadcasts.
endowments bigint --Revenue from endowments and investments.
athletic_revenues bigint --Total revenue.
other_revenues bigint --Other revenues.
athletic_expenses bigint --Total expenses.
subsidy bigint --Total state government and institutional subsidy.
subsidyproportion float --Subsidy divided by athletic revenues.
institutional_subsidy bigint --Direct institutional support plus indirect facil admin support.
institutionalsubsidy_proportion float --Institutional subsidy divided by athletic revenues.
net_revenue bigint --Athletic revenues minus athletic expenses.
net_revenue_before_subsidy bigint --Net revenue minus subsidy.
external_revenue bigint --Athletic revenues minus subsidy.
instate_tuition bigint --2014 in-state tuition.

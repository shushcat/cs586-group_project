CREATE DATABASE colleges_2014;

--\c colleges_2014

--CREATE TABLES

DROP TABLE IF EXISTS public.institutions CASCADE;
DROP TABLE IF EXISTS public.student_backgrounds;
DROP TABLE IF EXISTS public.student_academic_profile;
DROP TABLE IF EXISTS public.student_financial_profile;
DROP TABLE IF EXISTS public.institutional_financial_profile;
DROP TABLE IF EXISTS public.foreign_gifts;
DROP TABLE IF EXISTS public.athletics_financing;

CREATE TABLE institutions ( --from `college_scorecard`
	unitid int PRIMARY KEY, --UNITID
	opeid varchar(16), --OPEID
	name varchar(128) NOT NULL, --INSTNM
	state varchar(2), --STABBR
	city varchar(64), --CITY
	zip_code varchar(10), --ZIP
	latitude float, --Latitude
	longitude float, --Longitude
	adm_rate_all float, --Admission rate for all campuses rolled up to the 6-digit OPE ID
	undergraduate_enrollment integer, --UG; Enrollment of all undergraduate students
	grad_enrollment integer, --GRADS; number of graduate students
	student_faculty_ratio float, --STUFACR; undergraduate student to instructional faculty ratio
	adm_rate_supp float --Admission rate, suppressed for n<30
);

CREATE TABLE student_backgrounds ( --from `college_scorecard`
	id SERIAL PRIMARY KEY,
	unitid int REFERENCES institutions(unitid), --UNITID
	pct_ba float, --Percent of people over age 25 from students' zip codes with bachelor's degrees.
	pct_grad_prof float, --Percent of people over age 25 from students' zip codes with professional degrees.
	pct_born_us float, --Percent of people from students' zip codes that were born in the US.
	ugds_men float, --Total share of enrollment of undergraduate degree-seeking students who are men.
	ugds_women float --Total share of enrollment of undergraduate degree-seeking students who are women.
);

CREATE TABLE student_academic_profile ( --from `college_scorecard`
	id SERIAL PRIMARY KEY,
	unitid int REFERENCES institutions(unitid), --UNITID
	sat_mid_read float, --SATVRMID
	sat_mid_math float, --SATMTMID
	sat_mid_write float, --SATWRMID
	sat_avg float, --SAT_AVG
	sat_avg_all float, --Average SAT equivalent score of students admitted for all campuses rolled up to the 6-digit OPE ID
	completion_rate float, --C200_4_POOLED_SUPP
	median_completion_rate float, --MDCOMP_ALL; overall median of completion rate
	non_traditional float --UG25ABV; percentage of undergraduates aged 25 and above
);

CREATE TABLE student_financial_profile ( --from `college_scorecard`
	id SERIAL PRIMARY KEY,
	unitid int REFERENCES institutions(unitid), --UNITID
	median_cost float, --MDCOST_ALL; overall median for average net price.
	grad_debt_mdn float, --The median debt for students who have completed.
	female_debt_mdn float, --The median debt for female students.
	male_debt_mdn float, --The median debt for male students.
	mdearn_pd float, --Median earnings of students working and not enrolled 10 years after entry.
	count_nwne_1yr integer, --Number of graduates working and not enrolled 1 year after completing.
	count_wne_1yr integer, --Number of graduates not working and not enrolled 1 year after completing.
	pct_pell_students float, --PCTPELL
	default_rate2 float, --CDR2
	default_rate3 float, --CDR3
	pell_ever float, --PELL_EVER; share of students who received a Pell Grant while in school.
	shrinking_loans float, --RPY_7YR_RT
	earning_over_highschool float, --GT_THRESHOLD_P11; students earning more than a high school graduate 11 years after entry.
	count_ed integer, --Count of students in the earnings cohort.
	age_entry integer, --Average age of entry.
	female float, --Share of female students.
	married float, --Share of married students.
	dependent float, --Share of dependent students.
	veteran float, --Share of veteran students.
	first_gen float, --Share of first-generation students.
	faminc integer, --Average family income.
	md_faminc integer, --Median family income.
	faminc_ind integer, --Average family income for independent students.
	median_hh_inc integer, --Median household income.
	poverty_rate float, --Poverty rate, via Census data.
	unemp_rate float --Unemployment rate, via Census data.
);

CREATE TABLE institutional_financial_profile ( --from `college_scorecard`
	id SERIAL PRIMARY KEY,
	unitid int REFERENCES institutions(unitid),
	enrollment int, --UG
	in_state_cost integer, --TUITIONFEE_IN
	out_state_cost integer, --TUITIONFEE_OUT
	year int DEFAULT 2014 CHECK (year = 2014),
	average_faculty_salary integer, --AVGFACSAL; average faculty salary
	instruction_spend_per_student int, --INTEXPFTE
	endowbegin decimal(15, 2), --Value of school's endowment at the beginning of the fiscal year
	endowend decimal(15, 2) --Value of school's endowment at the end of the fiscal year
);

CREATE TABLE foreign_gifts ( --from `foreign_gifts`
	id SERIAL PRIMARY KEY,
	opeid varchar(16) REFERENCES institutions(opeid), --OPEID
	donor_country varchar(50), --"Country of Giftor"
	donor_name varchar(100), --"Giftor Name"
	gift_amount decimal(16, 2), --"Foreign Gift Amount"
	gift_date date, --"Foreign Gift Received"
	gift_type varchar(32) --"Gift Type"
);

CREATE TABLE athletics_financing ( --from `college_athletics_financing`
	id SERIAL PRIMARY KEY,
	unitid int REFERENCES institutions(unitid), --UNITID
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

--IMPORT DATA

\COPY institutions (unitid, opeid, name, state, city, zip_code, latitude, longitude, adm_rate_all, undergraduate_enrollment, grad_enrollment, student_faculty_ratio, adm_rate_supp) FROM 'datasets/college_scorecard/institutions.csv' DELIMITER ',' CSV HEADER NULL 'NA';

\COPY student_backgrounds (unitid, pct_ba, pct_grad_prof, pct_born_us, ugds_men, ugds_women) FROM 'datasets/college_scorecard/student_backgrounds.csv' DELIMITER ',' CSV HEADER NULL 'NA';

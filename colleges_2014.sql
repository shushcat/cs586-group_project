DROP SCHEMA IF EXISTS colleges_2014;

CREATE SCHEMA colleges_2014;

DROP TABLE IF EXISTS colleges_2014.institutions CASCADE;
DROP TABLE IF EXISTS colleges_2014.student_backgrounds;
DROP TABLE IF EXISTS colleges_2014.student_academic_profile;
DROP TABLE IF EXISTS colleges_2014.student_financial_profile;
DROP TABLE IF EXISTS colleges_2014.institutional_financial_profile;
DROP TABLE IF EXISTS colleges_2014.foreign_gifts;
DROP TABLE IF EXISTS colleges_2014.athletics_financing;

-- CREATE TABLES

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

CREATE TABLE colleges_2014.student_backgrounds ( --from `college_scorecard`
	id SERIAL PRIMARY KEY,
	unitid int REFERENCES colleges_2014.institutions(unitid), --UNITID
	pct_ba float, --Percent of people over age 25 from students' zip codes with bachelor's degrees.
	pct_grad_prof float, --Percent of people over age 25 from students' zip codes with professional degrees.
	pct_born_us float, --Percent of people from students' zip codes that were born in the US.
	ugds_men float, --Total share of enrollment of undergraduate degree-seeking students who are men.
	ugds_women float --Total share of enrollment of undergraduate degree-seeking students who are women.
);

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

CREATE TABLE colleges_2014.foreign_gifts ( --from `foreign_gifts`
	id SERIAL PRIMARY KEY,
	unitid int REFERENCES colleges_2014.institutions(unitid),
	donor_country varchar(50), --"Country of Giftor"
	donor_name varchar(100), --"Giftor Name"
	gift_amount decimal(16, 2), --"Foreign Gift Amount"
	gift_date date, --"Foreign Gift Received"
	gift_type varchar(32) --"Gift Type"
);

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

--CREATE VIEW

DROP VIEW colleges_2014.faculty_and_sex_ratios;

CREATE OR REPLACE VIEW colleges_2014.faculty_and_sex_ratios AS
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

--IMPORT DATA

\COPY colleges_2014.institutions (unitid, opeid, name, state, city, zip_code, latitude, longitude, adm_rate_all, undergraduate_enrollment, grad_enrollment, student_faculty_ratio, adm_rate_supp) FROM 'datasets/college_scorecard/institutions.csv' DELIMITER ',' CSV HEADER NULL 'NA';

\COPY colleges_2014.student_backgrounds (unitid, pct_ba, pct_grad_prof, pct_born_us, ugds_men, ugds_women) FROM 'datasets/college_scorecard/student_backgrounds.csv' DELIMITER ',' CSV HEADER NULL 'NA';

\COPY colleges_2014.student_academic_profile (unitid, sat_mid_read, sat_mid_math, sat_mid_write, sat_avg, sat_avg_all, completion_rate, median_completion_rate, non_traditional) FROM 'datasets/college_scorecard/student_academic_profile.csv' DELIMITER ',' CSV HEADER NULL 'NA';

\COPY colleges_2014.student_financial_profile (unitid, median_cost, grad_debt_mdn, female_debt_mdn, male_debt_mdn, mdearn_pd, count_nwne_1yr, count_wne_1yr, pct_pell_students, default_rate2, default_rate3, pell_ever, shrinking_loans, earning_over_highschool, count_ed, age_entry, female, married, dependent, veteran, first_gen, faminc, poverty_rate, unemp_rate) FROM 'datasets/college_scorecard/student_financial_profile.csv' DELIMITER ',' CSV HEADER NULL 'NA';

\COPY colleges_2014.institutional_financial_profile (unitid, in_state_cost, out_state_cost, average_faculty_salary, instruction_spend_per_student, endowbegin, endowend) FROM 'datasets/college_scorecard/institutional_financial_profile.csv' DELIMITER ',' CSV HEADER NULL 'NA';

\COPY colleges_2014.foreign_gifts (unitid, gift_date, gift_amount, gift_type, donor_country, donor_name) FROM 'datasets/foreign_gifts/2014data_unitid.csv' DELIMITER ',' CSV HEADER NULL 'NA';

\COPY colleges_2014.athletics_financing (unitid, athletic_revenues, royalties, tv_revenue, ticket_sales, subsidy, direct_state_govt_support, ncaa_distributions, indirect_facil_admin_support, endowments, other_revenues, athletic_expenses, student_fees, net_revenue) FROM 'datasets/college_athletics_financing/2014data_selected.csv' DELIMITER ',' CSV HEADER NULL 'NULL';


-- NORMALIZE DATA : Can be achieved by removing the below columns as there is no data available for those columns 

* institutions - Laititude, Longitude, adm_rate_supp
* student_backgrounds - pct_ba, pct_grad_prof, pct_born_us
* student_academic_profile - completion_rate, median_completion_ratenon_traditional
* student_financial_profile - median_cost, mdearn_pd, count_nwne_1yr, count_wne_1yr, earning_over_highschool, count_ed ,poverty_rate, unemp_rate
* institutional_financial_profile - Good, normalization isn't required 
* foreign_gifts - Good, no normalization required 
* athletics_financing - Good, no normalization required 



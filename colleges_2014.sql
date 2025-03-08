CREATE DATABASE colleges_2014;
\c colleges_2014

CREATE TABLE institutions (
	unitid int PRIMARY KEY, --UNITID
	opeid varchar(16), --OPEID
	name varchar(128) NOT NULL, --INSTNM
	state varchar(2), --STABBR
	city varchar(64), --CITY
	zip_code varchar(10) --ZIP
);

CREATE TABLE academic_scores (
	id SERIAL PRIMARY KEY,
	unitid int REFERENCES institutions(unitid),
	sat_mid_read float, --SATVRMID
	sat_mid_math float, --SATMTMID
	sat_mid_write float, --SATWRMID
	sat_avg float, --SAT_AVG
	completion_rate, float --C200_4_POOLED_SUPP
);

CREATE TABLE financial_scores (
	id SERIAL PRIMARY KEY,
	unitid int REFERENCES institutions(unitid),
	enrollment int, --UG
	in_state_cost integer, --TUITIONFEE_IN
	out_state_cost integer, --TUITIONFEE_OUT
	median_debt decimal(10, 2), --GRAD_DEBT_MDN
	year int DEFAULT 2014 CHECK (year = 2014),
	instruction_spend_per_student int, --INTEXPFTE
	pct_pell_students float, --PCTPELL
	default_rate2 float, --CDR2
	default_rate3 float, --CDR3
	shrinking_loans float --RPY_7YR_RT
);

CREATE TABLE foreign_gifts (
	id SERIAL PRIMARY KEY,
	opeid varchar(16) REFERENCES institutions(opeid), --OPEID
	donor_country varchar(50), --"Country of Giftor"
	donor_name varchar(100), --"Giftor Name"
	gift_amount decimal(16, 2), --"Foreign Gift Amount"
	gift_date date, --"Foreign Gift Received"
	gift_type varchar(32) --"Gift Type"
);

CREATE TABLE athletics_financing (
	id SERIAL PRIMARY KEY,
	institution_id int REFERENCES institutions(unitid),
	total_revenue decimal(15, 2),
	total_expenses decimal(15, 2),
	year int DEFAULT 2014 CHECK (year = 2014)
);

COPY scorecards (
COPY college_scorecards (institution_id, enrollment, avg_tuition, grad_rate, median_debt, year)
FROM './datasets/college_scorecard/2014data00.csv' DELIMITER ',' CSV HEADER;

--college_scorecard/
variable_name API_data_type --NAME_OF_DATA_ELEMENT
unitid integer --Unit ID for institution
opeid string --8-digit OPE ID for institution
opeid6 string --6-digit OPE ID for institution
instnm autocomplete --Institution name
city autocomplete --City
stabbr string --State postcode
zip string --ZIP code
accredagency string --Accreditor for institution
insturl string --URL for institution's homepage
npcurl string --URL for institution's net price calculator
sch_deg integer --Predominant degree awarded (recoded 0s and 4s)
hcm2 integer --Schools that are on Heightened Cash Monitoring 2 by the Department of Education
main integer --Flag for main campus
numbranch integer --Number of branch campuses
preddeg integer --Predominant undergraduate degree awarded  0 Not classified  1 Predominantly certificate-degree granting  2 Predominantly associate's-degree granting  3 Predominantly bachelor's-degree granting  4 Entirely graduate-degree granting
highdeg integer --Highest degree awarded  0 Non-degree-granting  1 Certificate degree  2 Associate degree  3 Bachelor's degree  4 Graduate degree
control integer --Control of institution (IPEDS)
st_fips integer --FIPS code for state
region integer --Region (IPEDS)
locale integer --Locale of institution
locale2 integer --Degree of urbanization of institution
latitude float --Latitude
longitude float --Longitude
ccbasic integer --Carnegie Classification -- basic
ccugprof integer --Carnegie Classification -- undergraduate profile
ccsizset integer --Carnegie Classification -- size and setting
hbcu integer --Flag for Historically Black College and University
pbi integer --Flag for predominantly black institution
annhi integer --Flag for Alaska Native Native Hawaiian serving institution
tribal integer --Flag for tribal college and university
aanapii integer --Flag for Asian American Native American Pacific Islander-serving institution
hsi integer --Flag for Hispanic-serving institution
nanti integer --Flag for Native American non-tribal institution
menonly integer --Flag for men-only college
womenonly integer --Flag for women-only college
relaffil integer --Religous affiliation of the institution
adm_rate float --Admission rate
adm_rate_all float --Admission rate for all campuses rolled up to the 6-digit OPE ID
satvr25 float --25th percentile of SAT scores at the institution (critical reading)
satvr75 float --75th percentile of SAT scores at the institution (critical reading)
satmt25 float --25th percentile of SAT scores at the institution (math)
satmt75 float --75th percentile of SAT scores at the institution (math)
satwr25 float --25th percentile of SAT scores at the institution (writing)
satwr75 float --75th percentile of SAT scores at the institution (writing)
satvrmid float --Midpoint of SAT scores at the institution (critical reading)
satmtmid float --Midpoint of SAT scores at the institution (math)
satwrmid float --Midpoint of SAT scores at the institution (writing)
actcm25 float --25th percentile of the ACT cumulative score
actcm75 float --75th percentile of the ACT cumulative score
acten25 float --25th percentile of the ACT English score
acten75 float --75th percentile of the ACT English score
actmt25 float --25th percentile of the ACT math score
actmt75 float --75th percentile of the ACT math score
actwr25 float --25th percentile of the ACT writing score
actwr75 float --75th percentile of the ACT writing score
actcmmid float --Midpoint of the ACT cumulative score
actenmid float --Midpoint of the ACT English score
actmtmid float --Midpoint of the ACT math score
actwrmid float --Midpoint of the ACT writing score
sat_avg float --Average SAT equivalent score of students admitted
sat_avg_all float --Average SAT equivalent score of students admitted for all campuses rolled up to the 6-digit OPE ID
pcip01 float --Percentage of degrees awarded in Agriculture, Agriculture Operations, And Related Sciences.
pcip03 float --Percentage of degrees awarded in Natural Resources And Conservation.
pcip04 float --Percentage of degrees awarded in Architecture And Related Services.
pcip05 float --Percentage of degrees awarded in Area, Ethnic, Cultural, Gender, And Group Studies.
pcip09 float --Percentage of degrees awarded in Communication, Journalism, And Related Programs.
pcip10 float --Percentage of degrees awarded in Communications Technologies/Technicians And Support Services.
pcip11 float --Percentage of degrees awarded in Computer And Information Sciences And Support Services.
pcip12 float --Percentage of degrees awarded in Personal And Culinary Services.
pcip13 float --Percentage of degrees awarded in Education.
pcip14 float --Percentage of degrees awarded in Engineering.
pcip15 float --Percentage of degrees awarded in Engineering Technologies And Engineering-Related Fields.
pcip16 float --Percentage of degrees awarded in Foreign Languages, Literatures, And Linguistics.
pcip19 float --Percentage of degrees awarded in Family And Consumer Sciences/Human Sciences.
pcip22 float --Percentage of degrees awarded in Legal Professions And Studies.
pcip23 float --Percentage of degrees awarded in English Language And Literature/Letters.
pcip24 float --Percentage of degrees awarded in Liberal Arts And Sciences, General Studies And Humanities.
pcip25 float --Percentage of degrees awarded in Library Science.
pcip26 float --Percentage of degrees awarded in Biological And Biomedical Sciences.
pcip27 float --Percentage of degrees awarded in Mathematics And Statistics.
pcip29 float --Percentage of degrees awarded in Military Technologies And Applied Sciences.
pcip30 float --Percentage of degrees awarded in Multi/Interdisciplinary Studies.
pcip31 float --Percentage of degrees awarded in Parks, Recreation, Leisure, And Fitness Studies.
pcip38 float --Percentage of degrees awarded in Philosophy And Religious Studies.
pcip39 float --Percentage of degrees awarded in Theology And Religious Vocations.
pcip40 float --Percentage of degrees awarded in Physical Sciences.
pcip41 float --Percentage of degrees awarded in Science Technologies/Technicians.
pcip42 float --Percentage of degrees awarded in Psychology.
pcip43 float --Percentage of degrees awarded in Homeland Security, Law Enforcement, Firefighting And Related Protective Services.
pcip44 float --Percentage of degrees awarded in Public Administration And Social Service Professions.
pcip45 float --Percentage of degrees awarded in Social Sciences.
pcip46 float --Percentage of degrees awarded in Construction Trades.
pcip47 float --Percentage of degrees awarded in Mechanic And Repair Technologies/Technicians.
pcip48 float --Percentage of degrees awarded in Precision Production.
pcip49 float --Percentage of degrees awarded in Transportation And Materials Moving.
pcip50 float --Percentage of degrees awarded in Visual And Performing Arts.
pcip51 float --Percentage of degrees awarded in Health Professions And Related Programs.
pcip52 float --Percentage of degrees awarded in Business, Management, Marketing, And Related Support Services.
pcip54 float --Percentage of degrees awarded in History.
cip01cert1 integer --Certificate of less than one academic year in Agriculture, Agriculture Operations, And Related Sciences.
cip01cert2 integer --Certificate of at least one but less than two academic years in Agriculture, Agriculture Operations, And Related Sciences.
cip01assoc integer --Associate degree in Agriculture, Agriculture Operations, And Related Sciences.
cip01cert4 integer --Award of at least two but less than four academic years in Agriculture, Agriculture Operations, And Related Sciences.
cip01bachl integer --Bachelor's degree in Agriculture, Agriculture Operations, And Related Sciences.
cip03cert1 integer --Certificate of less than one academic year in Natural Resources And Conservation.
cip03cert2 integer --Certificate of at least one but less than two academic years in Natural Resources And Conservation.
cip03assoc integer --Associate degree in Natural Resources And Conservation.
cip03cert4 integer --Award of at least two but less than four academic years in Natural Resources And Conservation.
cip03bachl integer --Bachelor's degree in Natural Resources And Conservation.
cip04cert1 integer --Certificate of less than one academic year in Architecture And Related Services.
cip04cert2 integer --Certificate of at least one but less than two academic years in Architecture And Related Services.
cip04assoc integer --Associate degree in Architecture And Related Services.
cip04cert4 integer --Award of at least two but less than four academic years in Architecture And Related Services.
cip04bachl integer --Bachelor's degree in Architecture And Related Services.
cip05cert1 integer --Certificate of less than one academic year in Area, Ethnic, Cultural, Gender, And Group Studies.
cip05cert2 integer --Certificate of at least one but less than two academic years in Area, Ethnic, Cultural, Gender, And Group Studies.
cip05assoc integer --Associate degree in Area, Ethnic, Cultural, Gender, And Group Studies.
cip05cert4 integer --Award of at least two but less than four academic years in Area, Ethnic, Cultural, Gender, And Group Studies.
cip05bachl integer --Bachelor's degree in Area, Ethnic, Cultural, Gender, And Group Studies.
cip09cert1 integer --Certificate of less than one academic year in Communication, Journalism, And Related Programs.
cip09cert2 integer --Certificate of at least one but less than two academic years in Communication, Journalism, And Related Programs.
cip09assoc integer --Associate degree in Communication, Journalism, And Related Programs.
cip09cert4 integer --Award of at least two but less than four academic years in Communication, Journalism, And Related Programs.
cip09bachl integer --Bachelor's degree in Communication, Journalism, And Related Programs.
cip10cert1 integer --Certificate of less than one academic year in Communications Technologies/Technicians And Support Services.
cip10cert2 integer --Certificate of at least one but less than two academic years in Communications Technologies/Technicians And Support Services.
cip10assoc integer --Associate degree in Communications Technologies/Technicians And Support Services.
cip10cert4 integer --Award of at least two but less than four academic years in Communications Technologies/Technicians And Support Services.
cip10bachl integer --Bachelor's degree in Communications Technologies/Technicians And Support Services.
cip11cert1 integer --Certificate of less than one academic year in Computer And Information Sciences And Support Services.
cip11cert2 integer --Certificate of at least one but less than two academic years in Computer And Information Sciences And Support Services.
cip11assoc integer --Associate degree in Computer And Information Sciences And Support Services.
cip11cert4 integer --Award of at least two but less than four academic years in Computer And Information Sciences And Support Services.
cip11bachl integer --Bachelor's degree in Computer And Information Sciences And Support Services.
cip12cert1 integer --Certificate of less than one academic year in Personal And Culinary Services.
cip12cert2 integer --Certificate of at least one but less than two academic years in Personal And Culinary Services.
cip12assoc integer --Associate degree in Personal And Culinary Services.
cip12cert4 integer --Award of at least two but less than four academic years in Personal And Culinary Services.
cip12bachl integer --Bachelor's degree in Personal And Culinary Services.
cip13cert1 integer --Certificate of less than one academic year in Education.
cip13cert2 integer --Certificate of at least one but less than two academic years in Education.
cip13assoc integer --Associate degree in Education.
cip13cert4 integer --Award of at least two but less than four academic years in Education.
cip13bachl integer --Bachelor's degree in Education.
cip14cert1 integer --Certificate of less than one academic year in Engineering.
cip14cert2 integer --Certificate of at least one but less than two academic years in Engineering.
cip14assoc integer --Associate degree in Engineering.
cip14cert4 integer --Award of at least two but less than four academic years in Engineering.
cip14bachl integer --Bachelor's degree in Engineering.
cip15cert1 integer --Certificate of less than one academic year in Engineering Technologies And Engineering-Related Fields.
cip15cert2 integer --Certificate of at least one but less than two academic years in Engineering Technologies And Engineering-Related Fields.
cip15assoc integer --Associate degree in Engineering Technologies And Engineering-Related Fields.
cip15cert4 integer --Award of at least two but less than four academic years in Engineering Technologies And Engineering-Related Fields.
cip15bachl integer --Bachelor's degree in Engineering Technologies And Engineering-Related Fields.
cip16cert1 integer --Certificate of less than one academic year in Foreign Languages, Literatures, And Linguistics.
cip16cert2 integer --Certificate of at least one but less than two academic years in Foreign Languages, Literatures, And Linguistics.
cip16assoc integer --Associate degree in Foreign Languages, Literatures, And Linguistics.
cip16cert4 integer --Award of at least two but less than four academic years in Foreign Languages, Literatures, And Linguistics.
cip16bachl integer --Bachelor's degree in Foreign Languages, Literatures, And Linguistics.
cip19cert1 integer --Certificate of less than one academic year in Family And Consumer Sciences/Human Sciences.
cip19cert2 integer --Certificate of at least one but less than two academic years in Family And Consumer Sciences/Human Sciences.
cip19assoc integer --Associate degree in Family And Consumer Sciences/Human Sciences.
cip19cert4 integer --Award of at least two but less than four academic years in Family And Consumer Sciences/Human Sciences.
cip19bachl integer --Bachelor's degree in Family And Consumer Sciences/Human Sciences.
cip22cert1 integer --Certificate of less than one academic year in Legal Professions And Studies.
cip22cert2 integer --Certificate of at least one but less than two academic years in Legal Professions And Studies.
cip22assoc integer --Associate degree in Legal Professions And Studies.
cip22cert4 integer --Award of at least two but less than four academic years in Legal Professions And Studies.
cip22bachl integer --Bachelor's degree in Legal Professions And Studies.
cip23cert1 integer --Certificate of less than one academic year in English Language And Literature/Letters.
cip23cert2 integer --Certificate of at least one but less than two academic years in English Language And Literature/Letters.
cip23assoc integer --Associate degree in English Language And Literature/Letters.
cip23cert4 integer --Award of at least two but less than four academic years in English Language And Literature/Letters.
cip23bachl integer --Bachelor's degree in English Language And Literature/Letters.
cip24cert1 integer --Certificate of less than one academic year in Liberal Arts And Sciences, General Studies And Humanities.
cip24cert2 integer --Certificate of at least one but less than two academic years in Liberal Arts And Sciences, General Studies And Humanities.
cip24assoc integer --Associate degree in Liberal Arts And Sciences, General Studies And Humanities.
cip24cert4 integer --Award of at least two but less than four academic years in Liberal Arts And Sciences, General Studies And Humanities.
cip24bachl integer --Bachelor's degree in Liberal Arts And Sciences, General Studies And Humanities.
cip25cert1 integer --Certificate of less than one academic year in Library Science.
cip25cert2 integer --Certificate of at least one but less than two academic years in Library Science.
cip25assoc integer --Associate degree in Library Science.
cip25cert4 integer --Award of at least two but less than four academic years in Library Science.
cip25bachl integer --Bachelor's degree in Library Science.
cip26cert1 integer --Certificate of less than one academic year in Biological And Biomedical Sciences.
cip26cert2 integer --Certificate of at least one but less than two academic years in Biological And Biomedical Sciences.
cip26assoc integer --Associate degree in Biological And Biomedical Sciences.
cip26cert4 integer --Award of at least two but less than four academic years in Biological And Biomedical Sciences.
cip26bachl integer --Bachelor's degree in Biological And Biomedical Sciences.
cip27cert1 integer --Certificate of less than one academic year in Mathematics And Statistics.
cip27cert2 integer --Certificate of at least one but less than two academic years in Mathematics And Statistics.
cip27assoc integer --Associate degree in Mathematics And Statistics.
cip27cert4 integer --Award of at least two but less than four academic years in Mathematics And Statistics.
cip27bachl integer --Bachelor's degree in Mathematics And Statistics.
cip29cert1 integer --Certificate of less than one academic year in Military Technologies And Applied Sciences.
cip29cert2 integer --Certificate of at least one but less than two academic years in Military Technologies And Applied Sciences.
cip29assoc integer --Associate degree in Military Technologies And Applied Sciences.
cip29cert4 integer --Award of at least two but less than four academic years in Military Technologies And Applied Sciences.
cip29bachl integer --Bachelor's degree in Military Technologies And Applied Sciences.
cip30cert1 integer --Certificate of less than one academic year in Multi/Interdisciplinary Studies.
cip30cert2 integer --Certificate of at least one but less than two academic years in Multi/Interdisciplinary Studies.
cip30assoc integer --Associate degree in Multi/Interdisciplinary Studies.
cip30cert4 integer --Award of at least two but less than four academic years in Multi/Interdisciplinary Studies.
cip30bachl integer --Bachelor's degree in Multi/Interdisciplinary Studies.
cip31cert1 integer --Certificate of less than one academic year in Parks, Recreation, Leisure, And Fitness Studies.
cip31cert2 integer --Certificate of at least one but less than two academic years in Parks, Recreation, Leisure, And Fitness Studies.
cip31assoc integer --Associate degree in Parks, Recreation, Leisure, And Fitness Studies.
cip31cert4 integer --Award of at least two but less than four academic years in Parks, Recreation, Leisure, And Fitness Studies.
cip31bachl integer --Bachelor's degree in Parks, Recreation, Leisure, And Fitness Studies.
cip38cert1 integer --Certificate of less than one academic year in Philosophy And Religious Studies.
cip38cert2 integer --Certificate of at least one but less than two academic years in Philosophy And Religious Studies.
cip38assoc integer --Associate degree in Philosophy And Religious Studies.
cip38cert4 integer --Award of at least two but less than four academic years in Philosophy And Religious Studies.
cip38bachl integer --Bachelor's degree in Philosophy And Religious Studies.
cip39cert1 integer --Certificate of less than one academic year in Theology And Religious Vocations.
cip39cert2 integer --Certificate of at least one but less than two academic years in Theology And Religious Vocations.
cip39assoc integer --Associate degree in Theology And Religious Vocations.
cip39cert4 integer --Award of at least two but less than four academic years in Theology And Religious Vocations.
cip39bachl integer --Bachelor's degree in Theology And Religious Vocations.
cip40cert1 integer --Certificate of less than one academic year in Physical Sciences.
cip40cert2 integer --Certificate of at least one but less than two academic years in Physical Sciences.
cip40assoc integer --Associate degree in Physical Sciences.
cip40cert4 integer --Award of at least two but less than four academic years in Physical Sciences.
cip40bachl integer --Bachelor's degree in Physical Sciences.
cip41cert1 integer --Certificate of less than one academic year in Science Technologies/Technicians.
cip41cert2 integer --Certificate of at least one but less than two academic years in Science Technologies/Technicians.
cip41assoc integer --Associate degree in Science Technologies/Technicians.
cip41cert4 integer --Award of at least two but less than four academic years in Science Technologies/Technicians.
cip41bachl integer --Bachelor's degree in Science Technologies/Technicians.
cip42cert1 integer --Certificate of less than one academic year in Psychology.
cip42cert2 integer --Certificate of at least one but less than two academic years in Psychology.
cip42assoc integer --Associate degree in Psychology.
cip42cert4 integer --Award of at least two but less than four academic years in Psychology.
cip42bachl integer --Bachelor's degree in Psychology.
cip43cert1 integer --Certificate of less than one academic year in Homeland Security, Law Enforcement, Firefighting And Related Protective Services.
cip43cert2 integer --Certificate of at least one but less than two academic years in Homeland Security, Law Enforcement, Firefighting And Related Protective Services.
cip43assoc integer --Associate degree in Homeland Security, Law Enforcement, Firefighting And Related Protective Services.
cip43cert4 integer --Award of at least two but less than four academic years in Homeland Security, Law Enforcement, Firefighting And Related Protective Services.
cip43bachl integer --Bachelor's degree in Homeland Security, Law Enforcement, Firefighting And Related Protective Services.
cip44cert1 integer --Certificate of less than one academic year in Public Administration And Social Service Professions.
cip44cert2 integer --Certificate of at least one but less than two academic years in Public Administration And Social Service Professions.
cip44assoc integer --Associate degree in Public Administration And Social Service Professions.
cip44cert4 integer --Award of at least two but less than four academic years in Public Administration And Social Service Professions.
cip44bachl integer --Bachelor's degree in Public Administration And Social Service Professions.
cip45cert1 integer --Certificate of less than one academic year in Social Sciences.
cip45cert2 integer --Certificate of at least one but less than two academic years in Social Sciences.
cip45assoc integer --Associate degree in Social Sciences.
cip45cert4 integer --Award of at least two but less than four academic years in Social Sciences.
cip45bachl integer --Bachelor's degree in Social Sciences.
cip46cert1 integer --Certificate of less than one academic year in Construction Trades.
cip46cert2 integer --Certificate of at least one but less than two academic years in Construction Trades.
cip46assoc integer --Associate degree in Construction Trades.
cip46cert4 integer --Award of at least two but less than four academic years in Construction Trades.
cip46bachl integer --Bachelor's degree in Construction Trades.
cip47cert1 integer --Certificate of less than one academic year in Mechanic And Repair Technologies/Technicians.
cip47cert2 integer --Certificate of at least one but less than two academic years in Mechanic And Repair Technologies/Technicians.
cip47assoc integer --Associate degree in Mechanic And Repair Technologies/Technicians.
cip47cert4 integer --Award of at least two but less than four academic years in Mechanic And Repair Technologies/Technicians.
cip47bachl integer --Bachelor's degree in Mechanic And Repair Technologies/Technicians.
cip48cert1 integer --Certificate of less than one academic year in Precision Production.
cip48cert2 integer --Certificate of at least one but less than two academic years in Precision Production.
cip48assoc integer --Associate degree in Precision Production.
cip48cert4 integer --Award of at least two but less than four academic years in Precision Production.
cip48bachl integer --Bachelor's degree in Precision Production.
cip49cert1 integer --Certificate of less than one academic year in Transportation And Materials Moving.
cip49cert2 integer --Certificate of at least one but less than two academic years in Transportation And Materials Moving.
cip49assoc integer --Associate degree in Transportation And Materials Moving.
cip49cert4 integer --Award of at least two but less than four academic years in Transportation And Materials Moving.
cip49bachl integer --Bachelor's degree in Transportation And Materials Moving.
cip50cert1 integer --Certificate of less than one academic year in Visual And Performing Arts.
cip50cert2 integer --Certificate of at least one but less than two academic years in Visual And Performing Arts.
cip50assoc integer --Associate degree in Visual And Performing Arts.
cip50cert4 integer --Award of at least two but less than four academic years in Visual And Performing Arts.
cip50bachl integer --Bachelor's degree in Visual And Performing Arts.
cip51cert1 integer --Certificate of less than one academic year in Health Professions And Related Programs.
cip51cert2 integer --Certificate of at least one but less than two academic years in Health Professions And Related Programs.
cip51assoc integer --Associate degree in Health Professions And Related Programs.
cip51cert4 integer --Award of at least two but less than four academic years in Health Professions And Related Programs.
cip51bachl integer --Bachelor's degree in Health Professions And Related Programs.
cip52cert1 integer --Certificate of less than one academic year in Business, Management, Marketing, And Related Support Services.
cip52cert2 integer --Certificate of at least one but less than two academic years in Business, Management, Marketing, And Related Support Services.
cip52assoc integer --Associate degree in Business, Management, Marketing, And Related Support Services.
cip52cert4 integer --Award of at least two but less than four academic years in Business, Management, Marketing, And Related Support Services.
cip52bachl integer --Bachelor's degree in Business, Management, Marketing, And Related Support Services.
cip54cert1 integer --Certificate of less than one academic year in History.
cip54cert2 integer --Certificate of at least one but less than two academic years in History.
cip54assoc integer --Associate degree in History.
cip54cert4 integer --Award of at least two but less than four academic years in History.
cip54bachl integer --Bachelor's degree in History.
distanceonly integer --Flag for distance-education-only education
ugds integer --Enrollment of undergraduate certificate/degree-seeking students
ug integer --Enrollment of all undergraduate students
ugds_white float --Total share of enrollment of undergraduate degree-seeking students who are white
ugds_black float --Total share of enrollment of undergraduate degree-seeking students who are black
ugds_hisp float --Total share of enrollment of undergraduate degree-seeking students who are Hispanic
ugds_asian float --Total share of enrollment of undergraduate degree-seeking students who are Asian
ugds_aian float --Total share of enrollment of undergraduate degree-seeking students who are American Indian/Alaska Native
ugds_nhpi float --Total share of enrollment of undergraduate degree-seeking students who are Native Hawaiian/Pacific Islander
ugds_2mor float --Total share of enrollment of undergraduate degree-seeking students who are two or more races
ugds_nra float --Total share of enrollment of undergraduate degree-seeking students who are non-resident aliens
ugds_unkn float --Total share of enrollment of undergraduate degree-seeking students whose race is unknown
ugds_whitenh float --Total share of enrollment of undergraduate degree-seeking students who are white non-Hispanic
ugds_blacknh float --Total share of enrollment of undergraduate degree-seeking students who are black non-Hispanic
ugds_api float --Total share of enrollment of undergraduate degree-seeking students who are Asian/Pacific Islander
ugds_aianold float --Total share of enrollment of undergraduate degree-seeking students who are American Indian/Alaska Native
ugds_hispold float --Total share of enrollment of undergraduate degree-seeking students who are Hispanic
ug_nra float --Total share of enrollment of undergraduate students who are non-resident aliens
ug_unkn float --Total share of enrollment of undergraduate students whose race is unknown
ug_whitenh float --Total share of enrollment of undergraduate students who are white non-Hispanic
ug_blacknh float --Total share of enrollment of undergraduate students who are black non-Hispanic
ug_api float --Total share of enrollment of undergraduate students who are Asian/Pacific Islander
ug_aianold float --Total share of enrollment of undergraduate students who are American Indian/Alaska Native
ug_hispold float --Total share of enrollment of undergraduate students who are Hispanic
pptug_ef float --Share of undergraduate, degree-/certificate-seeking students who are part-time
pptug_ef2 float --Share of undergraduate, degree-/certificate-seeking students who are part-time
curroper integer --Flag for currently operating institution, 0=closed, 1=operating
npt4_pub integer --Average net price for Title IV institutions (public institutions)
npt4_priv integer --Average net price for Title IV institutions (private for-profit and nonprofit institutions)
npt4_prog integer --Average net price for the largest program at the institution for program-year institutions
npt4_other integer --Average net price for the largest program at the institution for schools on ""other"" academic year calendars
npt41_pub integer --Average net price for $0-$30,000 family income (public institutions)
npt42_pub integer --Average net price for $30,001-$48,000 family income (public institutions)
npt43_pub integer --Average net price for $48,001-$75,000 family income (public institutions)
npt44_pub integer --Average net price for $75,001-$110,000 family income (public institutions)
npt45_pub integer --Average net price for $110,000+ family income (public institutions)
npt41_priv integer --Average net price for $0-$30,000 family income (private for-profit and nonprofit institutions)
npt42_priv integer --Average net price for $30,001-$48,000 family income (private for-profit and nonprofit institutions)
npt43_priv integer --Average net price for $48,001-$75,000 family income (private for-profit and nonprofit institutions)
npt44_priv integer --Average net price for $75,001-$110,000 family income (private for-profit and nonprofit institutions)
npt45_priv integer --Average net price for $110,000+ family income (private for-profit and nonprofit institutions)
npt41_prog integer --Average net price for $0-$30,000 family income (program-year institutions)
npt42_prog integer --Average net price for $30,001-$48,000 family income (program-year institutions)
npt43_prog integer --Average net price for $48,001-$75,000 family income (program-year institutions)
npt44_prog integer --Average net price for $75,001-$110,000 family income (program-year institutions)
npt45_prog integer --Average net price for $110,000+ family income (program-year institutions)
npt41_other integer --Average net price for $0-$30,000 family income (other academic calendar institutions)
npt42_other integer --Average net price for $30,001-$48,000 family income (other academic calendar institutions)
npt43_other integer --Average net price for $48,001-$75,000 family income (other academic calendar institutions)
npt44_other integer --Average net price for $75,001-$110,000 family income (other academic calendar institutions)
npt45_other integer --Average net price for $110,000+ family income (other academic calendar institutions)
npt4_048_pub integer --Average net price for $0-$48,000 family income (public institutions)
npt4_048_priv integer --Average net price for $0-$48,000 family income (private for-profit and nonprofit institutions)
npt4_048_prog integer --Average net price for $0-$48,000 family income (program-year institutions)
npt4_048_other integer --Average net price for $0-$48,000 family income (other academic calendar institutions)
npt4_3075_pub integer --Average net price for $30,001-$75,000 family income (public institutions)
npt4_3075_priv integer --Average net price for $30,001-$75,000 family income (private for-profit and nonprofit institutions)
npt4_75up_pub integer --Average net price for $75,000+ family income (public institutions)
npt4_75up_priv integer --Average net price for $75,000+ family income (private for-profit and nonprofit institutions)
npt4_3075_prog integer --Average net price for $30,001-$75,000 family income (program-year institutions)
npt4_3075_other integer --Average net price for $30,001-$75,000 family income (other academic calendar institutions)
npt4_75up_prog integer --Average net price for $75,000+ family income (program-year institutions)
npt4_75up_other integer --Average net price for $75,000+ family income (other academic calendar institutions)
num4_pub integer --Number of Title IV students (public institutions)
num4_priv integer --Number of Title IV students (private for-profit and nonprofit institutions)
num4_prog integer --Number of Title IV students (program-year institutions)
num4_other integer --Number of Title IV students (other academic calendar institutions)
num41_pub integer --Number of Title IV students, $0-$30,000 family income (public institutions)
num42_pub integer --Number of Title IV students, $30,001-$48,000 family income (public institutions)
num43_pub integer --Number of Title IV students, $48,001-$75,000 family income (public institutions)
num44_pub integer --Number of Title IV students, $75,001-$110,000 family income (public institutions)
num45_pub integer --Number of Title IV students, $110,000+ family income (public institutions)
num41_priv integer --Number of Title IV students, $0-$30,000 family income (private for-profit and nonprofit institutions)
num42_priv integer --Number of Title IV students, $30,001-$48,000 family income (private for-profit and nonprofit institutions)
num43_priv integer --Number of Title IV students, $48,001-$75,000 family income (private for-profit and nonprofit institutions)
num44_priv integer --Number of Title IV students, $75,001-$110,000 family income (private for-profit and nonprofit institutions)
num45_priv integer --Number of Title IV students, $110,000+ family income (private for-profit and nonprofit institutions)
num41_prog integer --Number of Title IV students, $0-$30,000 family income (program-year institutions)
num42_prog integer --Number of Title IV students, $30,001-$48,000 family income (program-year institutions)
num43_prog integer --Number of Title IV students, $48,001-$75,000 family income (program-year institutions)
num44_prog integer --Number of Title IV students, $75,001-$110,000 family income (program-year institutions)
num45_prog integer --Number of Title IV students, $110,000+ family income (program-year institutions)
num41_other integer --Number of Title IV students, $0-$30,000 family income (other academic calendar institutions)
num42_other integer --Number of Title IV students, $30,001-$48,000 family income (other academic calendar institutions)
num43_other integer --Number of Title IV students, $48,001-$75,000 family income (other academic calendar institutions)
num44_other integer --Number of Title IV students, $75,001-$110,000 family income (other academic calendar institutions)
num45_other integer --Number of Title IV students, $110,000+ family income (other academic calendar institutions)
costt4_a integer --Average cost of attendance (academic year institutions)
costt4_p integer --Average cost of attendance (program-year institutions)
tuitionfee_in integer --In-state tuition and fees
tuitionfee_out integer --Out-of-state tuition and fees
tuitionfee_prog integer --Tuition and fees for program-year institutions
tuitfte integer --Net tuition revenue per full-time equivalent student
inexpfte integer --Instructional expenditures per full-time equivalent student
avgfacsal integer --Average faculty salary
pftfac float --Proportion of faculty that is full-time
pctpell float --Percentage of undergraduates who receive a Pell Grant
c150_4 float --Completion rate for first-time, full-time students at four-year institutions (150% of expected time to completion)
c150_l4 float --Completion rate for first-time, full-time students at less-than-four-year institutions (150% of expected time to completion)
c150_4_pooled float --Completion rate for first-time, full-time students at four-year institutions (150% of expected time to completion), pooled for two year rolling averages
c150_l4_pooled float --Completion rate for first-time, full-time students at less-than-four-year institutions (150% of expected time to completion), pooled for two year rolling averages
poolyrs integer --Years used for rolling averages of completion rate C150_[4/L4]_POOLED and transfer rate TRANS_[4/L4]_POOLED
pftftug1_ef float --Share of entering undergraduate students who are first-time, full-time degree-/certificate-seeking undergraduate students
d150_4 integer --Adjusted cohort count for completion rate at four-year institutions (denominator of 150% completion rate)
d150_l4 integer --Adjusted cohort count for completion rate at less-than-four-year institutions (denominator of 150% completion rate)
d150_4_pooled integer --Adjusted cohort count for completion rate at four-year institutions (denominator of 150% completion rate), pooled for two-year rolling averages
d150_l4_pooled integer --Adjusted cohort count for completion rate at less-than-four-year institutions (denominator of 150% completion rate), pooled for two-year rolling averages
c150_4_white float --Completion rate for first-time, full-time students at four-year institutions (150% of expected time to completion) for white students
c150_4_black float --Completion rate for first-time, full-time students at four-year institutions (150% of expected time to completion) for black students
c150_4_hisp float --Completion rate for first-time, full-time students at four-year institutions (150% of expected time to completion) for Hispanic students
c150_4_asian float --Completion rate for first-time, full-time students at four-year institutions (150% of expected time to completion) for Asian students
c150_4_aian float --Completion rate for first-time, full-time students at four-year institutions (150% of expected time to completion) for American Indian/Alaska Native students
c150_4_nhpi float --Completion rate for first-time, full-time students at four-year institutions (150% of expected time to completion) for Native Hawaiian/Pacific Islander students
c150_4_2mor float --Completion rate for first-time, full-time students at four-year institutions (150% of expected time to completion) for students of two-or-more-races
c150_4_nra float --Completion rate for first-time, full-time students at four-year institutions (150% of expected time to completion) for non-resident alien students
c150_4_unkn float --Completion rate for first-time, full-time students at four-year institutions (150% of expected time to completion) for students whose race is unknown
c150_4_whitenh float --Completion rate for first-time, full-time students at four-year institutions (150% of expected time to completion) for white students
c150_4_blacknh float --Completion rate for first-time, full-time students at four-year institutions (150% of expected time to completion) for black students
c150_4_api float --Completion rate for first-time, full-time students at four-year institutions (150% of expected time to completion) for Asian/Pacific Islander students
c150_4_aianold float --Completion rate for first-time, full-time students at four-year institutions (150% of expected time to completion) for American Indian/Alaska Native students
c150_4_hispold float --Completion rate for first-time, full-time students at four-year institutions (150% of expected time to completion) for Hispanic students
c150_l4_white float --Completion rate for first-time, full-time students at less-than-four-year institutions (150% of expected time to completion) for white students
c150_l4_black float --Completion rate for first-time, full-time students at less-than-four-year institutions (150% of expected time to completion) for black students
c150_l4_hisp float --Completion rate for first-time, full-time students at less-than-four-year institutions (150% of expected time to completion) for Hispanic students
c150_l4_asian float --Completion rate for first-time, full-time students at less-than-four-year institutions (150% of expected time to completion) for Asian students
c150_l4_aian float --Completion rate for first-time, full-time students at less-than-four-year institutions (150% of expected time to completion) for American Indian/Alaska Native students
c150_l4_nhpi float --Completion rate for first-time, full-time students at less-than-four-year institutions (150% of expected time to completion) for Native Hawaiian/Pacific Islander students
c150_l4_2mor float --Completion rate for first-time, full-time students at less-than-four-year institutions (150% of expected time to completion) for students of two-or-more-races
c150_l4_nra float --Completion rate for first-time, full-time students at less-than-four-year institutions (150% of expected time to completion) for non-resident alien students
c150_l4_unkn float --Completion rate for first-time, full-time students at less-than-four-year institutions (150% of expected time to completion) for students whose race is unknown
c150_l4_whitenh float --Completion rate for first-time, full-time students at less-than-four-year institutions (150% of expected time to completion) for white non-Hispanic students
c150_l4_blacknh float --Completion rate for first-time, full-time students at less-than-four-year institutions (150% of expected time to completion) for black non-Hispanic students
c150_l4_api float --Completion rate for first-time, full-time students at less-than-four-year institutions (150% of expected time to completion) for Asian/Pacific Islander students
c150_l4_aianold float --Completion rate for first-time, full-time students at less-than-four-year institutions (150% of expected time to completion) for American Indian/Alaska Native students
c150_l4_hispold float --Completion rate for first-time, full-time students at less-than-four-year institutions (150% of expected time to completion) for Hispanic students
c200_4 float --Completion rate for first-time, full-time bachelor's-degree-seeking students at four-year institutions (200% of expected time to completion)
c200_l4 float --Completion rate for first-time, full-time students at less-than-four-year institutions (200% of expected time to completion)
d200_4 float --Adjusted cohort count for completion rate at four-year institutions (denominator of 200% completion rate)
d200_l4 float --Adjusted cohort count for completion rate at less-than-four-year institutions (denominator of 200% completion rate)
ret_ft4 float --First-time, full-time student retention rate at four-year institutions
ret_ftl4 float --First-time, full-time student retention rate at less-than-four-year institutions
ret_pt4 float --First-time, part-time student retention rate at four-year institutions
ret_ptl4 float --First-time, part-time student retention rate at less-than-four-year institutions
c200_4_pooled float --Completion rate for first-time, full-time bachelor's-degree-seeking students at four-year institutions (200% of expected time to completion), pooled for two year rolling averages
c200_l4_pooled float --Completion rate for first-time, full-time students at less-than-four-year institutions (200% of expected time to completion), pooled for two year rolling averages
poolyrs200 integer --Years used for rolling averages of completion rate C200_[4/L4]_POOLED
d200_4_pooled float --Adjusted cohort count for completion rate at four-year institutions (denominator of 200% completion rate), pooled for two-year rolling averages
d200_l4_pooled float --Adjusted cohort count for completion rate at less-than-four-year institutions (denominator of 200% completion rate), pooled for two-year rolling averages
pctfloan float --Percent of all undergraduate students receiving a federal student loan
ug25abv float --Percentage of undergraduates aged 25 and above
cdr2 float --Two-year cohort default rate
cdr3 float --Three-year cohort default rate
death_yr2_rt float --Percent died within 2 years at original institution
comp_orig_yr2_rt float --Percent completed within 2 years at original institution
comp_4yr_trans_yr2_rt float --Percent who transferred to a 4-year institution and completed within 2 years
comp_2yr_trans_yr2_rt float --Percent who transferred to a 2-year institution and completed within 2 years
wdraw_orig_yr2_rt float --Percent withdrawn from original institution within 2 years
wdraw_4yr_trans_yr2_rt float --Percent who transferred to a 4-year institution and withdrew within 2 years
wdraw_2yr_trans_yr2_rt float --Percent who transferred to a 2-year institution and withdrew within 2 years
enrl_orig_yr2_rt float --Percent still enrolled at original institution within 2 years
enrl_4yr_trans_yr2_rt float --Percent who transferred to a 4-year institution and were still enrolled within 2 years
enrl_2yr_trans_yr2_rt float --Percent who transferred to a 2-year institution and were still enrolled within 2 years
unkn_orig_yr2_rt float --Percent with status unknown within 2 years at original institution
unkn_4yr_trans_yr2_rt float --Percent who transferred to a 4-year institution and whose status is unknown within 2 years
unkn_2yr_trans_yr2_rt float --Percent who transferred to a 2-year institution and whose status is unknown within 2 years
lo_inc_death_yr2_rt float --Percent of low-income (less than $30,000 in nominal family income) students who died within 2 years at original institution
lo_inc_comp_orig_yr2_rt float --Percent of low-income (less than $30,000 in nominal family income) students who completed within 2 years at original institution
lo_inc_comp_4yr_trans_yr2_rt float --Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 4-year institution and completed within 2 years
lo_inc_comp_2yr_trans_yr2_rt float --Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 2-year institution and completed within 2 years
lo_inc_wdraw_orig_yr2_rt float --Percent of low-income (less than $30,000 in nominal family income) students withdrawn from original institution within 2 years
lo_inc_wdraw_4yr_trans_yr2_rt float --Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 4-year institution and withdrew within 2 years
lo_inc_wdraw_2yr_trans_yr2_rt float --Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 2-year institution and withdrew within 2 years
lo_inc_enrl_orig_yr2_rt float --Percent of low-income (less than $30,000 in nominal family income) students who were still enrolled at original institution within 2 years
lo_inc_enrl_4yr_trans_yr2_rt float --Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 4-year institution and were still enrolled within 2 years
lo_inc_enrl_2yr_trans_yr2_rt float --Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 2-year institution and were still enrolled within 2 years
lo_inc_unkn_orig_yr2_rt float --Percent of low-income (less than $30,000 in nominal family income) students with status unknown within 2 years at original institution
lo_inc_unkn_4yr_trans_yr2_rt float --Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 4-year institution and whose status is unknown within 2 years
lo_inc_unkn_2yr_trans_yr2_rt float --Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 2-year institution and whose status is unknown within 2 years
md_inc_death_yr2_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who died within 2 years at original institution
md_inc_comp_orig_yr2_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who completed within 2 years at original institution
md_inc_comp_4yr_trans_yr2_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to a 4-year institution and completed within 2 years
md_inc_comp_2yr_trans_yr2_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to a 2-year institution and completed within 2 years
md_inc_wdraw_orig_yr2_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students withdrawn from original institution within 2 years
md_inc_wdraw_4yr_trans_yr2_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to a 4-year institution and withdrew within 2 years
md_inc_wdraw_2yr_trans_yr2_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to a 2-year institution and withdrew within 2 years
md_inc_enrl_orig_yr2_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who were still enrolled at original institution within 2 years
md_inc_enrl_4yr_trans_yr2_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to a 4-year institution and were still enrolled within 2 years
md_inc_enrl_2yr_trans_yr2_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to a 2-year institution and were still enrolled within 2 years
md_inc_unkn_orig_yr2_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students with status unknown within 2 years at original institution
md_inc_unkn_4yr_trans_yr2_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to a 4-year institution and whose status is unknown within 2 years
md_inc_unkn_2yr_trans_yr2_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to a 2-year institution and whose status is unknown within 2 years
hi_inc_death_yr2_rt float --Percent of high-income (above $75,000 in nominal family income) students who died within 2 years at original institution
hi_inc_comp_orig_yr2_rt float --Percent of high-income (above $75,000 in nominal family income) students who completed within 2 years at original institution
hi_inc_comp_4yr_trans_yr2_rt float --Percent of high-income (above $75,000 in nominal family income) students who transferred to a 4-year institution and completed within 2 years
hi_inc_comp_2yr_trans_yr2_rt float --Percent of high-income (above $75,000 in nominal family income) students who transferred to a 2-year institution and completed within 2 years
hi_inc_wdraw_orig_yr2_rt float --Percent of high-income (above $75,000 in nominal family income) students withdrawn from original institution within 2 years
hi_inc_wdraw_4yr_trans_yr2_rt float --Percent of high-income (above $75,000 in nominal family income) students who transferred to a 4-year institution and withdrew within 2 years
hi_inc_wdraw_2yr_trans_yr2_rt float --Percent of high-income (above $75,000 in nominal family income) students who transferred to a 2-year institution and withdrew within 2 years
hi_inc_enrl_orig_yr2_rt float --Percent of high-income (above $75,000 in nominal family income) students who were still enrolled at original institution within 2 years
hi_inc_enrl_4yr_trans_yr2_rt float --Percent of high-income (above $75,000 in nominal family income) students who transferred to a 4-year institution and were still enrolled within 2 years
hi_inc_enrl_2yr_trans_yr2_rt float --Percent of high-income (above $75,000 in nominal family income) students who transferred to a 2-year institution and were still enrolled within 2 years
hi_inc_unkn_orig_yr2_rt float --Percent of high-income (above $75,000 in nominal family income) students with status unknown within 2 years at original institution
hi_inc_unkn_4yr_trans_yr2_rt float --Percent of high-income (above $75,000 in nominal family income) students who transferred to a 4-year institution and whose status is unknown within 2 years
hi_inc_unkn_2yr_trans_yr2_rt float --Percent of high-income (above $75,000 in nominal family income) students who transferred to a 2-year institution and whose status is unknown within 2 years
dep_death_yr2_rt float --Percent of dependent students who died within 2 years at original institution
dep_comp_orig_yr2_rt float --Percent of dependent students who completed within 2 years at original institution
dep_comp_4yr_trans_yr2_rt float --Percent of dependent students who transferred to a 4-year institution and completed within 2 years
dep_comp_2yr_trans_yr2_rt float --Percent of dependent students who transferred to a 2-year institution and completed within 2 years
dep_wdraw_orig_yr2_rt float --Percent of dependent students withdrawn from original institution within 2 years
dep_wdraw_4yr_trans_yr2_rt float --Percent of dependent students who transferred to a 4-year institution and withdrew within 2 years
dep_wdraw_2yr_trans_yr2_rt float --Percent of dependent students who transferred to a 2-year institution and withdrew within 2 years
dep_enrl_orig_yr2_rt float --Percent of dependent students who were still enrolled at original institution within 2 years
dep_enrl_4yr_trans_yr2_rt float --Percent of dependent students who transferred to a 4-year institution and were still enrolled within 2 years
dep_enrl_2yr_trans_yr2_rt float --Percent of dependent students who transferred to a 2-year institution and were still enrolled within 2 years
dep_unkn_orig_yr2_rt float --Percent of dependent students with status unknown within 2 years at original institution
dep_unkn_4yr_trans_yr2_rt float --Percent of dependent students who transferred to a 4-year institution and whose status is unknown within 2 years
dep_unkn_2yr_trans_yr2_rt float --Percent of dependent students who transferred to a 2-year institution and whose status is unknown within 2 years
ind_death_yr2_rt float --Percent of independent students who died within 2 years at original institution
ind_comp_orig_yr2_rt float --Percent of independent students who completed within 2 years at original institution
ind_comp_4yr_trans_yr2_rt float --Percent of independent students who transferred to a 4-year institution and completed within 2 years
ind_comp_2yr_trans_yr2_rt float --Percent of independent students who transferred to a 2-year institution and completed within 2 years
ind_wdraw_orig_yr2_rt float --Percent of independent students withdrawn from original institution within 2 years
ind_wdraw_4yr_trans_yr2_rt float --Percent of independent students who transferred to a 4-year institution and withdrew within 2 years
ind_wdraw_2yr_trans_yr2_rt float --Percent of independent students who transferred to a 2-year institution and withdrew within 2 years
ind_enrl_orig_yr2_rt float --Percent of independent students who were still enrolled at original institution within 2 years
ind_enrl_4yr_trans_yr2_rt float --Percent of independent students who transferred to a 4-year institution and were still enrolled within 2 years
ind_enrl_2yr_trans_yr2_rt float --Percent of independent students who transferred to a 2-year institution and were still enrolled within 2 years
ind_unkn_orig_yr2_rt float --Percent of independent students with status unknown within 2 years at original institution
ind_unkn_4yr_trans_yr2_rt float --Percent of independent students who transferred to a 4-year institution and whose status is unknown within 2 years
ind_unkn_2yr_trans_yr2_rt float --Percent of independent students who transferred to a 2-year institution and whose status is unknown within 2 years
female_death_yr2_rt float --Percent of female students who died within 2 years at original institution
female_comp_orig_yr2_rt float --Percent of female students who completed within 2 years at original institution
female_comp_4yr_trans_yr2_rt float --Percent of female students who transferred to a 4-year institution and completed within 2 years
female_comp_2yr_trans_yr2_rt float --Percent of female students who transferred to a 2-year institution and completed within 2 years
female_wdraw_orig_yr2_rt float --Percent of female students withdrawn from original institution within 2 years
female_wdraw_4yr_trans_yr2_rt float --Percent of female students who transferred to a 4-year institution and withdrew within 2 years
female_wdraw_2yr_trans_yr2_rt float --Percent of female students who transferred to a 2-year institution and withdrew within 2 years
female_enrl_orig_yr2_rt float --Percent of female students who were still enrolled at original institution within 2 years
female_enrl_4yr_trans_yr2_rt float --Percent of female students who transferred to a 4-year institution and were still enrolled within 2 years
female_enrl_2yr_trans_yr2_rt float --Percent of female students who transferred to a 2-year institution and were still enrolled within 2 years
female_unkn_orig_yr2_rt float --Percent of female students with status unknown within 2 years at original institution
female_unkn_4yr_trans_yr2_rt float --Percent of female students who transferred to a 4-year institution and whose status is unknown within 2 years
female_unkn_2yr_trans_yr2_rt float --Percent of female students who transferred to a 2-year institution and whose status is unknown within 2 years
male_death_yr2_rt float --Percent of male students who died within 2 years at original institution
male_comp_orig_yr2_rt float --Percent of male students who completed within 2 years at original institution
male_comp_4yr_trans_yr2_rt float --Percent of male students who transferred to a 4-year institution and completed within 2 years
male_comp_2yr_trans_yr2_rt float --Percent of male students who transferred to a 2-year institution and completed within 2 years
male_wdraw_orig_yr2_rt float --Percent of male students withdrawn from original institution within 2 years
male_wdraw_4yr_trans_yr2_rt float --Percent of male students who transferred to a 4-year institution and withdrew within 2 years
male_wdraw_2yr_trans_yr2_rt float --Percent of male students who transferred to a 2-year institution and withdrew within 2 years
male_enrl_orig_yr2_rt float --Percent of male students who were still enrolled at original institution within 2 years
male_enrl_4yr_trans_yr2_rt float --Percent of male students who transferred to a 4-year institution and were still enrolled within 2 years
male_enrl_2yr_trans_yr2_rt float --Percent of male students who transferred to a 2-year institution and were still enrolled within 2 years
male_unkn_orig_yr2_rt float --Percent of male students with status unknown within 2 years at original institution
male_unkn_4yr_trans_yr2_rt float --Percent of male students who transferred to a 4-year institution and whose status is unknown within 2 years
male_unkn_2yr_trans_yr2_rt float --Percent of male students who transferred to a 2-year institution and whose status is unknown within 2 years
pell_death_yr2_rt float --Percent of students who received a Pell Grant at the institution and who died within 2 years at original institution
pell_comp_orig_yr2_rt float --Percent of students who received a Pell Grant at the institution and who completed in 2 years at original institution
pell_comp_4yr_trans_yr2_rt float --Percent of students who received a Pell Grant at the institution and who transferred to a 4-year institution and completed within 2 years
pell_comp_2yr_trans_yr2_rt float --Percent of students who received a Pell Grant at the institution and who transferred to a 2-year institution and completed within 2 years
pell_wdraw_orig_yr2_rt float --Percent of students who received a Pell Grant at the institution and withdrew from original institution within 2 years
pell_wdraw_4yr_trans_yr2_rt float --Percent of students who received a Pell Grant at the institution and who transferred to a 4-year institution and withdrew within 2 years
pell_wdraw_2yr_trans_yr2_rt float --Percent of students who received a Pell Grant at the institution and who transferred to a 2-year institution and withdrew within 2 years
pell_enrl_orig_yr2_rt float --Percent of students who received a Pell Grant at the institution and who were still enrolled at original institution within 2 years
pell_enrl_4yr_trans_yr2_rt float --Percent of students who received a Pell Grant at the institution and who transferred to a 4-year institution and were still enrolled within 2 years
pell_enrl_2yr_trans_yr2_rt float --Percent of students who received a Pell Grant at the institution and who transferred to a 2-year institution and were still enrolled within 2 years
pell_unkn_orig_yr2_rt float --Percent of students who received a Pell Grant at the institution and with status unknown within 2 years at original institution
pell_unkn_4yr_trans_yr2_rt float --Percent of students who received a Pell Grant at the institution and who transferred to a 4-year institution and whose status is unknown within 2 years
pell_unkn_2yr_trans_yr2_rt float --Percent of students who received a Pell Grant at the institution and who transferred to a 2-year institution and whose status is unknown within 2 years
nopell_death_yr2_rt float --Percent of students who never received a Pell Grant at the institution and who died within 2 years at original institution
nopell_comp_orig_yr2_rt float --Percent of students who never received a Pell Grant at the institution and who completed in 2 years at original institution
nopell_comp_4yr_trans_yr2_rt float --Percent of students who never received a Pell Grant at the institution and who transferred to a 4-year institution and completed within 2 years
nopell_comp_2yr_trans_yr2_rt float --Percent of students who never received a Pell Grant at the institution and who transferred to a 2-year institution and completed within 2 years
nopell_wdraw_orig_yr2_rt float --Percent of students who never received a Pell Grant at the institution and withdrew from original institution within 2 years
nopell_wdraw_4yr_trans_yr2_rt float --Percent of students who never received a Pell Grant at the institution and who transferred to a 4-year institution and withdrew within 2 years
nopell_wdraw_2yr_trans_yr2_rt float --Percent of students who never received a Pell Grant at the institution and who transferred to a 2-year institution and withdrew within 2 years
nopell_enrl_orig_yr2_rt float --Percent of students who never received a Pell Grant at the institution and who were still enrolled at original institution within 2 years
nopell_enrl_4yr_trans_yr2_rt float --Percent of students who never received a Pell Grant at the institution and who transferred to a 4-year institution and were still enrolled within 2 years
nopell_enrl_2yr_trans_yr2_rt float --Percent of students who never received a Pell Grant at the institution and who transferred to a 2-year institution and were still enrolled within 2 years
nopell_unkn_orig_yr2_rt float --Percent of students who never received a Pell Grant at the institution and with status unknown within 2 years at original institution
nopell_unkn_4yr_trans_yr2_rt float --Percent of students who never received a Pell Grant at the institution and who transferred to a 4-year institution and whose status is unknown within 2 years
nopell_unkn_2yr_trans_yr2_rt float --Percent of students who never received a Pell Grant at the institution and who transferred to a 2-year institution and whose status is unknown within 2 years
loan_death_yr2_rt float --Percent of students who received a federal loan at the institution and who died within 2 years at original institution
loan_comp_orig_yr2_rt float --Percent of students who received a federal loan at the institution and who completed in 2 years at original institution
loan_comp_4yr_trans_yr2_rt float --Percent of students who received a federel loan at the institution and who transferred to a 4-year institution and completed within 2 years
loan_comp_2yr_trans_yr2_rt float --Percent of students who received a federal loan at the institution and who transferred to a 2-year institution and completed within 2 years
loan_wdraw_orig_yr2_rt float --Percent of students who received a federal loan at the institution and withdrew from original institution within 2 years
loan_wdraw_4yr_trans_yr2_rt float --Percent of students who received a federal loan at the institution and who transferred to a 4-year institution and withdrew within 2 years
loan_wdraw_2yr_trans_yr2_rt float --Percent of students who received a federal loan at the institution and who transferred to a 2-year institution and withdrew within 2 years
loan_enrl_orig_yr2_rt float --Percent of students who received a federal loan at the institution and who were still enrolled at original institution within 2 years
loan_enrl_4yr_trans_yr2_rt float --Percent of students who received a federal loan at the institution and who transferred to a 4-year institution and were still enrolled within 2 years
loan_enrl_2yr_trans_yr2_rt float --Percent of students who received a federal loan at the institution and who transferred to a 2-year institution and were still enrolled within 2 years
loan_unkn_orig_yr2_rt float --Percent of students who received a federal loan at the institution and with status unknown within 2 years at original institution
loan_unkn_4yr_trans_yr2_rt float --Percent of students who received a federal loan at the institution and who transferred to a 4-year institution and whose status is unknown within 2 years
loan_unkn_2yr_trans_yr2_rt float --Percent of students who received a federal loan at the institution and who transferred to a 2-year institution and whose status is unknown within 2 years
noloan_death_yr2_rt float --Percent of students who never received a federal loan at the institution and who died within 2 years at original institution
noloan_comp_orig_yr2_rt float --Percent of students who never received a federal loan at the institution and who completed in 2 years at original institution
noloan_comp_4yr_trans_yr2_rt float --Percent of students who never received a federal loan at the institution and who transferred to a 4-year institution and completed within 2 years
noloan_comp_2yr_trans_yr2_rt float --Percent of students who never received a federal loan at the institution and who transferred to a 2-year institution and completed within 2 years
noloan_wdraw_orig_yr2_rt float --Percent of students who never received a federal loan at the institution and withdrew from original institution within 2 years
noloan_wdraw_4yr_trans_yr2_rt float --Percent of students who never received a federal loan at the institution and who transferred to a 4-year institution and withdrew within 2 years
noloan_wdraw_2yr_trans_yr2_rt float --Percent of students who never received a federal loan at the institution and who transferred to a 2-year institution and withdrew within 2 years
noloan_enrl_orig_yr2_rt float --Percent of students who never received a federal loan at the institution and who were still enrolled at original institution within 2 years
noloan_enrl_4yr_trans_yr2_rt float --Percent of students who never received a federal loan at the institution and who transferred to a 4-year institution and were still enrolled within 2 years
noloan_enrl_2yr_trans_yr2_rt float --Percent of students who never received a federal loan at the institution and who transferred to a 2-year institution and were still enrolled within 2 years
noloan_unkn_orig_yr2_rt float --Percent of students who never received a federal loan at the institution and with status unknown within 2 years at original institution
noloan_unkn_4yr_trans_yr2_rt float --Percent of students who never received a federal loan at the institution and who transferred to a 4-year institution and whose status is unknown within 2 years
noloan_unkn_2yr_trans_yr2_rt float --Percent of students who never received a federal loan at the institution and who transferred to a 2-year institution and whose status is unknown within 2 years
firstgen_death_yr2_rt float --Percent of first-generation students who died within 2 years at original institution
firstgen_comp_orig_yr2_rt float --Percent of first-generation students who completed within 2 years at original institution
firstgen_comp_4yr_trans_yr2_rt float --Percent of first-generation students who transferred to a 4-year institution and completed within 2 years
firstgen_comp_2yr_trans_yr2_rt float --Percent of first-generation students who transferred to a 2-year institution and completed within 2 years
firstgen_wdraw_orig_yr2_rt float --Percent of first-generation students withdrawn from original institution within 2 years
firstgen_wdraw_4yr_trans_yr2_rt float --Percent of first-generation students who transferred to a 4-year institution and withdrew within 2 years
firstgen_wdraw_2yr_trans_yr2_rt float --Percent of first-generation students who transferred to a 2-year institution and withdrew within 2 years
firstgen_enrl_orig_yr2_rt float --Percent of first-generation students who were still enrolled at original institution within 2 years
firstgen_enrl_4yr_trans_yr2_rt float --Percent of first-generation students who transferred to a 4-year institution and were still enrolled within 2 years
firstgen_enrl_2yr_trans_yr2_rt float --Percent of first-generation students who transferred to a 2-year institution and were still enrolled within 2 years
firstgen_unkn_orig_yr2_rt float --Percent of first-generation students with status unknown within 2 years at original institution
firstgen_unkn_4yr_trans_yr2_rt float --Percent of first-generation students who transferred to a 4-year institution and whose status is unknown within 2 years
firstgen_unkn_2yr_trans_yr2_rt float --Percent of first-generation students who transferred to a 2-year institution and whose status is unknown within 2 years
not1stgen_death_yr2_rt float --Percent of not-first-generation students who died within 2 years at original institution
not1stgen_comp_orig_yr2_rt float --Percent of not-first-generation students who completed within 2 years at original institution
not1stgen_comp_4yr_trans_yr2_rt float --Percent of not-first-generation students who transferred to a 4-year institution and completed within 2 years
not1stgen_comp_2yr_trans_yr2_rt float --Percent of not-first-generation students who transferred to a 2-year institution and completed within 2 years
not1stgen_wdraw_orig_yr2_rt float --Percent of not-first-generation students withdrawn from original institution within 2 years
not1stgen_wdraw_4yr_trans_yr2_rt float --Percent of not-first-generation students who transferred to a 4-year institution and withdrew within 2 years
not1stgen_wdraw_2yr_trans_yr2_rt float --Percent of not-first-generation students who transferred to a 2-year institution and withdrew within 2 years
not1stgen_enrl_orig_yr2_rt float --Percent of not-first-generation students who were still enrolled at original institution within 2 years
not1stgen_enrl_4yr_trans_yr2_rt float --Percent of not-first-generation students who transferred to a 4-year institution and were still enrolled within 2 years
not1stgen_enrl_2yr_trans_yr2_rt float --Percent of not-first-generation students who transferred to a 2-year institution and were still enrolled within 2 years
not1stgen_unkn_orig_yr2_rt float --Percent of not-first-generation students with status unknown within 2 years at original institution
not1stgen_unkn_4yr_trans_yr2_rt float --Percent of not-first-generation students who transferred to a 4-year institution and whose status is unknown within 2 years
not1stgen_unkn_2yr_trans_yr2_rt float --Percent of not-first-generation students who transferred to a 2-year institution and whose status is unknown within 2 years
death_yr3_rt float --Percent died within 3 years at original institution
comp_orig_yr3_rt float --Percent completed within 3 years at original institution
comp_4yr_trans_yr3_rt float --Percent who transferred to a 4-year institution and completed within 3 years
comp_2yr_trans_yr3_rt float --Percent who transferred to a 2-year institution and completed within 3 years
wdraw_orig_yr3_rt float --Percent withdrawn from original institution within 3 years
wdraw_4yr_trans_yr3_rt float --Percent who transferred to a 4-year institution and withdrew within 3 years
wdraw_2yr_trans_yr3_rt float --Percent who transferred to a 2-year institution and withdrew within 3 years
enrl_orig_yr3_rt float --Percent still enrolled at original institution within 3 years
enrl_4yr_trans_yr3_rt float --Percent who transferred to a 4-year institution and were still enrolled within 3 years
enrl_2yr_trans_yr3_rt float --Percent who transferred to a 2-year institution and were still enrolled within 3 years
unkn_orig_yr3_rt float --Percent with status unknown within 3 years at original institution
unkn_4yr_trans_yr3_rt float --Percent who transferred to a 4-year institution and whose status is unknown within 3 years
unkn_2yr_trans_yr3_rt float --Percent who transferred to a 2-year institution and whose status is unknown within 3 years
lo_inc_death_yr3_rt float --Percent of low-income (less than $30,000 in nominal family income) students who died within 3 years at original institution
lo_inc_comp_orig_yr3_rt float --Percent of low-income (less than $30,000 in nominal family income) students who completed within 3 years at original institution
lo_inc_comp_4yr_trans_yr3_rt float --Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 4-year institution and completed within 3 years
lo_inc_comp_2yr_trans_yr3_rt float --Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 2-year institution and completed within 3 years
lo_inc_wdraw_orig_yr3_rt float --Percent of low-income (less than $30,000 in nominal family income) students withdrawn from original institution within 3 years
lo_inc_wdraw_4yr_trans_yr3_rt float --Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 4-year institution and withdrew within 3 years
lo_inc_wdraw_2yr_trans_yr3_rt float --Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 2-year institution and withdrew within 3 years
lo_inc_enrl_orig_yr3_rt float --Percent of low-income (less than $30,000 in nominal family income) students who were still enrolled at original institution within 3 years
lo_inc_enrl_4yr_trans_yr3_rt float --Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 4-year institution and were still enrolled within 3 years
lo_inc_enrl_2yr_trans_yr3_rt float --Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 2-year institution and were still enrolled within 3 years
lo_inc_unkn_orig_yr3_rt float --Percent of low-income (less than $30,000 in nominal family income) students with status unknown within 3 years at original institution
lo_inc_unkn_4yr_trans_yr3_rt float --Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 4-year institution and whose status is unknown within 3 years
lo_inc_unkn_2yr_trans_yr3_rt float --Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 2-year institution and whose status is unknown within 3 years
md_inc_death_yr3_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who died within 3 years at original institution
md_inc_comp_orig_yr3_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who completed within 3 years at original institution
md_inc_comp_4yr_trans_yr3_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to a 4-year institution and completed within 3 years
md_inc_comp_2yr_trans_yr3_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to a 2-year institution and completed within 3 years
md_inc_wdraw_orig_yr3_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students withdrawn from original institution within 3 years
md_inc_wdraw_4yr_trans_yr3_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to a 4-year institution and withdrew within 3 years
md_inc_wdraw_2yr_trans_yr3_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to a 2-year institution and withdrew within 3 years
md_inc_enrl_orig_yr3_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who were still enrolled at original institution within 3 years
md_inc_enrl_4yr_trans_yr3_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to a 4-year institution and were still enrolled within 3 years
md_inc_enrl_2yr_trans_yr3_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to a 2-year institution and were still enrolled within 3 years
md_inc_unkn_orig_yr3_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students with status unknown within 3 years at original institution
md_inc_unkn_4yr_trans_yr3_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to a 4-year institution and whose status is unknown within 3 years
md_inc_unkn_2yr_trans_yr3_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to a 2-year institution and whose status is unknown within 3 years
hi_inc_death_yr3_rt float --Percent of high-income (above $75,000 in nominal family income) students who died within 3 years at original institution
hi_inc_comp_orig_yr3_rt float --Percent of high-income (above $75,000 in nominal family income) students who completed within 3 years at original institution
hi_inc_comp_4yr_trans_yr3_rt float --Percent of high-income (above $75,000 in nominal family income) students who transferred to a 4-year institution and completed within 3 years
hi_inc_comp_2yr_trans_yr3_rt float --Percent of high-income (above $75,000 in nominal family income) students who transferred to a 2-year institution and completed within 3 years
hi_inc_wdraw_orig_yr3_rt float --Percent of high-income (above $75,000 in nominal family income) students withdrawn from original institution within 3 years
hi_inc_wdraw_4yr_trans_yr3_rt float --Percent of high-income (above $75,000 in nominal family income) students who transferred to a 4-year institution and withdrew within 3 years
hi_inc_wdraw_2yr_trans_yr3_rt float --Percent of high-income (above $75,000 in nominal family income) students who transferred to a 2-year institution and withdrew within 3 years
hi_inc_enrl_orig_yr3_rt float --Percent of high-income (above $75,000 in nominal family income) students who were still enrolled at original institution within 3 years
hi_inc_enrl_4yr_trans_yr3_rt float --Percent of high-income (above $75,000 in nominal family income) students who transferred to a 4-year institution and were still enrolled within 3 years
hi_inc_enrl_2yr_trans_yr3_rt float --Percent of high-income (above $75,000 in nominal family income) students who transferred to a 2-year institution and were still enrolled within 3 years
hi_inc_unkn_orig_yr3_rt float --Percent of high-income (above $75,000 in nominal family income) students with status unknown within 3 years at original institution
hi_inc_unkn_4yr_trans_yr3_rt float --Percent of high-income (above $75,000 in nominal family income) students who transferred to a 4-year institution and whose status is unknown within 3 years
hi_inc_unkn_2yr_trans_yr3_rt float --Percent of high-income (above $75,000 in nominal family income) students who transferred to a 2-year institution and whose status is unknown within 3 years
dep_death_yr3_rt float --Percent of dependent students who died within 3 years at original institution
dep_comp_orig_yr3_rt float --Percent of dependent students who completed within 3 years at original institution
dep_comp_4yr_trans_yr3_rt float --Percent of dependent students who transferred to a 4-year institution and completed within 3 years
dep_comp_2yr_trans_yr3_rt float --Percent of dependent students who transferred to a 2-year institution and completed within 3 years
dep_wdraw_orig_yr3_rt float --Percent of dependent students withdrawn from original institution within 3 years
dep_wdraw_4yr_trans_yr3_rt float --Percent of dependent students who transferred to a 4-year institution and withdrew within 3 years
dep_wdraw_2yr_trans_yr3_rt float --Percent of dependent students who transferred to a 2-year institution and withdrew within 3 years
dep_enrl_orig_yr3_rt float --Percent of dependent students who were still enrolled at original institution within 3 years
dep_enrl_4yr_trans_yr3_rt float --Percent of dependent students who transferred to a 4-year institution and were still enrolled within 3 years
dep_enrl_2yr_trans_yr3_rt float --Percent of dependent students who transferred to a 2-year institution and were still enrolled within 3 years
dep_unkn_orig_yr3_rt float --Percent of dependent students with status unknown within 3 years at original institution
dep_unkn_4yr_trans_yr3_rt float --Percent of dependent students who transferred to a 4-year institution and whose status is unknown within 3 years
dep_unkn_2yr_trans_yr3_rt float --Percent of dependent students who transferred to a 2-year institution and whose status is unknown within 3 years
ind_death_yr3_rt float --Percent of independent students who died within 3 years at original institution
ind_comp_orig_yr3_rt float --Percent of independent students who completed within 3 years at original institution
ind_comp_4yr_trans_yr3_rt float --Percent of independent students who transferred to a 4-year institution and completed within 3 years
ind_comp_2yr_trans_yr3_rt float --Percent of independent students who transferred to a 2-year institution and completed within 3 years
ind_wdraw_orig_yr3_rt float --Percent of independent students withdrawn from original institution within 3 years
ind_wdraw_4yr_trans_yr3_rt float --Percent of independent students who transferred to a 4-year institution and withdrew within 3 years
ind_wdraw_2yr_trans_yr3_rt float --Percent of independent students who transferred to a 2-year institution and withdrew within 3 years
ind_enrl_orig_yr3_rt float --Percent of independent students who were still enrolled at original institution within 3 years
ind_enrl_4yr_trans_yr3_rt float --Percent of independent students who transferred to a 4-year institution and were still enrolled within 3 years
ind_enrl_2yr_trans_yr3_rt float --Percent of independent students who transferred to a 2-year institution and were still enrolled within 3 years
ind_unkn_orig_yr3_rt float --Percent of independent students with status unknown within 3 years at original institution
ind_unkn_4yr_trans_yr3_rt float --Percent of independent students who transferred to a 4-year institution and whose status is unknown within 3 years
ind_unkn_2yr_trans_yr3_rt float --Percent of independent students who transferred to a 2-year institution and whose status is unknown within 3 years
female_death_yr3_rt float --Percent of female students who died within 3 years at original institution
female_comp_orig_yr3_rt float --Percent of female students who completed within 3 years at original institution
female_comp_4yr_trans_yr3_rt float --Percent of female students who transferred to a 4-year institution and completed within 3 years
female_comp_2yr_trans_yr3_rt float --Percent of female students who transferred to a 2-year institution and completed within 3 years
female_wdraw_orig_yr3_rt float --Percent of female students withdrawn from original institution within 3 years
female_wdraw_4yr_trans_yr3_rt float --Percent of female students who transferred to a 4-year institution and withdrew within 3 years
female_wdraw_2yr_trans_yr3_rt float --Percent of female students who transferred to a 2-year institution and withdrew within 3 years
female_enrl_orig_yr3_rt float --Percent of female students who were still enrolled at original institution within 3 years
female_enrl_4yr_trans_yr3_rt float --Percent of female students who transferred to a 4-year institution and were still enrolled within 3 years
female_enrl_2yr_trans_yr3_rt float --Percent of female students who transferred to a 2-year institution and were still enrolled within 3 years
female_unkn_orig_yr3_rt float --Percent of female students with status unknown within 3 years at original institution
female_unkn_4yr_trans_yr3_rt float --Percent of female students who transferred to a 4-year institution and whose status is unknown within 3 years
female_unkn_2yr_trans_yr3_rt float --Percent of female students who transferred to a 2-year institution and whose status is unknown within 3 years
male_death_yr3_rt float --Percent of male students who died within 3 years at original institution
male_comp_orig_yr3_rt float --Percent of male students who completed within 3 years at original institution
male_comp_4yr_trans_yr3_rt float --Percent of male students who transferred to a 4-year institution and completed within 3 years
male_comp_2yr_trans_yr3_rt float --Percent of male students who transferred to a 2-year institution and completed within 3 years
male_wdraw_orig_yr3_rt float --Percent of male students withdrawn from original institution within 3 years
male_wdraw_4yr_trans_yr3_rt float --Percent of male students who transferred to a 4-year institution and withdrew within 3 years
male_wdraw_2yr_trans_yr3_rt float --Percent of male students who transferred to a 2-year institution and withdrew within 3 years
male_enrl_orig_yr3_rt float --Percent of male students who were still enrolled at original institution within 3 years
male_enrl_4yr_trans_yr3_rt float --Percent of male students who transferred to a 4-year institution and were still enrolled within 3 years
male_enrl_2yr_trans_yr3_rt float --Percent of male students who transferred to a 2-year institution and were still enrolled within 3 years
male_unkn_orig_yr3_rt float --Percent of male students with status unknown within 3 years at original institution
male_unkn_4yr_trans_yr3_rt float --Percent of male students who transferred to a 4-year institution and whose status is unknown within 3 years
male_unkn_2yr_trans_yr3_rt float --Percent of male students who transferred to a 2-year institution and whose status is unknown within 3 years
pell_death_yr3_rt float --Percent of students who received a Pell Grant at the institution and who died within 3 years at original institution
pell_comp_orig_yr3_rt float --Percent of students who received a Pell Grant at the institution and who completed in 3 years at original institution
pell_comp_4yr_trans_yr3_rt float --Percent of students who received a Pell Grant at the institution and who transferred to a 4-year institution and completed within 3 years
pell_comp_2yr_trans_yr3_rt float --Percent of students who received a Pell Grant at the institution and who transferred to a 2-year institution and completed within 3 years
pell_wdraw_orig_yr3_rt float --Percent of students who received a Pell Grant at the institution and withdrew from original institution within 3 years
pell_wdraw_4yr_trans_yr3_rt float --Percent of students who received a Pell Grant at the institution and who transferred to a 4-year institution and withdrew within 3 years
pell_wdraw_2yr_trans_yr3_rt float --Percent of students who received a Pell Grant at the institution and who transferred to a 2-year institution and withdrew within 3 years
pell_enrl_orig_yr3_rt float --Percent of students who received a Pell Grant at the institution and who were still enrolled at original institution within 3 years
pell_enrl_4yr_trans_yr3_rt float --Percent of students who received a Pell Grant at the institution and who transferred to a 4-year institution and were still enrolled within 3 years
pell_enrl_2yr_trans_yr3_rt float --Percent of students who received a Pell Grant at the institution and who transferred to a 2-year institution and were still enrolled within 3 years
pell_unkn_orig_yr3_rt float --Percent of students who received a Pell Grant at the institution and with status unknown within 3 years at original institution
pell_unkn_4yr_trans_yr3_rt float --Percent of students who received a Pell Grant at the institution and who transferred to a 4-year institution and whose status is unknown within 3 years
pell_unkn_2yr_trans_yr3_rt float --Percent of students who received a Pell Grant at the institution and who transferred to a 2-year institution and whose status is unknown within 3 years
nopell_death_yr3_rt float --Percent of students who never received a Pell Grant at the institution and who died within 3 years at original institution
nopell_comp_orig_yr3_rt float --Percent of students who never received a Pell Grant at the institution and who completed in 3 years at original institution
nopell_comp_4yr_trans_yr3_rt float --Percent of students who never received a Pell Grant at the institution and who transferred to a 4-year institution and completed within 3 years
nopell_comp_2yr_trans_yr3_rt float --Percent of students who never received a Pell Grant at the institution and who transferred to a 2-year institution and completed within 3 years
nopell_wdraw_orig_yr3_rt float --Percent of students who never received a Pell Grant at the institution and withdrew from original institution within 3 years
nopell_wdraw_4yr_trans_yr3_rt float --Percent of students who never received a Pell Grant at the institution and who transferred to a 4-year institution and withdrew within 3 years
nopell_wdraw_2yr_trans_yr3_rt float --Percent of students who never received a Pell Grant at the institution and who transferred to a 2-year institution and withdrew within 3 years
nopell_enrl_orig_yr3_rt float --Percent of students who never received a Pell Grant at the institution and who were still enrolled at original institution within 3 years
nopell_enrl_4yr_trans_yr3_rt float --Percent of students who never received a Pell Grant at the institution and who transferred to a 4-year institution and were still enrolled within 3 years
nopell_enrl_2yr_trans_yr3_rt float --Percent of students who never received a Pell Grant at the institution and who transferred to a 2-year institution and were still enrolled within 3 years
nopell_unkn_orig_yr3_rt float --Percent of students who never received a Pell Grant at the institution and with status unknown within 3 years at original institution
nopell_unkn_4yr_trans_yr3_rt float --Percent of students who never received a Pell Grant at the institution and who transferred to a 4-year institution and whose status is unknown within 3 years
nopell_unkn_2yr_trans_yr3_rt float --Percent of students who never received a Pell Grant at the institution and who transferred to a 2-year institution and whose status is unknown within 3 years
loan_death_yr3_rt float --Percent of students who received a federal loan at the institution and who died within 3 years at original institution
loan_comp_orig_yr3_rt float --Percent of students who received a federal loan at the institution and who completed in 3 years at original institution
loan_comp_4yr_trans_yr3_rt float --Percent of students who received a federal loan at the institution and who transferred to a 4-year institution and completed within 3 years
loan_comp_2yr_trans_yr3_rt float --Percent of students who received a federal loan at the institution and who transferred to a 2-year institution and completed within 3 years
loan_wdraw_orig_yr3_rt float --Percent of students who received a federal loan at the institution and withdrew from original institution within 3 years
loan_wdraw_4yr_trans_yr3_rt float --Percent of students who received a federal loan at the institution and who transferred to a 4-year institution and withdrew within 3 years
loan_wdraw_2yr_trans_yr3_rt float --Percent of students who received a federal loan at the institution and who transferred to a 2-year institution and withdrew within 3 years
loan_enrl_orig_yr3_rt float --Percent of students who received a federal loan at the institution and who were still enrolled at original institution within 3 years
loan_enrl_4yr_trans_yr3_rt float --Percent of students who received a federal loan at the institution and who transferred to a 4-year institution and were still enrolled within 3 years
loan_enrl_2yr_trans_yr3_rt float --Percent of students who received a federal loan at the institution and who transferred to a 2-year institution and were still enrolled within 3 years
loan_unkn_orig_yr3_rt float --Percent of students who received a federal loan at the institution and with status unknown within 3 years at original institution
loan_unkn_4yr_trans_yr3_rt float --Percent of students who received a federal loan at the institution and who transferred to a 4-year institution and whose status is unknown within 3 years
loan_unkn_2yr_trans_yr3_rt float --Percent of students who received a federal loan at the institution and who transferred to a 2-year institution and whose status is unknown within 3 years
noloan_death_yr3_rt float --Percent of students who never received a federal loan at the institution and who died within 3 years at original institution
noloan_comp_orig_yr3_rt float --Percent of students who never received a federal loan at the institution and who completed in 3 years at original institution
noloan_comp_4yr_trans_yr3_rt float --Percent of students who never received a federal loan at the institution and who transferred to a 4-year institution and completed within 3 years
noloan_comp_2yr_trans_yr3_rt float --Percent of students who never received a federal loan at the institution and who transferred to a 2-year institution and completed within 3 years
noloan_wdraw_orig_yr3_rt float --Percent of students who never received a federal loan at the institution and withdrew from original institution within 3 years
noloan_wdraw_4yr_trans_yr3_rt float --Percent of students who never received a federal loan at the institution and who transferred to a 4-year institution and withdrew within 3 years
noloan_wdraw_2yr_trans_yr3_rt float --Percent of students who never received a federal loan at the institution and who transferred to a 2-year institution and withdrew within 3 years
noloan_enrl_orig_yr3_rt float --Percent of students who never received a federal loan at the institution and who were still enrolled at original institution within 3 years
noloan_enrl_4yr_trans_yr3_rt float --Percent of students who never received a federal loan at the institution and who transferred to a 4-year institution and were still enrolled within 3 years
noloan_enrl_2yr_trans_yr3_rt float --Percent of students who never received a federal loan at the institution and who transferred to a 2-year institution and were still enrolled within 3 years
noloan_unkn_orig_yr3_rt float --Percent of students who never received a federal loan at the institution and with status unknown within 3 years at original institution
noloan_unkn_4yr_trans_yr3_rt float --Percent of students who never received a federal loan at the institution and who transferred to a 4-year institution and whose status is unknown within 3 years
noloan_unkn_2yr_trans_yr3_rt float --Percent of students who never received a federal loan at the institution and who transferred to a 2-year institution and whose status is unknown within 3 years
firstgen_death_yr3_rt float --Percent of first-generation students who died within 3 years at original institution
firstgen_comp_orig_yr3_rt float --Percent of first-generation students who completed within 3 years at original institution
firstgen_comp_4yr_trans_yr3_rt float --Percent of first-generation students who transferred to a 4-year institution and completed within 3 years
firstgen_comp_2yr_trans_yr3_rt float --Percent of first-generation students who transferred to a 2-year institution and completed within 3 years
firstgen_wdraw_orig_yr3_rt float --Percent of first-generation students withdrawn from original institution within 3 years
firstgen_wdraw_4yr_trans_yr3_rt float --Percent of first-generation students who transferred to a 4-year institution and withdrew within 3 years
firstgen_wdraw_2yr_trans_yr3_rt float --Percent of first-generation students who transferred to a 2-year institution and withdrew within 3 years
firstgen_enrl_orig_yr3_rt float --Percent of first-generation students who were still enrolled at original institution within 3 years
firstgen_enrl_4yr_trans_yr3_rt float --Percent of first-generation students who transferred to a 4-year institution and were still enrolled within 3 years
firstgen_enrl_2yr_trans_yr3_rt float --Percent of first-generation students who transferred to a 2-year institution and were still enrolled within 3 years
firstgen_unkn_orig_yr3_rt float --Percent of first-generation students with status unknown within 3 years at original institution
firstgen_unkn_4yr_trans_yr3_rt float --Percent of first-generation students who transferred to a 4-year institution and whose status is unknown within 3 years
firstgen_unkn_2yr_trans_yr3_rt float --Percent of first-generation students who transferred to a 2-year institution and whose status is unknown within 3 years
not1stgen_death_yr3_rt float --Percent of not-first-generation students who died within 3 years at original institution
not1stgen_comp_orig_yr3_rt float --Percent of not-first-generation students who completed within 3 years at original institution
not1stgen_comp_4yr_trans_yr3_rt float --Percent of not-first-generation students who transferred to a 4-year institution and completed within 3 years
not1stgen_comp_2yr_trans_yr3_rt float --Percent of not-first-generation students who transferred to a 2-year institution and completed within 3 years
not1stgen_wdraw_orig_yr3_rt float --Percent of not-first-generation students withdrawn from original institution within 3 years
not1stgen_wdraw_4yr_trans_yr3_rt float --Percent of not-first-generation students who transferred to a 4-year institution and withdrew within 3 years
not1stgen_wdraw_2yr_trans_yr3_rt float --Percent of not-first-generation students who transferred to a 2-year institution and withdrew within 3 years
not1stgen_enrl_orig_yr3_rt float --Percent of not-first-generation students who were still enrolled at original institution within 3 years
not1stgen_enrl_4yr_trans_yr3_rt float --Percent of not-first-generation students who transferred to a 4-year institution and were still enrolled within 3 years
not1stgen_enrl_2yr_trans_yr3_rt float --Percent of not-first-generation students who transferred to a 2-year institution and were still enrolled within 3 years
not1stgen_unkn_orig_yr3_rt float --Percent of not-first-generation students with status unknown within 3 years at original institution
not1stgen_unkn_4yr_trans_yr3_rt float --Percent of not-first-generation students who transferred to a 4-year institution and whose status is unknown within 3 years
not1stgen_unkn_2yr_trans_yr3_rt float --Percent of not-first-generation students who transferred to a 2-year institution and whose status is unknown within 3 years
death_yr4_rt float --Percent died within 4 years at original institution
comp_orig_yr4_rt float --Percent completed within 4 years at original institution
comp_4yr_trans_yr4_rt float --Percent who transferred to a 4-year institution and completed within 4 years
comp_2yr_trans_yr4_rt float --Percent who transferred to a 2-year institution and completed within 4 years
wdraw_orig_yr4_rt float --Percent withdrawn from original institution within 4 years
wdraw_4yr_trans_yr4_rt float --Percent who transferred to a 4-year institution and withdrew within 4 years
wdraw_2yr_trans_yr4_rt float --Percent who transferred to a 2-year institution and withdrew within 4 years
enrl_orig_yr4_rt float --Percent still enrolled at original institution within 4 years
enrl_4yr_trans_yr4_rt float --Percent who transferred to a 4-year institution and were still enrolled within 4 years
enrl_2yr_trans_yr4_rt float --Percent who transferred to a 2-year institution and were still enrolled within 4 years
unkn_orig_yr4_rt float --Percent with status unknown within 4 years at original institution
unkn_4yr_trans_yr4_rt float --Percent who transferred to a 4-year institution and whose status is unknown within 4 years
unkn_2yr_trans_yr4_rt float --Percent who transferred to a 2-year institution and whose status is unknown within 4 years
lo_inc_death_yr4_rt float --Percent of low-income (less than $30,000 in nominal family income) students who died within 4 years at original institution
lo_inc_comp_orig_yr4_rt float --Percent of low-income (less than $30,000 in nominal family income) students who completed within 4 years at original institution
lo_inc_comp_4yr_trans_yr4_rt float --Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 4-year institution and completed within 4 years
lo_inc_comp_2yr_trans_yr4_rt float --Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 2-year institution and completed within 4 years
lo_inc_wdraw_orig_yr4_rt float --Percent of low-income (less than $30,000 in nominal family income) students withdrawn from original institution within 4 years
lo_inc_wdraw_4yr_trans_yr4_rt float --Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 4-year institution and withdrew within 4 years
lo_inc_wdraw_2yr_trans_yr4_rt float --Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 2-year institution and withdrew within 4 years
lo_inc_enrl_orig_yr4_rt float --Percent of low-income (less than $30,000 in nominal family income) students who were still enrolled at original institution within 4 years
lo_inc_enrl_4yr_trans_yr4_rt float --Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 4-year institution and were still enrolled within 4 years
lo_inc_enrl_2yr_trans_yr4_rt float --Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 2-year institution and were still enrolled within 4 years
lo_inc_unkn_orig_yr4_rt float --Percent of low-income (less than $30,000 in nominal family income) students with status unknown within 4 years at original institution
lo_inc_unkn_4yr_trans_yr4_rt float --Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 4-year institution and whose status is unknown within 4 years
lo_inc_unkn_2yr_trans_yr4_rt float --Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 2-year institution and whose status is unknown within 4 years
md_inc_death_yr4_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who died within 4 years at original institution
md_inc_comp_orig_yr4_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who completed within 4 years at original institution
md_inc_comp_4yr_trans_yr4_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to a 4-year institution and completed within 4 years
md_inc_comp_2yr_trans_yr4_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to a 2-year institution and completed within 4 years
md_inc_wdraw_orig_yr4_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students withdrawn from original institution within 4 years
md_inc_wdraw_4yr_trans_yr4_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to a 4-year institution and withdrew within 4 years
md_inc_wdraw_2yr_trans_yr4_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to a 2-year institution and withdrew within 4 years
md_inc_enrl_orig_yr4_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who were still enrolled at original institution within 4 years
md_inc_enrl_4yr_trans_yr4_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to a 4-year institution and were still enrolled within 4 years
md_inc_enrl_2yr_trans_yr4_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to a 2-year institution and were still enrolled within 4 years
md_inc_unkn_orig_yr4_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students with status unknown within 4 years at original institution
md_inc_unkn_4yr_trans_yr4_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to a 4-year institution and whose status is unknown within 4 years
md_inc_unkn_2yr_trans_yr4_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to a 2-year institution and whose status is unknown within 4 years
hi_inc_death_yr4_rt float --Percent of high-income (above $75,000 in nominal family income) students who died within 4 years at original institution
hi_inc_comp_orig_yr4_rt float --Percent of high-income (above $75,000 in nominal family income) students who completed within 4 years at original institution
hi_inc_comp_4yr_trans_yr4_rt float --Percent of high-income (above $75,000 in nominal family income) students who transferred to a 4-year institution and completed within 4 years
hi_inc_comp_2yr_trans_yr4_rt float --Percent of high-income (above $75,000 in nominal family income) students who transferred to a 2-year institution and completed within 4 years
hi_inc_wdraw_orig_yr4_rt float --Percent of high-income (above $75,000 in nominal family income) students withdrawn from original institution within 4 years
hi_inc_wdraw_4yr_trans_yr4_rt float --Percent of high-income (above $75,000 in nominal family income) students who transferred to a 4-year institution and withdrew within 4 years
hi_inc_wdraw_2yr_trans_yr4_rt float --Percent of high-income (above $75,000 in nominal family income) students who transferred to a 2-year institution and withdrew within 4 years
hi_inc_enrl_orig_yr4_rt float --Percent of high-income (above $75,000 in nominal family income) students who were still enrolled at original institution within 4 years
hi_inc_enrl_4yr_trans_yr4_rt float --Percent of high-income (above $75,000 in nominal family income) students who transferred to a 4-year institution and were still enrolled within 4 years
hi_inc_enrl_2yr_trans_yr4_rt float --Percent of high-income (above $75,000 in nominal family income) students who transferred to a 2-year institution and were still enrolled within 4 years
hi_inc_unkn_orig_yr4_rt float --Percent of high-income (above $75,000 in nominal family income) students with status unknown within 4 years at original institution
hi_inc_unkn_4yr_trans_yr4_rt float --Percent of high-income (above $75,000 in nominal family income) students who transferred to a 4-year institution and whose status is unknown within 4 years
hi_inc_unkn_2yr_trans_yr4_rt float --Percent of high-income (above $75,000 in nominal family income) students who transferred to a 2-year institution and whose status is unknown within 4 years
dep_death_yr4_rt float --Percent of dependent students who died within 4 years at original institution
dep_comp_orig_yr4_rt float --Percent of dependent students who completed within 4 years at original institution
dep_comp_4yr_trans_yr4_rt float --Percent of dependent students who transferred to a 4-year institution and completed within 4 years
dep_comp_2yr_trans_yr4_rt float --Percent of dependent students who transferred to a 2-year institution and completed within 4 years
dep_wdraw_orig_yr4_rt float --Percent of dependent students withdrawn from original institution within 4 years
dep_wdraw_4yr_trans_yr4_rt float --Percent of dependent students who transferred to a 4-year institution and withdrew within 4 years
dep_wdraw_2yr_trans_yr4_rt float --Percent of dependent students who transferred to a 2-year institution and withdrew within 4 years
dep_enrl_orig_yr4_rt float --Percent of dependent students who were still enrolled at original institution within 4 years
dep_enrl_4yr_trans_yr4_rt float --Percent of dependent students who transferred to a 4-year institution and were still enrolled within 4 years
dep_enrl_2yr_trans_yr4_rt float --Percent of dependent students who transferred to a 2-year institution and were still enrolled within 4 years
dep_unkn_orig_yr4_rt float --Percent of dependent students with status unknown within 4 years at original institution
dep_unkn_4yr_trans_yr4_rt float --Percent of dependent students who transferred to a 4-year institution and whose status is unknown within 4 years
dep_unkn_2yr_trans_yr4_rt float --Percent of dependent students who transferred to a 2-year institution and whose status is unknown within 4 years
ind_death_yr4_rt float --Percent of independent students who died within 4 years at original institution
ind_comp_orig_yr4_rt float --Percent of independent students who completed within 4 years at original institution
ind_comp_4yr_trans_yr4_rt float --Percent of independent students who transferred to a 4-year institution and completed within 4 years
ind_comp_2yr_trans_yr4_rt float --Percent of independent students who transferred to a 2-year institution and completed within 4 years
ind_wdraw_orig_yr4_rt float --Percent of independent students withdrawn from original institution within 4 years
ind_wdraw_4yr_trans_yr4_rt float --Percent of independent students who transferred to a 4-year institution and withdrew within 4 years
ind_wdraw_2yr_trans_yr4_rt float --Percent of independent students who transferred to a 2-year institution and withdrew within 4 years
ind_enrl_orig_yr4_rt float --Percent of independent students who were still enrolled at original institution within 4 years
ind_enrl_4yr_trans_yr4_rt float --Percent of independent students who transferred to a 4-year institution and were still enrolled within 4 years
ind_enrl_2yr_trans_yr4_rt float --Percent of independent students who transferred to a 2-year institution and were still enrolled within 4 years
ind_unkn_orig_yr4_rt float --Percent of independent students with status unknown within 4 years at original institution
ind_unkn_4yr_trans_yr4_rt float --Percent of independent students who transferred to a 4-year institution and whose status is unknown within 4 years
ind_unkn_2yr_trans_yr4_rt float --Percent of independent students who transferred to a 2-year institution and whose status is unknown within 4 years
female_death_yr4_rt float --Percent of female students who died within 4 years at original institution
female_comp_orig_yr4_rt float --Percent of female students who completed within 4 years at original institution
female_comp_4yr_trans_yr4_rt float --Percent of female students who transferred to a 4-year institution and completed within 4 years
female_comp_2yr_trans_yr4_rt float --Percent of female students who transferred to a 2-year institution and completed within 4 years
female_wdraw_orig_yr4_rt float --Percent of female students withdrawn from original institution within 4 years
female_wdraw_4yr_trans_yr4_rt float --Percent of female students who transferred to a 4-year institution and withdrew within 4 years
female_wdraw_2yr_trans_yr4_rt float --Percent of female students who transferred to a 2-year institution and withdrew within 4 years
female_enrl_orig_yr4_rt float --Percent of female students who were still enrolled at original institution within 4 years
female_enrl_4yr_trans_yr4_rt float --Percent of female students who transferred to a 4-year institution and were still enrolled within 4 years
female_enrl_2yr_trans_yr4_rt float --Percent of female students who transferred to a 2-year institution and were still enrolled within 4 years
female_unkn_orig_yr4_rt float --Percent of female students with status unknown within 4 years at original institution
female_unkn_4yr_trans_yr4_rt float --Percent of female students who transferred to a 4-year institution and whose status is unknown within 4 years
female_unkn_2yr_trans_yr4_rt float --Percent of female students who transferred to a 2-year institution and whose status is unknown within 4 years
male_death_yr4_rt float --Percent of male students who died within 4 years at original institution
male_comp_orig_yr4_rt float --Percent of male students who completed within 4 years at original institution
male_comp_4yr_trans_yr4_rt float --Percent of male students who transferred to a 4-year institution and completed within 4 years
male_comp_2yr_trans_yr4_rt float --Percent of male students who transferred to a 2-year institution and completed within 4 years
male_wdraw_orig_yr4_rt float --Percent of male students withdrawn from original institution within 4 years
male_wdraw_4yr_trans_yr4_rt float --Percent of male students who transferred to a 4-year institution and withdrew within 4 years
male_wdraw_2yr_trans_yr4_rt float --Percent of male students who transferred to a 2-year institution and withdrew within 4 years
male_enrl_orig_yr4_rt float --Percent of male students who were still enrolled at original institution within 4 years
male_enrl_4yr_trans_yr4_rt float --Percent of male students who transferred to a 4-year institution and were still enrolled within 4 years
male_enrl_2yr_trans_yr4_rt float --Percent of male students who transferred to a 2-year institution and were still enrolled within 4 years
male_unkn_orig_yr4_rt float --Percent of male students with status unknown within 4 years at original institution
male_unkn_4yr_trans_yr4_rt float --Percent of male students who transferred to a 4-year institution and whose status is unknown within 4 years
male_unkn_2yr_trans_yr4_rt float --Percent of male students who transferred to a 2-year institution and whose status is unknown within 4 years
pell_death_yr4_rt float --Percent of students who received a Pell Grant at the institution and who died within 4 years at original institution
pell_comp_orig_yr4_rt float --Percent of students who received a Pell Grant at the institution and who completed in 4 years at original institution
pell_comp_4yr_trans_yr4_rt float --Percent of students who received a Pell Grant at the institution and who transferred to a 4-year institution and completed within 4 years
pell_comp_2yr_trans_yr4_rt float --Percent of students who received a Pell Grant at the institution and who transferred to a 2-year institution and completed within 4 years
pell_wdraw_orig_yr4_rt float --Percent of students who received a Pell Grant at the institution and withdrew from original institution within 4 years
pell_wdraw_4yr_trans_yr4_rt float --Percent of students who received a Pell Grant at the institution and who transferred to a 4-year institution and withdrew within 4 years
pell_wdraw_2yr_trans_yr4_rt float --Percent of students who received a Pell Grant at the institution and who transferred to a 2-year institution and withdrew within 4 years
pell_enrl_orig_yr4_rt float --Percent of students who received a Pell Grant at the institution and who were still enrolled at original institution within 4 years
pell_enrl_4yr_trans_yr4_rt float --Percent of students who received a Pell Grant at the institution and who transferred to a 4-year institution and were still enrolled within 4 years
pell_enrl_2yr_trans_yr4_rt float --Percent of students who received a Pell Grant at the institution and who transferred to a 2-year institution and were still enrolled within 4 years
pell_unkn_orig_yr4_rt float --Percent of students who received a Pell Grant at the institution and with status unknown within 4 years at original institution
pell_unkn_4yr_trans_yr4_rt float --Percent of students who received a Pell Grant at the institution and who transferred to a 4-year institution and whose status is unknown within 4 years
pell_unkn_2yr_trans_yr4_rt float --Percent of students who received a Pell Grant at the institution and who transferred to a 2-year institution and whose status is unknown within 4 years
nopell_death_yr4_rt float --Percent of students who never received a Pell Grant at the institution and who died within 4 years at original institution
nopell_comp_orig_yr4_rt float --Percent of students who never received a Pell Grant at the institution and who completed in 4 years at original institution
nopell_comp_4yr_trans_yr4_rt float --Percent of students who never received a Pell Grant at the institution and who transferred to a 4-year institution and completed within 4 years
nopell_comp_2yr_trans_yr4_rt float --Percent of students who never received a Pell Grant at the institution and who transferred to a 2-year institution and completed within 4 years
nopell_wdraw_orig_yr4_rt float --Percent of students who never received a Pell Grant at the institution and withdrew from original institution within 4 years
nopell_wdraw_4yr_trans_yr4_rt float --Percent of students who never received a Pell Grant at the institution and who transferred to a 4-year institution and withdrew within 4 years
nopell_wdraw_2yr_trans_yr4_rt float --Percent of students who never received a Pell Grant at the institution and who transferred to a 2-year institution and withdrew within 4 years
nopell_enrl_orig_yr4_rt float --Percent of students who never received a Pell Grant at the institution and who were still enrolled at original institution within 4 years
nopell_enrl_4yr_trans_yr4_rt float --Percent of students who never received a Pell Grant at the institution and who transferred to a 4-year institution and were still enrolled within 4 years
nopell_enrl_2yr_trans_yr4_rt float --Percent of students who never received a Pell Grant at the institution and who transferred to a 2-year institution and were still enrolled within 4 years
nopell_unkn_orig_yr4_rt float --Percent of students who never received a Pell Grant at the institution and with status unknown within 4 years at original institution
nopell_unkn_4yr_trans_yr4_rt float --Percent of students who never received a Pell Grant at the institution and who transferred to a 4-year institution and whose status is unknown within 4 years
nopell_unkn_2yr_trans_yr4_rt float --Percent of students who never received a Pell Grant at the institution and who transferred to a 2-year institution and whose status is unknown within 4 years
loan_death_yr4_rt float --Percent of students who received a federal loan at the institution and who died within 4 years at original institution
loan_comp_orig_yr4_rt float --Percent of students who received a federal loan at the institution and who completed in 4 years at original institution
loan_comp_4yr_trans_yr4_rt float --Percent of students who received a federal loan at the institution and who transferred to a 4-year institution and completed within 4 years
loan_comp_2yr_trans_yr4_rt float --Percent of students who received a federal loan at the institution and who transferred to a 2-year institution and completed within 4 years
loan_wdraw_orig_yr4_rt float --Percent of students who received a federal loan at the institution and withdrew from original institution within 4 years
loan_wdraw_4yr_trans_yr4_rt float --Percent of students who received a federal loan at the institution and who transferred to a 4-year institution and withdrew within 4 years
loan_wdraw_2yr_trans_yr4_rt float --Percent of students who received a federal loan at the institution and who transferred to a 2-year institution and withdrew within 4 years
loan_enrl_orig_yr4_rt float --Percent of students who received a federal loan at the institution and who were still enrolled at original institution within 4 years
loan_enrl_4yr_trans_yr4_rt float --Percent of students who received a federal loan at the institution and who transferred to a 4-year institution and were still enrolled within 4 years
loan_enrl_2yr_trans_yr4_rt float --Percent of students who received a federal loan at the institution and who transferred to a 2-year institution and were still enrolled within 4 years
loan_unkn_orig_yr4_rt float --Percent of students who received a federal loan at the institution and with status unknown within 4 years at original institution
loan_unkn_4yr_trans_yr4_rt float --Percent of students who received a federal loan at the institution and who transferred to a 4-year institution and whose status is unknown within 4 years
loan_unkn_2yr_trans_yr4_rt float --Percent of students who received a federal loan at the institution and who transferred to a 2-year institution and whose status is unknown within 4 years
noloan_death_yr4_rt float --Percent of students who never received a federal loan at the institution and who died within 4 years at original institution
noloan_comp_orig_yr4_rt float --Percent of students who never received a federal loan at the institution and who completed in 4 years at original institution
noloan_comp_4yr_trans_yr4_rt float --Percent of students who never received a federal loan at the institution and who transferred to a 4-year institution and completed within 4 years
noloan_comp_2yr_trans_yr4_rt float --Percent of students who never received a federal loan at the institution and who transferred to a 2-year institution and completed within 4 years
noloan_wdraw_orig_yr4_rt float --Percent of students who never received a federal loan at the institution and withdrew from original institution within 4 years
noloan_wdraw_4yr_trans_yr4_rt float --Percent of students who never received a federal loan at the institution and who transferred to a 4-year institution and withdrew within 4 years
noloan_wdraw_2yr_trans_yr4_rt float --Percent of students who never received a federal loan at the institution and who transferred to a 2-year institution and withdrew within 4 years
noloan_enrl_orig_yr4_rt float --Percent of students who never received a federal loan at the institution and who were still enrolled at original institution within 4 years
noloan_enrl_4yr_trans_yr4_rt float --Percent of students who never received a federal loan at the institution and who transferred to a 4-year institution and were still enrolled within 4 years
noloan_enrl_2yr_trans_yr4_rt float --Percent of students who never received a federal loan at the institution and who transferred to a 2-year institution and were still enrolled within 4 years
noloan_unkn_orig_yr4_rt float --Percent of students who never received a federal loan at the institution and with status unknown within 4 years at original institution
noloan_unkn_4yr_trans_yr4_rt float --Percent of students who never received a federal loan at the institution and who transferred to a 4-year institution and whose status is unknown within 4 years
noloan_unkn_2yr_trans_yr4_rt float --Percent of students who never received a federal loan at the institution and who transferred to a 2-year institution and whose status is unknown within 4 years
firstgen_death_yr4_rt float --Percent of first-generation students who died within 4 years at original institution
firstgen_comp_orig_yr4_rt float --Percent of first-generation students who completed within 4 years at original institution
firstgen_comp_4yr_trans_yr4_rt float --Percent of first-generation students who transferred to a 4-year institution and completed within 4 years
firstgen_comp_2yr_trans_yr4_rt float --Percent of first-generation students who transferred to a 2-year institution and completed within 4 years
firstgen_wdraw_orig_yr4_rt float --Percent of first-generation students withdrawn from original institution within 4 years
firstgen_wdraw_4yr_trans_yr4_rt float --Percent of first-generation students who transferred to a 4-year institution and withdrew within 4 years
firstgen_wdraw_2yr_trans_yr4_rt float --Percent of first-generation students who transferred to a 2-year institution and withdrew within 4 years
firstgen_enrl_orig_yr4_rt float --Percent of first-generation students who were still enrolled at original institution within 4 years
firstgen_enrl_4yr_trans_yr4_rt float --Percent of first-generation students who transferred to a 4-year institution and were still enrolled within 4 years
firstgen_enrl_2yr_trans_yr4_rt float --Percent of first-generation students who transferred to a 2-year institution and were still enrolled within 4 years
firstgen_unkn_orig_yr4_rt float --Percent of first-generation students with status unknown within 4 years at original institution
firstgen_unkn_4yr_trans_yr4_rt float --Percent of first-generation students who transferred to a 4-year institution and whose status is unknown within 4 years
firstgen_unkn_2yr_trans_yr4_rt float --Percent of first-generation students who transferred to a 2-year institution and whose status is unknown within 4 years
not1stgen_death_yr4_rt float --Percent of not-first-generation students who died within 4 years at original institution
not1stgen_comp_orig_yr4_rt float --Percent of not-first-generation students who completed within 4 years at original institution
not1stgen_comp_4yr_trans_yr4_rt float --Percent of not-first-generation students who transferred to a 4-year institution and completed within 4 years
not1stgen_comp_2yr_trans_yr4_rt float --Percent of not-first-generation students who transferred to a 2-year institution and completed within 4 years
not1stgen_wdraw_orig_yr4_rt float --Percent of not-first-generation students withdrawn from original institution within 4 years
not1stgen_wdraw_4yr_trans_yr4_rt float --Percent of not-first-generation students who transferred to a 4-year institution and withdrew within 4 years
not1stgen_wdraw_2yr_trans_yr4_rt float --Percent of not-first-generation students who transferred to a 2-year institution and withdrew within 4 years
not1stgen_enrl_orig_yr4_rt float --Percent of not-first-generation students who were still enrolled at original institution within 4 years
not1stgen_enrl_4yr_trans_yr4_rt float --Percent of not-first-generation students who transferred to a 4-year institution and were still enrolled within 4 years
not1stgen_enrl_2yr_trans_yr4_rt float --Percent of not-first-generation students who transferred to a 2-year institution and were still enrolled within 4 years
not1stgen_unkn_orig_yr4_rt float --Percent of not-first-generation students with status unknown within 4 years at original institution
not1stgen_unkn_4yr_trans_yr4_rt float --Percent of not-first-generation students who transferred to a 4-year institution and whose status is unknown within 4 years
not1stgen_unkn_2yr_trans_yr4_rt float --Percent of not-first-generation students who transferred to a 2-year institution and whose status is unknown within 4 years
death_yr6_rt float --Percent died within 6 years at original institution
comp_orig_yr6_rt float --Percent completed within 6 years at original institution
comp_4yr_trans_yr6_rt float --Percent who transferred to a 4-year institution and completed within 6 years
comp_2yr_trans_yr6_rt float --Percent who transferred to a 2-year institution and completed within 6 years
wdraw_orig_yr6_rt float --Percent withdrawn from original institution within 6 years
wdraw_4yr_trans_yr6_rt float --Percent who transferred to a 4-year institution and withdrew within 6 years
wdraw_2yr_trans_yr6_rt float --Percent who transferred to a 2-year institution and withdrew within 6 years
enrl_orig_yr6_rt float --Percent still enrolled at original institution within 6 years
enrl_4yr_trans_yr6_rt float --Percent who transferred to a 4-year institution and were still enrolled within 6 years
enrl_2yr_trans_yr6_rt float --Percent who transferred to a 2-year institution and were still enrolled within 6 years
unkn_orig_yr6_rt float --Percent with status unknown within 6 years at original institution
unkn_4yr_trans_yr6_rt float --Percent who transferred to a 4-year institution and whose status is unknown within 6 years
unkn_2yr_trans_yr6_rt float --Percent who transferred to a 2-year institution and whose status is unknown within 6 years
lo_inc_death_yr6_rt float --Percent of low-income (less than $30,000 in nominal family income) students who died within 6 years at original institution
lo_inc_comp_orig_yr6_rt float --Percent of low-income (less than $30,000 in nominal family income) students who completed within 6 years at original institution
lo_inc_comp_4yr_trans_yr6_rt float --Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 4-year institution and completed within 6 years
lo_inc_comp_2yr_trans_yr6_rt float --Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 2-year institution and completed within 6 years
lo_inc_wdraw_orig_yr6_rt float --Percent of low-income (less than $30,000 in nominal family income) students withdrawn from original institution within 6 years
lo_inc_wdraw_4yr_trans_yr6_rt float --Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 4-year institution and withdrew within 6 years
lo_inc_wdraw_2yr_trans_yr6_rt float --Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 2-year institution and withdrew within 6 years
lo_inc_enrl_orig_yr6_rt float --Percent of low-income (less than $30,000 in nominal family income) students who were still enrolled at original institution within 6 years
lo_inc_enrl_4yr_trans_yr6_rt float --Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 4-year institution and were still enrolled within 6 years
lo_inc_enrl_2yr_trans_yr6_rt float --Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 2-year institution and were still enrolled within 6 years
lo_inc_unkn_orig_yr6_rt float --Percent of low-income (less than $30,000 in nominal family income) students with status unknown within 6 years at original institution
lo_inc_unkn_4yr_trans_yr6_rt float --Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 4-year institution and whose status is unknown within 6 years
lo_inc_unkn_2yr_trans_yr6_rt float --Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 2-year institution and whose status is unknown within 6 years
md_inc_death_yr6_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who died within 6 years at original institution
md_inc_comp_orig_yr6_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who completed within 6 years at original institution
md_inc_comp_4yr_trans_yr6_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to a 4-year institution and completed within 6 years
md_inc_comp_2yr_trans_yr6_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to a 2-year institution and completed within 6 years
md_inc_wdraw_orig_yr6_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students withdrawn from original institution within 6 years
md_inc_wdraw_4yr_trans_yr6_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to a 4-year institution and withdrew within 6 years
md_inc_wdraw_2yr_trans_yr6_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to a 2-year institution and withdrew within 6 years
md_inc_enrl_orig_yr6_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who were still enrolled at original institution within 6 years
md_inc_enrl_4yr_trans_yr6_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to a 4-year institution and were still enrolled within 6 years
md_inc_enrl_2yr_trans_yr6_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to a 2-year institution and were still enrolled within 6 years
md_inc_unkn_orig_yr6_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students with status unknown within 6 years at original institution
md_inc_unkn_4yr_trans_yr6_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to a 4-year institution and whose status is unknown within 6 years
md_inc_unkn_2yr_trans_yr6_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to a 2-year institution and whose status is unknown within 6 years
hi_inc_death_yr6_rt float --Percent of high-income (above $75,000 in nominal family income) students who died within 6 years at original institution
hi_inc_comp_orig_yr6_rt float --Percent of high-income (above $75,000 in nominal family income) students who completed within 6 years at original institution
hi_inc_comp_4yr_trans_yr6_rt float --Percent of high-income (above $75,000 in nominal family income) students who transferred to a 4-year institution and completed within 6 years
hi_inc_comp_2yr_trans_yr6_rt float --Percent of high-income (above $75,000 in nominal family income) students who transferred to a 2-year institution and completed within 6 years
hi_inc_wdraw_orig_yr6_rt float --Percent of high-income (above $75,000 in nominal family income) students withdrawn from original institution within 6 years
hi_inc_wdraw_4yr_trans_yr6_rt float --Percent of high-income (above $75,000 in nominal family income) students who transferred to a 4-year institution and withdrew within 6 years
hi_inc_wdraw_2yr_trans_yr6_rt float --Percent of high-income (above $75,000 in nominal family income) students who transferred to a 2-year institution and withdrew within 6 years
hi_inc_enrl_orig_yr6_rt float --Percent of high-income (above $75,000 in nominal family income) students who were still enrolled at original institution within 6 years
hi_inc_enrl_4yr_trans_yr6_rt float --Percent of high-income (above $75,000 in nominal family income) students who transferred to a 4-year institution and were still enrolled within 6 years
hi_inc_enrl_2yr_trans_yr6_rt float --Percent of high-income (above $75,000 in nominal family income) students who transferred to a 2-year institution and were still enrolled within 6 years
hi_inc_unkn_orig_yr6_rt float --Percent of high-income (above $75,000 in nominal family income) students with status unknown within 6 years at original institution
hi_inc_unkn_4yr_trans_yr6_rt float --Percent of high-income (above $75,000 in nominal family income) students who transferred to a 4-year institution and whose status is unknown within 6 years
hi_inc_unkn_2yr_trans_yr6_rt float --Percent of high-income (above $75,000 in nominal family income) students who transferred to a 2-year institution and whose status is unknown within 6 years
dep_death_yr6_rt float --Percent of dependent students who died within 6 years at original institution
dep_comp_orig_yr6_rt float --Percent of dependent students who completed within 6 years at original institution
dep_comp_4yr_trans_yr6_rt float --Percent of dependent students who transferred to a 4-year institution and completed within 6 years
dep_comp_2yr_trans_yr6_rt float --Percent of dependent students who transferred to a 2-year institution and completed within 6 years
dep_wdraw_orig_yr6_rt float --Percent of dependent students withdrawn from original institution within 6 years
dep_wdraw_4yr_trans_yr6_rt float --Percent of dependent students who transferred to a 4-year institution and withdrew within 6 years
dep_wdraw_2yr_trans_yr6_rt float --Percent of dependent students who transferred to a 2-year institution and withdrew within 6 years
dep_enrl_orig_yr6_rt float --Percent of dependent students who were still enrolled at original institution within 6 years
dep_enrl_4yr_trans_yr6_rt float --Percent of dependent students who transferred to a 4-year institution and were still enrolled within 6 years
dep_enrl_2yr_trans_yr6_rt float --Percent of dependent students who transferred to a 2-year institution and were still enrolled within 6 years
dep_unkn_orig_yr6_rt float --Percent of dependent students with status unknown within 6 years at original institution
dep_unkn_4yr_trans_yr6_rt float --Percent of dependent students who transferred to a 4-year institution and whose status is unknown within 6 years
dep_unkn_2yr_trans_yr6_rt float --Percent of dependent students who transferred to a 2-year institution and whose status is unknown within 6 years
ind_death_yr6_rt float --Percent of independent students who died within 6 years at original institution
ind_comp_orig_yr6_rt float --Percent of independent students who completed within 6 years at original institution
ind_comp_4yr_trans_yr6_rt float --Percent of independent students who transferred to a 4-year institution and completed within 6 years
ind_comp_2yr_trans_yr6_rt float --Percent of independent students who transferred to a 2-year institution and completed within 6 years
ind_wdraw_orig_yr6_rt float --Percent of independent students withdrawn from original institution within 6 years
ind_wdraw_4yr_trans_yr6_rt float --Percent of independent students who transferred to a 4-year institution and withdrew within 6 years
ind_wdraw_2yr_trans_yr6_rt float --Percent of independent students who transferred to a 2-year institution and withdrew within 6 years
ind_enrl_orig_yr6_rt float --Percent of independent students who were still enrolled at original institution within 6 years
ind_enrl_4yr_trans_yr6_rt float --Percent of independent students who transferred to a 4-year institution and were still enrolled within 6 years
ind_enrl_2yr_trans_yr6_rt float --Percent of independent students who transferred to a 2-year institution and were still enrolled within 6 years
ind_unkn_orig_yr6_rt float --Percent of independent students with status unknown within 6 years at original institution
ind_unkn_4yr_trans_yr6_rt float --Percent of independent students who transferred to a 4-year institution and whose status is unknown within 6 years
ind_unkn_2yr_trans_yr6_rt float --Percent of independent students who transferred to a 2-year institution and whose status is unknown within 6 years
female_death_yr6_rt float --Percent of female students who died within 6 years at original institution
female_comp_orig_yr6_rt float --Percent of female students who completed within 6 years at original institution
female_comp_4yr_trans_yr6_rt float --Percent of female students who transferred to a 4-year institution and completed within 6 years
female_comp_2yr_trans_yr6_rt float --Percent of female students who transferred to a 2-year institution and completed within 6 years
female_wdraw_orig_yr6_rt float --Percent of female students withdrawn from original institution within 6 years
female_wdraw_4yr_trans_yr6_rt float --Percent of female students who transferred to a 4-year institution and withdrew within 6 years
female_wdraw_2yr_trans_yr6_rt float --Percent of female students who transferred to a 2-year institution and withdrew within 6 years
female_enrl_orig_yr6_rt float --Percent of female students who were still enrolled at original institution within 6 years
female_enrl_4yr_trans_yr6_rt float --Percent of female students who transferred to a 4-year institution and were still enrolled within 6 years
female_enrl_2yr_trans_yr6_rt float --Percent of female students who transferred to a 2-year institution and were still enrolled within 6 years
female_unkn_orig_yr6_rt float --Percent of female students with status unknown within 6 years at original institution
female_unkn_4yr_trans_yr6_rt float --Percent of female students who transferred to a 4-year institution and whose status is unknown within 6 years
female_unkn_2yr_trans_yr6_rt float --Percent of female students who transferred to a 2-year institution and whose status is unknown within 6 years
male_death_yr6_rt float --Percent of male students who died within 6 years at original institution
male_comp_orig_yr6_rt float --Percent of male students who completed within 6 years at original institution
male_comp_4yr_trans_yr6_rt float --Percent of male students who transferred to a 4-year institution and completed within 6 years
male_comp_2yr_trans_yr6_rt float --Percent of male students who transferred to a 2-year institution and completed within 6 years
male_wdraw_orig_yr6_rt float --Percent of male students withdrawn from original institution within 6 years
male_wdraw_4yr_trans_yr6_rt float --Percent of male students who transferred to a 4-year institution and withdrew within 6 years
male_wdraw_2yr_trans_yr6_rt float --Percent of male students who transferred to a 2-year institution and withdrew within 6 years
male_enrl_orig_yr6_rt float --Percent of male students who were still enrolled at original institution within 6 years
male_enrl_4yr_trans_yr6_rt float --Percent of male students who transferred to a 4-year institution and were still enrolled within 6 years
male_enrl_2yr_trans_yr6_rt float --Percent of male students who transferred to a 2-year institution and were still enrolled within 6 years
male_unkn_orig_yr6_rt float --Percent of male students with status unknown within 6 years at original institution
male_unkn_4yr_trans_yr6_rt float --Percent of male students who transferred to a 4-year institution and whose status is unknown within 6 years
male_unkn_2yr_trans_yr6_rt float --Percent of male students who transferred to a 2-year institution and whose status is unknown within 6 years
pell_death_yr6_rt float --Percent of students who received a Pell Grant at the institution and who died within 6 years at original institution
pell_comp_orig_yr6_rt float --Percent of students who received a Pell Grant at the institution and who completed in 6 years at original institution
pell_comp_4yr_trans_yr6_rt float --Percent of students who received a Pell Grant at the institution and who transferred to a 4-year institution and completed within 6 years
pell_comp_2yr_trans_yr6_rt float --Percent of students who received a Pell Grant at the institution and who transferred to a 2-year institution and completed within 6 years
pell_wdraw_orig_yr6_rt float --Percent of students who received a Pell Grant at the institution and withdrew from original institution within 6 years
pell_wdraw_4yr_trans_yr6_rt float --Percent of students who received a Pell Grant at the institution and who transferred to a 4-year institution and withdrew within 6 years
pell_wdraw_2yr_trans_yr6_rt float --Percent of students who received a Pell Grant at the institution and who transferred to a 2-year institution and withdrew within 6 years
pell_enrl_orig_yr6_rt float --Percent of students who received a Pell Grant at the institution and who were still enrolled at original institution within 6 years
pell_enrl_4yr_trans_yr6_rt float --Percent of students who received a Pell Grant at the institution and who transferred to a 4-year institution and were still enrolled within 6 years
pell_enrl_2yr_trans_yr6_rt float --Percent of students who received a Pell Grant at the institution and who transferred to a 2-year institution and were still enrolled within 6 years
pell_unkn_orig_yr6_rt float --Percent of students who received a Pell Grant at the institution and with status unknown within 6 years at original institution
pell_unkn_4yr_trans_yr6_rt float --Percent of students who received a Pell Grant at the institution and who transferred to a 4-year institution and whose status is unknown within 6 years
pell_unkn_2yr_trans_yr6_rt float --Percent of students who received a Pell Grant at the institution and who transferred to a 2-year institution and whose status is unknown within 6 years
nopell_death_yr6_rt float --Percent of students who never received a Pell Grant at the institution and who died within 6 years at original institution
nopell_comp_orig_yr6_rt float --Percent of students who never received a Pell Grant at the institution and who completed in 6 years at original institution
nopell_comp_4yr_trans_yr6_rt float --Percent of students who never received a Pell Grant at the institution and who transferred to a 4-year institution and completed within 6 years
nopell_comp_2yr_trans_yr6_rt float --Percent of students who never received a Pell Grant at the institution and who transferred to a 2-year institution and completed within 6 years
nopell_wdraw_orig_yr6_rt float --Percent of students who never received a Pell Grant at the institution and withdrew from original institution within 6 years
nopell_wdraw_4yr_trans_yr6_rt float --Percent of students who never received a Pell Grant at the institution and who transferred to a 4-year institution and withdrew within 6 years
nopell_wdraw_2yr_trans_yr6_rt float --Percent of students who never received a Pell Grant at the institution and who transferred to a 2-year institution and withdrew within 6 years
nopell_enrl_orig_yr6_rt float --Percent of students who never received a Pell Grant at the institution and who were still enrolled at original institution within 6 years
nopell_enrl_4yr_trans_yr6_rt float --Percent of students who never received a Pell Grant at the institution and who transferred to a 4-year institution and were still enrolled within 6 years
nopell_enrl_2yr_trans_yr6_rt float --Percent of students who never received a Pell Grant at the institution and who transferred to a 2-year institution and were still enrolled within 6 years
nopell_unkn_orig_yr6_rt float --Percent of students who never received a Pell Grant at the institution and with status unknown within 6 years at original institution
nopell_unkn_4yr_trans_yr6_rt float --Percent of students who never received a Pell Grant at the institution and who transferred to a 4-year institution and whose status is unknown within 6 years
nopell_unkn_2yr_trans_yr6_rt float --Percent of students who never received a Pell Grant at the institution and who transferred to a 2-year institution and whose status is unknown within 6 years
loan_death_yr6_rt float --Percent of students who received a federal loan at the institution and who died within 6 years at original institution
loan_comp_orig_yr6_rt float --Percent of students who received a federal loan at the institution and who completed in 6 years at original institution
loan_comp_4yr_trans_yr6_rt float --Percent of students who received a federal loan at the institution and who transferred to a 4-year institution and completed within 6 years
loan_comp_2yr_trans_yr6_rt float --Percent of students who received a federal loan at the institution and who transferred to a 2-year institution and completed within 6 years
loan_wdraw_orig_yr6_rt float --Percent of students who received a federal loan at the institution and withdrew from original institution within 6 years
loan_wdraw_4yr_trans_yr6_rt float --Percent of students who received a federal loan at the institution and who transferred to a 4-year institution and withdrew within 6 years
loan_wdraw_2yr_trans_yr6_rt float --Percent of students who received a federal loan at the institution and who transferred to a 2-year institution and withdrew within 6 years
loan_enrl_orig_yr6_rt float --Percent of students who received a federal loan at the institution and who were still enrolled at original institution within 6 years
loan_enrl_4yr_trans_yr6_rt float --Percent of students who received a federal loan at the institution and who transferred to a 4-year institution and were still enrolled within 6 years
loan_enrl_2yr_trans_yr6_rt float --Percent of students who received a federal loan at the institution and who transferred to a 2-year institution and were still enrolled within 6 years
loan_unkn_orig_yr6_rt float --Percent of students who received a federal loan at the institution and with status unknown within 6 years at original institution
loan_unkn_4yr_trans_yr6_rt float --Percent of students who received a federal loan at the institution and who transferred to a 4-year institution and whose status is unknown within 6 years
loan_unkn_2yr_trans_yr6_rt float --Percent of students who received a federal loan at the institution and who transferred to a 2-year institution and whose status is unknown within 6 years
noloan_death_yr6_rt float --Percent of students who never received a federal loan at the institution and who died within 6 years at original institution
noloan_comp_orig_yr6_rt float --Percent of students who never received a federal loan at the institution and who completed in 6 years at original institution
noloan_comp_4yr_trans_yr6_rt float --Percent of students who never received a federal loan at the institution and who transferred to a 4-year institution and completed within 6 years
noloan_comp_2yr_trans_yr6_rt float --Percent of students who never received a federal loan at the institution and who transferred to a 2-year institution and completed within 6 years
noloan_wdraw_orig_yr6_rt float --Percent of students who never received a federal loan at the institution and withdrew from original institution within 6 years
noloan_wdraw_4yr_trans_yr6_rt float --Percent of students who never received a federal loan at the institution and who transferred to a 4-year institution and withdrew within 6 years
noloan_wdraw_2yr_trans_yr6_rt float --Percent of students who never received a federal loan at the institution and who transferred to a 2-year institution and withdrew within 6 years
noloan_enrl_orig_yr6_rt float --Percent of students who never received a federal loan at the institution and who were still enrolled at original institution within 6 years
noloan_enrl_4yr_trans_yr6_rt float --Percent of students who never received a federal loan at the institution and who transferred to a 4-year institution and were still enrolled within 6 years
noloan_enrl_2yr_trans_yr6_rt float --Percent of students who never received a federal loan at the institution and who transferred to a 2-year institution and were still enrolled within 6 years
noloan_unkn_orig_yr6_rt float --Percent of students who never received a federal loan at the institution and with status unknown within 6 years at original institution
noloan_unkn_4yr_trans_yr6_rt float --Percent of students who never received a federal loan at the institution and who transferred to a 4-year institution and whose status is unknown within 6 years
noloan_unkn_2yr_trans_yr6_rt float --Percent of students who never received a federal loan at the institution and who transferred to a 2-year institution and whose status is unknown within 6 years
firstgen_death_yr6_rt float --Percent of first-generation students who died within 6 years at original institution
firstgen_comp_orig_yr6_rt float --Percent of first-generation students who completed within 6 years at original institution
firstgen_comp_4yr_trans_yr6_rt float --Percent of first-generation students who transferred to a 4-year institution and completed within 6 years
firstgen_comp_2yr_trans_yr6_rt float --Percent of first-generation students who transferred to a 2-year institution and completed within 6 years
firstgen_wdraw_orig_yr6_rt float --Percent of first-generation students withdrawn from original institution within 6 years
firstgen_wdraw_4yr_trans_yr6_rt float --Percent of first-generation students who transferred to a 4-year institution and withdrew within 6 years
firstgen_wdraw_2yr_trans_yr6_rt float --Percent of first-generation students who transferred to a 2-year institution and withdrew within 6 years
firstgen_enrl_orig_yr6_rt float --Percent of first-generation students who were still enrolled at original institution within 6 years
firstgen_enrl_4yr_trans_yr6_rt float --Percent of first-generation students who transferred to a 4-year institution and were still enrolled within 6 years
firstgen_enrl_2yr_trans_yr6_rt float --Percent of first-generation students who transferred to a 2-year institution and were still enrolled within 6 years
firstgen_unkn_orig_yr6_rt float --Percent of first-generation students with status unknown within 6 years at original institution
firstgen_unkn_4yr_trans_yr6_rt float --Percent of first-generation students who transferred to a 4-year institution and whose status is unknown within 6 years
firstgen_unkn_2yr_trans_yr6_rt float --Percent of first-generation students who transferred to a 2-year institution and whose status is unknown within 6 years
not1stgen_death_yr6_rt float --Percent of not-first-generation students who died within 6 years at original institution
not1stgen_comp_orig_yr6_rt float --Percent of not-first-generation students who completed within 6 years at original institution
not1stgen_comp_4yr_trans_yr6_rt float --Percent of not-first-generation students who transferred to a 4-year institution and completed within 6 years
not1stgen_comp_2yr_trans_yr6_rt float --Percent of not-first-generation students who transferred to a 2-year institution and completed within 6 years
not1stgen_wdraw_orig_yr6_rt float --Percent of not-first-generation students withdrawn from original institution within 6 years
not1stgen_wdraw_4yr_trans_yr6_rt float --Percent of not-first-generation students who transferred to a 4-year institution and withdrew within 6 years
not1stgen_wdraw_2yr_trans_yr6_rt float --Percent of not-first-generation students who transferred to a 2-year institution and withdrew within 6 years
not1stgen_enrl_orig_yr6_rt float --Percent of not-first-generation students who were still enrolled at original institution within 6 years
not1stgen_enrl_4yr_trans_yr6_rt float --Percent of not-first-generation students who transferred to a 4-year institution and were still enrolled within 6 years
not1stgen_enrl_2yr_trans_yr6_rt float --Percent of not-first-generation students who transferred to a 2-year institution and were still enrolled within 6 years
not1stgen_unkn_orig_yr6_rt float --Percent of not-first-generation students with status unknown within 6 years at original institution
not1stgen_unkn_4yr_trans_yr6_rt float --Percent of not-first-generation students who transferred to a 4-year institution and whose status is unknown within 6 years
not1stgen_unkn_2yr_trans_yr6_rt float --Percent of not-first-generation students who transferred to a 2-year institution and whose status is unknown within 6 years
death_yr8_rt float --Percent died within 8 years at original institution
comp_orig_yr8_rt float --Percent completed within 8 years at original institution
comp_4yr_trans_yr8_rt float --Percent who transferred to a 4-year institution and completed within 8 years
comp_2yr_trans_yr8_rt float --Percent who transferred to a 2-year institution and completed within 8 years
wdraw_orig_yr8_rt float --Percent withdrawn from original institution within 8 years
wdraw_4yr_trans_yr8_rt float --Percent who transferred to a 4-year institution and withdrew within 8 years
wdraw_2yr_trans_yr8_rt float --Percent who transferred to a 2-year institution and withdrew within 8 years
enrl_orig_yr8_rt float --Percent still enrolled at original institution within 8 years
enrl_4yr_trans_yr8_rt float --Percent who transferred to a 4-year institution and were still enrolled within 8 years
enrl_2yr_trans_yr8_rt float --Percent who transferred to a 2-year institution and were still enrolled within 8 years
unkn_orig_yr8_rt float --Percent with status unknown within 8 years at original institution
unkn_4yr_trans_yr8_rt float --Percent who transferred to a 4-year institution and whose status is unknown within 8 years
unkn_2yr_trans_yr8_rt float --Percent who transferred to a 2-year institution and whose status is unknown within 8 years
lo_inc_death_yr8_rt float --Percent of low-income (less than $30,000 in nominal family income) students who died within 8 years at original institution
lo_inc_comp_orig_yr8_rt float --Percent of low-income (less than $30,000 in nominal family income) students who completed within 8 years at original institution
lo_inc_comp_4yr_trans_yr8_rt float --Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 4-year institution and completed within 8 years
lo_inc_comp_2yr_trans_yr8_rt float --Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 2-year institution and completed within 8 years
lo_inc_wdraw_orig_yr8_rt float --Percent of low-income (less than $30,000 in nominal family income) students withdrawn from original institution within 8 years
lo_inc_wdraw_4yr_trans_yr8_rt float --Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 4-year institution and withdrew within 8 years
lo_inc_wdraw_2yr_trans_yr8_rt float --Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 2-year institution and withdrew within 8 years
lo_inc_enrl_orig_yr8_rt float --Percent of low-income (less than $30,000 in nominal family income) students who were still enrolled at original institution within 8 years
lo_inc_enrl_4yr_trans_yr8_rt float --Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 4-year institution and were still enrolled within 8 years
lo_inc_enrl_2yr_trans_yr8_rt float --Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 2-year institution and were still enrolled within 8 years
lo_inc_unkn_orig_yr8_rt float --Percent of low-income (less than $30,000 in nominal family income) students with status unknown within 8 years at original institution
lo_inc_unkn_4yr_trans_yr8_rt float --Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 4-year institution and whose status is unknown within 8 years
lo_inc_unkn_2yr_trans_yr8_rt float --Percent of low-income (less than $30,000 in nominal family income) students who transferred to a 2-year institution and whose status is unknown within 8 years
md_inc_death_yr8_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who died within 8 years at original institution
md_inc_comp_orig_yr8_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who completed within 8 years at original institution
md_inc_comp_4yr_trans_yr8_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to a 4-year institution and completed within 8 years
md_inc_comp_2yr_trans_yr8_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to a 2-year institution and completed within 8 years
md_inc_wdraw_orig_yr8_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students withdrawn from original institution within 8 years
md_inc_wdraw_4yr_trans_yr8_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to a 4-year institution and withdrew within 8 years
md_inc_wdraw_2yr_trans_yr8_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to a 2-year institution and withdrew within 8 years
md_inc_enrl_orig_yr8_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who were still enrolled at original institution within 8 years
md_inc_enrl_4yr_trans_yr8_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to a 4-year institution and were still enrolled within 8 years
md_inc_enrl_2yr_trans_yr8_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to a 2-year institution and were still enrolled within 8 years
md_inc_unkn_orig_yr8_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students with status unknown within 8 years at original institution
md_inc_unkn_4yr_trans_yr8_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to a 4-year institution and whose status is unknown within 8 years
md_inc_unkn_2yr_trans_yr8_rt float --Percent of middle-income (between $30,000 and $75,000 in nominal family income) students who transferred to a 2-year institution and whose status is unknown within 8 years
hi_inc_death_yr8_rt float --Percent of high-income (above $75,000 in nominal family income) students who died within 8 years at original institution
hi_inc_comp_orig_yr8_rt float --Percent of high-income (above $75,000 in nominal family income) students who completed within 8 years at original institution
hi_inc_comp_4yr_trans_yr8_rt float --Percent of high-income (above $75,000 in nominal family income) students who transferred to a 4-year institution and completed within 8 years
hi_inc_comp_2yr_trans_yr8_rt float --Percent of high-income (above $75,000 in nominal family income) students who transferred to a 2-year institution and completed within 8 years
hi_inc_wdraw_orig_yr8_rt float --Percent of high-income (above $75,000 in nominal family income) students withdrawn from original institution within 8 years
hi_inc_wdraw_4yr_trans_yr8_rt float --Percent of high-income (above $75,000 in nominal family income) students who transferred to a 4-year institution and withdrew within 8 years
hi_inc_wdraw_2yr_trans_yr8_rt float --Percent of high-income (above $75,000 in nominal family income) students who transferred to a 2-year institution and withdrew within 8 years
hi_inc_enrl_orig_yr8_rt float --Percent of high-income (above $75,000 in nominal family income) students who were still enrolled at original institution within 8 years
hi_inc_enrl_4yr_trans_yr8_rt float --Percent of high-income (above $75,000 in nominal family income) students who transferred to a 4-year institution and were still enrolled within 8 years
hi_inc_enrl_2yr_trans_yr8_rt float --Percent of high-income (above $75,000 in nominal family income) students who transferred to a 2-year institution and were still enrolled within 8 years
hi_inc_unkn_orig_yr8_rt float --Percent of high-income (above $75,000 in nominal family income) students with status unknown within 8 years at original institution
hi_inc_unkn_4yr_trans_yr8_rt float --Percent of high-income (above $75,000 in nominal family income) students who transferred to a 4-year institution and whose status is unknown within 8 years
hi_inc_unkn_2yr_trans_yr8_rt float --Percent of high-income (above $75,000 in nominal family income) students who transferred to a 2-year institution and whose status is unknown within 8 years
dep_death_yr8_rt float --Percent of dependent students who died within 8 years at original institution
dep_comp_orig_yr8_rt float --Percent of dependent students who completed within 8 years at original institution
dep_comp_4yr_trans_yr8_rt float --Percent of dependent students who transferred to a 4-year institution and completed within 8 years
dep_comp_2yr_trans_yr8_rt float --Percent of dependent students who transferred to a 2-year institution and completed within 8 years
dep_wdraw_orig_yr8_rt float --Percent of dependent students withdrawn from original institution within 8 years
dep_wdraw_4yr_trans_yr8_rt float --Percent of dependent students who transferred to a 4-year institution and withdrew within 8 years
dep_wdraw_2yr_trans_yr8_rt float --Percent of dependent students who transferred to a 2-year institution and withdrew within 8 years
dep_enrl_orig_yr8_rt float --Percent of dependent students who were still enrolled at original institution within 8 years
dep_enrl_4yr_trans_yr8_rt float --Percent of dependent students who transferred to a 4-year institution and were still enrolled within 8 years
dep_enrl_2yr_trans_yr8_rt float --Percent of dependent students who transferred to a 2-year institution and were still enrolled within 8 years
dep_unkn_orig_yr8_rt float --Percent of dependent students with status unknown within 8 years at original institution
dep_unkn_4yr_trans_yr8_rt float --Percent of dependent students who transferred to a 4-year institution and whose status is unknown within 8 years
dep_unkn_2yr_trans_yr8_rt float --Percent of dependent students who transferred to a 2-year institution and whose status is unknown within 8 years
ind_death_yr8_rt float --Percent of independent students who died within 8 years at original institution
ind_comp_orig_yr8_rt float --Percent of independent students who completed within 8 years at original institution
ind_comp_4yr_trans_yr8_rt float --Percent of independent students who transferred to a 4-year institution and completed within 8 years
ind_comp_2yr_trans_yr8_rt float --Percent of independent students who transferred to a 2-year institution and completed within 8 years
ind_wdraw_orig_yr8_rt float --Percent of independent students withdrawn from original institution within 8 years
ind_wdraw_4yr_trans_yr8_rt float --Percent of independent students who transferred to a 4-year institution and withdrew within 8 years
ind_wdraw_2yr_trans_yr8_rt float --Percent of independent students who transferred to a 2-year institution and withdrew within 8 years
ind_enrl_orig_yr8_rt float --Percent of independent students who were still enrolled at original institution within 8 years
ind_enrl_4yr_trans_yr8_rt float --Percent of independent students who transferred to a 4-year institution and were still enrolled within 8 years
ind_enrl_2yr_trans_yr8_rt float --Percent of independent students who transferred to a 2-year institution and were still enrolled within 8 years
ind_unkn_orig_yr8_rt float --Percent of independent students with status unknown within 8 years at original institution
ind_unkn_4yr_trans_yr8_rt float --Percent of independent students who transferred to a 4-year institution and whose status is unknown within 8 years
ind_unkn_2yr_trans_yr8_rt float --Percent of independent students who transferred to a 2-year institution and whose status is unknown within 8 years
female_death_yr8_rt float --Percent of female students who died within 8 years at original institution
female_comp_orig_yr8_rt float --Percent of female students who completed within 8 years at original institution
female_comp_4yr_trans_yr8_rt float --Percent of female students who transferred to a 4-year institution and completed within 8 years
female_comp_2yr_trans_yr8_rt float --Percent of female students who transferred to a 2-year institution and completed within 8 years
female_wdraw_orig_yr8_rt float --Percent of female students withdrawn from original institution within 8 years
female_wdraw_4yr_trans_yr8_rt float --Percent of female students who transferred to a 4-year institution and withdrew within 8 years
female_wdraw_2yr_trans_yr8_rt float --Percent of female students who transferred to a 2-year institution and withdrew within 8 years
female_enrl_orig_yr8_rt float --Percent of female students who were still enrolled at original institution within 8 years
female_enrl_4yr_trans_yr8_rt float --Percent of female students who transferred to a 4-year institution and were still enrolled within 8 years
female_enrl_2yr_trans_yr8_rt float --Percent of female students who transferred to a 2-year institution and were still enrolled within 8 years
female_unkn_orig_yr8_rt float --Percent of female students with status unknown within 8 years at original institution
female_unkn_4yr_trans_yr8_rt float --Percent of female students who transferred to a 4-year institution and whose status is unknown within 8 years
female_unkn_2yr_trans_yr8_rt float --Percent of female students who transferred to a 2-year institution and whose status is unknown within 8 years
male_death_yr8_rt float --Percent of male students who died within 8 years at original institution
male_comp_orig_yr8_rt float --Percent of male students who completed within 8 years at original institution
male_comp_4yr_trans_yr8_rt float --Percent of male students who transferred to a 4-year institution and completed within 8 years
male_comp_2yr_trans_yr8_rt float --Percent of male students who transferred to a 2-year institution and completed within 8 years
male_wdraw_orig_yr8_rt float --Percent of male students withdrawn from original institution within 8 years
male_wdraw_4yr_trans_yr8_rt float --Percent of male students who transferred to a 4-year institution and withdrew within 8 years
male_wdraw_2yr_trans_yr8_rt float --Percent of male students who transferred to a 2-year institution and withdrew within 8 years
male_enrl_orig_yr8_rt float --Percent of male students who were still enrolled at original institution within 8 years
male_enrl_4yr_trans_yr8_rt float --Percent of male students who transferred to a 4-year institution and were still enrolled within 8 years
male_enrl_2yr_trans_yr8_rt float --Percent of male students who transferred to a 2-year institution and were still enrolled within 8 years
male_unkn_orig_yr8_rt float --Percent of male students with status unknown within 8 years at original institution
male_unkn_4yr_trans_yr8_rt float --Percent of male students who transferred to a 4-year institution and whose status is unknown within 8 years
male_unkn_2yr_trans_yr8_rt float --Percent of male students who transferred to a 2-year institution and whose status is unknown within 8 years
pell_death_yr8_rt float --Percent of students who received a Pell Grant at the institution and who died within 8 years at original institution
pell_comp_orig_yr8_rt float --Percent of students who received a Pell Grant at the institution and who completed in 8 years at original institution
pell_comp_4yr_trans_yr8_rt float --Percent of students who received a Pell Grant at the institution and who transferred to a 4-year institution and completed within 8 years
pell_comp_2yr_trans_yr8_rt float --Percent of students who received a Pell Grant at the institution and who transferred to a 2-year institution and completed within 8 years
pell_wdraw_orig_yr8_rt float --Percent of students who received a Pell Grant at the institution and withdrew from original institution within 8 years
pell_wdraw_4yr_trans_yr8_rt float --Percent of students who received a Pell Grant at the institution and who transferred to a 4-year institution and withdrew within 8 years
pell_wdraw_2yr_trans_yr8_rt float --Percent of students who received a Pell Grant at the institution and who transferred to a 2-year institution and withdrew within 8 years
pell_enrl_orig_yr8_rt float --Percent of students who received a Pell Grant at the institution and who were still enrolled at original institution within 8 years
pell_enrl_4yr_trans_yr8_rt float --Percent of students who received a Pell Grant at the institution and who transferred to a 4-year institution and were still enrolled within 8 years
pell_enrl_2yr_trans_yr8_rt float --Percent of students who received a Pell Grant at the institution and who transferred to a 2-year institution and were still enrolled within 8 years
pell_unkn_orig_yr8_rt float --Percent of students who received a Pell Grant at the institution and with status unknown within 8 years at original institution
pell_unkn_4yr_trans_yr8_rt float --Percent of students who received a Pell Grant at the institution and who transferred to a 4-year institution and whose status is unknown within 8 years
pell_unkn_2yr_trans_yr8_rt float --Percent of students who received a Pell Grant at the institution and who transferred to a 2-year institution and whose status is unknown within 8 years
nopell_death_yr8_rt float --Percent of students who never received a Pell Grant at the institution and who died within 8 years at original institution
nopell_comp_orig_yr8_rt float --Percent of students who never received a Pell Grant at the institution and who completed in 8 years at original institution
nopell_comp_4yr_trans_yr8_rt float --Percent of students who never received a Pell Grant at the institution and who transferred to a 4-year institution and completed within 8 years
nopell_comp_2yr_trans_yr8_rt float --Percent of students who never received a Pell Grant at the institution and who transferred to a 2-year institution and completed within 8 years
nopell_wdraw_orig_yr8_rt float --Percent of students who never received a Pell Grant at the institution and withdrew from original institution within 8 years
nopell_wdraw_4yr_trans_yr8_rt float --Percent of students who never received a Pell Grant at the institution and who transferred to a 4-year institution and withdrew within 8 years
nopell_wdraw_2yr_trans_yr8_rt float --Percent of students who never received a Pell Grant at the institution and who transferred to a 2-year institution and withdrew within 8 years
nopell_enrl_orig_yr8_rt float --Percent of students who never received a Pell Grant at the institution and who were still enrolled at original institution within 8 years
nopell_enrl_4yr_trans_yr8_rt float --Percent of students who never received a Pell Grant at the institution and who transferred to a 4-year institution and were still enrolled within 8 years
nopell_enrl_2yr_trans_yr8_rt float --Percent of students who never received a Pell Grant at the institution and who transferred to a 2-year institution and were still enrolled within 8 years
nopell_unkn_orig_yr8_rt float --Percent of students who never received a Pell Grant at the institution and with status unknown within 8 years at original institution
nopell_unkn_4yr_trans_yr8_rt float --Percent of students who never received a Pell Grant at the institution and who transferred to a 4-year institution and whose status is unknown within 8 years
nopell_unkn_2yr_trans_yr8_rt float --Percent of students who never received a Pell Grant at the institution and who transferred to a 2-year institution and whose status is unknown within 8 years
loan_death_yr8_rt float --Percent of students who received a federal loan at the institution and who died within 8 years at original institution
loan_comp_orig_yr8_rt float --Percent of students who received a federal loan at the institution and who completed in 8 years at original institution
loan_comp_4yr_trans_yr8_rt float --Percent of students who received a federal loan at the institution and who transferred to a 4-year institution and completed within 8 years
loan_comp_2yr_trans_yr8_rt float --Percent of students who received a federal loan at the institution and who transferred to a 2-year institution and completed within 8 years
loan_wdraw_orig_yr8_rt float --Percent of students who received a federal loan at the institution and withdrew from original institution within 8 years
loan_wdraw_4yr_trans_yr8_rt float --Percent of students who received a federal loan at the institution and who transferred to a 4-year institution and withdrew within 8 years
loan_wdraw_2yr_trans_yr8_rt float --Percent of students who received a federal loan at the institution and who transferred to a 2-year institution and withdrew within 8 years
loan_enrl_orig_yr8_rt float --Percent of students who received a federal loan at the institution and who were still enrolled at original institution within 8 years
loan_enrl_4yr_trans_yr8_rt float --Percent of students who received a federal loan at the institution and who transferred to a 4-year institution and were still enrolled within 8 years
loan_enrl_2yr_trans_yr8_rt float --Percent of students who received a federal loan at the institution and who transferred to a 2-year institution and were still enrolled within 8 years
loan_unkn_orig_yr8_rt float --Percent of students who received a federal loan at the institution and with status unknown within 8 years at original institution
loan_unkn_4yr_trans_yr8_rt float --Percent of students who received a federal loan at the institution and who transferred to a 4-year institution and whose status is unknown within 8 years
loan_unkn_2yr_trans_yr8_rt float --Percent of students who received a federal loan at the institution and who transferred to a 2-year institution and whose status is unknown within 8 years
noloan_death_yr8_rt float --Percent of students who never received a federal loan at the institution and who died within 8 years at original institution
noloan_comp_orig_yr8_rt float --Percent of students who never received a federal loan at the institution and who completed in 8 years at original institution
noloan_comp_4yr_trans_yr8_rt float --Percent of students who never received a federal loan at the institution and who transferred to a 4-year institution and completed within 8 years
noloan_comp_2yr_trans_yr8_rt float --Percent of students who never received a federal loan at the institution and who transferred to a 2-year institution and completed within 8 years
noloan_wdraw_orig_yr8_rt float --Percent of students who never received a federal loan at the institution and withdrew from original institution within 8 years
noloan_wdraw_4yr_trans_yr8_rt float --Percent of students who never received a federal loan at the institution and who transferred to a 4-year institution and withdrew within 8 years
noloan_wdraw_2yr_trans_yr8_rt float --Percent of students who never received a federal loan at the institution and who transferred to a 2-year institution and withdrew within 8 years
noloan_enrl_orig_yr8_rt float --Percent of students who never received a federal loan at the institution and who were still enrolled at original institution within 8 years
noloan_enrl_4yr_trans_yr8_rt float --Percent of students who never received a federal loan at the institution and who transferred to a 4-year institution and were still enrolled within 8 years
noloan_enrl_2yr_trans_yr8_rt float --Percent of students who never received a federal loan at the institution and who transferred to a 2-year institution and were still enrolled within 8 years
noloan_unkn_orig_yr8_rt float --Percent of students who never received a federal loan at the institution and with status unknown within 8 years at original institution
noloan_unkn_4yr_trans_yr8_rt float --Percent of students who never received a federal loan at the institution and who transferred to a 4-year institution and whose status is unknown within 8 years
noloan_unkn_2yr_trans_yr8_rt float --Percent of students who never received a federal loan at the institution and who transferred to a 2-year institution and whose status is unknown within 8 years
firstgen_death_yr8_rt float --Percent of first-generation students who died within 8 years at original institution
firstgen_comp_orig_yr8_rt float --Percent of first-generation students who completed within 8 years at original institution
firstgen_comp_4yr_trans_yr8_rt float --Percent of first-generation students who transferred to a 4-year institution and completed within 8 years
firstgen_comp_2yr_trans_yr8_rt float --Percent of first-generation students who transferred to a 2-year institution and completed within 8 years
firstgen_wdraw_orig_yr8_rt float --Percent of first-generation students withdrawn from original institution within 8 years
firstgen_wdraw_4yr_trans_yr8_rt float --Percent of first-generation students who transferred to a 4-year institution and withdrew within 8 years
firstgen_wdraw_2yr_trans_yr8_rt float --Percent of first-generation students who transferred to a 2-year institution and withdrew within 8 years
firstgen_enrl_orig_yr8_rt float --Percent of first-generation students who were still enrolled at original institution within 8 years
firstgen_enrl_4yr_trans_yr8_rt float --Percent of first-generation students who transferred to a 4-year institution and were still enrolled within 8 years
firstgen_enrl_2yr_trans_yr8_rt float --Percent of first-generation students who transferred to a 2-year institution and were still enrolled within 8 years
firstgen_unkn_orig_yr8_rt float --Percent of first-generation students with status unknown within 8 years at original institution
firstgen_unkn_4yr_trans_yr8_rt float --Percent of first-generation students who transferred to a 4-year institution and whose status is unknown within 8 years
firstgen_unkn_2yr_trans_yr8_rt float --Percent of first-generation students who transferred to a 2-year institution and whose status is unknown within 8 years
not1stgen_death_yr8_rt float --Percent of not-first-generation students who died within 8 years at original institution
not1stgen_comp_orig_yr8_rt float --Percent of not-first-generation students who completed within 8 years at original institution
not1stgen_comp_4yr_trans_yr8_rt float --Percent of not-first-generation students who transferred to a 4-year institution and completed within 8 years
not1stgen_comp_2yr_trans_yr8_rt float --Percent of not-first-generation students who transferred to a 2-year institution and completed within 8 years
not1stgen_wdraw_orig_yr8_rt float --Percent of not-first-generation students withdrawn from original institution within 8 years
not1stgen_wdraw_4yr_trans_yr8_rt float --Percent of not-first-generation students who transferred to a 4-year institution and withdrew within 8 years
not1stgen_wdraw_2yr_trans_yr8_rt float --Percent of not-first-generation students who transferred to a 2-year institution and withdrew within 8 years
not1stgen_enrl_orig_yr8_rt float --Percent of not-first-generation students who were still enrolled at original institution within 8 years
not1stgen_enrl_4yr_trans_yr8_rt float --Percent of not-first-generation students who transferred to a 4-year institution and were still enrolled within 8 years
not1stgen_enrl_2yr_trans_yr8_rt float --Percent of not-first-generation students who transferred to a 2-year institution and were still enrolled within 8 years
not1stgen_unkn_orig_yr8_rt float --Percent of not-first-generation students with status unknown within 8 years at original institution
not1stgen_unkn_4yr_trans_yr8_rt float --Percent of not-first-generation students who transferred to a 4-year institution and whose status is unknown within 8 years
not1stgen_unkn_2yr_trans_yr8_rt float --Percent of not-first-generation students who transferred to a 2-year institution and whose status is unknown within 8 years
rpy_1yr_rt float --Fraction of repayment cohort who are not in default, and with loan balances that have declined one year since entering repayment, excluding enrolled and military deferment from calculation. (Rolling averages)
compl_rpy_1yr_rt float --One-year repayment rate for completers
noncom_rpy_1yr_rt float --One-year repayment rate for non-completers
lo_inc_rpy_1yr_rt float --One-year repayment rate by family income ($0-30,000)
md_inc_rpy_1yr_rt float --One-year repayment rate by family income ($30,000-75,000)
hi_inc_rpy_1yr_rt float --One-year repayment rate by family income ($75,000+)
dep_rpy_1yr_rt float --One-year repayment rate for dependent students
ind_rpy_1yr_rt float --One-year repayment rate for independent students
pell_rpy_1yr_rt float --One-year repayment rate for students who received a Pell grant while at the school
nopell_rpy_1yr_rt float --One-year repayment rate for students who never received a Pell grant while at school
female_rpy_1yr_rt float --One-year repayment rate for females
male_rpy_1yr_rt float --One-year repayment rate for males
firstgen_rpy_1yr_rt float --One-year repayment rate for first-generation students
notfirstgen_rpy_1yr_rt float --One-year repayment rate for students who are not first-generation
rpy_3yr_rt float --Fraction of repayment cohort who are not in default, and with loan balances that have declined three years since entering repayment, excluding enrolled and military deferment from calculation. (rolling averages)
compl_rpy_3yr_rt float --Three-year repayment rate for completers
noncom_rpy_3yr_rt float --Three-year repayment rate for non-completers
lo_inc_rpy_3yr_rt float --Three-year repayment rate by family income ($0-30,000)
md_inc_rpy_3yr_rt float --Three-year repayment rate by family income ($30,000-75,000)
hi_inc_rpy_3yr_rt float --Three-year repayment rate by family income ($75,000+)
dep_rpy_3yr_rt float --Three-year repayment rate for dependent students
ind_rpy_3yr_rt float --Three-year repayment rate for independent students
pell_rpy_3yr_rt float --Three-year repayment rate for students who received a Pell grant while at the school
nopell_rpy_3yr_rt float --Three-year repayment rate for students who never received a Pell grant while at school
female_rpy_3yr_rt float --Three-year repayment rate for females
male_rpy_3yr_rt float --Three-year repayment rate for males
firstgen_rpy_3yr_rt float --Three-year repayment rate for first-generation students
notfirstgen_rpy_3yr_rt float --Three-year repayment rate for students who are not first-generation
rpy_5yr_rt float --Fraction of repayment cohort who are not in default, and with loan balances that have declined five years since entering repayment, excluding enrolled and military deferment from calculation. (rolling averages)
compl_rpy_5yr_rt float --Five-year repayment rate for completers
noncom_rpy_5yr_rt float --Five-year repayment rate for non-completers
lo_inc_rpy_5yr_rt float --Five-year repayment rate by family income ($0-30,000)
md_inc_rpy_5yr_rt float --Five-year repayment rate by family income ($30,000-75,000)
hi_inc_rpy_5yr_rt float --Five-year repayment rate by family income ($75,000+)
dep_rpy_5yr_rt float --Five-year repayment rate for dependent students
ind_rpy_5yr_rt float --Five-year repayment rate for independent students
pell_rpy_5yr_rt float --Five-year repayment rate for students who received a Pell grant while at the school
nopell_rpy_5yr_rt float --Five-year repayment rate for students who never received a Pell grant while at school
female_rpy_5yr_rt float --Five-year repayment rate for females
male_rpy_5yr_rt float --Five-year repayment rate for males
firstgen_rpy_5yr_rt float --Five-year repayment rate for first-generation students
notfirstgen_rpy_5yr_rt float --Five-year repayment rate for students who are not first-generation
rpy_7yr_rt float --Fraction of repayment cohort who are not in default, and with loan balances that have declined seven years since entering repayment, excluding enrolled and military deferment from calculation. (rolling averages)
compl_rpy_7yr_rt float --Seven-year repayment rate for completers
noncom_rpy_7yr_rt float --Seven-year repayment rate for non-completers
lo_inc_rpy_7yr_rt float --Seven-year repayment rate by family income ($0-30,000)
md_inc_rpy_7yr_rt float --Seven-year repayment rate by family income ($30,000-75,000)
hi_inc_rpy_7yr_rt float --Seven-year repayment rate by family income ($75,000+)
dep_rpy_7yr_rt float --Seven-year repayment rate for dependent students
ind_rpy_7yr_rt float --Seven-year repayment rate for independent students
pell_rpy_7yr_rt float --Seven-year repayment rate for students who received a Pell grant while at the school
nopell_rpy_7yr_rt float --Seven-year repayment rate for students who never received a Pell grant while at school
female_rpy_7yr_rt float --Seven-year repayment rate for females
male_rpy_7yr_rt float --Seven-year repayment rate for males
firstgen_rpy_7yr_rt float --Seven-year repayment rate for first-generation students
notfirstgen_rpy_7yr_rt float --Seven-year repayment rate for students who are not first-generation
inc_pct_lo float --Percentage of aided students whose family income is between $0-$30,000
dep_stat_pct_ind float --Percentage of students who are financially independent
ind_inc_pct_lo float --Percentage of students who are financially independent and have family incomes between $0-30,000
dep_inc_pct_lo float --Percentage of students who are financially dependent and have family incomes between $0-30,000
par_ed_pct_1stgen float --Percentage first-generation students
inc_pct_m1 float --Aided students with family incomes between $30,001-$48,000 in nominal dollars
inc_pct_m2 float --Aided students with family incomes between $48,001-$75,000 in nominal dollars
inc_pct_h1 float --Aided students with family incomes between $75,001-$110,000 in nominal dollars
inc_pct_h2 float --Aided students with family incomes between $110,001+ in nominal dollars
dep_inc_pct_m1 float --Dependent students with family incomes between $30,001-$48,000 in nominal dollars
dep_inc_pct_m2 float --Dependent students with family incomes between $48,001-$75,000 in nominal dollars
dep_inc_pct_h1 float --Dependent students with family incomes between $75,001-$110,000 in nominal dollars
dep_inc_pct_h2 float --Dependent students with family incomes between $110,001+ in nominal dollars
ind_inc_pct_m1 float --Independent students with family incomes between $30,001-$48,000 in nominal dollars
ind_inc_pct_m2 float --Independent students with family incomes between $48,001-$75,000 in nominal dollars
ind_inc_pct_h1 float --Independent students with family incomes between $75,001-$110,000 in nominal dollars
ind_inc_pct_h2 float --Independent students with family incomes between $110,001+ in nominal dollars
par_ed_pct_ms float --Percent of students whose parents' highest educational level is middle school
par_ed_pct_hs float --Percent of students whose parents' highest educational level is high school
par_ed_pct_ps float --Percent of students whose parents' highest educational level was is some form of postsecondary education
appl_sch_pct_ge2 float --Number of applications is greater than or equal to 2
appl_sch_pct_ge3 float --Number of applications is greater than or equal to 3
appl_sch_pct_ge4 float --Number of applications is greater than or equal to 4
appl_sch_pct_ge5 float --Number of applications is greater than or equal to 5
dep_inc_avg integer --Average family income of dependent students in real 2015 dollars.
ind_inc_avg integer --Average family income of independent students in real 2015 dollars.
overall_yr2_n integer --Number of students in overall 2-year completion cohort
lo_inc_yr2_n integer --Number of low-income (less than $30,000 in nominal family income) students in overall 2-year completion cohort
md_inc_yr2_n integer --Number of middle-income (between $30,000 and $75,000 in nominal family income) students in overall 2-year completion cohort
hi_inc_yr2_n integer --Number of high-income (above $75,000 in nominal family income) students in overall 2-year completion cohort
dep_yr2_n integer --Number of dependent students in overall 2-year completion cohort
ind_yr2_n integer --Number of independent students in overall 2-year completion cohort
female_yr2_n integer --Number of female students in overall 2-year completion cohort
male_yr2_n integer --Number of male students in overall 2-year completion cohort
pell_yr2_n integer --Number of Pell students in overall 2-year completion cohort
nopell_yr2_n integer --Number of no-Pell students in overall 2-year completion cohort
loan_yr2_n integer --Number of loan students in overall 2-year completion cohort
noloan_yr2_n integer --Number of no-loan students in overall 2-year completion cohort
firstgen_yr2_n integer --Number of first-generation students in overall 2-year completion cohort
not1stgen_yr2_n integer --Number of not-first-generation students in overall 2-year completion cohort
overall_yr3_n integer --Number of students in overall 3-year completion cohort
lo_inc_yr3_n integer --Number of low-income (less than $30,000 in nominal family income) students in overall 3-year completion cohort
md_inc_yr3_n integer --Number of middle-income (between $30,000 and $75,000 in nominal family income) students in overall 3-year completion cohort
hi_inc_yr3_n integer --Number of high-income (above $75,000 in nominal family income) students in overall 3-year completion cohort
dep_yr3_n integer --Number of dependent students in overall 3-year completion cohort
ind_yr3_n integer --Number of independent students in overall 3-year completion cohort
female_yr3_n integer --Number of female students in overall 3-year completion cohort
male_yr3_n integer --Number of male students in overall 3-year completion cohort
pell_yr3_n integer --Number of Pell students in overall 3-year completion cohort
nopell_yr3_n integer --Number of no-Pell students in overall 3-year completion cohort
loan_yr3_n integer --Number of loan students in overall 3-year completion cohort
noloan_yr3_n integer --Number of no-loan students in overall 3-year completion cohort
firstgen_yr3_n integer --Number of first-generation students in overall 3-year completion cohort
not1stgen_yr3_n integer --Number of not-first-generation students in overall 3-year completion cohort
overall_yr4_n integer --Number of students in overall 4-year completion cohort
lo_inc_yr4_n integer --Number of low-income (less than $30,000 in nominal family income) students in overall 4-year completion cohort
md_inc_yr4_n integer --Number of middle-income (between $30,000 and $75,000 in nominal family income) students in overall 4-year completion cohort
hi_inc_yr4_n integer --Number of high-income (above $75,000 in nominal family income) students in overall 4-year completion cohort
dep_yr4_n integer --Number of dependent students in overall 4-year completion cohort
ind_yr4_n integer --Number of independent students in overall 4-year completion cohort
female_yr4_n integer --Number of female students in overall 4-year completion cohort
male_yr4_n integer --Number of male students in overall 4-year completion cohort
pell_yr4_n integer --Number of Pell students in overall 4-year completion cohort
nopell_yr4_n integer --Number of no-Pell students in overall 4-year completion cohort
loan_yr4_n integer --Number of loan students in overall 4-year completion cohort
noloan_yr4_n integer --Number of no-loan students in overall 4-year completion cohort
firstgen_yr4_n integer --Number of first-generation students in overall 4-year completion cohort
not1stgen_yr4_n integer --Number of not-first-generation students in overall 4-year completion cohort
overall_yr6_n integer --Number of students in overall 6-year completion cohort
lo_inc_yr6_n integer --Number of low-income (less than $30,000 in nominal family income) students in overall 6-year completion cohort
md_inc_yr6_n integer --Number of middle-income (between $30,000 and $75,000 in nominal family income) students in overall 6-year completion cohort
hi_inc_yr6_n integer --Number of high-income (above $75,000 in nominal family income) students in overall 6-year completion cohort
dep_yr6_n integer --Number of dependent students in overall 6-year completion cohort
ind_yr6_n integer --Number of independent students in overall 6-year completion cohort
female_yr6_n integer --Number of female students in overall 6-year completion cohort
male_yr6_n integer --Number of male students in overall 6-year completion cohort
pell_yr6_n integer --Number of Pell students in overall 6-year completion cohort
nopell_yr6_n integer --Number of no-Pell students in overall 6-year completion cohort
loan_yr6_n integer --Number of loan students in overall 6-year completion cohort
noloan_yr6_n integer --Number of no-loan students in overall 6-year completion cohort
firstgen_yr6_n integer --Number of first-generation students in overall 6-year completion cohort
not1stgen_yr6_n integer --Number of not-first-generation students in overall 6-year completion cohort
overall_yr8_n integer --Number of students in overall 8-year completion cohort
lo_inc_yr8_n integer --Number of low-income (less than $30,000 in nominal family income) students in overall 8-year completion cohort
md_inc_yr8_n integer --Number of middle-income (between $30,000 and $75,000 in nominal family income) students in overall 8-year completion cohort
hi_inc_yr8_n integer --Number of high-income (above $75,000 in nominal family income) students in overall 8-year completion cohort
dep_yr8_n integer --Number of dependent students in overall 8-year completion cohort
ind_yr8_n integer --Number of independent students in overall 8-year completion cohort
female_yr8_n integer --Number of female students in overall 8-year completion cohort
male_yr8_n integer --Number of male students in overall 8-year completion cohort
pell_yr8_n integer --Number of Pell students in overall 8-year completion cohort
nopell_yr8_n integer --Number of no-Pell students in overall 8-year completion cohort
loan_yr8_n integer --Number of loan students in overall 8-year completion cohort
noloan_yr8_n integer --Number of no-loan students in overall 8-year completion cohort
firstgen_yr8_n integer --Number of first-generation students in overall 8-year completion cohort
not1stgen_yr8_n integer --Number of not-first-generation students in overall 8-year completion cohort
debt_mdn float --The median original amount of the loan principal upon entering repayment
grad_debt_mdn float --The median debt for students who have completed
wdraw_debt_mdn float --The median debt for students who have not completed
lo_inc_debt_mdn float --The median debt for students with family income between $0-$30,000
md_inc_debt_mdn float --The median debt for students with family income between $30,001-$75,000
hi_inc_debt_mdn float --The median debt for students with family income $75,001+
dep_debt_mdn float --The median debt for dependent students
ind_debt_mdn float --The median debt for independent students
pell_debt_mdn float --The median debt for Pell students
nopell_debt_mdn float --The median debt for no-Pell students
female_debt_mdn float --The median debt for female students
male_debt_mdn float --The median debt for male students
firstgen_debt_mdn float --The median debt for first-generation students
notfirstgen_debt_mdn float --The median debt for not-first-generation students
debt_n integer --The number of students in the median debt cohort
grad_debt_n integer --The number of students in the median debt completers cohort
wdraw_debt_n integer --The number of students in the median debt withdrawn cohort
lo_inc_debt_n integer --The number of students in the median debt low-income (less than or equal to $30,000 in nominal family income) students cohort
md_inc_debt_n integer --The number of students in the median debt middle-income (between $30,000 and $75,000 in nominal family income) students cohort
hi_inc_debt_n integer --The number of students in the median debt high-income (above $75,000 in nominal family income) students cohort
dep_debt_n integer --The number of students in the median debt dependent students cohort
ind_debt_n integer --The number of students in the median debt independent students cohort
pell_debt_n integer --The number of students in the median debt Pell students cohort
nopell_debt_n integer --The number of students in the median debt no-Pell students cohort
female_debt_n integer --The number of students in the median debt female students cohort
male_debt_n integer --The number of students in the median debt male students cohort
firstgen_debt_n integer --The number of students in the median debt first-generation students cohort
notfirstgen_debt_n integer --The number of students in the median debt not-first-generation students cohort
grad_debt_mdn10yr float --Median loan debt of completers in monthly payments (10-year amortization plan)
cuml_debt_n integer --Number of students in the cumulative loan debt cohort
cuml_debt_p90 integer --Cumulative loan debt at the 90th percentile
cuml_debt_p75 integer --Cumulative loan debt at the 75th percentile
cuml_debt_p25 integer --Cumulative loan debt at the 25th percentile
cuml_debt_p10 integer --Cumulative loan debt at the 10th percentile
inc_n integer --Number of students in the family income cohort
dep_inc_n integer --Number of students in the family income dependent students cohort
ind_inc_n integer --Number of students in the family income independent students cohort
dep_stat_n integer --Number of students in the disaggregation with valid dependency status
par_ed_n integer --Number of students in the parents' education level cohort
appl_sch_n integer --Number of students in the FAFSA applications cohort
repay_dt_mdn string --Median Date Student Enters Repayment
separ_dt_mdn string --Median Date Student Separated
repay_dt_n integer --Number of students in the cohort for date students enter repayment
separ_dt_n integer --Number of students in the cohort for date students separated from the school
rpy_1yr_n integer --Number of students in the 1-year repayment rate cohort
compl_rpy_1yr_n integer --Number of students in the 1-year repayment rate of completers cohort
noncom_rpy_1yr_n integer --Number of students in the 1-year repayment rate of non-completers cohort
lo_inc_rpy_1yr_n integer --Number of students in the 1-year repayment rate of low-income (less than $30,000 in nominal family income) students cohort
md_inc_rpy_1yr_n integer --Number of students in the 1-year repayment rate of middle-income (between $30,000 and $75,000 in nominal family income) students cohort
hi_inc_rpy_1yr_n integer --Number of students in the 1-year repayment rate of high-income (above $75,000 in nominal family income) students cohort
dep_rpy_1yr_n integer --Number of students in the 1-year repayment rate of dependent students cohort
ind_rpy_1yr_n integer --Number of students in the 1-year repayment rate of independent students cohort
pell_rpy_1yr_n integer --Number of students in the 1-year repayment rate of Pell students cohort
nopell_rpy_1yr_n integer --Number of students in the 1-year repayment rate of no-Pell students cohort
female_rpy_1yr_n integer --Number of students in the 1-year repayment rate of female students cohort
male_rpy_1yr_n integer --Number of students in the 1-year repayment rate of male students cohort
firstgen_rpy_1yr_n integer --Number of students in the 1-year repayment rate of first-generation students cohort
notfirstgen_rpy_1yr_n integer --Number of students in the 1-year repayment rate of not-first-generation students cohort
rpy_3yr_n integer --Number of students in the 3-year repayment rate cohort
compl_rpy_3yr_n integer --Number of students in the 3-year repayment rate of completers cohort
noncom_rpy_3yr_n integer --Number of students in the 3-year repayment rate of non-completers cohort
lo_inc_rpy_3yr_n integer --Number of students in the 3-year repayment rate of low-income (less than $30,000 in nominal family income) students cohort
md_inc_rpy_3yr_n integer --Number of students in the 3-year repayment rate of middle-income (between $30,000 and $75,000 in nominal family income) students cohort
hi_inc_rpy_3yr_n integer --Number of students in the 3-year repayment rate of high-income (above $75,000 in nominal family income) students cohort
dep_rpy_3yr_n integer --Number of students in the 3-year repayment rate of dependent students cohort
ind_rpy_3yr_n integer --Number of students in the 3-year repayment rate of independent students cohort
pell_rpy_3yr_n integer --Number of students in the 3-year repayment rate of Pell students cohort
nopell_rpy_3yr_n integer --Number of students in the 3-year repayment rate of no-Pell students cohort
female_rpy_3yr_n integer --Number of students in the 3-year repayment rate of female students cohort
male_rpy_3yr_n integer --Number of students in the 3-year repayment rate of male students cohort
firstgen_rpy_3yr_n integer --Number of students in the 3-year repayment rate of first-generation students cohort
notfirstgen_rpy_3yr_n integer --Number of students in the 3-year repayment rate of not-first-generation students cohort
rpy_5yr_n integer --Number of students in the 5-year repayment rate cohort
compl_rpy_5yr_n integer --Number of students in the 5-year repayment rate of completers cohort
noncom_rpy_5yr_n integer --Number of students in the 5-year repayment rate of non-completers cohort
lo_inc_rpy_5yr_n integer --Number of students in the 5-year repayment rate of low-income (less than $30,000 in nominal family income) students cohort
md_inc_rpy_5yr_n integer --Number of students in the 5-year repayment rate of middle-income (between $30,000 and $75,000 in nominal family income) students cohort
hi_inc_rpy_5yr_n integer --Number of students in the 5-year repayment rate of high-income (above $75,000 in nominal family income) students cohort
dep_rpy_5yr_n integer --Number of students in the 5-year repayment rate of dependent students cohort
ind_rpy_5yr_n integer --Number of students in the 5-year repayment rate of independent students cohort
pell_rpy_5yr_n integer --Number of students in the 5-year repayment rate of Pell students cohort
nopell_rpy_5yr_n integer --Number of students in the 5-year repayment rate of no-Pell students cohort
female_rpy_5yr_n integer --Number of students in the 5-year repayment rate of female students cohort
male_rpy_5yr_n integer --Number of students in the 5-year repayment rate of male students cohort
firstgen_rpy_5yr_n integer --Number of students in the 5-year repayment rate of first-generation students cohort
notfirstgen_rpy_5yr_n integer --Number of students in the 5-year repayment rate of not-first-generation students cohort
rpy_7yr_n integer --Number of students in the 7-year repayment rate cohort
compl_rpy_7yr_n integer --Number of students in the 7-year repayment rate of completers cohort
noncom_rpy_7yr_n integer --Number of students in the 7-year repayment rate of non-completers cohort
lo_inc_rpy_7yr_n integer --Number of students in the 7-year repayment rate of low-income (less than $30,000 in nominal family income) students cohort
md_inc_rpy_7yr_n integer --Number of students in the 7-year repayment rate of middle-income (between $30,000 and $75,000 in nominal family income) students cohort
hi_inc_rpy_7yr_n integer --Number of students in the 7-year repayment rate of high-income (above $75,000 in nominal family income) students cohort
dep_rpy_7yr_n integer --Number of students in the 7-year repayment rate of dependent students cohort
ind_rpy_7yr_n integer --Number of students in the 7-year repayment rate of independent students cohort
pell_rpy_7yr_n integer --Number of students in the 7-year repayment rate of Pell students cohort
nopell_rpy_7yr_n integer --Number of students in the 7-year repayment rate of no-Pell students cohort
female_rpy_7yr_n integer --Number of students in the 7-year repayment rate of female students cohort
male_rpy_7yr_n integer --Number of students in the 7-year repayment rate of male students cohort
firstgen_rpy_7yr_n integer --Number of students in the 7-year repayment rate of first-generation students cohort
notfirstgen_rpy_7yr_n integer --Number of students in the 7-year repayment rate of not-first-generation students cohort
count_ed integer --Count of students in the earnings cohort
loan_ever float --Share of students who received a federal loan while in school
pell_ever float --Share of students who received a Pell Grant while in school
age_entry integer --Average age of entry
age_entry_sq integer --Average of the age of entry squared
agege24 float --Percent of students over 23 at entry
female float --Share of female students
married float --Share of married students
dependent float --Share of dependent students
veteran float --Share of veteran students
first_gen float --Share of first-generation students
faminc integer --Average family income
md_faminc integer --Median family income
faminc_ind integer --Average family income for independent students 
lnfaminc integer --Average of the log of family income
lnfaminc_ind integer --Average of the log of family income for independent students
pct_white float --Percent of the population from students' zip codes that is White, via Census data
pct_black float --Percent of the population from students' zip codes that is Black, via Census data
pct_asian float --Percent of the population from students' zip codes that is Asian, via Census data
pct_hispanic float --Percent of the population from students' zip codes that is Hispanic, via Census data
pct_ba float --Percent of the population from students' zip codes with a bachelor's degree over the age 25, via Census data
pct_grad_prof float --Percent of the population from students' zip codes over 25 with a professional degree, via Census data
pct_born_us float --Percent of the population from students' zip codes that was born in the US, via Census data
median_hh_inc integer --Median household income
poverty_rate float --Poverty rate, via Census data
unemp_rate float --Unemployment rate, via Census data
ln_median_hh_inc integer --Log of the median household income
fsend_count integer --Average number of students who sent their FAFSA reports to at least one college
fsend_1 float --Share of students who submitted FAFSAs to only one college
fsend_2 float --Share of students who submitted FAFSAs to two colleges
fsend_3 float --Share of students who submitted FAFSAs to three colleges
fsend_4 float --Share of students who submitted FAFSAs to four colleges
fsend_5 float --Share of students who submitted FAFSAs to at least five colleges
count_nwne_p10 integer --Number of students not working and not enrolled 10 years after entry
count_wne_p10 integer --Number of students working and not enrolled 10 years after entry
mn_earn_wne_p10 integer --Mean earnings of students working and not enrolled 10 years after entry
md_earn_wne_p10 integer --Median earnings of students working and not enrolled 10 years after entry
pct10_earn_wne_p10 integer --10th percentile of earnings of students working and not enrolled 10 years after entry
pct25_earn_wne_p10 integer --25th percentile of earnings of students working and not enrolled 10 years after entry
pct75_earn_wne_p10 integer --75th percentile of earnings of students working and not enrolled 10 years after entry
pct90_earn_wne_p10 integer --90th percentile of earnings of students working and not enrolled 10 years after entry
sd_earn_wne_p10 integer --Standard deviation of earnings of students working and not enrolled 10 years after entry
count_wne_inc1_p10 integer --Number of students working and not enrolled 10 years after entry in the lowest income tercile $0-$30,000
count_wne_inc2_p10 integer --Number of students working and not enrolled 10 years after entry in the middle income tercile $30,001-$75,000
count_wne_inc3_p10 integer --Number of students working and not enrolled 10 years after entry in the highest income tercile $75,001+ 
count_wne_indep0_inc1_p10 integer --Number of dependent students working and not enrolled 10 years after entry in the lowest income tercile $0-$30,000 
count_wne_indep0_p10 integer --Number of dependent students working and not enrolled 10 years after entry
count_wne_indep1_p10 integer --Number of independent students working and not enrolled 10 years after entry
count_wne_male0_p10 integer --Number of female students working and not enrolled 10 years after entry
count_wne_male1_p10 integer --Number of male students working and not enrolled 10 years after entry
gt_25k_p10 float --Share of students earning over $25,000/year (threshold earnings) 10 years after entry
gt_28k_p10 float --Share of students earning over $28,000/year (threshold earnings) 10 years after entry
mn_earn_wne_inc1_p10 integer --Mean earnings of students working and not enrolled 10 years after entry in the lowest income tercile $0-$30,000
mn_earn_wne_inc2_p10 integer --Mean earnings of students working and not enrolled 10 years after entry in the middle income tercile $30,001-$75,000
mn_earn_wne_inc3_p10 integer --Mean earnings of students working and not enrolled 10 years after entry in the highest income tercile $75,001+ 
mn_earn_wne_indep0_inc1_p10 integer --Mean earnings of dependent students working and not enrolled 10 years after entry in the lowest income tercile $0-$30,000
mn_earn_wne_indep0_p10 integer --Mean earnings of dependent students working and not enrolled 10 years after entry
mn_earn_wne_indep1_p10 integer --Mean earnings of independent students working and not enrolled 10 years after entry
mn_earn_wne_male0_p10 integer --Mean earnings of female students working and not enrolled 10 years after entry
mn_earn_wne_male1_p10 integer --Mean earnings of male students working and not enrolled 10 years after entry
count_nwne_p6 integer --Number of students not working and not enrolled 6 years after entry
count_wne_p6 integer --Number of students working and not enrolled 6 years after entry
mn_earn_wne_p6 integer --Mean earnings of students working and not enrolled 6 years after entry
md_earn_wne_p6 integer --Median earnings of students working and not enrolled 6 years after entry
pct10_earn_wne_p6 integer --10th percentile of earnings of students working and not enrolled 6 years after entry
pct25_earn_wne_p6 integer --25th percentile of earnings of students working and not enrolled 6 years after entry
pct75_earn_wne_p6 integer --75th percentile of earnings of students working and not enrolled 6 years after entry
pct90_earn_wne_p6 integer --90th percentile of earnings of students working and not enrolled 6 years after entry
sd_earn_wne_p6 integer --Standard deviation of earnings of students working and not enrolled 6 years after entry
count_wne_inc1_p6 integer --Number of students working and not enrolled 6 years after entry in the lowest income tercile $0-$30,000
count_wne_inc2_p6 integer --Number of students working and not enrolled 6 years after entry in the middle income tercile $30,001-$75,000
count_wne_inc3_p6 integer --Number of students working and not enrolled 6 years after entry in the highest income tercile $75,001+ 
count_wne_indep0_inc1_p6 integer --Number of dependent students working and not enrolled 6 years after entry in the lowest income tercile $0-$30,000
count_wne_indep0_p6 integer --Number of dependent students working and not enrolled 6 years after entry
count_wne_indep1_p6 integer --Number of independent students working and not enrolled 6 years after entry
count_wne_male0_p6 integer --Number of female students working and not enrolled 6 years after entry
count_wne_male1_p6 integer --Number of male students working and not enrolled 6 years after entry
gt_25k_p6 float --Share of students earning over $25,000/year (threshold earnings) 6 years after entry
gt_28k_p6 float --Share of students earning over $28,000/year (threshold earnings) 6 years after entry
mn_earn_wne_inc1_p6 float --Mean earnings of students working and not enrolled 6 years after entry in the lowest income tercile $0-$30,000
mn_earn_wne_inc2_p6 float --Mean earnings of students working and not enrolled 6 years after entry in the middle income tercile $30,001-$75,000
mn_earn_wne_inc3_p6 float --Mean earnings of students working and not enrolled 6 years after entry in the highest income tercile $75,001+ 
mn_earn_wne_indep0_inc1_p6 float --Mean earnings of dependent students working and not enrolled 6 years after entry in the lowest income tercile $0-$30,000
mn_earn_wne_indep0_p6 float --Mean earnings of dependent students working and not enrolled 6 years after entry
mn_earn_wne_indep1_p6 float --Mean earnings of independent students working and not enrolled 6 years after entry
mn_earn_wne_male0_p6 float --Mean earnings of female students working and not enrolled 6 years after entry
mn_earn_wne_male1_p6 float --Mean earnings of male students working and not enrolled 6 years after entry
count_nwne_p7 float --Number of students not working and not enrolled 7 years after entry
count_wne_p7 integer --Number of students working and not enrolled 7 years after entry
mn_earn_wne_p7 float --Mean earnings of students working and not enrolled 7 years after entry
sd_earn_wne_p7 float --Standard deviation of earnings of students working and not enrolled 7 years after entry
gt_25k_p7 float --Share of students earning over $25,000/year (threshold earnings) 7 years after entry
count_nwne_p8 integer --Number of students not working and not enrolled 8 years after entry
count_wne_p8 integer --Number of students working and not enrolled 8 years after entry
mn_earn_wne_p8 float --Mean earnings of students working and not enrolled 8 years after entry
md_earn_wne_p8 float --Median earnings of students working and not enrolled 8 years after entry
pct10_earn_wne_p8 integer --10th percentile of earnings of students working and not enrolled 8 years after entry
pct25_earn_wne_p8 integer --25th percentile of earnings of students working and not enrolled 8 years after entry
pct75_earn_wne_p8 integer --75th percentile of earnings of students working and not enrolled 8 years after entry
pct90_earn_wne_p8 integer --90th percentile of earnings of students working and not enrolled 8 years after entry
sd_earn_wne_p8 float --Standard deviation of earnings of students working and not enrolled 8 years after entry
gt_25k_p8 float --Share of students earning over $25,000/year (threshold earnings) 8 years after entry
gt_28k_p8 float --Share of students earning over $28,000/year (threshold earnings) 8 years after entry
count_nwne_p9 integer --Number of students not working and not enrolled 9 years after entry
count_wne_p9 integer --Number of students working and not enrolled 9 years after entry
mn_earn_wne_p9 float --Mean earnings of students working and not enrolled 9 years after entry
sd_earn_wne_p9 float --Standard deviation of earnings of students working and not enrolled 9 years after entry
gt_25k_p9 float --Share of students earning over $25,000/year (threshold earnings) 9 years after entry
debt_mdn_supp float --Median debt, suppressed for n=30
grad_debt_mdn_supp float --Median debt of completers, suppressed for n=30
grad_debt_mdn10yr_supp float --Median debt of completers expressed in 10-year monthly payments, suppressed for n=30
rpy_3yr_rt_supp float --3-year repayment rate, suppressed for n=30
lo_inc_rpy_3yr_rt_supp float --3-year repayment rate for low-income (less than $30,000 in nominal family income) students, suppressed for n=30
md_inc_rpy_3yr_rt_supp float --3-year repayment rate for middle-income (between $30,000 and $75,000 in nominal family income) students, suppressed for n=30
hi_inc_rpy_3yr_rt_supp float --3-year repayment rate for high-income (above $75,000 in nominal family income) students, suppressed for n=30
compl_rpy_3yr_rt_supp float --3-year repayment rate for completers, suppressed for n=30
noncom_rpy_3yr_rt_supp float --3-year repayment rate for non-completers, suppressed for n=30
dep_rpy_3yr_rt_supp float --3-year repayment rate for dependent students, suppressed for n=30
ind_rpy_3yr_rt_supp float --3-year repayment rate for independent students, suppressed for n=30
pell_rpy_3yr_rt_supp float --3-year repayment rate for Pell students, suppressed for n=30
nopell_rpy_3yr_rt_supp float --3-year repayment rate for no-Pell students, suppressed for n=30
female_rpy_3yr_rt_supp float --3-year repayment rate for female students, suppressed for n=30
male_rpy_3yr_rt_supp float --3-year repayment rate for male students, suppressed for n=30
firstgen_rpy_3yr_rt_supp float --3-year repayment rate for first-generation students, suppressed for n=30
notfirstgen_rpy_3yr_rt_supp float --3-year repayment rate for non-first-generation students, suppressed for n=30
c150_l4_pooled_supp float --Completion rate for first-time, full-time students at less-than-four-year institutions (150% of expected time to completion) , pooled in two-year rolling averages and suppressed for small n size
c150_4_pooled_supp float --Completion rate for first-time, full-time students at four-year institutions (150% of expected time to completion) , pooled in two-year rolling averages and suppressed for small n size.
c200_l4_pooled_supp float --Completion rate for first-time, full-time students at less-than-four-year institutions (200% of expected time to completion), pooled in two-year rolling averages and suppressed for small n size. 
c200_4_pooled_supp float --Completion rate for first-time, full-time students at four-year institutions (200% of expected time to completion), pooled in two-year rolling averages and suppressed for small n size
alias autocomplete --Institution name aliases
c100_4 float --Completion rate for first-time, full-time students at four-year institutions (100% of expected time to completion)
d100_4 integer --Adjusted cohort count for completion rate at four-year institutions (denominator of 100% completion rate)
c100_l4 float --Completion rate for first-time, full-time students at less-than-four-year institutions (100% of expected time to completion)
d100_l4 integer --Adjusted cohort count for completion rate at less-than-four-year institutions (denominator of 100% completion rate)
trans_4 float --Transfer rate for first-time, full-time students at four-year institutions (within 150% of expected time to completion/6 years)
dtrans_4 integer --Adjusted cohort count for transfer rate at four-year institutions (denominator of 150% transfer rate)
trans_l4 float --Transfer rate for first-time, full-time students at less-than-four-year institutions (150% of expected time to completion)
dtrans_l4 integer --Adjusted cohort count for transfer rate at less-than-four-year institutions (denominator of 150% transfer rate)
iclevel integer --Level of institution
ugds_men float --Total share of enrollment of undergraduate degree-seeking students who are men
ugds_women float --Total share of enrollment of undergraduate degree-seeking students who are women
cdr2_denom integer --Number of students in the cohort for the two-year cohort default rate
cdr3_denom integer --Number of students in the cohort for the three-year cohort default rate
openadmp integer --Open admissions policy indicator
d_pctpell_pctfloan integer --Number of undergraduate students (denominator percent receiving a pell grant or federal student loan)
ugnonds integer --Number of non-degree-seeking undergraduate students
grads integer --Number of graduate students
d150_4_white integer --Adjusted cohort count for completion rate of White students at four-year institutions (denominator of 150% completion rate)
d150_4_black integer --Adjusted cohort count for completion rate of Black/African American students at four-year institutions (denominator of 150% completion rate)
d150_4_hisp integer --Adjusted cohort count for completion rate of Hispanic students at four-year institutions (denominator of 150% completion rate)
d150_4_asian integer --Adjusted cohort count for completion rate of Asian students at four-year institutions (denominator of 150% completion rate)
d150_4_aian integer --Adjusted cohort count for completion rate of American Indian/Alaska Native students at four-year institutions (denominator of 150% completion rate)
d150_4_nhpi integer --Adjusted cohort count for completion rate of Native Hawaiian/Pacific Islander students at four-year institutions (denominator of 150% completion rate)
d150_4_2mor integer --Adjusted cohort count for completion rate of students of Two or More Races at four-year institutions (denominator of 150% completion rate)
d150_4_nra integer --Adjusted cohort count for completion rate of U.S. Nonresident students at four-year institutions (denominator of 150% completion rate)
d150_4_unkn integer --Adjusted cohort count for completion rate of students of Unknown race at four-year institutions (denominator of 150% completion rate)
d150_l4_white integer --Adjusted cohort count for completion rate of White students at less-than-four-year institutions (denominator of 150% completion rate)
d150_l4_black integer --Adjusted cohort count for completion rate of Black/African American students at less-than-four-year institutions (denominator of 150% completion rate)
d150_l4_hisp integer --Adjusted cohort count for completion rate of Hispanic students at less-than-four-year institutions (denominator of 150% completion rate)
d150_l4_asian integer --Adjusted cohort count for completion rate of Asian students at less-than-four-year institutions (denominator of 150% completion rate)
d150_l4_aian integer --Adjusted cohort count for completion rate of American Indian/Alaska Native students at less-than-four-year institutions (denominator of 150% completion rate)
d150_l4_nhpi integer --Adjusted cohort count for completion rate of Native Hawaiian/Pacific Islander students at less-than-four-year institutions (denominator of 150% completion rate)
d150_l4_2mor integer --Adjusted cohort count for completion rate of students of Two or More Races at less-than-four-year institutions (denominator of 150% completion rate)
d150_l4_nra integer --Adjusted cohort count for completion rate of U.S. Nonresident students at less-than-four-year institutions (denominator of 150% completion rate)
d150_l4_unkn integer --Adjusted cohort count for completion rate of students of Unknown race at less-than-four-year institutions (denominator of 150% completion rate)
d150_4_whitenh integer --Adjusted cohort count for completion rate of White, non-Hispanic students at four-year institutions (denominator of 150% completion rate)
d150_4_blacknh integer --Adjusted cohort count for completion rate of Black, non-Hispanic students at four-year institutions (denominator of 150% completion rate)
d150_4_api integer --Adjusted cohort count for completion rate of Asian/Pacific Islander students at four-year institutions (denominator of 150% completion rate)
d150_4_aianold integer --Adjusted cohort count for completion rate of American Indian/Alaska Native students at four-year institutions (denominator of 150% completion rate)
d150_4_hispold integer --Adjusted cohort count for completion rate of Hispanic students at four-year institutions (denominator of 150% completion rate)
d150_l4_whitenh integer --Adjusted cohort count for completion rate of White, non-Hispanic students at less-than-four-year institutions (denominator of 150% completion rate)
d150_l4_blacknh integer --Adjusted cohort count for completion rate of Black, non-Hispanic students at less-than-four-year institutions (denominator of 150% completion rate)
d150_l4_api integer --Adjusted cohort count for completion rate of Asian/Pacific Islander students at less-than-four-year institutions (denominator of 150% completion rate)
d150_l4_aianold integer --Adjusted cohort count for completion rate of American Indian/Alaska Native students at less-than-four-year institutions (denominator of 150% completion rate)
d150_l4_hispold integer --Adjusted cohort count for completion rate of Hispanic students at less-than-four-year institutions (denominator of 150% completion rate)
accredcode string --Code corresponding to accreditor (as captured from PEPS)
t4approvaldate string --Date that institution was first approved to participate in Title IV aid programs
omacht6_ftft integer --Adjusted cohort count of full-time, first-time students (denominator for the percentage receiving an award within 6 years of entry)
omawdp6_ftft float --Percentage of full-time, first-time student receiving an award within 6 years of entry
omacht8_ftft integer --Adjusted cohort count of full-time, first-time students (denominator for the 8-year outcomes percentages)
omawdp8_ftft float --Percentage of full-time, first-time student receiving an award within 8 years of entry
omenryp8_ftft float --Percentage of full-time, first-time students that did not receive an award and are still enrolled at this institution 8 years after entry
omenrap8_ftft float --Percentage of full-time, first-time students that did not receive an award and enrolled at another institution after leaving this institution within 8 years of entry
omenrup8_ftft float --Percentage of full-time, first-time students that did not receive an award and whose enrollment status is unknown after leaving this institution within 8 years of entry
omacht6_ptft integer --Adjusted cohort count of part-time, first-time students (denominator for the percentage receiving an award within 6 years of entry)
omawdp6_ptft float --Percentage of part-time, first-time student receiving an award within 6 years of entry
omacht8_ptft integer --Adjusted cohort count of part-time, first-time students (denominator for the 8-year outcomes percentages)
omawdp8_ptft float --Percentage of part-time, first-time student receiving an award within 8 years of entry
omenryp8_ptft float --Percentage of part-time, first-time students that did not receive an award and are still enrolled at this institution 8 years after entry
omenrap8_ptft float --Percentage of part-time, first-time students that did not receive an award and enrolled at another institution after leaving this institution within 8 years of entry
omenrup8_ptft float --Percentage of part-time, first-time students that did not receive an award and whose enrollment status is unknown after leaving this institution within 8 years of entry
omacht6_ftnft integer --Adjusted cohort count of full-time, not first-time students (denominator for the percentage receiving an award within 6 years of entry)
omawdp6_ftnft float --Percentage of full-time, not first-time student receiving an award within 6 years of entry
omacht8_ftnft integer --Adjusted cohort count of full-time, not first-time students (denominator for the 8-year outcomes percentages)
omawdp8_ftnft float --Percentage of full-time, not first-time student receiving an award within 8 years of entry
omenryp8_ftnft float --Percentage of full-time, not first-time students that did not receive an award and are still enrolled at this institution 8 years after entry
omenrap8_ftnft float --Percentage of full-time, not first-time students that did not receive an award and enrolled at another institution after leaving this institution within 8 years of entry
omenrup8_ftnft float --Percentage of full-time, not first-time students that did not receive an award and whose enrollment status is unknown after leaving this institution within 8 years of entry
omacht6_ptnft integer --Adjusted cohort count of part-time, not first-time students (denominator for the percentage receiving an award within 6 years of entry)
omawdp6_ptnft float --Percentage of part-time, not first-time student receiving an award within 6 years of entry
omacht8_ptnft integer --Adjusted cohort count of part-time, not first-time students (denominator for the 8-year outcomes percentages)
omawdp8_ptnft float --Percentage of part-time, not first-time student receiving an award within 8 years of entry
omenryp8_ptnft float --Percentage of part-time, not first-time students that did not receive an award and are still enrolled at this institution 8 years after entry
omenrap8_ptnft float --Percentage of part-time, not first-time students that did not receive an award and enrolled at another institution after leaving this institution within 8 years of entry
omenrup8_ptnft float --Percentage of part-time, not first-time students that did not receive an award and whose enrollment status is unknown after leaving this institution within 8 years of entry
ret_ft4_pooled float --First-time, full-time student retention rate at four-year institutions
ret_ftl4_pooled float --First-time, full-time student retention rate at less-than-four-year institutions
ret_pt4_pooled float --First-time, part-time student retention rate at four-year institutions
ret_ptl4_pooled float --First-time, part-time student retention rate at less-than-four-year institutions
ret_ft_den4_pooled float --Adjusted cohort count for the first-time, full-time student retention rate at four-year institutions (denominator of the retention rate)
ret_ft_denl4_pooled float --Adjusted cohort count for the first-time, full-time student retention rate at less-than-four-year institutions (denominator of the retention rate)
ret_pt_den4_pooled float --Adjusted cohort count for the first-time, part-time student retention rate at four-year institutions (denominator of the retention rate)
ret_pt_denl4_pooled float --Adjusted cohort count for the first-time, part-time student retention rate at less-than-four-year institutions (denominator of the retention rate)
poolyrsret_ft integer --Years used for rolling averages of full-time retention rate RET_FT[4/L4]_POOLED
poolyrsret_pt integer --Years used for rolling averages of part-time retention rate RET_PT[4/L4]_POOLED
ret_ft4_pooled_supp float --First-time, full-time student retention rate at four-year institutions
ret_ftl4_pooled_supp float --First-time, full-time student retention rate at less-than-four-year institutions
ret_pt4_pooled_supp float --First-time, part-time student retention rate at four-year institutions
ret_ptl4_pooled_supp float --First-time, part-time student retention rate at less-than-four-year institutions
trans_4_pooled float --Transfer rate for first-time, full-time students at four-year institutions (within 150% of expected time to completion/6 years)
trans_l4_pooled float --Transfer rate for first-time, full-time students at less-than-four-year institutions (150% of expected time to completion)
dtrans_4_pooled integer --Adjusted cohort count for transfer rate at four-year institutions (denominator of 150% transfer rate)
dtrans_l4_pooled integer --Adjusted cohort count for transfer rate at less-than-four-year institutions (denominator of 150% transfer rate)
trans_4_pooled_supp float --Transfer rate for first-time, full-time students at four-year institutions (within 150% of expected time to completion/6 years)
trans_l4_pooled_supp float --Transfer rate for first-time, full-time students at less-than-four-year institutions (150% of expected time to completion)
c100_4_pooled float --Completion rate for first-time, full-time students at four-year institutions (100% of expected time to completion), pooled for rolling averages
c100_l4_pooled float --Completion rate for first-time, full-time students at less-than-four-year institutions (100% of expected time to completion), pooled for rolling averages
d100_4_pooled integer --Adjusted cohort count for completion rate at four-year institutions (denominator of 100% completion rate), pooled for rolling averages
d100_l4_pooled integer --Adjusted cohort count for completion rate at less-than-four-year institutions (denominator of 100% completion rate), pooled for rolling averages
poolyrs100 integer --Years used for rolling averages of completion rate C100_[4/L4]_POOLED
c100_4_pooled_supp float --Completion rate for first-time, full-time students at four-year institutions (100% of expected time to completion), pooled for rolling averages and suppressed for small n size.
c100_l4_pooled_supp float --Completion rate for first-time, full-time students at less-than-four-year institutions (100% of expected time to completion), pooled for rolling averages and suppressed for small n size.
c150_4_pell float --Completion rate for first-time, full-time students receiving a Pell Grant during their first year of college at four-year institutions (150% of expected time to completion)
d150_4_pell integer --Adjusted cohort count for Pell Grant recipient completion rate at four-year institutions (denominator of 150% Pell Grant recipient completion rate)
c150_l4_pell float --Completion rate for first-time, full-time students receiving a Pell Grant during their first year of college at less-than-four-year institutions (150% of expected time to completion)
d150_l4_pell integer --Adjusted cohort count for Pell Grant recipient completion rate at less-than-four-year institutions (denominator of 150% Pell Grant recipient completion rate)
c150_4_loannopell float --Completion rate for first-time, full-time students receiving a Direct Subsidized Loan but not a Pell Grant during their first year of college at four-year institutions (150% of expected time to completion)
d150_4_loannopell integer --Adjusted cohort count for Direct Subsidized Loan recipients who did not receive a Pell Grant completion rate at four-year institutions (denominator of 150% Direct Subsidized Loan recipient who did not receive a Pell Grant completion rate)
c150_l4_loannopell float --Completion rate for first-time, full-time students receiving a Direct Subsidized Loan but not a Pell Grant during their first year of college at less-than-four-year institutions (150% of expected time to completion)
d150_l4_loannopell integer --Adjusted cohort count for Direct Subsidized Loan recipients who did not receive a Pell Grant completion rate at less-than-four-year institutions (denominator of 150% Direct Subsidized Loan recipient who did not receive a Pell Grant completion rate)
c150_4_noloannopell float --Completion rate for first-time, full-time students receiving neither a Direct Subsidized Loan or a Pell Grant during their first year of college at four-year institutions (150% of expected time to completion)
d150_4_noloannopell integer --Adjusted cohort count for those who did not receive a Direct Subsidized Loan or a Pell Grant completion rate at four-year institutions (denominator of 150% did not receive a Direct Subsidized Loan or Pell Grant completion rate)
c150_l4_noloannopell float --Completion rate for first-time, full-time students receiving neither a Direct Subsidized Loan or a Pell Grant during their first year of college at less-than-four-year institutions (150% of expected time to completion)
d150_l4_noloannopell integer --Adjusted cohort count for those who did not receive a Direct Subsidized Loan or a Pell Grant completion rate at less-than-four-year institutions (denominator of 150% did not receive a Direct Subsidized Loan or Pell Grant completion rate)
omacht6_ftft_pooled integer --Adjusted cohort count of full-time, first-time students (denominator for the percentage receiving an award within 6 years of entry), pooled across years.
omawdp6_ftft_pooled float --Percentage of full-time, first-time student receiving an award within 6 years of entry, pooled in rolling averages.
omacht8_ftft_pooled integer --Adjusted cohort count of full-time, first-time students (denominator for the 8-year outcomes percentages), pooled across years.
omawdp8_ftft_pooled float --Percentage of full-time, first-time student receiving an award within 8 years of entry, pooled in rolling averages.
omenryp8_ftft_pooled float --Percentage of full-time, first-time students that did not receive an award and are still enrolled at this institution 8 years after entry, pooled in rolling averages.
omenrap8_ftft_pooled float --Percentage of full-time, first-time students that did not receive an award and enrolled at another institution after leaving this institution within 8 years of entry, pooled in rolling averages.
omenrup8_ftft_pooled float --Percentage of full-time, first-time students that did not receive an award and whose enrollment status is unknown after leaving this institution within 8 years of entry, pooled in rolling averages.
omacht6_ptft_pooled integer --Adjusted cohort count of part-time, first-time students (denominator for the percentage receiving an award within 6 years of entry), pooled across years.
omawdp6_ptft_pooled float --Percentage of part-time, first-time student receiving an award within 6 years of entry, pooled in rolling averages.
omacht8_ptft_pooled integer --Adjusted cohort count of part-time, first-time students (denominator for the 8-year outcomes percentages), pooled across years.
omawdp8_ptft_pooled float --Percentage of part-time, first-time student receiving an award within 8 years of entry, pooled in rolling averages.
omenryp8_ptft_pooled float --Percentage of part-time, first-time students that did not receive an award and are still enrolled at this institution 8 years after entry, pooled in rolling averages.
omenrap8_ptft_pooled float --Percentage of part-time, first-time students that did not receive an award and enrolled at another institution after leaving this institution within 8 years of entry, pooled in rolling averages.
omenrup8_ptft_pooled float --Percentage of part-time, first-time students that did not receive an award and whose enrollment status is unknown after leaving this institution within 8 years of entry, pooled in rolling averages.
omacht6_ftnft_pooled integer --Adjusted cohort count of full-time, not first-time students (denominator for the percentage receiving an award within 6 years of entry), pooled across years.
omawdp6_ftnft_pooled float --Percentage of full-time, not first-time student receiving an award within 6 years of entry, pooled in rolling averages.
omacht8_ftnft_pooled integer --Adjusted cohort count of full-time, not first-time students (denominator for the 8-year outcomes percentages), pooled across years.
omawdp8_ftnft_pooled float --Percentage of full-time, not first-time student receiving an award within 8 years of entry, pooled in rolling averages.
omenryp8_ftnft_pooled float --Percentage of full-time, not first-time students that did not receive an award and are still enrolled at this institution 8 years after entry, pooled in rolling averages.
omenrap8_ftnft_pooled float --Percentage of full-time, not first-time students that did not receive an award and enrolled at another institution after leaving this institution within 8 years of entry, pooled in rolling averages.
omenrup8_ftnft_pooled float --Percentage of full-time, not first-time students that did not receive an award and whose enrollment status is unknown after leaving this institution within 8 years of entry, pooled in rolling averages.
omacht6_ptnft_pooled integer --Adjusted cohort count of part-time, not first-time students (denominator for the percentage receiving an award within 6 years of entry), pooled across years.
omawdp6_ptnft_pooled float --Percentage of part-time, not first-time student receiving an award within 6 years of entry, pooled in rolling averages.
omacht8_ptnft_pooled integer --Adjusted cohort count of part-time, not first-time students (denominator for the 8-year outcomes percentages), pooled across years.
omawdp8_ptnft_pooled float --Percentage of part-time, not first-time student receiving an award within 8 years of entry, pooled in rolling averages.
omenryp8_ptnft_pooled float --Percentage of part-time, not first-time students that did not receive an award and are still enrolled at this institution 8 years after entry, pooled in rolling averages.
omenrap8_ptnft_pooled float --Percentage of part-time, not first-time students that did not receive an award and enrolled at another institution after leaving this institution within 8 years of entry, pooled in rolling averages.
omenrup8_ptnft_pooled float --Percentage of part-time, not first-time students that did not receive an award and whose enrollment status is unknown after leaving this institution within 8 years of entry, pooled in rolling averages.
poolyrsom_ftft integer --Years used for rolling averages of outcome metrics OM[ACHT6/AWDP6/ACHT8/AWDP8/ENRAP8/ENRYP8/ENRUP8]_FTFT_POOLED
poolyrsom_ptft integer --Years used for rolling averages of outcome metrics OM[ACHT6/AWDP6/ACHT8/AWDP8/ENRAP8/ENRYP8/ENRUP8]_PTFT_POOLED
poolyrsom_ftnft integer --Years used for rolling averages of outcome metrics OM[ACHT6/AWDP6/ACHT8/AWDP8/ENRAP8/ENRYP8/ENRUP8]_FTNFT_POOLED
poolyrsom_ptnft integer --Years used for rolling averages of outcome metrics OM[ACHT6/AWDP6/ACHT8/AWDP8/ENRAP8/ENRYP8/ENRUP8]_PTNFT_POOLED
omawdp6_ftft_pooled_supp float --Percentage of full-time, first-time student receiving an award within 6 years of entry, pooled in rolling averages and suppressed for small n size
omawdp8_ftft_pooled_supp float --Percentage of full-time, first-time student receiving an award within 8 years of entry, pooled in rolling averages and suppressed for small n size
omenryp8_ftft_pooled_supp float --Percentage of full-time, first-time students that did not receive an award and are still enrolled at this institution 8 years after entry, pooled in rolling averages and suppressed for small n size
omenrap8_ftft_pooled_supp float --Percentage of full-time, first-time students that did not receive an award and enrolled at another institution after leaving this institution within 8 years of entry, pooled in rolling averages and suppressed for small n size
omenrup8_ftft_pooled_supp float --Percentage of full-time, first-time students that did not receive an award and whose enrollment status is unknown after leaving this institution within 8 years of entry, pooled in rolling averages and suppressed for small n size
omawdp6_ptft_pooled_supp float --Percentage of part-time, first-time student receiving an award within 6 years of entry, pooled in rolling averages and suppressed for small n size
omawdp8_ptft_pooled_supp float --Percentage of part-time, first-time student receiving an award within 8 years of entry, pooled in rolling averages and suppressed for small n size
omenryp8_ptft_pooled_supp float --Percentage of part-time, first-time students that did not receive an award and are still enrolled at this institution 8 years after entry, pooled in rolling averages and suppressed for small n size
omenrap8_ptft_pooled_supp float --Percentage of part-time, first-time students that did not receive an award and enrolled at another institution after leaving this institution within 8 years of entry, pooled in rolling averages and suppressed for small n size
omenrup8_ptft_pooled_supp float --Percentage of part-time, first-time students that did not receive an award and whose enrollment status is unknown after leaving this institution within 8 years of entry, pooled in rolling averages and suppressed for small n size
omawdp6_ftnft_pooled_supp float --Percentage of full-time, not first-time student receiving an award within 6 years of entry, pooled in rolling averages and suppressed for small n size
omawdp8_ftnft_pooled_supp float --Percentage of full-time, not first-time student receiving an award within 8 years of entry, pooled in rolling averages and suppressed for small n size
omenryp8_ftnft_pooled_supp float --Percentage of full-time, not first-time students that did not receive an award and are still enrolled at this institution 8 years after entry, pooled in rolling averages and suppressed for small n size
omenrap8_ftnft_pooled_supp float --Percentage of full-time, not first-time students that did not receive an award and enrolled at another institution after leaving this institution within 8 years of entry, pooled in rolling averages and suppressed for small n size
omenrup8_ftnft_pooled_supp float --Percentage of full-time, not first-time students that did not receive an award and whose enrollment status is unknown after leaving this institution within 8 years of entry, pooled in rolling averages and suppressed for small n size
omawdp6_ptnft_pooled_supp float --Percentage of part-time, not first-time student receiving an award within 6 years of entry, pooled in rolling averages and suppressed for small n size
omawdp8_ptnft_pooled_supp float --Percentage of part-time, not first-time student receiving an award within 8 years of entry, pooled in rolling averages and suppressed for small n size
omenryp8_ptnft_pooled_supp float --Percentage of part-time, not first-time students that did not receive an award and are still enrolled at this institution 8 years after entry, pooled in rolling averages and suppressed for small n size
omenrap8_ptnft_pooled_supp float --Percentage of part-time, not first-time students that did not receive an award and enrolled at another institution after leaving this institution within 8 years of entry, pooled in rolling averages and suppressed for small n size
omenrup8_ptnft_pooled_supp float --Percentage of part-time, not first-time students that did not receive an award and whose enrollment status is unknown after leaving this institution within 8 years of entry, pooled in rolling averages and suppressed for small n size
schtype integer --Control of institution, per PEPS
opeflag integer --Title IV eligibility type
prgmofr integer --Number of programs offered
cipcode1 string --CIP code of largest program
cipcode2 string --CIP code of program #2
cipcode3 string --CIP code of program #3
cipcode4 string --CIP code of program #4
cipcode5 string --CIP code of program #5
cipcode6 string --CIP code of program #6
ciptitle1 string --CIP text description of largest program
ciptitle2 string --CIP text description of program #2
ciptitle3 string --CIP text description of program #3
ciptitle4 string --CIP text description of program #4
ciptitle5 string --CIP text description of program #5
ciptitle6 string --CIP text description of program #6
ciptfbs1 integer --Tuition, fees, books, and supply charges for largest program (full program)
ciptfbs2 integer --Tuition, fees, books, and supply charges for program #2 (full program)
ciptfbs3 integer --Tuition, fees, books, and supply charges for program #3 (full program)
ciptfbs4 integer --Tuition, fees, books, and supply charges for program #4 (full program)
ciptfbs5 integer --Tuition, fees, books, and supply charges for program #5 (full program)
ciptfbs6 integer --Tuition, fees, books, and supply charges for program #6 (full program)
ciptfbsannual1 integer --Tuition, fees, books, and supply charges for largest program (annualized based on institution's academic year)
ciptfbsannual2 integer --Tuition, fees, books, and supply charges for program #2 (annualized based on institution's academic year)
ciptfbsannual3 integer --Tuition, fees, books, and supply charges for program #3 (annualized based on institution's academic year)
ciptfbsannual4 integer --Tuition, fees, books, and supply charges for program #4 (annualized based on institution's academic year)
ciptfbsannual5 integer --Tuition, fees, books, and supply charges for program #5 (annualized based on institution's academic year)
ciptfbsannual6 integer --Tuition, fees, books, and supply charges for program #6 (annualized based on institution's academic year)
mthcmp1 integer --Average number of months needed to complete largest program
mthcmp2 integer --Average number of months needed to complete program #2
mthcmp3 integer --Average number of months needed to complete program #3
mthcmp4 integer --Average number of months needed to complete program #4
mthcmp5 integer --Average number of months needed to complete program #5
mthcmp6 integer --Average number of months needed to complete program #6
poolyrsom_all integer --Years used for rolling averages of outcome metrics OM[AWDP8/ENRAP8/ENRYP8/ENRUP8]_ALL_POOLED
poolyrsom_firsttime integer --Years used for rolling averages of outcome metrics OM[AWDP8/ENRAP8/ENRYP8/ENRUP8]_FIRSTTIME_POOLED
poolyrsom_notfirsttime integer --Years used for rolling averages of outcome metrics OM[AWDP8/ENRAP8/ENRYP8/ENRUP8]_NOTFIRSTTIME_POOLED
poolyrsom_fulltime integer --Years used for rolling averages of outcome metrics OM[AWDP8/ENRAP8/ENRYP8/ENRUP8]_FULLTIME_POOLED
poolyrsom_parttime integer --Years used for rolling averages of outcome metrics OM[AWDP8/ENRAP8/ENRYP8/ENRUP8]_PARTTIME_POOLED
omenryp_all float --Percentage of all students that did not receive an award and are still enrolled at this institution 8 years after entry
omenrap_all float --Percentage of all students that did not receive an award and enrolled at another institution after leaving this institution within 8 years of entry
omawdp8_all float --Percentage of all student receiving an award within 8 years of entry
omenrup_all float --Percentage of all students that did not receive an award and whose enrollment status is unknown after leaving this institution within 8 years of entry
omenryp_firsttime float --Percentage of first-time students that did not receive an award and are still enrolled at this institution 8 years after entry
omenrap_firsttime float --Percentage of first-time students that did not receive an award and enrolled at another institution after leaving this institution within 8 years of entry
omawdp8_firsttime float --Percentage of first-time student receiving an award within 8 years of entry
omenrup_firsttime float --Percentage of first-time students that did not receive an award and whose enrollment status is unknown after leaving this institution within 8 years of entry
omenryp_notfirsttime float --Percentage of not first-time students that did not receive an award and are still enrolled at this institution 8 years after entry
omenrap_notfirsttime float --Percentage of not first-time students that did not receive an award and enrolled at another institution after leaving this institution within 8 years of entry
omawdp8_notfirsttime float --Percentage of not first-time student receiving an award within 8 years of entry
omenrup_notfirsttime float --Percentage of not first-time students that did not receive an award and whose enrollment status is unknown after leaving this institution within 8 years of entry
omenryp_fulltime float --Percentage of full-time students that did not receive an award and are still enrolled at this institution 8 years after entry
omenrap_fulltime float --Percentage of full-time students that did not receive an award and enrolled at another institution after leaving this institution within 8 years of entry
omawdp8_fulltime float --Percentage of full-time student receiving an award within 8 years of entry
omenrup_fulltime float --Percentage of full-time students that did not receive an award and whose enrollment status is unknown after leaving this institution within 8 years of entry
omenryp_parttime float --Percentage of part-time students that did not receive an award and are still enrolled at this institution 8 years after entry
omenrap_parttime float --Percentage of part-time students that did not receive an award and enrolled at another institution after leaving this institution within 8 years of entry
omawdp8_parttime float --Percentage of part-time student receiving an award within 8 years of entry
omenrup_parttime float --Percentage of part-time students that did not receive an award and whose enrollment status is unknown after leaving this institution within 8 years of entry
omenryp_all_pooled_supp float --Percentage of all students that did not receive an award and are still enrolled at this institution 8 years after entry, pooled in rolling averages and suppressed for small n size
omenrap_all_pooled_supp float --Percentage of all students that did not receive an award and enrolled at another institution after leaving this institution within 8 years of entry, pooled in rolling averages and suppressed for small n size
omawdp8_all_pooled_supp float --Percentage of all student receiving an award within 8 years of entry, pooled in rolling averages and suppressed for small n size
omenrup_all_pooled_supp float --Percentage of all students that did not receive an award and whose enrollment status is unknown after leaving this institution within 8 years of entry, pooled in rolling averages and suppressed for small n size
omenryp_firsttime_pooled_supp float --Percentage of first-time students that did not receive an award and are still enrolled at this institution 8 years after entry, pooled in rolling averages and suppressed for small n size
omenrap_firsttime_pooled_supp float --Percentage of first-time students that did not receive an award and enrolled at another institution after leaving this institution within 8 years of entry, pooled in rolling averages and suppressed for small n size
omawdp8_firsttime_pooled_supp float --Percentage of first-time student receiving an award within 8 years of entry, pooled in rolling averages and suppressed for small n size
omenrup_firsttime_pooled_supp float --Percentage of first-time students that did not receive an award and whose enrollment status is unknown after leaving this institution within 8 years of entry, pooled in rolling averages and suppressed for small n size
omenryp_notfirsttime_pooled_supp float --Percentage of not first-time students that did not receive an award and are still enrolled at this institution 8 years after entry, pooled in rolling averages and suppressed for small n size
omenrap_notfirsttime_pooled_supp float --Percentage of not first-time students that did not receive an award and enrolled at another institution after leaving this institution within 8 years of entry, pooled in rolling averages and suppressed for small n size
omawdp8_notfirsttime_pooled_supp float --Percentage of not first-time student receiving an award within 8 years of entry, pooled in rolling averages and suppressed for small n size
omenrup_notfirsttime_pooled_supp float --Percentage of not first-time students that did not receive an award and whose enrollment status is unknown after leaving this institution within 8 years of entry, pooled in rolling averages and suppressed for small n size
omenryp_fulltime_pooled_supp float --Percentage of full-time students that did not receive an award and are still enrolled at this institution 8 years after entry, pooled in rolling averages and suppressed for small n size
omenrap_fulltime_pooled_supp float --Percentage of full-time students that did not receive an award and enrolled at another institution after leaving this institution within 8 years of entry, pooled in rolling averages and suppressed for small n size
omawdp8_fulltime_pooled_supp float --Percentage of full-time student receiving an award within 8 years of entry, pooled in rolling averages and suppressed for small n size
omenrup_fulltime_pooled_supp float --Percentage of full-time students that did not receive an award and whose enrollment status is unknown after leaving this institution within 8 years of entry, pooled in rolling averages and suppressed for small n size
omenryp_parttime_pooled_supp float --Percentage of part-time students that did not receive an award and are still enrolled at this institution 8 years after entry, pooled in rolling averages and suppressed for small n size
omenrap_parttime_pooled_supp float --Percentage of part-time students that did not receive an award and enrolled at another institution after leaving this institution within 8 years of entry, pooled in rolling averages and suppressed for small n size
omawdp8_parttime_pooled_supp float --Percentage of part-time student receiving an award within 8 years of entry, pooled in rolling averages and suppressed for small n size
omenrup_parttime_pooled_supp float --Percentage of part-time students that did not receive an award and whose enrollment status is unknown after leaving this institution within 8 years of entry, pooled in rolling averages and suppressed for small n size
ftftpctpell float --Percentage of full-time, first-time degree/certificate-seeking undergraduate students awarded a Pell Grant
ftftpctfloan float --Percentage of full-time, first-time degree/certificate-seeking undergraduate students awarded a federal loan
ug12mn integer --Unduplicated count of undergraduate students enrolled during a 12 month period
g12mn integer --Unduplicated count of graduate students enrolled during a 12 month period
scugffn integer --Number of full-time, first-time degree/certificate-seeking undergraduate students (denominator for percent full-time, first-time degree/certificate-seeking undergraduates receiving a pell grant or federal student loan)
poolyrs_ftftaidpct integer --Years used for rolling averages of FTFTPCTPELL_POOLED_SUPP and FTFTPCTFLOAN_POOLED_SUPP
ftftpctpell_pooled_supp float --Percentage of full-time, first-time degree/certificate-seeking undergraduate students awarded a Pell Grant, pooled in rolling averages and suppressed for small n size
ftftpctfloan_pooled_supp float --Percentage of full-time, first-time degree/certificate-seeking undergraduate students awarded a federal loan, pooled in rolling averages and suppressed for small n size
scugffn_pooled integer --Number of full-time, first-time degree/certificate-seeking undergraduate students (denominator for percent full-time, first-time degree/certificate-seeking undergraduates receiving a pell grant or federal student loan), pooled in rolling averages
pplus_pct_low integer --Lower bound of estimated percentage range of students whose parents took out a PLUS loan
pplus_pct_high integer --Upper bound of estimated percentage range of students whose parents took out a PLUS loan
pplus_pct_low_pooled_supp integer --Lower bound of estimated percentage range of students whose parents took out a PLUS loan, pooled in rolling averages and suppressed for small n size
pplus_pct_high_pooled_supp integer --Upper bound of estimated percentage range of students whose parents took out a PLUS loan, pooled in rolling averages and suppressed for small n size
poolyrs_pluspct integer --Years used for rolling averages of PPLUS_PCT_LOW_POOLED_SUPP and PPLUS_PCT_HIGH_POOLED_SUPP
plus_debt_inst_n integer --Student recipient count for median PLUS loan debt disbursed at this institution
plus_debt_inst_md integer --Median PLUS loan debt disbursed at this institution
plus_debt_all_n integer --Student recipient count for median PLUS loan debt disbursed at all institutions
plus_debt_all_md integer --Median PLUS loan debt disbursed at all institutions
plus_debt_inst_comp_n integer --Student recipient count for median PLUS loan debt disbursed to completers at this institution
plus_debt_inst_comp_md integer --Median PLUS loan debt disbursed to completers at this institution
plus_debt_inst_comp_mdpay10 float --Median estimated monthly payment for PLUS loan debt disbursed to completers at this institution
plus_debt_inst_comp_md_supp integer --Median PLUS loan debt disbursed to completers at this institution, suppressed for n=30
plus_debt_inst_comp_mdpay10_supp float --Median estimated monthly payment for PLUS loan debt disbursed to completers at this institution, suppressed for n=30
plus_debt_all_comp_n integer --Student recipient count for median PLUS loan debt disbursed to completers at all institutions
plus_debt_all_comp_md integer --Median PLUS loan debt disbursed to completers at all institutions
plus_debt_all_comp_mdpay10 float --Median estimated monthly payment for PLUS loan debt disbursed to completers at all institutions
plus_debt_all_comp_md_supp integer --Median PLUS loan debt disbursed to completers at all institutions, suppressed for n=30
plus_debt_all_comp_mdpay10_supp float --Median estimated monthly payment for PLUS loan debt disbursed to completers at all institutions, suppressed for n=30
plus_debt_inst_nocomp_n integer --Student recipient count for median PLUS loan debt disbursed to non-completers at this institution
plus_debt_inst_nocomp_md integer --Median PLUS loan debt disbursed to non-completers at this institution
plus_debt_all_nocomp_n integer --Student recipient count for median PLUS loan debt disbursed to non-completers at all institutions
plus_debt_all_nocomp_md integer --Median PLUS loan debt disbursed to non-completers at all institutions
plus_debt_inst_male_n integer --Student recipient count for median PLUS loan debt disbursed to males at this institution
plus_debt_inst_male_md integer --Median PLUS loan debt disbursed to males at this institution
plus_debt_all_male_n integer --Student recipient count for median PLUS loan debt disbursed to males at all institutions
plus_debt_all_male_md integer --Median PLUS loan debt disbursed to males at all institutions
plus_debt_inst_nomale_n integer --Student recipient count for median PLUS loan debt disbursed to non-males at this institution
plus_debt_inst_nomale_md integer --Median PLUS loan debt disbursed to non-males at this institution
plus_debt_all_nomale_n integer --Student recipient count for median PLUS loan debt disbursed to non-males at all institutions
plus_debt_all_nomale_md integer --Median PLUS loan debt disbursed to non-males at all institutions
plus_debt_inst_pell_n integer --Student recipient count for median PLUS loan debt disbursed to Pell recipients at this institution
plus_debt_inst_pell_md integer --Median PLUS loan debt disbursed to Pell recipients at this institution
plus_debt_all_pell_n integer --Student recipient count for median PLUS loan debt disbursed to Pell recipients at all institutions
plus_debt_all_pell_md integer --Median PLUS loan debt disbursed to Pell recipients at all institutions
plus_debt_inst_nopell_n integer --Student recipient count for median PLUS loan debt disbursed to non-Pell-recipients at this institution
plus_debt_inst_nopell_md integer --Median PLUS loan debt disbursed to non-Pell-recipients at this institution
plus_debt_all_nopell_n integer --Student recipient count for median PLUS loan debt disbursed to non-Pell-recipients at all institutions
plus_debt_all_nopell_md integer --Median PLUS loan debt disbursed to non-Pell-recipients at all institutions
plus_debt_inst_staffthis_n integer --Student recipient count for median PLUS loan debt disbursed at this institution to Stafford loan recipients at this institution
plus_debt_inst_staffthis_md integer --Median PLUS loan debt disbursed at this institution to Stafford loan recipients at this institution
plus_debt_all_staffthis_n integer --Student recipient count for median PLUS loan debt disbursed at any institution to Stafford loan recipients at this institution
plus_debt_all_staffthis_md integer --Median PLUS loan debt disbursed at any institution to Stafford loan recipients at this institution
plus_debt_inst_nostaffthis_n integer --Student recipient count for median PLUS loan debt disbursed at this institution to students not receiving a Stafford loan at this institution
plus_debt_inst_nostaffthis_md integer --Median PLUS loan debt disbursed at this institution to students not receiving a Stafford loan at this institution
plus_debt_all_nostaffthis_n integer --Student recipient count for median PLUS loan debt disbursed at any institution to students not receiving a Stafford loan at this institution
plus_debt_all_nostaffthis_md integer --Median PLUS loan debt disbursed at any institution to students not receiving a Stafford loan at this institution
plus_debt_inst_staffany_n integer --Student recipient count for median PLUS loan debt disbursed at this institution to Stafford loan recipients at any institution
plus_debt_inst_staffany_md integer --Median PLUS loan debt disbursed at this institution to Stafford loan recipients at any institution
plus_debt_all_staffany_n integer --Student recipient count for median PLUS loan debt disbursed at any institution to Stafford loan recipients at any institution
plus_debt_all_staffany_md integer --Median PLUS loan debt disbursed at any institution to Stafford loan recipients at any institution
plus_debt_inst_nostaffany_n integer --Student recipient count for median PLUS loan debt disbursed at this institution to students not receiving a Stafford loan at any institution
plus_debt_inst_nostaffany_md integer --Median PLUS loan debt disbursed at this institution to students not receiving a Stafford loan at any institution
plus_debt_all_nostaffany_n integer --Student recipient count for median PLUS loan debt disbursed at any institution to students not receiving a Stafford loan at any institution
plus_debt_all_nostaffany_md integer --Median PLUS loan debt disbursed at any institution to students not receiving a Stafford loan at any institution
count_nwne_3yr integer --Number of graduates not working and not enrolled 3 years after completing
count_wne_3yr integer --Number of graduates working and not enrolled 3 years after completing
cntover150_3yr integer --Number of graduates working and not enrolled who earned more than 150% of the single-person household poverty threshold 3 years after completing
dbrr1_fed_ug_n integer --Undergraduate federal student loan dollar-based 1-year repayment rate borrower count
dbrr1_fed_ug_num long --Undergraduate federal student loan dollar-based 1-year repayment rate numerator
dbrr1_fed_ug_den long --Undergraduate federal student loan dollar-based 1-year repayment rate denominator
dbrr1_fed_ug_rt float --Undergraduate federal student loan dollar-based 1-year repayment rate
dbrr1_fed_gr_n integer --Graduate federal student loan dollar-based 1-year repayment rate borrower count
dbrr1_fed_gr_num long --Graduate federal student loan dollar-based 1-year repayment rate numerator
dbrr1_fed_gr_den long --Graduate federal student loan dollar-based 1-year repayment rate denominator
dbrr1_fed_gr_rt float --Graduate federal student loan dollar-based 1-year repayment rate
dbrr1_fed_ugcomp_n integer --Undergraduate borrower completers undergraduate federal student loan dollar-based 1-year repayment rate borrower count
dbrr1_fed_ugcomp_num long --Undergraduate borrower completers undergraduate federal student loan dollar-based 1-year repayment rate numerator
dbrr1_fed_ugcomp_den long --Undergraduate borrower completers undergraduate federal student loan dollar-based 1-year repayment rate denominator
dbrr1_fed_ugcomp_rt float --Undergraduate borrower completers undergraduate federal student loan dollar-based 1-year repayment rate
dbrr1_fed_ugnocomp_n integer --Undergraduate borrower non-completers undergraduate federal student loan dollar-based 1-year repayment rate borrower count
dbrr1_fed_ugnocomp_num long --Undergraduate borrower non-completers undergraduate federal student loan dollar-based 1-year repayment rate numerator
dbrr1_fed_ugnocomp_den long --Undergraduate borrower non-completers undergraduate federal student loan dollar-based 1-year repayment rate denominator
dbrr1_fed_ugnocomp_rt float --Undergraduate borrower non-completers undergraduate federal student loan dollar-based 1-year repayment rate repayment rate
dbrr1_fed_ugunk_n integer --Undergraduate borrowers with unknown completion status undergraduate federal student loan dollar-based 1-year repayment rate borrower count
dbrr1_fed_ugunk_num long --Undergraduate borrowers with unknown completion status undergraduate federal student loan dollar-based 1-year repayment rate numerator
dbrr1_fed_ugunk_den long --Undergraduate borrowers with unknown completion status undergraduate federal student loan dollar-based 1-year repayment rate denominator
dbrr1_fed_ugunk_rt float --Undergraduate borrowers with unknown completion status undergraduate federal student loan dollar-based 1-year repayment rate repayment rate
dbrr1_fed_grcomp_n integer --Graduate borrower completers graduate federal student loan dollar-based 1-year repayment rate borrower count
dbrr1_fed_grcomp_num long --Graduate borrower completers graduate federal student loan dollar-based 1-year repayment rate numerator
dbrr1_fed_grcomp_den long --Graduate borrower completers graduate federal student loan dollar-based 1-year repayment rate denominator
dbrr1_fed_grcomp_rt float --Graduate borrower completers graduate federal student loan dollar-based 1-year repayment rate
dbrr1_fed_grnocomp_n integer --Graduate borrower non-completers graduate federal student loan dollar-based 1-year repayment rate borrower count
dbrr1_fed_grnocomp_num long --Graduate borrower non-completers graduate federal student loan dollar-based 1-year repayment rate numerator
dbrr1_fed_grnocomp_den long --Graduate borrower non-completers graduate federal student loan dollar-based 1-year repayment rate denominator
dbrr1_fed_grnocomp_rt float --Graduate borrower non-completers graduate federal student loan dollar-based 1-year repayment rate repayment rate
dbrr4_fed_ug_n integer --Undergraduate federal student loan dollar-based 4-year repayment rate borrower count
dbrr4_fed_ug_num long --Undergraduate federal student loan dollar-based 4-year repayment rate numerator
dbrr4_fed_ug_den long --Undergraduate federal student loan dollar-based 4-year repayment rate denominator
dbrr4_fed_ug_rt float --Undergraduate federal student loan dollar-based 4-year repayment rate
dbrr4_fed_gr_n integer --Graduate federal student loan dollar-based 4-year repayment rate borrower count
dbrr4_fed_gr_num long --Graduate federal student loan dollar-based 4-year repayment rate numerator
dbrr4_fed_gr_den long --Graduate federal student loan dollar-based 4-year repayment rate denominator
dbrr4_fed_gr_rt float --Graduate federal student loan dollar-based 4-year repayment rate
dbrr4_fed_ugcomp_n integer --Undergraduate borrower completers undergraduate federal student loan dollar-based 4-year repayment rate borrower count
dbrr4_fed_ugcomp_num long --Undergraduate borrower completers undergraduate federal student loan dollar-based 4-year repayment rate numerator
dbrr4_fed_ugcomp_den long --Undergraduate borrower completers undergraduate federal student loan dollar-based 4-year repayment rate denominator
dbrr4_fed_ugcomp_rt float --Undergraduate borrower completers undergraduate federal student loan dollar-based 4-year repayment rate
dbrr4_fed_ugnocomp_n integer --Undergraduate borrower non-completers undergraduate federal student loan dollar-based 4-year repayment rate borrower count
dbrr4_fed_ugnocomp_num long --Undergraduate borrower non-completers undergraduate federal student loan dollar-based 4-year repayment rate numerator
dbrr4_fed_ugnocomp_den long --Undergraduate borrower non-completers undergraduate federal student loan dollar-based 4-year repayment rate denominator
dbrr4_fed_ugnocomp_rt float --Undergraduate borrower non-completers undergraduate federal student loan dollar-based 4-year repayment rate repayment rate
dbrr4_fed_ugunk_n integer --Undergraduate borrowers with unknown completion status undergraduate federal student loan dollar-based 4-year repayment rate borrower count
dbrr4_fed_ugunk_num long --Undergraduate borrowers with unknown completion status undergraduate federal student loan dollar-based 4-year repayment rate numerator
dbrr4_fed_ugunk_den long --Undergraduate borrowers with unknown completion status undergraduate federal student loan dollar-based 4-year repayment rate denominator
dbrr4_fed_ugunk_rt float --Undergraduate borrowers with unknown completion status undergraduate federal student loan dollar-based 4-year repayment rate repayment rate
dbrr5_fed_ug_n integer --Undergraduate federal student loan dollar-based 5-year repayment rate borrower count
dbrr5_fed_ug_num long --Undergraduate federal student loan dollar-based 5-year repayment rate numerator
dbrr5_fed_ug_den long --Undergraduate federal student loan dollar-based 5-year repayment rate denominator
dbrr5_fed_ug_rt float --Undergraduate federal student loan dollar-based 5-year repayment rate
dbrr5_fed_gr_n integer --Graduate federal student loan dollar-based 5-year repayment rate borrower count
dbrr5_fed_gr_num long --Graduate federal student loan dollar-based 5-year repayment rate numerator
dbrr5_fed_gr_den long --Graduate federal student loan dollar-based 5-year repayment rate denominator
dbrr5_fed_gr_rt float --Graduate federal student loan dollar-based 5-year repayment rate
dbrr10_fed_ug_n integer --Undergraduate federal student loan dollar-based 10-year repayment rate borrower count
dbrr10_fed_ug_num long --Undergraduate federal student loan dollar-based 10-year repayment rate numerator
dbrr10_fed_ug_den long --Undergraduate federal student loan dollar-based 10-year repayment rate denominator
dbrr10_fed_ug_rt float --Undergraduate federal student loan dollar-based 10-year repayment rate
dbrr10_fed_gr_n integer --Graduate federal student loan dollar-based 10-year repayment rate borrower count
dbrr10_fed_gr_num long --Graduate federal student loan dollar-based 10-year repayment rate numerator
dbrr10_fed_gr_den long --Graduate federal student loan dollar-based 10-year repayment rate denominator
dbrr10_fed_gr_rt float --Graduate federal student loan dollar-based 10-year repayment rate
dbrr20_fed_ug_n integer --Undergraduate federal student loan dollar-based 20-year repayment rate borrower count
dbrr20_fed_ug_num long --Undergraduate federal student loan dollar-based 20-year repayment rate numerator
dbrr20_fed_ug_den long --Undergraduate federal student loan dollar-based 20-year repayment rate denominator
dbrr20_fed_ug_rt float --Undergraduate federal student loan dollar-based 20-year repayment rate
dbrr20_fed_gr_n integer --Graduate federal student loan dollar-based 20-year repayment rate borrower count
dbrr20_fed_gr_num long --Graduate federal student loan dollar-based 20-year repayment rate numerator
dbrr20_fed_gr_den long --Graduate federal student loan dollar-based 20-year repayment rate denominator
dbrr20_fed_gr_rt float --Graduate federal student loan dollar-based 20-year repayment rate
dbrr1_pp_ug_n integer --Undergraduate Parent PLUS Loan dollar-based 1-year repayment rate borrower count
dbrr1_pp_ug_num long --Undergraduate Parent PLUS Loan dollar-based 1-year repayment rate numerator
dbrr1_pp_ug_den long --Undergraduate Parent PLUS Loan dollar-based 1-year repayment rate denominator
dbrr1_pp_ug_rt float --Undergraduate Parent PLUS Loan dollar-based 1-year repayment rate
dbrr1_pp_ugcomp_n integer --Undergraduate student completers Parent PLUS Loan dollar-based 1-year repayment rate borrower count
dbrr1_pp_ugcomp_num long --Undergraduate student completers Parent PLUS Loan dollar-based 1-year repayment rate numerator
dbrr1_pp_ugcomp_den long --Undergraduate student completers Parent PLUS Loan dollar-based 1-year repayment rate denominator
dbrr1_pp_ugcomp_rt float --Undergraduate student completers Parent PLUS Loan dollar-based 1-year repayment rate
dbrr1_pp_ugnocomp_n integer --Undergraduate student non-completers Parent PLUS Loan dollar-based 1-year repayment rate borrower count
dbrr1_pp_ugnocomp_num long --Undergraduate student non-completers Parent PLUS Loan dollar-based 1-year repayment rate numerator
dbrr1_pp_ugnocomp_den long --Undergraduate student non-completers Parent PLUS Loan dollar-based 1-year repayment rate denominator
dbrr1_pp_ugnocomp_rt float --Undergraduate student non-completers Parent PLUS Loan dollar-based 1-year repayment rate repayment rate
dbrr1_pp_ugunk_n integer --Undergraduate students with unknown completion status Parent PLUS Loan dollar-based 1-year repayment rate borrower count
dbrr1_pp_ugunk_num long --Undergraduate students with unknown completion status Parent PLUS Loan dollar-based 1-year repayment rate numerator
dbrr1_pp_ugunk_den long --Undergraduate students with unknown completion status Parent PLUS Loan dollar-based 1-year repayment rate denominator
dbrr1_pp_ugunk_rt float --Undergraduate students with unknown completion status Parent PLUS Loan dollar-based 1-year repayment rate repayment rate
dbrr4_pp_ug_n integer --Undergraduate Parent PLUS Loan dollar-based 4-year repayment rate borrower count
dbrr4_pp_ug_num long --Undergraduate Parent PLUS Loan dollar-based 4-year repayment rate numerator
dbrr4_pp_ug_den long --Undergraduate Parent PLUS Loan dollar-based 4-year repayment rate denominator
dbrr4_pp_ug_rt float --Undergraduate Parent PLUS Loan dollar-based 4-year repayment rate
dbrr4_pp_ugcomp_n integer --Undergraduate student completers Parent PLUS Loan dollar-based 4-year repayment rate borrower count
dbrr4_pp_ugcomp_num long --Undergraduate student completers Parent PLUS Loan dollar-based 4-year repayment rate numerator
dbrr4_pp_ugcomp_den long --Undergraduate student completers Parent PLUS Loan dollar-based 4-year repayment rate denominator
dbrr4_pp_ugcomp_rt float --Undergraduate student completers Parent PLUS Loan dollar-based 4-year repayment rate
dbrr4_pp_ugnocomp_n integer --Undergraduate student non-completers Parent PLUS Loan dollar-based 4-year repayment rate borrower count
dbrr4_pp_ugnocomp_num long --Undergraduate student non-completers Parent PLUS Loan dollar-based 4-year repayment rate numerator
dbrr4_pp_ugnocomp_den long --Undergraduate student non-completers Parent PLUS Loan dollar-based 4-year repayment rate denominator
dbrr4_pp_ugnocomp_rt float --Undergraduate student non-completers Parent PLUS Loan dollar-based 4-year repayment rate repayment rate
dbrr4_pp_ugunk_n integer --Undergraduate students with unknown completion status Parent PLUS Loan dollar-based 4-year repayment rate borrower count
dbrr4_pp_ugunk_num long --Undergraduate students with unknown completion status Parent PLUS Loan dollar-based 4-year repayment rate numerator
dbrr4_pp_ugunk_den long --Undergraduate students with unknown completion status Parent PLUS Loan dollar-based 4-year repayment rate denominator
dbrr4_pp_ugunk_rt float --Undergraduate students with unknown completion status Parent PLUS Loan dollar-based 4-year repayment rate repayment rate
dbrr5_pp_ug_n integer --Undergraduate Parent PLUS Loan dollar-based 5-year repayment rate borrower count
dbrr5_pp_ug_num long --Undergraduate Parent PLUS Loan dollar-based 5-year repayment rate numerator
dbrr5_pp_ug_den long --Undergraduate Parent PLUS Loan dollar-based 5-year repayment rate denominator
dbrr5_pp_ug_rt float --Undergraduate Parent PLUS Loan dollar-based 5-year repayment rate
dbrr10_pp_ug_n integer --Undergraduate Parent PLUS Loan dollar-based 10-year repayment rate borrower count
dbrr10_pp_ug_num long --Undergraduate Parent PLUS Loan dollar-based 10-year repayment rate numerator
dbrr10_pp_ug_den long --Undergraduate Parent PLUS Loan dollar-based 10-year repayment rate denominator
dbrr10_pp_ug_rt float --Undergraduate Parent PLUS Loan dollar-based 10-year repayment rate
dbrr20_pp_ug_n integer --Undergraduate Parent PLUS Loan dollar-based 20-year repayment rate borrower count
dbrr20_pp_ug_num long --Undergraduate Parent PLUS Loan dollar-based 20-year repayment rate numerator
dbrr20_pp_ug_den long --Undergraduate Parent PLUS Loan dollar-based 20-year repayment rate denominator
dbrr20_pp_ug_rt float --Undergraduate Parent PLUS Loan dollar-based 20-year repayment rate
bbrr1_fed_ug_n integer --Undergraduate federal student loan borrower-based 1-year borrower count
bbrr1_fed_ug_dflt float --Percentage of undergraduate federal student loan borrowers in default after 1 year
bbrr1_fed_ug_dlnq float --Percentage of undergraduate federal student loan borrowers in delinquency after 1 year
bbrr1_fed_ug_fbr float --Percentage of undergraduate federal student loan borrowers in forbearance after 1 year
bbrr1_fed_ug_dfr float --Percentage of undergraduate federal student loan borrowers in deferment after 1 year
bbrr1_fed_ug_noprog float --Percentage of undergraduate federal student loan borrowers not making progress after 1 year
bbrr1_fed_ug_makeprog float --Percentage of undergraduate federal student loan borrowers making progress after 1 year
bbrr1_fed_ug_paidinfull float --Percentage of undergraduate federal student loan borrowers paid in full after 1 year
bbrr1_fed_ug_discharge float --Percentage of undergraduate federal student loan borrowers with all loans discharged after 1 year
bbrr1_fed_ugcomp_n integer --Undergraduate completer undergraduate federal student loan borrower-based 1-year borrower count
bbrr1_fed_ugcomp_dflt float --Percentage of undergraduate completer undergraduate federal student loan borrowers in default after 1 year
bbrr1_fed_ugcomp_dlnq float --Percentage of undergraduate completer undergraduate federal student loan borrowers in delinquency after 1 year
bbrr1_fed_ugcomp_fbr float --Percentage of undergraduate completer undergraduate federal student loan borrowers in forbearance after 1 year
bbrr1_fed_ugcomp_dfr float --Percentage of undergraduate completer undergraduate federal student loan borrowers in deferment after 1 year
bbrr1_fed_ugcomp_noprog float --Percentage of undergraduate completer undergraduate federal student loan borrowers not making progress after 1 year
bbrr1_fed_ugcomp_makeprog float --Percentage of undergraduate completer undergraduate federal student loan borrowers making progress after 1 year
bbrr1_fed_ugcomp_paidinfull float --Percentage of undergraduate completer undergraduate federal student loan borrowers paid in full after 1 year
bbrr1_fed_ugcomp_discharge float --Percentage of undergraduate completer undergraduate federal student loan borrowers with all loans discharged after 1 year
bbrr1_fed_ugnocomp_n integer --Undergraduate non-completer undergraduate federal student loan borrower-based 1-year borrower count
bbrr1_fed_ugnocomp_dflt float --Percentage of undergraduate non-completer undergraduate federal student loan borrowers in default after 1 year
bbrr1_fed_ugnocomp_dlnq float --Percentage of undergraduate non-completer undergraduate federal student loan borrowers in delinquency after 1 year
bbrr1_fed_ugnocomp_fbr float --Percentage of undergraduate non-completer undergraduate federal student loan borrowers in forbearance after 1 year
bbrr1_fed_ugnocomp_dfr float --Percentage of undergraduate non-completer undergraduate federal student loan borrowers in deferment after 1 year
bbrr1_fed_ugnocomp_noprog float --Percentage of undergraduate non-completer undergraduate federal student loan borrowers not making progress after 1 year
bbrr1_fed_ugnocomp_makeprog float --Percentage of undergraduate non-completer undergraduate federal student loan borrowers making progress after 1 year
bbrr1_fed_ugnocomp_paidinfull float --Percentage of undergraduate non-completer undergraduate federal student loan borrowers paid in full after 1 year
bbrr1_fed_ugnocomp_discharge float --Percentage of undergraduate non-completer undergraduate federal student loan borrowers with all loans discharged after 1 year
bbrr1_fed_ugunk_n integer --Undergraduate unknown completion status undergraduate federal student loan borrower-based 1-year borrower count
bbrr1_fed_ugunk_dflt float --Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers in default after 1 year
bbrr1_fed_ugunk_dlnq float --Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers in delinquency after 1 year
bbrr1_fed_ugunk_fbr float --Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers in forbearance after 1 year
bbrr1_fed_ugunk_dfr float --Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers in deferment after 1 year
bbrr1_fed_ugunk_noprog float --Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers not making progress after 1 year
bbrr1_fed_ugunk_makeprog float --Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers making progress after 1 year
bbrr1_fed_ugunk_paidinfull float --Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers paid in full after 1 year
bbrr1_fed_ugunk_discharge float --Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers with all loans discharged after 1 year
bbrr1_fed_gr_n integer --Graduate federal student loan borrower-based 1-year borrower count
bbrr1_fed_gr_dflt float --Percentage of graduate federal student loan borrowers in default after 1 year
bbrr1_fed_gr_dlnq float --Percentage of graduate federal student loan borrowers in delinquency after 1 year
bbrr1_fed_gr_fbr float --Percentage of graduate federal student loan borrowers in forbearance after 1 year
bbrr1_fed_gr_dfr float --Percentage of graduate federal student loan borrowers in deferment after 1 year
bbrr1_fed_gr_noprog float --Percentage of graduate federal student loan borrowers not making progress after 1 year
bbrr1_fed_gr_makeprog float --Percentage of graduate federal student loan borrowers making progress after 1 year
bbrr1_fed_gr_paidinfull float --Percentage of graduate federal student loan borrowers paid in full after 1 year
bbrr1_fed_gr_discharge float --Percentage of graduate federal student loan borrowers with all loans discharged after 1 year
bbrr1_fed_grcomp_n integer --Graduate completer graduate federal student loan borrower-based 1-year borrower count
bbrr1_fed_grcomp_dflt float --Percentage of graduate completer graduate federal student loan borrowers in default after 1 year
bbrr1_fed_grcomp_dlnq float --Percentage of graduate completer graduate federal student loan borrowers in delinquency after 1 year
bbrr1_fed_grcomp_fbr float --Percentage of graduate completer graduate federal student loan borrowers in forbearance after 1 year
bbrr1_fed_grcomp_dfr float --Percentage of graduate completer graduate federal student loan borrowers in deferment after 1 year
bbrr1_fed_grcomp_noprog float --Percentage of graduate completer graduate federal student loan borrowers not making progress after 1 year
bbrr1_fed_grcomp_makeprog float --Percentage of graduate completer graduate federal student loan borrowers making progress after 1 year
bbrr1_fed_grcomp_paidinfull float --Percentage of graduate completer graduate federal student loan borrowers paid in full after 1 year
bbrr1_fed_grcomp_discharge float --Percentage of graduate completer graduate federal student loan borrowers with all loans discharged after 1 year
bbrr1_fed_grnocomp_n integer --Graduate non-completer graduate federal student loan borrower-based 1-year borrower count
bbrr1_fed_grnocomp_dflt float --Percentage of graduate non-completer graduate federal student loan borrowers in default after 1 year
bbrr1_fed_grnocomp_dlnq float --Percentage of graduate non-completer graduate federal student loan borrowers in delinquency after 1 year
bbrr1_fed_grnocomp_fbr float --Percentage of graduate non-completer graduate federal student loan borrowers in forbearance after 1 year
bbrr1_fed_grnocomp_dfr float --Percentage of graduate non-completer graduate federal student loan borrowers in deferment after 1 year
bbrr1_fed_grnocomp_noprog float --Percentage of graduate non-completer graduate federal student loan borrowers not making progress after 1 year
bbrr1_fed_grnocomp_makeprog float --Percentage of graduate non-completer graduate federal student loan borrowers making progress after 1 year
bbrr1_fed_grnocomp_paidinfull float --Percentage of graduate non-completer graduate federal student loan borrowers paid in full after 1 year
bbrr1_fed_grnocomp_discharge float --Percentage of graduate non-completer graduate federal student loan borrowers with all loans discharged after 1 year
bbrr1_pp_ug_n integer --Undergraduate student Parent PLUS Loan borrower-based 1-year borrower count
bbrr1_pp_ug_dflt float --Percentage of undergraduate student Parent PLUS Loan borrowers in default after 1 year
bbrr1_pp_ug_dlnq float --Percentage of undergraduate student Parent PLUS Loan borrowers in delinquency after 1 year
bbrr1_pp_ug_fbr float --Percentage of undergraduate student Parent PLUS Loan borrowers in forbearance after 1 year
bbrr1_pp_ug_dfr float --Percentage of undergraduate student Parent PLUS Loan borrowers in deferment after 1 year
bbrr1_pp_ug_noprog float --Percentage of undergraduate student Parent PLUS Loan borrowers not making progress after 1 year
bbrr1_pp_ug_makeprog float --Percentage of undergraduate student Parent PLUS Loan borrowers making progress after 1 year
bbrr1_pp_ug_paidinfull float --Percentage of undergraduate student Parent PLUS Loan borrowers paid in full after 1 year
bbrr1_pp_ug_discharge float --Percentage of undergraduate student Parent PLUS Loan borrowers with all loans discharged after 1 year
bbrr1_pp_ugcomp_n integer --Undergraduate completer undergraduate student Parent PLUS Loan borrower-based 1-year borrower count
bbrr1_pp_ugcomp_dflt float --Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers in default after 1 year
bbrr1_pp_ugcomp_dlnq float --Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers in delinquency after 1 year
bbrr1_pp_ugcomp_fbr float --Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers in forbearance after 1 year
bbrr1_pp_ugcomp_dfr float --Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers in deferment after 1 year
bbrr1_pp_ugcomp_noprog float --Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers not making progress after 1 year
bbrr1_pp_ugcomp_makeprog float --Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers making progress after 1 year
bbrr1_pp_ugcomp_paidinfull float --Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers paid in full after 1 year
bbrr1_pp_ugcomp_discharge float --Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers with all loans discharged after 1 year
bbrr1_pp_ugnocomp_n integer --Undergraduate non-completer undergraduate student Parent PLUS Loan borrower-based 1-year borrower count
bbrr1_pp_ugnocomp_dflt float --Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers in default after 1 year
bbrr1_pp_ugnocomp_dlnq float --Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers in delinquency after 1 year
bbrr1_pp_ugnocomp_fbr float --Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers in forbearance after 1 year
bbrr1_pp_ugnocomp_dfr float --Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers in deferment after 1 year
bbrr1_pp_ugnocomp_noprog float --Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers not making progress after 1 year
bbrr1_pp_ugnocomp_makeprog float --Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers making progress after 1 year
bbrr1_pp_ugnocomp_paidinfull float --Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers paid in full after 1 year
bbrr1_pp_ugnocomp_discharge float --Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers with all loans discharged after 1 year
bbrr1_pp_ugunk_n integer --Undergraduate unknown completion status undergraduate student Parent PLUS Loan borrower-based 1-year borrower count
bbrr1_pp_ugunk_dflt float --Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers in default after 1 year
bbrr1_pp_ugunk_dlnq float --Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers in delinquency after 1 year
bbrr1_pp_ugunk_fbr float --Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers in forbearance after 1 year
bbrr1_pp_ugunk_dfr float --Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers in deferment after 1 year
bbrr1_pp_ugunk_noprog float --Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers not making progress after 1 year
bbrr1_pp_ugunk_makeprog float --Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers making progress after 1 year
bbrr1_pp_ugunk_paidinfull float --Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers paid in full after 1 year
bbrr1_pp_ugunk_discharge float --Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers with all loans discharged after 1 year
bbrr2_fed_ug_n integer --Undergraduate federal student loan borrower-based 2-year borrower count
bbrr2_fed_ug_dflt float --Percentage of undergraduate federal student loan borrowers in default after 2 years
bbrr2_fed_ug_dlnq float --Percentage of undergraduate federal student loan borrowers in delinquency after 2 years
bbrr2_fed_ug_fbr float --Percentage of undergraduate federal student loan borrowers in forbearance after 2 years
bbrr2_fed_ug_dfr float --Percentage of undergraduate federal student loan borrowers in deferment after 2 years
bbrr2_fed_ug_noprog float --Percentage of undergraduate federal student loan borrowers not making progress after 2 years
bbrr2_fed_ug_makeprog float --Percentage of undergraduate federal student loan borrowers making progress after 2 years
bbrr2_fed_ug_paidinfull float --Percentage of undergraduate federal student loan borrowers paid in full after 2 years
bbrr2_fed_ug_discharge float --Percentage of undergraduate federal student loan borrowers with all loans discharged after 2 years
bbrr2_fed_ugcomp_n integer --Undergraduate completer undergraduate federal student loan borrower-based 2-year borrower count
bbrr2_fed_ugcomp_dflt float --Percentage of undergraduate completer undergraduate federal student loan borrowers in default after 2 years
bbrr2_fed_ugcomp_dlnq float --Percentage of undergraduate completer undergraduate federal student loan borrowers in delinquency after 2 years
bbrr2_fed_ugcomp_fbr float --Percentage of undergraduate completer undergraduate federal student loan borrowers in forbearance after 2 years
bbrr2_fed_ugcomp_dfr float --Percentage of undergraduate completer undergraduate federal student loan borrowers in deferment after 2 years
bbrr2_fed_ugcomp_noprog float --Percentage of undergraduate completer undergraduate federal student loan borrowers not making progress after 2 years
bbrr2_fed_ugcomp_makeprog float --Percentage of undergraduate completer undergraduate federal student loan borrowers making progress after 2 years
bbrr2_fed_ugcomp_paidinfull float --Percentage of undergraduate completer undergraduate federal student loan borrowers paid in full after 2 years
bbrr2_fed_ugcomp_discharge float --Percentage of undergraduate completer undergraduate federal student loan borrowers with all loans discharged after 2 years
bbrr2_fed_ugnocomp_n integer --Undergraduate non-completer undergraduate federal student loan borrower-based 2-year borrower count
bbrr2_fed_ugnocomp_dflt float --Percentage of undergraduate non-completer undergraduate federal student loan borrowers in default after 2 years
bbrr2_fed_ugnocomp_dlnq float --Percentage of undergraduate non-completer undergraduate federal student loan borrowers in delinquency after 2 years
bbrr2_fed_ugnocomp_fbr float --Percentage of undergraduate non-completer undergraduate federal student loan borrowers in forbearance after 2 years
bbrr2_fed_ugnocomp_dfr float --Percentage of undergraduate non-completer undergraduate federal student loan borrowers in deferment after 2 years
bbrr2_fed_ugnocomp_noprog float --Percentage of undergraduate non-completer undergraduate federal student loan borrowers not making progress after 2 years
bbrr2_fed_ugnocomp_makeprog float --Percentage of undergraduate non-completer undergraduate federal student loan borrowers making progress after 2 years
bbrr2_fed_ugnocomp_paidinfull float --Percentage of undergraduate non-completer undergraduate federal student loan borrowers paid in full after 2 years
bbrr2_fed_ugnocomp_discharge float --Percentage of undergraduate non-completer undergraduate federal student loan borrowers with all loans discharged after 2 years
bbrr2_fed_ugunk_n integer --Undergraduate unknown completion status undergraduate federal student loan borrower-based 2-year borrower count
bbrr2_fed_ugunk_dflt float --Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers in default after 2 years
bbrr2_fed_ugunk_dlnq float --Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers in delinquency after 2 years
bbrr2_fed_ugunk_fbr float --Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers in forbearance after 2 years
bbrr2_fed_ugunk_dfr float --Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers in deferment after 2 years
bbrr2_fed_ugunk_noprog float --Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers not making progress after 2 years
bbrr2_fed_ugunk_makeprog float --Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers making progress after 2 years
bbrr2_fed_ugunk_paidinfull float --Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers paid in full after 2 years
bbrr2_fed_ugunk_discharge float --Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers with all loans discharged after 2 years
bbrr2_fed_gr_n integer --Graduate federal student loan borrower-based 2-year borrower count
bbrr2_fed_gr_dflt float --Percentage of graduate federal student loan borrowers in default after 2 years
bbrr2_fed_gr_dlnq float --Percentage of graduate federal student loan borrowers in delinquency after 2 years
bbrr2_fed_gr_fbr float --Percentage of graduate federal student loan borrowers in forbearance after 2 years
bbrr2_fed_gr_dfr float --Percentage of graduate federal student loan borrowers in deferment after 2 years
bbrr2_fed_gr_noprog float --Percentage of graduate federal student loan borrowers not making progress after 2 years
bbrr2_fed_gr_makeprog float --Percentage of graduate federal student loan borrowers making progress after 2 years
bbrr2_fed_gr_paidinfull float --Percentage of graduate federal student loan borrowers paid in full after 2 years
bbrr2_fed_gr_discharge float --Percentage of graduate federal student loan borrowers with all loans discharged after 2 years
bbrr2_fed_grcomp_n integer --Graduate completer graduate federal student loan borrower-based 2-year borrower count
bbrr2_fed_grcomp_dflt float --Percentage of graduate completer graduate federal student loan borrowers in default after 2 years
bbrr2_fed_grcomp_dlnq float --Percentage of graduate completer graduate federal student loan borrowers in delinquency after 2 years
bbrr2_fed_grcomp_fbr float --Percentage of graduate completer graduate federal student loan borrowers in forbearance after 2 years
bbrr2_fed_grcomp_dfr float --Percentage of graduate completer graduate federal student loan borrowers in deferment after 2 years
bbrr2_fed_grcomp_noprog float --Percentage of graduate completer graduate federal student loan borrowers not making progress after 2 years
bbrr2_fed_grcomp_makeprog float --Percentage of graduate completer graduate federal student loan borrowers making progress after 2 years
bbrr2_fed_grcomp_paidinfull float --Percentage of graduate completer graduate federal student loan borrowers paid in full after 2 years
bbrr2_fed_grcomp_discharge float --Percentage of graduate completer graduate federal student loan borrowers with all loans discharged after 2 years
bbrr2_fed_grnocomp_n integer --Graduate non-completer graduate federal student loan borrower-based 2-year borrower count
bbrr2_fed_grnocomp_dflt float --Percentage of graduate non-completer graduate federal student loan borrowers in default after 2 years
bbrr2_fed_grnocomp_dlnq float --Percentage of graduate non-completer graduate federal student loan borrowers in delinquency after 2 years
bbrr2_fed_grnocomp_fbr float --Percentage of graduate non-completer graduate federal student loan borrowers in forbearance after 2 years
bbrr2_fed_grnocomp_dfr float --Percentage of graduate non-completer graduate federal student loan borrowers in deferment after 2 years
bbrr2_fed_grnocomp_noprog float --Percentage of graduate non-completer graduate federal student loan borrowers not making progress after 2 years
bbrr2_fed_grnocomp_makeprog float --Percentage of graduate non-completer graduate federal student loan borrowers making progress after 2 years
bbrr2_fed_grnocomp_paidinfull float --Percentage of graduate non-completer graduate federal student loan borrowers paid in full after 2 years
bbrr2_fed_grnocomp_discharge float --Percentage of graduate non-completer graduate federal student loan borrowers with all loans discharged after 2 years
bbrr2_pp_ug_n integer --Undergraduate student Parent PLUS Loan borrower-based 2-year borrower count
bbrr2_pp_ug_dflt float --Percentage of undergraduate student Parent PLUS Loan borrowers in default after 2 years
bbrr2_pp_ug_dlnq float --Percentage of undergraduate student Parent PLUS Loan borrowers in delinquency after 2 years
bbrr2_pp_ug_fbr float --Percentage of undergraduate student Parent PLUS Loan borrowers in forbearance after 2 years
bbrr2_pp_ug_dfr float --Percentage of undergraduate student Parent PLUS Loan borrowers in deferment after 2 years
bbrr2_pp_ug_noprog float --Percentage of undergraduate student Parent PLUS Loan borrowers not making progress after 2 years
bbrr2_pp_ug_makeprog float --Percentage of undergraduate student Parent PLUS Loan borrowers making progress after 2 years
bbrr2_pp_ug_paidinfull float --Percentage of undergraduate student Parent PLUS Loan borrowers paid in full after 2 years
bbrr2_pp_ug_discharge float --Percentage of undergraduate student Parent PLUS Loan borrowers with all loans discharged after 2 years
bbrr2_pp_ugcomp_n integer --Undergraduate completer undergraduate student Parent PLUS Loan borrower-based 2-year borrower count
bbrr2_pp_ugcomp_dflt float --Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers in default after 2 years
bbrr2_pp_ugcomp_dlnq float --Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers in delinquency after 2 years
bbrr2_pp_ugcomp_fbr float --Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers in forbearance after 2 years
bbrr2_pp_ugcomp_dfr float --Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers in deferment after 2 years
bbrr2_pp_ugcomp_noprog float --Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers not making progress after 2 years
bbrr2_pp_ugcomp_makeprog float --Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers making progress after 2 years
bbrr2_pp_ugcomp_paidinfull float --Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers paid in full after 2 years
bbrr2_pp_ugcomp_discharge float --Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers with all loans discharged after 2 years
bbrr2_pp_ugnocomp_n integer --Undergraduate non-completer undergraduate student Parent PLUS Loan borrower-based 2-year borrower count
bbrr2_pp_ugnocomp_dflt float --Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers in default after 2 years
bbrr2_pp_ugnocomp_dlnq float --Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers in delinquency after 2 years
bbrr2_pp_ugnocomp_fbr float --Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers in forbearance after 2 years
bbrr2_pp_ugnocomp_dfr float --Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers in deferment after 2 years
bbrr2_pp_ugnocomp_noprog float --Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers not making progress after 2 years
bbrr2_pp_ugnocomp_makeprog float --Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers making progress after 2 years
bbrr2_pp_ugnocomp_paidinfull float --Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers paid in full after 2 years
bbrr2_pp_ugnocomp_discharge float --Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers with all loans discharged after 2 years
bbrr2_pp_ugunk_n integer --Undergraduate unknown completion status undergraduate student Parent PLUS Loan borrower-based 2-year borrower count
bbrr2_pp_ugunk_dflt float --Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers in default after 2 years
bbrr2_pp_ugunk_dlnq float --Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers in delinquency after 2 years
bbrr2_pp_ugunk_fbr float --Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers in forbearance after 2 years
bbrr2_pp_ugunk_dfr float --Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers in deferment after 2 years
bbrr2_pp_ugunk_noprog float --Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers not making progress after 2 years
bbrr2_pp_ugunk_makeprog float --Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers making progress after 2 years
bbrr2_pp_ugunk_paidinfull float --Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers paid in full after 2 years
bbrr2_pp_ugunk_discharge float --Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers with all loans discharged after 2 years
bbrr2_fed_ug_n_supp integer --Undergraduate federal student loan borrower-based 2-year borrower count, suppressed for n<30
bbrr2_fed_ug_dflt_supp float --Percentage of undergraduate federal student loan borrowers in default after 2 years, suppressed for n<30
bbrr2_fed_ug_dlnq_supp float --Percentage of undergraduate federal student loan borrowers in delinquency after 2 years, suppressed for n<30
bbrr2_fed_ug_fbr_supp float --Percentage of undergraduate federal student loan borrowers in forbearance after 2 years, suppressed for n<30
bbrr2_fed_ug_dfr_supp float --Percentage of undergraduate federal student loan borrowers in deferment after 2 years, suppressed for n<30
bbrr2_fed_ug_noprog_supp float --Percentage of undergraduate federal student loan borrowers not making progress after 2 years, suppressed for n<30
bbrr2_fed_ug_makeprog_supp float --Percentage of undergraduate federal student loan borrowers making progress after 2 years, suppressed for n<30
bbrr2_fed_ug_paidinfull_supp float --Percentage of undergraduate federal student loan borrowers paid in full after 2 years, suppressed for n<30
bbrr2_fed_ug_discharge_supp float --Percentage of undergraduate federal student loan borrowers with all loans discharged after 2 years, suppressed for n<30
bbrr2_fed_ugcomp_n_supp integer --Undergraduate completer undergraduate federal student loan borrower-based 2-year borrower count, suppressed for n<30
bbrr2_fed_ugcomp_dflt_supp float --Percentage of undergraduate completer undergraduate federal student loan borrowers in default after 2 years, suppressed for n<30
bbrr2_fed_ugcomp_dlnq_supp float --Percentage of undergraduate completer undergraduate federal student loan borrowers in delinquency after 2 years, suppressed for n<30
bbrr2_fed_ugcomp_fbr_supp float --Percentage of undergraduate completer undergraduate federal student loan borrowers in forbearance after 2 years, suppressed for n<30
bbrr2_fed_ugcomp_dfr_supp float --Percentage of undergraduate completer undergraduate federal student loan borrowers in deferment after 2 years, suppressed for n<30
bbrr2_fed_ugcomp_noprog_supp float --Percentage of undergraduate completer undergraduate federal student loan borrowers not making progress after 2 years, suppressed for n<30
bbrr2_fed_ugcomp_makeprog_supp float --Percentage of undergraduate completer undergraduate federal student loan borrowers making progress after 2 years, suppressed for n<30
bbrr2_fed_ugcomp_paidinfull_supp float --Percentage of undergraduate completer undergraduate federal student loan borrowers paid in full after 2 years, suppressed for n<30
bbrr2_fed_ugcomp_discharge_supp float --Percentage of undergraduate completer undergraduate federal student loan borrowers with all loans discharged after 2 years, suppressed for n<30
lpstafford_cnt integer --Number of borrowers with outstanding federal Direct Loan balances
lpstafford_amt long --Total outstanding federal Direct Loan balance
lppplus_cnt integer --Number of students associated with outstanding Parent PLUS Loan balances
lppplus_amt long --Total outstanding Parent PLUS Loan balance
lpgplus_cnt integer --Number of students associated with outstanding Grad PLUS Loan balances
lpgplus_amt long --Total outstanding Grad PLUS Loan balance
fedschcd string --Federal School Code
booksupply integer --Cost of attendance: estimated books and supplies
roomboard_on integer --Cost of attendance: on-campus room and board
otherexpense_on integer --Cost of attendance: on-campus other expenses
roomboard_off integer --Cost of attendance: off-campus room and board
otherexpense_off integer --Cost of attendance: off-campus other expenses
otherexpense_fam integer --Cost of attendance: with-family other expenses
endowbegin long --Value of school's endowment at the beginning of the fiscal year
endowend long --Value of school's endowment at the end of the fiscal year
dolprovider integer --DOL approved training provider indicator
admcon7 integer --Test score requirements for admission
mdcomp_pd float --Median completion rate amongst insitutions with the same predominant degree category 
mdcost_pd float --Median average net price amongst insitituions with the same predominant degree category
mdearn_pd float --Median earnings of students working and not enrolled 10 years after entry
mdcomp_all float --Overall median of completion rate
mdcost_all float --Overall median for average net price 
mdearn_all float --Overall median earnings of students working and not enrolled 10 years after entry
d150_l4_pell_pooled integer --Adjusted cohort count for Pell Grant recipient completion rate at less-than-four-year institutions (denominator of 150% completion rate), pooled for two-year rolling averages
c150_l4_pell_pooled float --Pell Grant recipient completion rate at less-than-four-year institutions, pooled for two-year rolling averages
d150_4_pell_pooled integer --Adjusted cohort count for Pell Grant recipient completion rate at four-year institutions (denominator of 150% completion rate), pooled for two-year rolling averages
c150_4_pell_pooled float --First-time, full-time Pell Grant recipient completion rate at four-year institutions, pooled for two-year rolling averages
c150_l4_pell_pooled_supp float --First-time, full-time Pell Grant recipient completion rate at less-than-four-year institutions, pooled for two-year rolling averages and suppressed for small n size
c150_4_pell_pooled_supp float --First-time, full-time Pell Grant recipient completion rate at four-year institutions, pooled for two-year rolling averages and suppressed for small n size
poolyrs150_pell integer --Years used for rolling averages of Pell Grant recipient completion rate C150_PELL_[4/L4]_POOLED
omenryp_pell_all float --Percentage of all Pell Grant recipient students that did not receive an award and are still enrolled at this institution 8 years after entry
omenrap_pell_all float --Percentage of all Pell Grant recipient students that did not receive an award and enrolled at another institution after leaving this institution within 8 years of entry
omawdp8_pell_all float --Percentage of all Pell Grant recipient students receiving an award within 8 years of entry
omenrup_pell_all float --Percentage of all Pell Grant recipient students that did not receive an award and whose enrollment status is unknown after leaving this institution within 8 years of entry
omenryp_pell_firsttime float --Percentage of first-time Pell Grant recipient students that did not receive an award and are still enrolled at this institution 8 years after entry
omenrap_pell_firsttime float --Percentage of first-time Pell Grant recipient students that did not receive an award and enrolled at another institution after leaving this institution within 8 years of entry
omawdp8_pell_firsttime float --Percentage of first-time Pell Grant recipient students receiving an award within 8 years of entry
omenrup_pell_firsttime float --Percentage of first-time Pell Grant recipient students that did not receive an award and whose enrollment status is unknown after leaving this institution within 8 years of entry
omenryp_pell_notfirsttime float --Percentage of not first-time Pell Grant recipient students that did not receive an award and are still enrolled at this institution 8 years after entry
omenrap_pell_notfirsttime float --Percentage of not first-time Pell Grant recipient students that did not receive an award and enrolled at another institution after leaving this institution within 8 years of entry
omawdp8_pell_notfirsttime float --Percentage of not first-time Pell Grant recipient students receiving an award within 8 years of entry
omenrup_pell_notfirsttime float --Percentage of not first-time Pell Grant recipient students that did not receive an award and whose enrollment status is unknown after leaving this institution within 8 years of entry
omenryp_pell_fulltime float --Percentage of full-time Pell Grant recipient students that did not receive an award and are still enrolled at this institution 8 years after entry
omenrap_pell_fulltime float --Percentage of full-time Pell Grant recipient students that did not receive an award and enrolled at another institution after leaving this institution within 8 years of entry
omawdp8_pell_fulltime float --Percentage of full-time Pell Grant recipient students receiving an award within 8 years of entry
omenrup_pell_fulltime float --Percentage of full-time Pell Grant recipient students that did not receive an award and whose enrollment status is unknown after leaving this institution within 8 years of entry
omenryp_pell_parttime float --Percentage of part-time Pell Grant recipient students that did not receive an award and are still enrolled at this institution 8 years after entry
omenrap_pell_parttime float --Percentage of part-time Pell Grant recipient students that did not receive an award and enrolled at another institution after leaving this institution within 8 years of entry
omawdp8_pell_parttime float --Percentage of part-time Pell Grant recipient students receiving an award within 8 years of entry
omenrup_pell_parttime float --Percentage of part-time Pell Grant recipient students that did not receive an award and whose enrollment status is unknown after leaving this institution within 8 years of entry
omacht8_pell_ftft integer --Adjusted cohort count of full-time, first-time Pell Grant recipient students (denominator for the 8-year outcomes percentages)
omawdp8_pell_ftft float --Percentage of full-time, first-time Pell Grant recipient students receiving an award within 8 years of entry
omenryp8_pell_ftft float --Percentage of full-time, first-time Pell Grant recipient students that did not receive an award and are still enrolled at this institution 8 years after entry
omenrap8_pell_ftft float --Percentage of full-time, first-time Pell Grant recipient students that did not receive an award and enrolled at another institution after leaving this institution within 8 years of entry
omenrup8_pell_ftft float --Percentage of full-time, first-time Pell Grant recipient students that did not receive an award and whose enrollment status is unknown after leaving this institution within 8 years of entry
omacht8_pell_ptft integer --Adjusted cohort count of part-time, first-time Pell Grant recipient students (denominator for the 8-year outcomes percentages)
omawdp8_pell_ptft float --Percentage of part-time, first-time Pell Grant recipient students receiving an award within 8 years of entry
omenryp8_pell_ptft float --Percentage of part-time, first-time Pell Grant recipient students that did not receive an award and are still enrolled at this institution 8 years after entry
omenrap8_pell_ptft float --Percentage of part-time, first-time Pell Grant recipient students that did not receive an award and enrolled at another institution after leaving this institution within 8 years of entry
omenrup8_pell_ptft float --Percentage of part-time, first-time Pell Grant recipient students that did not receive an award and whose enrollment status is unknown after leaving this institution within 8 years of entry
omacht8_pell_ftnft integer --Adjusted cohort count of full-time, not first-time Pell Grant recipient students (denominator for the 8-year outcomes percentages)
omawdp8_pell_ftnft float --Percentage of full-time, not first-time Pell Grant recipient students receiving an award within 8 years of entry
omenryp8_pell_ftnft float --Percentage of full-time, not first-time Pell Grant recipient students that did not receive an award and are still enrolled at this institution 8 years after entry
omenrap8_pell_ftnft float --Percentage of full-time, not first-time Pell Grant recipient students that did not receive an award and enrolled at another institution after leaving this institution within 8 years of entry
omenrup8_pell_ftnft float --Percentage of full-time, not first-time Pell Grant recipient students that did not receive an award and whose enrollment status is unknown after leaving this institution within 8 years of entry
omacht8_pell_ptnft integer --Adjusted cohort count of part-time, not first-time Pell Grant recipient students (denominator for the 8-year outcomes percentages)
omawdp8_pell_ptnft float --Percentage of part-time, not first-time Pell Grant recipient students receiving an award within 8 years of entry
omenryp8_pell_ptnft float --Percentage of part-time, not first-time Pell Grant recipient students that did not receive an award and are still enrolled at this institution 8 years after entry
omenrap8_pell_ptnft float --Percentage of part-time, not first-time Pell Grant recipient students that did not receive an award and enrolled at another institution after leaving this institution within 8 years of entry
omenrup8_pell_ptnft float --Percentage of part-time, not first-time Pell Grant recipient students that did not receive an award and whose enrollment status is unknown after leaving this institution within 8 years of entry
omacht8_pell_ftft_pooled integer --Adjusted cohort count of full-time, first-time Pell Grant recipient students (denominator for the 8-year outcomes percentages), pooled across years.
omacht8_pell_ptft_pooled integer --Adjusted cohort count of part-time, first-time Pell Grant recipient students (denominator for the 8-year outcomes percentages), pooled across years.
omacht8_pell_ftnft_pooled integer --Adjusted cohort count of full-time, not first-time Pell Grant recipient students (denominator for the 8-year outcomes percentages), pooled across years.
omacht8_pell_ptnft_pooled integer --Adjusted cohort count of part-time, not first-time Pell Grant recipient students (denominator for the 8-year outcomes percentages), pooled across years.
omawdp8_pell_ftft_pooled float --Percentage of full-time, first-time Pell Grant recipient students receiving an award within 8 years of entry, pooled in rolling averages.
omenryp8_pell_ftft_pooled float --Percentage of full-time, first-time Pell Grant recipient students that did not receive an award and are still enrolled at this institution 8 years after entry, pooled in rolling averages.
omenrap8_pell_ftft_pooled float --Percentage of full-time, first-time Pell Grant recipient students that did not receive an award and enrolled at another institution after leaving this institution within 8 years of entry, pooled in rolling averages.
omenrup8_pell_ftft_pooled float --Percentage of full-time, first-time Pell Grant recipient students that did not receive an award and whose enrollment status is unknown after leaving this institution within 8 years of entry, pooled in rolling averages.
omawdp8_pell_ptft_pooled float --Percentage of part-time, first-time Pell Grant recipient students receiving an award within 8 years of entry, pooled in rolling averages.
omenryp8_pell_ptft_pooled float --Percentage of part-time, first-time Pell Grant recipient students that did not receive an award and are still enrolled at this institution 8 years after entry, pooled in rolling averages.
omenrap8_pell_ptft_pooled float --Percentage of part-time, first-time Pell Grant recipient students that did not receive an award and enrolled at another institution after leaving this institution within 8 years of entry, pooled in rolling averages.
omenrup8_pell_ptft_pooled float --Percentage of part-time, first-time Pell Grant recipient students that did not receive an award and whose enrollment status is unknown after leaving this institution within 8 years of entry, pooled in rolling averages.
omawdp8_pell_ftnft_pooled float --Percentage of full-time, not first-time Pell Grant recipient students receiving an award within 8 years of entry, pooled in rolling averages.
omenryp8_pell_ftnft_pooled float --Percentage of full-time, not first-time Pell Grant recipient students that did not receive an award and are still enrolled at this institution 8 years after entry, pooled in rolling averages.
omenrap8_pell_ftnft_pooled float --Percentage of full-time, not first-time Pell Grant recipient students that did not receive an award and enrolled at another institution after leaving this institution within 8 years of entry, pooled in rolling averages.
omenrup8_pell_ftnft_pooled float --Percentage of full-time, not first-time Pell Grant recipient students that did not receive an award and whose enrollment status is unknown after leaving this institution within 8 years of entry, pooled in rolling averages.
omawdp8_pell_ptnft_pooled float --Percentage of part-time, not first-time Pell Grant recipient students receiving an award within 8 years of entry, pooled in rolling averages.
omenryp8_pell_ptnft_pooled float --Percentage of part-time, not first-time Pell Grant recipient students that did not receive an award and are still enrolled at this institution 8 years after entry, pooled in rolling averages.
omenrap8_pell_ptnft_pooled float --Percentage of part-time, not first-time Pell Grant recipient students that did not receive an award and enrolled at another institution after leaving this institution within 8 years of entry, pooled in rolling averages.
omenrup8_pell_ptnft_pooled float --Percentage of part-time, not first-time Pell Grant recipient students that did not receive an award and whose enrollment status is unknown after leaving this institution within 8 years of entry, pooled in rolling averages.
omenryp_pell_all_pooled float --Percentage of all Pell Grant recipient students that did not receive an award and are still enrolled at this institution 8 years after entry, pooled in rolling averages and suppressed for small n size
omenrap_pell_all_pooled float --Percentage of all Pell Grant recipient students that did not receive an award and enrolled at another institution after leaving this institution within 8 years of entry, pooled in rolling averages and suppressed for small n size
omawdp8_pell_all_pooled float --Percentage of all Pell Grant recipient students receiving an award within 8 years of entry, pooled in rolling averages and suppressed for small n size
omenrup_pell_all_pooled float --Percentage of all Pell Grant recipient students that did not receive an award and whose enrollment status is unknown after leaving this institution within 8 years of entry, pooled in rolling averages and suppressed for small n size
omenryp_pell_ftt_pooled float --Percentage of first-time Pell Grant recipient students that did not receive an award and are still enrolled at this institution 8 years after entry, pooled in rolling averages and suppressed for small n size
omenrap_pell_ftt_pooled float --Percentage of first-time Pell Grant recipient students that did not receive an award and enrolled at another institution after leaving this institution within 8 years of entry, pooled in rolling averages and suppressed for small n size
omawdp8_pell_ftt_pooled float --Percentage of first-time Pell Grant recipient students receiving an award within 8 years of entry, pooled in rolling averages and suppressed for small n size
omenrup_pell_ftt_pooled float --Percentage of first-time Pell Grant recipient students that did not receive an award and whose enrollment status is unknown after leaving this institution within 8 years of entry, pooled in rolling averages and suppressed for small n size
omenryp_pell_nft_pooled float --Percentage of not first-time Pell Grant recipient students that did not receive an award and are still enrolled at this institution 8 years after entry, pooled in rolling averages and suppressed for small n size
omenrap_pell_nft_pooled float --Percentage of not first-time Pell Grant recipient students that did not receive an award and enrolled at another institution after leaving this institution within 8 years of entry, pooled in rolling averages and suppressed for small n size
omawdp8_pell_nft_pooled float --Percentage of not first-time Pell Grant recipient students receiving an award within 8 years of entry, pooled in rolling averages and suppressed for small n size
omenrup_pell_nft_pooled float --Percentage of not first-time Pell Grant recipient students that did not receive an award and whose enrollment status is unknown after leaving this institution within 8 years of entry, pooled in rolling averages and suppressed for small n size
omenryp_pell_ft_pooled float --Percentage of full-time Pell Grant recipient students that did not receive an award and are still enrolled at this institution 8 years after entry, pooled in rolling averages and suppressed for small n size
omenrap_pell_ft_pooled float --Percentage of full-time Pell Grant recipient students that did not receive an award and enrolled at another institution after leaving this institution within 8 years of entry, pooled in rolling averages and suppressed for small n size
omawdp8_pell_ft_pooled float --Percentage of full-time Pell Grant recipient students receiving an award within 8 years of entry, pooled in rolling averages and suppressed for small n size
omenrup_pell_ft_pooled float --Percentage of full-time Pell Grant recipient students that did not receive an award and whose enrollment status is unknown after leaving this institution within 8 years of entry, pooled in rolling averages and suppressed for small n size
omenryp_pell_pt_pooled float --Percentage of part-time Pell Grant recipient students that did not receive an award and are still enrolled at this institution 8 years after entry, pooled in rolling averages and suppressed for small n size
omenrap_pell_pt_pooled float --Percentage of part-time Pell Grant recipient students that did not receive an award and enrolled at another institution after leaving this institution within 8 years of entry, pooled in rolling averages and suppressed for small n size
omawdp8_pell_pt_pooled float --Percentage of part-time Pell Grant recipient students receiving an award within 8 years of entry, pooled in rolling averages and suppressed for small n size
omenrup_pell_pt_pooled float --Percentage of part-time Pell Grant recipient students that did not receive an award and whose enrollment status is unknown after leaving this institution within 8 years of entry, pooled in rolling averages and suppressed for small n size
poolyrsom_pell_ftft float --Years used for rolling averages of outcome metrics OM[ACHT6/AWDP6/ACHT8/AWDP8/ENRAP8/ENRYP8/ENRUP8]_PELL_FTFT_POOLED
poolyrsom_pell_ptft float --Years used for rolling averages of outcome metrics OM[ACHT6/AWDP6/ACHT8/AWDP8/ENRAP8/ENRYP8/ENRUP8]_PELL_PTFT_POOLED
poolyrsom_pell_ftnft float --Years used for rolling averages of outcome metrics OM[ACHT6/AWDP6/ACHT8/AWDP8/ENRAP8/ENRYP8/ENRUP8]_PELL_FTNFT_POOLED
poolyrsom_pell_ptnft float --Years used for rolling averages of outcome metrics OM[ACHT6/AWDP6/ACHT8/AWDP8/ENRAP8/ENRYP8/ENRUP8]_PELL_PTNFT_POOLED
poolyrsom_pell_all float --Years used for rolling averages of outcome metrics OM[AWDP8/ENRAP8/ENRYP8/ENRUP8]_PELL_ALL_POOLED
poolyrsom_pell_firsttime float --Years used for rolling averages of outcome metrics OM[AWDP8/ENRAP8/ENRYP8/ENRUP8]_PELL_FTT_POOLED
poolyrsom_pell_notfirsttime float --Years used for rolling averages of outcome metrics OM[AWDP8/ENRAP8/ENRYP8/ENRUP8]_PELL_NFT_POOLED
poolyrsom_pell_fulltime float --Years used for rolling averages of outcome metrics OM[AWDP8/ENRAP8/ENRYP8/ENRUP8]_PELL_FT_POOLED
poolyrsom_pell_parttime float --Years used for rolling averages of outcome metrics OM[AWDP8/ENRAP8/ENRYP8/ENRUP8]_PELL_PT_POOLED
omawdp8_pell_ftft_pooled_supp float --Percentage of full-time, first-time Pell Grant recipient students receiving an award within 8 years of entry, pooled in rolling averages and suppressed for small n size
omenryp8_pell_ftft_pooled_supp float --Percentage of full-time, first-time Pell Grant recipient students that did not receive an award and are still enrolled at this institution 8 years after entry, pooled in rolling averages and suppressed for small n size
omenrap8_pell_ftft_pooled_supp float --Percentage of full-time, first-time Pell Grant recipient students that did not receive an award and enrolled at another institution after leaving this institution within 8 years of entry, pooled in rolling averages and suppressed for small n size
omenrup8_pell_ftft_pooled_supp float --Percentage of full-time, first-time Pell Grant recipient students that did not receive an award and whose enrollment status is unknown after leaving this institution within 8 years of entry, pooled in rolling averages and suppressed for small n size
omawdp8_pell_ptft_pooled_supp float --Percentage of part-time, first-time Pell Grant recipient students receiving an award within 8 years of entry, pooled in rolling averages and suppressed for small n size
omenryp8_pell_ptft_pooled_supp float --Percentage of part-time, first-time Pell Grant recipient students that did not receive an award and are still enrolled at this institution 8 years after entry, pooled in rolling averages and suppressed for small n size
omenrap8_pell_ptft_pooled_supp float --Percentage of part-time, first-time Pell Grant recipient students that did not receive an award and enrolled at another institution after leaving this institution within 8 years of entry, pooled in rolling averages and suppressed for small n size
omenrup8_pell_ptft_pooled_supp float --Percentage of part-time, first-time Pell Grant recipient students that did not receive an award and whose enrollment status is unknown after leaving this institution within 8 years of entry, pooled in rolling averages and suppressed for small n size
omawdp8_pell_ftnft_pooled_supp float --Percentage of full-time, not first-time Pell Grant recipient students receiving an award within 8 years of entry, pooled in rolling averages and suppressed for small n size
omenryp8_pell_ftnft_pooled_supp float --Percentage of full-time, not first-time Pell Grant recipient students that did not receive an award and are still enrolled at this institution 8 years after entry, pooled in rolling averages and suppressed for small n size
omenrap8_pell_ftnft_pooled_supp float --Percentage of full-time, not first-time Pell Grant recipient students that did not receive an award and enrolled at another institution after leaving this institution within 8 years of entry, pooled in rolling averages and suppressed for small n size
omenrup8_pell_ftnft_pooled_supp float --Percentage of full-time, not first-time Pell Grant recipient students that did not receive an award and whose enrollment status is unknown after leaving this institution within 8 years of entry, pooled in rolling averages and suppressed for small n size
omawdp8_pell_ptnft_pooled_supp float --Percentage of part-time, not first-time Pell Grant recipient students receiving an award within 8 years of entry, pooled in rolling averages and suppressed for small n size
omenryp8_pell_ptnft_pooled_supp float --Percentage of part-time, not first-time Pell Grant recipient students that did not receive an award and are still enrolled at this institution 8 years after entry, pooled in rolling averages and suppressed for small n size
omenrap8_pell_ptnft_pooled_supp float --Percentage of part-time, not first-time Pell Grant recipient students that did not receive an award and enrolled at another institution after leaving this institution within 8 years of entry, pooled in rolling averages and suppressed for small n size
omenrup8_pell_ptnft_pooled_supp float --Percentage of part-time, not first-time Pell Grant recipient students that did not receive an award and whose enrollment status is unknown after leaving this institution within 8 years of entry, pooled in rolling averages and suppressed for small n size
omenryp_pell_all_pooled_supp float --Percentage of all Pell Grant recipient students that did not receive an award and are still enrolled at this institution 8 years after entry, pooled in rolling averages and suppressed for small n size
omenrap_pell_all_pooled_supp float --Percentage of all Pell Grant recipient students that did not receive an award and enrolled at another institution after leaving this institution within 8 years of entry, pooled in rolling averages and suppressed for small n size
omawdp8_pell_all_pooled_supp float --Percentage of all Pell Grant recipient students receiving an award within 8 years of entry, pooled in rolling averages and suppressed for small n size
omenrup_pell_all_pooled_supp float --Percentage of all Pell Grant recipient students that did not receive an award and whose enrollment status is unknown after leaving this institution within 8 years of entry, pooled in rolling averages and suppressed for small n size
omenryp_pell_ftt_pooled_supp float --Percentage of first-time Pell Grant recipient students that did not receive an award and are still enrolled at this institution 8 years after entry, pooled in rolling averages and suppressed for small n size
omenrap_pell_ftt_pooled_supp float --Percentage of first-time Pell Grant recipient students that did not receive an award and enrolled at another institution after leaving this institution within 8 years of entry, pooled in rolling averages and suppressed for small n size
omawdp8_pell_ftt_pooled_supp float --Percentage of first-time Pell Grant recipient students receiving an award within 8 years of entry, pooled in rolling averages and suppressed for small n size
omenrup_pell_ftt_pooled_supp float --Percentage of first-time Pell Grant recipient students that did not receive an award and whose enrollment status is unknown after leaving this institution within 8 years of entry, pooled in rolling averages and suppressed for small n size
omenryp_pell_nft_pooled_supp float --Percentage of not first-time Pell Grant recipient students that did not receive an award and are still enrolled at this institution 8 years after entry, pooled in rolling averages and suppressed for small n size
omenrap_pell_nft_pooled_supp float --Percentage of not first-time Pell Grant recipient students that did not receive an award and enrolled at another institution after leaving this institution within 8 years of entry, pooled in rolling averages and suppressed for small n size
omawdp8_pell_nft_pooled_supp float --Percentage of not first-time Pell Grant recipient students receiving an award within 8 years of entry, pooled in rolling averages and suppressed for small n size
omenrup_pell_nft_pooled_supp float --Percentage of not first-time Pell Grant recipient students that did not receive an award and whose enrollment status is unknown after leaving this institution within 8 years of entry, pooled in rolling averages and suppressed for small n size
omenryp_pell_ft_pooled_supp float --Percentage of full-time Pell Grant recipient students that did not receive an award and are still enrolled at this institution 8 years after entry, pooled in rolling averages and suppressed for small n size
omenrap_pell_ft_pooled_supp float --Percentage of full-time Pell Grant recipient students that did not receive an award and enrolled at another institution after leaving this institution within 8 years of entry, pooled in rolling averages and suppressed for small n size
omawdp8_pell_ft_pooled_supp float --Percentage of full-time Pell Grant recipient students receiving an award within 8 years of entry, pooled in rolling averages and suppressed for small n size
omenrup_pell_ft_pooled_supp float --Percentage of full-time Pell Grant recipient students that did not receive an award and whose enrollment status is unknown after leaving this institution within 8 years of entry, pooled in rolling averages and suppressed for small n size
omenryp_pell_pt_pooled_supp float --Percentage of part-time Pell Grant recipient students that did not receive an award and are still enrolled at this institution 8 years after entry, pooled in rolling averages and suppressed for small n size
omenrap_pell_pt_pooled_supp float --Percentage of part-time Pell Grant recipient students that did not receive an award and enrolled at another institution after leaving this institution within 8 years of entry, pooled in rolling averages and suppressed for small n size
omawdp8_pell_pt_pooled_supp float --Percentage of part-time Pell Grant recipient students receiving an award within 8 years of entry, pooled in rolling averages and suppressed for small n size
omenrup_pell_pt_pooled_supp float --Percentage of part-time Pell Grant recipient students that did not receive an award and whose enrollment status is unknown after leaving this institution within 8 years of entry, pooled in rolling averages and suppressed for small n size
bbrr1_fed_ind_n integer --Independent federal student loan borrower-based 1-year borrower count
bbrr1_fed_ind_dflt string --Percentage of independent federal student loan borrowers in default after 1 year
bbrr1_fed_ind_dlnq string --Percentage of independent federal student loan borrowers in delinquency after 1 year
bbrr1_fed_ind_fbr string --Percentage of independent federal student loan borrowers in forbearance after 1 year
bbrr1_fed_ind_dfr string --Percentage of independent federal student loan borrowers in deferment after 1 year
bbrr1_fed_ind_noprog string --Percentage of independent federal student loan borrowers not making progress after 1 year
bbrr1_fed_ind_makeprog string --Percentage of independent federal student loan borrowers making progress after 1 year
bbrr1_fed_ind_paidinfull string --Percentage of independent federal student loan borrowers paid in full after 1 year
bbrr1_fed_ind_discharge string --Percentage of independent federal student loan borrowers with all loans discharged after 1 year
bbrr1_fed_dep_n integer --Dependent federal student loan borrower-based 1-year borrower count
bbrr1_fed_dep_dflt string --Percentage of dependent federal student loan borrowers in default after 1 year
bbrr1_fed_dep_dlnq string --Percentage of dependent federal student loan borrowers in delinquency after 1 year
bbrr1_fed_dep_fbr string --Percentage of dependent federal student loan borrowers in forbearance after 1 year
bbrr1_fed_dep_dfr string --Percentage of dependent federal student loan borrowers in deferment after 1 year
bbrr1_fed_dep_noprog string --Percentage of dependent federal student loan borrowers not making progress after 1 year
bbrr1_fed_dep_makeprog string --Percentage of dependent federal student loan borrowers making progress after 1 year
bbrr1_fed_dep_paidinfull string --Percentage of dependent federal student loan borrowers paid in full after 1 year
bbrr1_fed_dep_discharge string --Percentage of dependent federal student loan borrowers with all loans discharged after 1 year
bbrr1_fed_pell_n integer --Pell Grant recipient federal student loan borrower-based 1-year borrower count
bbrr1_fed_pell_dflt string --Percentage of Pell Grant recipient federal student loan borrowers in default after 1 year
bbrr1_fed_pell_dlnq string --Percentage of Pell Grant recipient federal student loan borrowers in delinquency after 1 year
bbrr1_fed_pell_fbr string --Percentage of Pell Grant recipient federal student loan borrowers in forbearance after 1 year
bbrr1_fed_pell_dfr string --Percentage of Pell Grant recipient federal student loan borrowers in deferment after 1 year
bbrr1_fed_pell_noprog string --Percentage of Pell Grant recipient federal student loan borrowers not making progress after 1 year
bbrr1_fed_pell_makeprog string --Percentage of Pell Grant recipient federal student loan borrowers making progress after 1 year
bbrr1_fed_pell_paidinfull string --Percentage of Pell Grant recipient federal student loan borrowers paid in full after 1 year
bbrr1_fed_pell_discharge string --Percentage of Pell Grant recipient federal student loan borrowers with all loans discharged after 1 year
bbrr1_fed_nopell_n integer --Non-Pell Grant recipient federal student loan borrower-based 1-year borrower count
bbrr1_fed_nopell_dflt string --Percentage of non-Pell Grant recipient federal student loan borrowers in default after 1 year
bbrr1_fed_nopell_dlnq string --Percentage of non-Pell Grant recipient federal student loan borrowers in delinquency after 1 year
bbrr1_fed_nopell_fbr string --Percentage of non-Pell Grant recipient federal student loan borrowers in forbearance after 1 year
bbrr1_fed_nopell_dfr string --Percentage of non-Pell Grant recipient federal student loan borrowers in deferment after 1 year
bbrr1_fed_nopell_noprog string --Percentage of non-Pell Grant recipient federal student loan borrowers not making progress after 1 year
bbrr1_fed_nopell_makeprog string --Percentage of non-Pell Grant recipient federal student loan borrowers making progress after 1 year
bbrr1_fed_nopell_paidinfull string --Percentage of non-Pell Grant recipient federal student loan borrowers paid in full after 1 year
bbrr1_fed_nopell_discharge string --Percentage of non-Pell Grant recipient federal student loan borrowers with all loans discharged after 1 year
bbrr1_fed_male_n integer --Male federal student loan borrower-based 1-year borrower count
bbrr1_fed_male_dflt string --Percentage of male federal student loan borrowers in default after 1 year
bbrr1_fed_male_dlnq string --Percentage of male federal student loan borrowers in delinquency after 1 year
bbrr1_fed_male_fbr string --Percentage of male federal student loan borrowers in forbearance after 1 year
bbrr1_fed_male_dfr string --Percentage of male federal student loan borrowers in deferment after 1 year
bbrr1_fed_male_noprog string --Percentage of male federal student loan borrowers not making progress after 1 year
bbrr1_fed_male_makeprog string --Percentage of male federal student loan borrowers making progress after 1 year
bbrr1_fed_male_paidinfull string --Percentage of male federal student loan borrowers paid in full after 1 year
bbrr1_fed_male_discharge string --Percentage of male federal student loan borrowers with all loans discharged after 1 year
bbrr1_fed_nomale_n integer --Non-male federal student loan borrower-based 1-year borrower count
bbrr1_fed_nomale_dflt string --Percentage of non-male federal student loan borrowers in default after 1 year
bbrr1_fed_nomale_dlnq string --Percentage of non-male federal student loan borrowers in delinquency after 1 year
bbrr1_fed_nomale_fbr string --Percentage of non-male federal student loan borrowers in forbearance after 1 year
bbrr1_fed_nomale_dfr string --Percentage of non-male federal student loan borrowers in deferment after 1 year
bbrr1_fed_nomale_noprog string --Percentage of non-male federal student loan borrowers not making progress after 1 year
bbrr1_fed_nomale_makeprog string --Percentage of non-male federal student loan borrowers making progress after 1 year
bbrr1_fed_nomale_paidinfull string --Percentage of non-male federal student loan borrowers paid in full after 1 year
bbrr1_fed_nomale_discharge string --Percentage of non-male federal student loan borrowers with all loans discharged after 1 year
bbrr1_pp_ind_n integer --Independent student Parent PLUS Loan borrower-based 1-year borrower count
bbrr1_pp_ind_dflt string --Percentage of independent student Parent PLUS Loan borrowers in default after 1 year
bbrr1_pp_ind_dlnq string --Percentage of independent student Parent PLUS Loan borrowers in delinquency after 1 year
bbrr1_pp_ind_fbr string --Percentage of independent student Parent PLUS Loan borrowers in forbearance after 1 year
bbrr1_pp_ind_dfr string --Percentage of independent student Parent PLUS Loan borrowers in deferment after 1 year
bbrr1_pp_ind_noprog string --Percentage of independent student Parent PLUS Loan borrowers not making progress after 1 year
bbrr1_pp_ind_makeprog string --Percentage of independent student Parent PLUS Loan borrowers making progress after 1 year
bbrr1_pp_ind_paidinfull string --Percentage of independent student Parent PLUS Loan borrowers paid in full after 1 year
bbrr1_pp_ind_discharge string --Percentage of independent student Parent PLUS Loan borrowers with all loans discharged after 1 year
bbrr1_pp_dep_n integer --Dependent student Parent PLUS Loan borrower-based 1-year borrower count
bbrr1_pp_dep_dflt string --Percentage of dependent student Parent PLUS Loan borrowers in default after 1 year
bbrr1_pp_dep_dlnq string --Percentage of dependent student Parent PLUS Loan borrowers in delinquency after 1 year
bbrr1_pp_dep_fbr string --Percentage of dependent student Parent PLUS Loan borrowers in forbearance after 1 year
bbrr1_pp_dep_dfr string --Percentage of dependent student Parent PLUS Loan borrowers in deferment after 1 year
bbrr1_pp_dep_noprog string --Percentage of dependent student Parent PLUS Loan borrowers not making progress after 1 year
bbrr1_pp_dep_makeprog string --Percentage of dependent student Parent PLUS Loan borrowers making progress after 1 year
bbrr1_pp_dep_paidinfull string --Percentage of dependent student Parent PLUS Loan borrowers paid in full after 1 year
bbrr1_pp_dep_discharge string --Percentage of dependent student Parent PLUS Loan borrowers with all loans discharged after 1 year
bbrr1_pp_pell_n integer --Pell Grant recipient student Parent PLUS Loan borrower-based 1-year borrower count
bbrr1_pp_pell_dflt string --Percentage of Pell Grant recipient student Parent PLUS Loan borrowers in default after 1 year
bbrr1_pp_pell_dlnq string --Percentage of Pell Grant recipient student Parent PLUS Loan borrowers in delinquency after 1 year
bbrr1_pp_pell_fbr string --Percentage of Pell Grant recipient student Parent PLUS Loan borrowers in forbearance after 1 year
bbrr1_pp_pell_dfr string --Percentage of Pell Grant recipient student Parent PLUS Loan borrowers in deferment after 1 year
bbrr1_pp_pell_noprog string --Percentage of Pell Grant recipient student Parent PLUS Loan borrowers not making progress after 1 year
bbrr1_pp_pell_makeprog string --Percentage of Pell Grant recipient student Parent PLUS Loan borrowers making progress after 1 year
bbrr1_pp_pell_paidinfull string --Percentage of Pell Grant recipient student Parent PLUS Loan borrowers paid in full after 1 year
bbrr1_pp_pell_discharge string --Percentage of Pell Grant recipient student Parent PLUS Loan borrowers with all loans discharged after 1 year
bbrr1_pp_nopell_n integer --Non-Pell Grant recipient student Parent PLUS Loan borrower-based 1-year borrower count
bbrr1_pp_nopell_dflt string --Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers in default after 1 year
bbrr1_pp_nopell_dlnq string --Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers in delinquency after 1 year
bbrr1_pp_nopell_fbr string --Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers in forbearance after 1 year
bbrr1_pp_nopell_dfr string --Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers in deferment after 1 year
bbrr1_pp_nopell_noprog string --Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers not making progress after 1 year
bbrr1_pp_nopell_makeprog string --Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers making progress after 1 year
bbrr1_pp_nopell_paidinfull string --Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers paid in full after 1 year
bbrr1_pp_nopell_discharge string --Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers with all loans discharged after 1 year
bbrr1_pp_male_n integer --Male student Parent PLUS Loan borrower-based 1-year borrower count
bbrr1_pp_male_dflt string --Percentage of male student Parent PLUS Loan borrowers in default after 1 year
bbrr1_pp_male_dlnq string --Percentage of male student Parent PLUS Loan borrowers in delinquency after 1 year
bbrr1_pp_male_fbr string --Percentage of male student Parent PLUS Loan borrowers in forbearance after 1 year
bbrr1_pp_male_dfr string --Percentage of male student Parent PLUS Loan borrowers in deferment after 1 year
bbrr1_pp_male_noprog string --Percentage of male student Parent PLUS Loan borrowers not making progress after 1 year
bbrr1_pp_male_makeprog string --Percentage of male student Parent PLUS Loan borrowers making progress after 1 year
bbrr1_pp_male_paidinfull string --Percentage of male student Parent PLUS Loan borrowers paid in full after 1 year
bbrr1_pp_male_discharge string --Percentage of male student Parent PLUS Loan borrowers with all loans discharged after 1 year
bbrr1_pp_nomale_n integer --Non-male student Parent PLUS Loan borrower-based 1-year borrower count
bbrr1_pp_nomale_dflt string --Percentage of non-male student Parent PLUS Loan borrowers in default after 1 year
bbrr1_pp_nomale_dlnq string --Percentage of non-male student Parent PLUS Loan borrowers in delinquency after 1 year
bbrr1_pp_nomale_fbr string --Percentage of non-male student Parent PLUS Loan borrowers in forbearance after 1 year
bbrr1_pp_nomale_dfr string --Percentage of non-male student Parent PLUS Loan borrowers in deferment after 1 year
bbrr1_pp_nomale_noprog string --Percentage of non-male student Parent PLUS Loan borrowers not making progress after 1 year
bbrr1_pp_nomale_makeprog string --Percentage of non-male student Parent PLUS Loan borrowers making progress after 1 year
bbrr1_pp_nomale_paidinfull string --Percentage of non-male student Parent PLUS Loan borrowers paid in full after 1 year
bbrr1_pp_nomale_discharge string --Percentage of non-male student Parent PLUS Loan borrowers with all loans discharged after 1 year
bbrr2_fed_ind_n integer --Independent federal student loan borrower-based 2-year borrower count
bbrr2_fed_ind_dflt string --Percentage of independent federal student loan borrowers in default after 2 years
bbrr2_fed_ind_dlnq string --Percentage of independent federal student loan borrowers in delinquency after 2 years
bbrr2_fed_ind_fbr string --Percentage of independent federal student loan borrowers in forbearance after 2 years
bbrr2_fed_ind_dfr string --Percentage of independent federal student loan borrowers in deferment after 2 years
bbrr2_fed_ind_noprog string --Percentage of independent federal student loan borrowers not making progress after 2 years
bbrr2_fed_ind_makeprog string --Percentage of independent federal student loan borrowers making progress after 2 years
bbrr2_fed_ind_paidinfull string --Percentage of independent federal student loan borrowers paid in full after 2 years
bbrr2_fed_ind_discharge string --Percentage of independent federal student loan borrowers with all loans discharged after 2 years
bbrr2_fed_dep_n integer --Dependent federal student loan borrower-based 2-year borrower count
bbrr2_fed_dep_dflt string --Percentage of dependent federal student loan borrowers in default after 2 years
bbrr2_fed_dep_dlnq string --Percentage of dependent federal student loan borrowers in delinquency after 2 years
bbrr2_fed_dep_fbr string --Percentage of dependent federal student loan borrowers in forbearance after 2 years
bbrr2_fed_dep_dfr string --Percentage of dependent federal student loan borrowers in deferment after 2 years
bbrr2_fed_dep_noprog string --Percentage of dependent federal student loan borrowers not making progress after 2 years
bbrr2_fed_dep_makeprog string --Percentage of dependent federal student loan borrowers making progress after 2 years
bbrr2_fed_dep_paidinfull string --Percentage of dependent federal student loan borrowers paid in full after 2 years
bbrr2_fed_dep_discharge string --Percentage of dependent federal student loan borrowers with all loans discharged after 2 years
bbrr2_fed_pell_n integer --Pell Grant recipient federal student loan borrower-based 2-year borrower count
bbrr2_fed_pell_dflt string --Percentage of Pell Grant recipient federal student loan borrowers in default after 2 years
bbrr2_fed_pell_dlnq string --Percentage of Pell Grant recipient federal student loan borrowers in delinquency after 2 years
bbrr2_fed_pell_fbr string --Percentage of Pell Grant recipient federal student loan borrowers in forbearance after 2 years
bbrr2_fed_pell_dfr string --Percentage of Pell Grant recipient federal student loan borrowers in deferment after 2 years
bbrr2_fed_pell_noprog string --Percentage of Pell Grant recipient federal student loan borrowers not making progress after 2 years
bbrr2_fed_pell_makeprog string --Percentage of Pell Grant recipient federal student loan borrowers making progress after 2 years
bbrr2_fed_pell_paidinfull string --Percentage of Pell Grant recipient federal student loan borrowers paid in full after 2 years
bbrr2_fed_pell_discharge string --Percentage of Pell Grant recipient federal student loan borrowers with all loans discharged after 2 years
bbrr2_fed_nopell_n integer --Non-Pell Grant recipient federal student loan borrower-based 2-year borrower count
bbrr2_fed_nopell_dflt string --Percentage of non-Pell Grant recipient federal student loan borrowers in default after 2 years
bbrr2_fed_nopell_dlnq string --Percentage of non-Pell Grant recipient federal student loan borrowers in delinquency after 2 years
bbrr2_fed_nopell_fbr string --Percentage of non-Pell Grant recipient federal student loan borrowers in forbearance after 2 years
bbrr2_fed_nopell_dfr string --Percentage of non-Pell Grant recipient federal student loan borrowers in deferment after 2 years
bbrr2_fed_nopell_noprog string --Percentage of non-Pell Grant recipient federal student loan borrowers not making progress after 2 years
bbrr2_fed_nopell_makeprog string --Percentage of non-Pell Grant recipient federal student loan borrowers making progress after 2 years
bbrr2_fed_nopell_paidinfull string --Percentage of non-Pell Grant recipient federal student loan borrowers paid in full after 2 years
bbrr2_fed_nopell_discharge string --Percentage of non-Pell Grant recipient federal student loan borrowers with all loans discharged after 2 years
bbrr2_fed_male_n integer --Male federal student loan borrower-based 2-year borrower count
bbrr2_fed_male_dflt string --Percentage of male federal student loan borrowers in default after 2 years
bbrr2_fed_male_dlnq string --Percentage of male federal student loan borrowers in delinquency after 2 years
bbrr2_fed_male_fbr string --Percentage of male federal student loan borrowers in forbearance after 2 years
bbrr2_fed_male_dfr string --Percentage of male federal student loan borrowers in deferment after 2 years
bbrr2_fed_male_noprog string --Percentage of male federal student loan borrowers not making progress after 2 years
bbrr2_fed_male_makeprog string --Percentage of male federal student loan borrowers making progress after 2 years
bbrr2_fed_male_paidinfull string --Percentage of male federal student loan borrowers paid in full after 2 years
bbrr2_fed_male_discharge string --Percentage of male federal student loan borrowers with all loans discharged after 2 years
bbrr2_fed_nomale_n integer --Non-male federal student loan borrower-based 2-year borrower count
bbrr2_fed_nomale_dflt string --Percentage of non-male federal student loan borrowers in default after 2 years
bbrr2_fed_nomale_dlnq string --Percentage of non-male federal student loan borrowers in delinquency after 2 years
bbrr2_fed_nomale_fbr string --Percentage of non-male federal student loan borrowers in forbearance after 2 years
bbrr2_fed_nomale_dfr string --Percentage of non-male federal student loan borrowers in deferment after 2 years
bbrr2_fed_nomale_noprog string --Percentage of non-male federal student loan borrowers not making progress after 2 years
bbrr2_fed_nomale_makeprog string --Percentage of non-male federal student loan borrowers making progress after 2 years
bbrr2_fed_nomale_paidinfull string --Percentage of non-male federal student loan borrowers paid in full after 2 years
bbrr2_fed_nomale_discharge string --Percentage of non-male federal student loan borrowers with all loans discharged after 2 years
bbrr2_pp_ind_n integer --Independent student Parent PLUS Loan borrower-based 2-year borrower count
bbrr2_pp_ind_dflt string --Percentage of independent student Parent PLUS Loan borrowers in default after 2 years
bbrr2_pp_ind_dlnq string --Percentage of independent student Parent PLUS Loan borrowers in delinquency after 2 years
bbrr2_pp_ind_fbr string --Percentage of independent student Parent PLUS Loan borrowers in forbearance after 2 years
bbrr2_pp_ind_dfr string --Percentage of independent student Parent PLUS Loan borrowers in deferment after 2 years
bbrr2_pp_ind_noprog string --Percentage of independent student Parent PLUS Loan borrowers not making progress after 2 years
bbrr2_pp_ind_makeprog string --Percentage of independent student Parent PLUS Loan borrowers making progress after 2 years
bbrr2_pp_ind_paidinfull string --Percentage of independent student Parent PLUS Loan borrowers paid in full after 2 years
bbrr2_pp_ind_discharge string --Percentage of independent student Parent PLUS Loan borrowers with all loans discharged after 2 years
bbrr2_pp_dep_n integer --Dependent student Parent PLUS Loan borrower-based 2-year borrower count
bbrr2_pp_dep_dflt string --Percentage of dependent student Parent PLUS Loan borrowers in default after 2 years
bbrr2_pp_dep_dlnq string --Percentage of dependent student Parent PLUS Loan borrowers in delinquency after 2 years
bbrr2_pp_dep_fbr string --Percentage of dependent student Parent PLUS Loan borrowers in forbearance after 2 years
bbrr2_pp_dep_dfr string --Percentage of dependent student Parent PLUS Loan borrowers in deferment after 2 years
bbrr2_pp_dep_noprog string --Percentage of dependent student Parent PLUS Loan borrowers not making progress after 2 years
bbrr2_pp_dep_makeprog string --Percentage of dependent student Parent PLUS Loan borrowers making progress after 2 years
bbrr2_pp_dep_paidinfull string --Percentage of dependent student Parent PLUS Loan borrowers paid in full after 2 years
bbrr2_pp_dep_discharge string --Percentage of dependent student Parent PLUS Loan borrowers with all loans discharged after 2 years
bbrr2_pp_pell_n integer --Pell Grant recipient student Parent PLUS Loan borrower-based 2-year borrower count
bbrr2_pp_pell_dflt string --Percentage of Pell Grant recipient student Parent PLUS Loan borrowers in default after 2 years
bbrr2_pp_pell_dlnq string --Percentage of Pell Grant recipient student Parent PLUS Loan borrowers in delinquency after 2 years
bbrr2_pp_pell_fbr string --Percentage of Pell Grant recipient student Parent PLUS Loan borrowers in forbearance after 2 years
bbrr2_pp_pell_dfr string --Percentage of Pell Grant recipient student Parent PLUS Loan borrowers in deferment after 2 years
bbrr2_pp_pell_noprog string --Percentage of Pell Grant recipient student Parent PLUS Loan borrowers not making progress after 2 years
bbrr2_pp_pell_makeprog string --Percentage of Pell Grant recipient student Parent PLUS Loan borrowers making progress after 2 years
bbrr2_pp_pell_paidinfull string --Percentage of Pell Grant recipient student Parent PLUS Loan borrowers paid in full after 2 years
bbrr2_pp_pell_discharge string --Percentage of Pell Grant recipient student Parent PLUS Loan borrowers with all loans discharged after 2 years
bbrr2_pp_nopell_n integer --Non-Pell Grant recipient student Parent PLUS Loan borrower-based 2-year borrower count
bbrr2_pp_nopell_dflt string --Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers in default after 2 years
bbrr2_pp_nopell_dlnq string --Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers in delinquency after 2 years
bbrr2_pp_nopell_fbr string --Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers in forbearance after 2 years
bbrr2_pp_nopell_dfr string --Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers in deferment after 2 years
bbrr2_pp_nopell_noprog string --Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers not making progress after 2 years
bbrr2_pp_nopell_makeprog string --Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers making progress after 2 years
bbrr2_pp_nopell_paidinfull string --Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers paid in full after 2 years
bbrr2_pp_nopell_discharge string --Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers with all loans discharged after 2 years
bbrr2_pp_male_n integer --Male student Parent PLUS Loan borrower-based 2-year borrower count
bbrr2_pp_male_dflt string --Percentage of male student Parent PLUS Loan borrowers in default after 2 years
bbrr2_pp_male_dlnq string --Percentage of male student Parent PLUS Loan borrowers in delinquency after 2 years
bbrr2_pp_male_fbr string --Percentage of male student Parent PLUS Loan borrowers in forbearance after 2 years
bbrr2_pp_male_dfr string --Percentage of male student Parent PLUS Loan borrowers in deferment after 2 years
bbrr2_pp_male_noprog string --Percentage of male student Parent PLUS Loan borrowers not making progress after 2 years
bbrr2_pp_male_makeprog string --Percentage of male student Parent PLUS Loan borrowers making progress after 2 years
bbrr2_pp_male_paidinfull string --Percentage of male student Parent PLUS Loan borrowers paid in full after 2 years
bbrr2_pp_male_discharge string --Percentage of male student Parent PLUS Loan borrowers with all loans discharged after 2 years
bbrr2_pp_nomale_n integer --Non-male student Parent PLUS Loan borrower-based 2-year borrower count
bbrr2_pp_nomale_dflt string --Percentage of non-male student Parent PLUS Loan borrowers in default after 2 years
bbrr2_pp_nomale_dlnq string --Percentage of non-male student Parent PLUS Loan borrowers in delinquency after 2 years
bbrr2_pp_nomale_fbr string --Percentage of non-male student Parent PLUS Loan borrowers in forbearance after 2 years
bbrr2_pp_nomale_dfr string --Percentage of non-male student Parent PLUS Loan borrowers in deferment after 2 years
bbrr2_pp_nomale_noprog string --Percentage of non-male student Parent PLUS Loan borrowers not making progress after 2 years
bbrr2_pp_nomale_makeprog string --Percentage of non-male student Parent PLUS Loan borrowers making progress after 2 years
bbrr2_pp_nomale_paidinfull string --Percentage of non-male student Parent PLUS Loan borrowers paid in full after 2 years
bbrr2_pp_nomale_discharge string --Percentage of non-male student Parent PLUS Loan borrowers with all loans discharged after 2 years
bbrr3_fed_ug_n integer --Undergraduate federal student loan borrower-based 3-year borrower count
bbrr3_fed_ug_dflt string --Percentage of undergraduate federal student loan borrowers in default after 3 years
bbrr3_fed_ug_dlnq string --Percentage of undergraduate federal student loan borrowers in delinquency after 3 years
bbrr3_fed_ug_fbr string --Percentage of undergraduate federal student loan borrowers in forbearance after 3 years
bbrr3_fed_ug_dfr string --Percentage of undergraduate federal student loan borrowers in deferment after 3 years
bbrr3_fed_ug_noprog string --Percentage of undergraduate federal student loan borrowers not making progress after 3 years
bbrr3_fed_ug_makeprog string --Percentage of undergraduate federal student loan borrowers making progress after 3 years
bbrr3_fed_ug_paidinfull string --Percentage of undergraduate federal student loan borrowers paid in full after 3 years
bbrr3_fed_ug_discharge string --Percentage of undergraduate federal student loan borrowers with all loans discharged after 3 years
bbrr3_fed_ugcomp_n integer --Undergraduate completer undergraduate federal student loan borrower-based 3-year borrower count
bbrr3_fed_ugcomp_dflt string --Percentage of undergraduate completer undergraduate federal student loan borrowers in default after 3 years
bbrr3_fed_ugcomp_dlnq string --Percentage of undergraduate completer undergraduate federal student loan borrowers in delinquency after 3 years
bbrr3_fed_ugcomp_fbr string --Percentage of undergraduate completer undergraduate federal student loan borrowers in forbearance after 3 years
bbrr3_fed_ugcomp_dfr string --Percentage of undergraduate completer undergraduate federal student loan borrowers in deferment after 3 years
bbrr3_fed_ugcomp_noprog string --Percentage of undergraduate completer undergraduate federal student loan borrowers not making progress after 3 years
bbrr3_fed_ugcomp_makeprog string --Percentage of undergraduate completer undergraduate federal student loan borrowers making progress after 3 years
bbrr3_fed_ugcomp_paidinfull string --Percentage of undergraduate completer undergraduate federal student loan borrowers paid in full after 3 years
bbrr3_fed_ugcomp_discharge string --Percentage of undergraduate completer undergraduate federal student loan borrowers with all loans discharged after 3 years
bbrr3_fed_ugnocomp_n integer --Undergraduate non-completer undergraduate federal student loan borrower-based 3-year borrower count
bbrr3_fed_ugnocomp_dflt string --Percentage of undergraduate non-completer undergraduate federal student loan borrowers in default after 3 years
bbrr3_fed_ugnocomp_dlnq string --Percentage of undergraduate non-completer undergraduate federal student loan borrowers in delinquency after 3 years
bbrr3_fed_ugnocomp_fbr string --Percentage of undergraduate non-completer undergraduate federal student loan borrowers in forbearance after 3 years
bbrr3_fed_ugnocomp_dfr string --Percentage of undergraduate non-completer undergraduate federal student loan borrowers in deferment after 3 years
bbrr3_fed_ugnocomp_noprog string --Percentage of undergraduate non-completer undergraduate federal student loan borrowers not making progress after 3 years
bbrr3_fed_ugnocomp_makeprog string --Percentage of undergraduate non-completer undergraduate federal student loan borrowers making progress after 3 years
bbrr3_fed_ugnocomp_paidinfull string --Percentage of undergraduate non-completer undergraduate federal student loan borrowers paid in full after 3 years
bbrr3_fed_ugnocomp_discharge string --Percentage of undergraduate non-completer undergraduate federal student loan borrowers with all loans discharged after 3 years
bbrr3_fed_ugunk_n integer --Undergraduate unknown completion status undergraduate federal student loan borrower-based 3-year borrower count
bbrr3_fed_ugunk_dflt string --Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers in default after 3 years
bbrr3_fed_ugunk_dlnq string --Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers in delinquency after 3 years
bbrr3_fed_ugunk_fbr string --Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers in forbearance after 3 years
bbrr3_fed_ugunk_dfr string --Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers in deferment after 3 years
bbrr3_fed_ugunk_noprog string --Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers not making progress after 3 years
bbrr3_fed_ugunk_makeprog string --Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers making progress after 3 years
bbrr3_fed_ugunk_paidinfull string --Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers paid in full after 3 years
bbrr3_fed_ugunk_discharge string --Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers with all loans discharged after 3 years
bbrr3_fed_gr_n integer --Graduate federal student loan borrower-based 3-year borrower count
bbrr3_fed_gr_dflt string --Percentage of graduate federal student loan borrowers in default after 3 years
bbrr3_fed_gr_dlnq string --Percentage of graduate federal student loan borrowers in delinquency after 3 years
bbrr3_fed_gr_fbr string --Percentage of graduate federal student loan borrowers in forbearance after 3 years
bbrr3_fed_gr_dfr string --Percentage of graduate federal student loan borrowers in deferment after 3 years
bbrr3_fed_gr_noprog string --Percentage of graduate federal student loan borrowers not making progress after 3 years
bbrr3_fed_gr_makeprog string --Percentage of graduate federal student loan borrowers making progress after 3 years
bbrr3_fed_gr_paidinfull string --Percentage of graduate federal student loan borrowers paid in full after 3 years
bbrr3_fed_gr_discharge string --Percentage of graduate federal student loan borrowers with all loans discharged after 3 years
bbrr3_fed_grcomp_n integer --Graduate completer graduate federal student loan borrower-based 3-year borrower count
bbrr3_fed_grcomp_dflt string --Percentage of graduate completer graduate federal student loan borrowers in default after 3 years
bbrr3_fed_grcomp_dlnq string --Percentage of graduate completer graduate federal student loan borrowers in delinquency after 3 years
bbrr3_fed_grcomp_fbr string --Percentage of graduate completer graduate federal student loan borrowers in forbearance after 3 years
bbrr3_fed_grcomp_dfr string --Percentage of graduate completer graduate federal student loan borrowers in deferment after 3 years
bbrr3_fed_grcomp_noprog string --Percentage of graduate completer graduate federal student loan borrowers not making progress after 3 years
bbrr3_fed_grcomp_makeprog string --Percentage of graduate completer graduate federal student loan borrowers making progress after 3 years
bbrr3_fed_grcomp_paidinfull string --Percentage of graduate completer graduate federal student loan borrowers paid in full after 3 years
bbrr3_fed_grcomp_discharge string --Percentage of graduate completer graduate federal student loan borrowers with all loans discharged after 3 years
bbrr3_fed_grnocomp_n integer --Graduate non-completer graduate federal student loan borrower-based 3-year borrower count
bbrr3_fed_grnocomp_dflt string --Percentage of graduate non-completer graduate federal student loan borrowers in default after 3 years
bbrr3_fed_grnocomp_dlnq string --Percentage of graduate non-completer graduate federal student loan borrowers in delinquency after 3 years
bbrr3_fed_grnocomp_fbr string --Percentage of graduate non-completer graduate federal student loan borrowers in forbearance after 3 years
bbrr3_fed_grnocomp_dfr string --Percentage of graduate non-completer graduate federal student loan borrowers in deferment after 3 years
bbrr3_fed_grnocomp_noprog string --Percentage of graduate non-completer graduate federal student loan borrowers not making progress after 3 years
bbrr3_fed_grnocomp_makeprog string --Percentage of graduate non-completer graduate federal student loan borrowers making progress after 3 years
bbrr3_fed_grnocomp_paidinfull string --Percentage of graduate non-completer graduate federal student loan borrowers paid in full after 3 years
bbrr3_fed_grnocomp_discharge string --Percentage of graduate non-completer graduate federal student loan borrowers with all loans discharged after 3 years
bbrr3_pp_ug_n integer --Undergraduate student Parent PLUS Loan borrower-based 3-year borrower count
bbrr3_pp_ug_dflt string --Percentage of undergraduate student Parent PLUS Loan borrowers in default after 3 years
bbrr3_pp_ug_dlnq string --Percentage of undergraduate student Parent PLUS Loan borrowers in delinquency after 3 years
bbrr3_pp_ug_fbr string --Percentage of undergraduate student Parent PLUS Loan borrowers in forbearance after 3 years
bbrr3_pp_ug_dfr string --Percentage of undergraduate student Parent PLUS Loan borrowers in deferment after 3 years
bbrr3_pp_ug_noprog string --Percentage of undergraduate student Parent PLUS Loan borrowers not making progress after 3 years
bbrr3_pp_ug_makeprog string --Percentage of undergraduate student Parent PLUS Loan borrowers making progress after 3 years
bbrr3_pp_ug_paidinfull string --Percentage of undergraduate student Parent PLUS Loan borrowers paid in full after 3 years
bbrr3_pp_ug_discharge string --Percentage of undergraduate student Parent PLUS Loan borrowers with all loans discharged after 3 years
bbrr3_pp_ugcomp_n integer --Undergraduate completer undergraduate student Parent PLUS Loan borrower-based 3-year borrower count
bbrr3_pp_ugcomp_dflt string --Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers in default after 3 years
bbrr3_pp_ugcomp_dlnq string --Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers in delinquency after 3 years
bbrr3_pp_ugcomp_fbr string --Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers in forbearance after 3 years
bbrr3_pp_ugcomp_dfr string --Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers in deferment after 3 years
bbrr3_pp_ugcomp_noprog string --Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers not making progress after 3 years
bbrr3_pp_ugcomp_makeprog string --Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers making progress after 3 years
bbrr3_pp_ugcomp_paidinfull string --Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers paid in full after 3 years
bbrr3_pp_ugcomp_discharge string --Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers with all loans discharged after 3 years
bbrr3_pp_ugnocomp_n integer --Undergraduate non-completer undergraduate student Parent PLUS Loan borrower-based 3-year borrower count
bbrr3_pp_ugnocomp_dflt string --Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers in default after 3 years
bbrr3_pp_ugnocomp_dlnq string --Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers in delinquency after 3 years
bbrr3_pp_ugnocomp_fbr string --Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers in forbearance after 3 years
bbrr3_pp_ugnocomp_dfr string --Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers in deferment after 3 years
bbrr3_pp_ugnocomp_noprog string --Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers not making progress after 3 years
bbrr3_pp_ugnocomp_makeprog string --Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers making progress after 3 years
bbrr3_pp_ugnocomp_paidinfull string --Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers paid in full after 3 years
bbrr3_pp_ugnocomp_discharge string --Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers with all loans discharged after 3 years
bbrr3_pp_ugunk_n integer --Undergraduate unknown completion status undergraduate student Parent PLUS Loan borrower-based 3-year borrower count
bbrr3_pp_ugunk_dflt string --Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers in default after 3 years
bbrr3_pp_ugunk_dlnq string --Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers in delinquency after 3 years
bbrr3_pp_ugunk_fbr string --Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers in forbearance after 3 years
bbrr3_pp_ugunk_dfr string --Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers in deferment after 3 years
bbrr3_pp_ugunk_noprog string --Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers not making progress after 3 years
bbrr3_pp_ugunk_makeprog string --Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers making progress after 3 years
bbrr3_pp_ugunk_paidinfull string --Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers paid in full after 3 years
bbrr3_pp_ugunk_discharge string --Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers with all loans discharged after 3 years
bbrr3_fed_ind_n integer --Independent federal student loan borrower-based 3-year borrower count
bbrr3_fed_ind_dflt string --Percentage of independent federal student loan borrowers in default after 3 years
bbrr3_fed_ind_dlnq string --Percentage of independent federal student loan borrowers in delinquency after 3 years
bbrr3_fed_ind_fbr string --Percentage of independent federal student loan borrowers in forbearance after 3 years
bbrr3_fed_ind_dfr string --Percentage of independent federal student loan borrowers in deferment after 3 years
bbrr3_fed_ind_noprog string --Percentage of independent federal student loan borrowers not making progress after 3 years
bbrr3_fed_ind_makeprog string --Percentage of independent federal student loan borrowers making progress after 3 years
bbrr3_fed_ind_paidinfull string --Percentage of independent federal student loan borrowers paid in full after 3 years
bbrr3_fed_ind_discharge string --Percentage of independent federal student loan borrowers with all loans discharged after 3 years
bbrr3_fed_dep_n integer --Dependent federal student loan borrower-based 3-year borrower count
bbrr3_fed_dep_dflt string --Percentage of dependent federal student loan borrowers in default after 3 years
bbrr3_fed_dep_dlnq string --Percentage of dependent federal student loan borrowers in delinquency after 3 years
bbrr3_fed_dep_fbr string --Percentage of dependent federal student loan borrowers in forbearance after 3 years
bbrr3_fed_dep_dfr string --Percentage of dependent federal student loan borrowers in deferment after 3 years
bbrr3_fed_dep_noprog string --Percentage of dependent federal student loan borrowers not making progress after 3 years
bbrr3_fed_dep_makeprog string --Percentage of dependent federal student loan borrowers making progress after 3 years
bbrr3_fed_dep_paidinfull string --Percentage of dependent federal student loan borrowers paid in full after 3 years
bbrr3_fed_dep_discharge string --Percentage of dependent federal student loan borrowers with all loans discharged after 3 years
bbrr3_fed_pell_n integer --Pell Grant recipient federal student loan borrower-based 3-year borrower count
bbrr3_fed_pell_dflt string --Percentage of Pell Grant recipient federal student loan borrowers in default after 3 years
bbrr3_fed_pell_dlnq string --Percentage of Pell Grant recipient federal student loan borrowers in delinquency after 3 years
bbrr3_fed_pell_fbr string --Percentage of Pell Grant recipient federal student loan borrowers in forbearance after 3 years
bbrr3_fed_pell_dfr string --Percentage of Pell Grant recipient federal student loan borrowers in deferment after 3 years
bbrr3_fed_pell_noprog string --Percentage of Pell Grant recipient federal student loan borrowers not making progress after 3 years
bbrr3_fed_pell_makeprog string --Percentage of Pell Grant recipient federal student loan borrowers making progress after 3 years
bbrr3_fed_pell_paidinfull string --Percentage of Pell Grant recipient federal student loan borrowers paid in full after 3 years
bbrr3_fed_pell_discharge string --Percentage of Pell Grant recipient federal student loan borrowers with all loans discharged after 3 years
bbrr3_fed_nopell_n integer --Non-Pell Grant recipient federal student loan borrower-based 3-year borrower count
bbrr3_fed_nopell_dflt string --Percentage of non-Pell Grant recipient federal student loan borrowers in default after 3 years
bbrr3_fed_nopell_dlnq string --Percentage of non-Pell Grant recipient federal student loan borrowers in delinquency after 3 years
bbrr3_fed_nopell_fbr string --Percentage of non-Pell Grant recipient federal student loan borrowers in forbearance after 3 years
bbrr3_fed_nopell_dfr string --Percentage of non-Pell Grant recipient federal student loan borrowers in deferment after 3 years
bbrr3_fed_nopell_noprog string --Percentage of non-Pell Grant recipient federal student loan borrowers not making progress after 3 years
bbrr3_fed_nopell_makeprog string --Percentage of non-Pell Grant recipient federal student loan borrowers making progress after 3 years
bbrr3_fed_nopell_paidinfull string --Percentage of non-Pell Grant recipient federal student loan borrowers paid in full after 3 years
bbrr3_fed_nopell_discharge string --Percentage of non-Pell Grant recipient federal student loan borrowers with all loans discharged after 3 years
bbrr3_fed_male_n integer --Male federal student loan borrower-based 3-year borrower count
bbrr3_fed_male_dflt string --Percentage of male federal student loan borrowers in default after 3 years
bbrr3_fed_male_dlnq string --Percentage of male federal student loan borrowers in delinquency after 3 years
bbrr3_fed_male_fbr string --Percentage of male federal student loan borrowers in forbearance after 3 years
bbrr3_fed_male_dfr string --Percentage of male federal student loan borrowers in deferment after 3 years
bbrr3_fed_male_noprog string --Percentage of male federal student loan borrowers not making progress after 3 years
bbrr3_fed_male_makeprog string --Percentage of male federal student loan borrowers making progress after 3 years
bbrr3_fed_male_paidinfull string --Percentage of male federal student loan borrowers paid in full after 3 years
bbrr3_fed_male_discharge string --Percentage of male federal student loan borrowers with all loans discharged after 3 years
bbrr3_fed_nomale_n integer --Non-male federal student loan borrower-based 3-year borrower count
bbrr3_fed_nomale_dflt string --Percentage of non-male federal student loan borrowers in default after 3 years
bbrr3_fed_nomale_dlnq string --Percentage of non-male federal student loan borrowers in delinquency after 3 years
bbrr3_fed_nomale_fbr string --Percentage of non-male federal student loan borrowers in forbearance after 3 years
bbrr3_fed_nomale_dfr string --Percentage of non-male federal student loan borrowers in deferment after 3 years
bbrr3_fed_nomale_noprog string --Percentage of non-male federal student loan borrowers not making progress after 3 years
bbrr3_fed_nomale_makeprog string --Percentage of non-male federal student loan borrowers making progress after 3 years
bbrr3_fed_nomale_paidinfull string --Percentage of non-male federal student loan borrowers paid in full after 3 years
bbrr3_fed_nomale_discharge string --Percentage of non-male federal student loan borrowers with all loans discharged after 3 years
bbrr3_pp_ind_n integer --Independent student Parent PLUS Loan borrower-based 3-year borrower count
bbrr3_pp_ind_dflt string --Percentage of independent student Parent PLUS Loan borrowers in default after 3 years
bbrr3_pp_ind_dlnq string --Percentage of independent student Parent PLUS Loan borrowers in delinquency after 3 years
bbrr3_pp_ind_fbr string --Percentage of independent student Parent PLUS Loan borrowers in forbearance after 3 years
bbrr3_pp_ind_dfr string --Percentage of independent student Parent PLUS Loan borrowers in deferment after 3 years
bbrr3_pp_ind_noprog string --Percentage of independent student Parent PLUS Loan borrowers not making progress after 3 years
bbrr3_pp_ind_makeprog string --Percentage of independent student Parent PLUS Loan borrowers making progress after 3 years
bbrr3_pp_ind_paidinfull string --Percentage of independent student Parent PLUS Loan borrowers paid in full after 3 years
bbrr3_pp_ind_discharge string --Percentage of independent student Parent PLUS Loan borrowers with all loans discharged after 3 years
bbrr3_pp_dep_n integer --Dependent student Parent PLUS Loan borrower-based 3-year borrower count
bbrr3_pp_dep_dflt string --Percentage of dependent student Parent PLUS Loan borrowers in default after 3 years
bbrr3_pp_dep_dlnq string --Percentage of dependent student Parent PLUS Loan borrowers in delinquency after 3 years
bbrr3_pp_dep_fbr string --Percentage of dependent student Parent PLUS Loan borrowers in forbearance after 3 years
bbrr3_pp_dep_dfr string --Percentage of dependent student Parent PLUS Loan borrowers in deferment after 3 years
bbrr3_pp_dep_noprog string --Percentage of dependent student Parent PLUS Loan borrowers not making progress after 3 years
bbrr3_pp_dep_makeprog string --Percentage of dependent student Parent PLUS Loan borrowers making progress after 3 years
bbrr3_pp_dep_paidinfull string --Percentage of dependent student Parent PLUS Loan borrowers paid in full after 3 years
bbrr3_pp_dep_discharge string --Percentage of dependent student Parent PLUS Loan borrowers with all loans discharged after 3 years
bbrr3_pp_pell_n integer --Pell Grant recipient student Parent PLUS Loan borrower-based 3-year borrower count
bbrr3_pp_pell_dflt string --Percentage of Pell Grant recipient student Parent PLUS Loan borrowers in default after 3 years
bbrr3_pp_pell_dlnq string --Percentage of Pell Grant recipient student Parent PLUS Loan borrowers in delinquency after 3 years
bbrr3_pp_pell_fbr string --Percentage of Pell Grant recipient student Parent PLUS Loan borrowers in forbearance after 3 years
bbrr3_pp_pell_dfr string --Percentage of Pell Grant recipient student Parent PLUS Loan borrowers in deferment after 3 years
bbrr3_pp_pell_noprog string --Percentage of Pell Grant recipient student Parent PLUS Loan borrowers not making progress after 3 years
bbrr3_pp_pell_makeprog string --Percentage of Pell Grant recipient student Parent PLUS Loan borrowers making progress after 3 years
bbrr3_pp_pell_paidinfull string --Percentage of Pell Grant recipient student Parent PLUS Loan borrowers paid in full after 3 years
bbrr3_pp_pell_discharge string --Percentage of Pell Grant recipient student Parent PLUS Loan borrowers with all loans discharged after 3 years
bbrr3_pp_nopell_n integer --Non-Pell Grant recipient student Parent PLUS Loan borrower-based 3-year borrower count
bbrr3_pp_nopell_dflt string --Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers in default after 3 years
bbrr3_pp_nopell_dlnq string --Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers in delinquency after 3 years
bbrr3_pp_nopell_fbr string --Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers in forbearance after 3 years
bbrr3_pp_nopell_dfr string --Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers in deferment after 3 years
bbrr3_pp_nopell_noprog string --Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers not making progress after 3 years
bbrr3_pp_nopell_makeprog string --Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers making progress after 3 years
bbrr3_pp_nopell_paidinfull string --Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers paid in full after 3 years
bbrr3_pp_nopell_discharge string --Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers with all loans discharged after 3 years
bbrr3_pp_male_n integer --Male student Parent PLUS Loan borrower-based 3-year borrower count
bbrr3_pp_male_dflt string --Percentage of male student Parent PLUS Loan borrowers in default after 3 years
bbrr3_pp_male_dlnq string --Percentage of male student Parent PLUS Loan borrowers in delinquency after 3 years
bbrr3_pp_male_fbr string --Percentage of male student Parent PLUS Loan borrowers in forbearance after 3 years
bbrr3_pp_male_dfr string --Percentage of male student Parent PLUS Loan borrowers in deferment after 3 years
bbrr3_pp_male_noprog string --Percentage of male student Parent PLUS Loan borrowers not making progress after 3 years
bbrr3_pp_male_makeprog string --Percentage of male student Parent PLUS Loan borrowers making progress after 3 years
bbrr3_pp_male_paidinfull string --Percentage of male student Parent PLUS Loan borrowers paid in full after 3 years
bbrr3_pp_male_discharge string --Percentage of male student Parent PLUS Loan borrowers with all loans discharged after 3 years
bbrr3_pp_nomale_n integer --Non-male student Parent PLUS Loan borrower-based 3-year borrower count
bbrr3_pp_nomale_dflt string --Percentage of non-male student Parent PLUS Loan borrowers in default after 3 years
bbrr3_pp_nomale_dlnq string --Percentage of non-male student Parent PLUS Loan borrowers in delinquency after 3 years
bbrr3_pp_nomale_fbr string --Percentage of non-male student Parent PLUS Loan borrowers in forbearance after 3 years
bbrr3_pp_nomale_dfr string --Percentage of non-male student Parent PLUS Loan borrowers in deferment after 3 years
bbrr3_pp_nomale_noprog string --Percentage of non-male student Parent PLUS Loan borrowers not making progress after 3 years
bbrr3_pp_nomale_makeprog string --Percentage of non-male student Parent PLUS Loan borrowers making progress after 3 years
bbrr3_pp_nomale_paidinfull string --Percentage of non-male student Parent PLUS Loan borrowers paid in full after 3 years
bbrr3_pp_nomale_discharge string --Percentage of non-male student Parent PLUS Loan borrowers with all loans discharged after 3 years
count_nwne_1yr integer --Number of graduates working and not enrolled 1 year after completing
count_wne_1yr integer --Number of graduates not working and not enrolled 1 year after completing
cntover150_1yr integer --Number of graduates working and not enrolled who earned more than 150% of the single-person household poverty threshold 1 year after completing
gt_threshold_p6 float --Share of students earning more than a high school graduate (threshold earnings) 6 years after entry
gt_threshold_p6_supp float --Share of students earning more than a high school graduate (threshold earnings) 6 years after entry, suppressed for small n size
md_earn_wne_inc1_p6 integer --Median earnings of students working and not enrolled 6 years after entry in the lowest income tercile $0-$30,000
md_earn_wne_inc2_p6 integer --Median earnings of students working and not enrolled 6 years after entry in the middle income tercile $30,001-$75,000
md_earn_wne_inc3_p6 integer --Median earnings of students working and not enrolled 6 years after entry in the highest income tercile $75,001+
md_earn_wne_indep1_p6 integer --Median earnings of independent students working and not enrolled 6 years after entry
md_earn_wne_indep0_p6 integer --Median earnings of dependent students working and not enrolled 6 years after entry
md_earn_wne_male0_p6 integer --Median earnings of non-male students working and not enrolled 6 years after entry
md_earn_wne_male1_p6 integer --Median earnings of male students working and not enrolled 6 years after entry
gt_threshold_p8 float --Share of students earning more than a high school graduate (threshold earnings) 8 years after entry
count_wne_inc1_p8 integer --Number of students working and not enrolled 8 years after entry in the lowest income tercile $0-$30,000
md_earn_wne_inc1_p8 integer --Median earnings of students working and not enrolled 8 years after entry in the lowest income tercile $0-$30,000
count_wne_inc2_p8 integer --Number of students working and not enrolled 8 years after entry in the middle income tercile $30,001-$75,000
md_earn_wne_inc2_p8 integer --Median earnings of students working and not enrolled 8 years after entry in the middle income tercile $30,001-$75,000
count_wne_inc3_p8 integer --Number of students working and not enrolled 8 years after entry in the highest income tercile $75,001+
md_earn_wne_inc3_p8 integer --Median earnings of students working and not enrolled 8 years after entry in the highest income tercile $75,001+
count_wne_indep1_p8 integer --Number of independent students working and not enrolled 8 years after entry
md_earn_wne_indep1_p8 integer --Median earnings of independent students working and not enrolled 8 years after entry
count_wne_indep0_p8 integer --Number of dependent students working and not enrolled 8 years after entry
md_earn_wne_indep0_p8 integer --Median earnings of dependent students working and not enrolled 8 years after entry
count_wne_male0_p8 integer --Number of non-male students working and not enrolled 8 years after entry
md_earn_wne_male0_p8 integer --Median earnings of non-male students working and not enrolled 8 years after entry
count_wne_male1_p8 integer --Number of male students working and not enrolled 8 years after entry
md_earn_wne_male1_p8 integer --Median earnings of male students working and not enrolled 8 years after entry
gt_threshold_p10 float --Share of students earning more than a high school graduate (threshold earnings) 10 years after entry
md_earn_wne_inc1_p10 integer --Median earnings of students working and not enrolled 10 years after entry in the lowest income tercile $0-$30,000
md_earn_wne_inc2_p10 integer --Median earnings of students working and not enrolled 10 years after entry in the middle income tercile $30,001-$75,000
md_earn_wne_inc3_p10 integer --Median earnings of students working and not enrolled 10 years after entry in the highest income tercile $75,001+
md_earn_wne_indep1_p10 integer --Median earnings of independent students working and not enrolled 10 years after entry
md_earn_wne_indep0_p10 integer --Median earnings of dependent students working and not enrolled 10 years after entry
md_earn_wne_male0_p10 integer --Median earnings of non-male students working and not enrolled 10 years after entry
md_earn_wne_male1_p10 integer --Median earnings of male students working and not enrolled 10 years after entry
stufacr float --Undergraduate student to instructional faculty ratio
irps_2mor float --Share of full time faculty that are Two or More Races
irps_aian float --Share of full time faculty that are American Indian or Alaskan Native
irps_asian float --Share of full time faculty that are Asian
irps_black float --Share of full time faculty that are Black or African American
irps_hisp float --Share of full time faculty that are Hispanic
irps_nhpi float --Share of full time faculty that are Native Hawaiian or Other Pacific Islander
irps_nra float --Share of full time faculty that are U.S. Nonresidents
irps_unkn float --Share of full time faculty that are of unknown race/ethnicity
irps_white float --Share of full time faculty that are White
irps_women float --Share of full time faculty that are men
irps_men float --Share of full time faculty that are women
md_earn_wne_1yr integer --Median earnings of graduates working and not enrolled 1 year after completing
gt_threshold_1yr integer --Number of graduates working and not enrolled who earned more than a high school graduate 1 year after completing
count_nwne_4yr integer --Number of graduates not working and not enrolled 4 years after completing
count_wne_4yr integer --Number of graduates working and not enrolled 4 years after completing
md_earn_wne_4yr integer --Median earnings of graduates working and not enrolled 4 years after completing
gt_threshold_4yr integer --Number of graduates working and not enrolled who earned more than a high school graduate 4 years after completing
bbrr4_fed_ug_n integer --Undergraduate federal student loan borrower-based 4-year borrower count
bbrr4_fed_ug_dflt string --Percentage of undergraduate federal student loan borrowers in default after 4 years
bbrr4_fed_ug_dlnq string --Percentage of undergraduate federal student loan borrowers in delinquency after 4 years
bbrr4_fed_ug_fbr string --Percentage of undergraduate federal student loan borrowers in forbearance after 4 years
bbrr4_fed_ug_dfr string --Percentage of undergraduate federal student loan borrowers in deferment after 4 years
bbrr4_fed_ug_noprog string --Percentage of undergraduate federal student loan borrowers not making progress after 4 years
bbrr4_fed_ug_makeprog string --Percentage of undergraduate federal student loan borrowers making progress after 4 years
bbrr4_fed_ug_paidinfull string --Percentage of undergraduate federal student loan borrowers paid in full after 4 years
bbrr4_fed_ug_discharge string --Percentage of undergraduate federal student loan borrowers with all loans discharged after 4 years
bbrr4_fed_ugcomp_n integer --Undergraduate completer undergraduate federal student loan borrower-based 4-year borrower count
bbrr4_fed_ugcomp_dflt string --Percentage of undergraduate completer undergraduate federal student loan borrowers in default after 4 years
bbrr4_fed_ugcomp_dlnq string --Percentage of undergraduate completer undergraduate federal student loan borrowers in delinquency after 4 years
bbrr4_fed_ugcomp_fbr string --Percentage of undergraduate completer undergraduate federal student loan borrowers in forbearance after 4 years
bbrr4_fed_ugcomp_dfr string --Percentage of undergraduate completer undergraduate federal student loan borrowers in deferment after 4 years
bbrr4_fed_ugcomp_noprog string --Percentage of undergraduate completer undergraduate federal student loan borrowers not making progress after 4 years
bbrr4_fed_ugcomp_makeprog string --Percentage of undergraduate completer undergraduate federal student loan borrowers making progress after 4 years
bbrr4_fed_ugcomp_paidinfull string --Percentage of undergraduate completer undergraduate federal student loan borrowers paid in full after 4 years
bbrr4_fed_ugcomp_discharge string --Percentage of undergraduate completer undergraduate federal student loan borrowers with all loans discharged after 4 years
bbrr4_fed_ugnocomp_n integer --Undergraduate non-completer undergraduate federal student loan borrower-based 4-year borrower count
bbrr4_fed_ugnocomp_dflt string --Percentage of undergraduate non-completer undergraduate federal student loan borrowers in default after 4 years
bbrr4_fed_ugnocomp_dlnq string --Percentage of undergraduate non-completer undergraduate federal student loan borrowers in delinquency after 4 years
bbrr4_fed_ugnocomp_fbr string --Percentage of undergraduate non-completer undergraduate federal student loan borrowers in forbearance after 4 years
bbrr4_fed_ugnocomp_dfr string --Percentage of undergraduate non-completer undergraduate federal student loan borrowers in deferment after 4 years
bbrr4_fed_ugnocomp_noprog string --Percentage of undergraduate non-completer undergraduate federal student loan borrowers not making progress after 4 years
bbrr4_fed_ugnocomp_makeprog string --Percentage of undergraduate non-completer undergraduate federal student loan borrowers making progress after 4 years
bbrr4_fed_ugnocomp_paidinfull string --Percentage of undergraduate non-completer undergraduate federal student loan borrowers paid in full after 4 years
bbrr4_fed_ugnocomp_discharge string --Percentage of undergraduate non-completer undergraduate federal student loan borrowers with all loans discharged after 4 years
bbrr4_fed_ugunk_n integer --Undergraduate unknown completion status undergraduate federal student loan borrower-based 4-year borrower count
bbrr4_fed_ugunk_dflt string --Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers in default after 4 years
bbrr4_fed_ugunk_dlnq string --Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers in delinquency after 4 years
bbrr4_fed_ugunk_fbr string --Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers in forbearance after 4 years
bbrr4_fed_ugunk_dfr string --Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers in deferment after 4 years
bbrr4_fed_ugunk_noprog string --Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers not making progress after 4 years
bbrr4_fed_ugunk_makeprog string --Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers making progress after 4 years
bbrr4_fed_ugunk_paidinfull string --Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers paid in full after 4 years
bbrr4_fed_ugunk_discharge string --Percentage of undergraduate unknown completion status undergraduate federal student loan borrowers with all loans discharged after 4 years
bbrr4_fed_gr_n integer --Graduate federal student loan borrower-based 4-year borrower count
bbrr4_fed_gr_dflt string --Percentage of graduate federal student loan borrowers in default after 4 years
bbrr4_fed_gr_dlnq string --Percentage of graduate federal student loan borrowers in delinquency after 4 years
bbrr4_fed_gr_fbr string --Percentage of graduate federal student loan borrowers in forbearance after 4 years
bbrr4_fed_gr_dfr string --Percentage of graduate federal student loan borrowers in deferment after 4 years
bbrr4_fed_gr_noprog string --Percentage of graduate federal student loan borrowers not making progress after 4 years
bbrr4_fed_gr_makeprog string --Percentage of graduate federal student loan borrowers making progress after 4 years
bbrr4_fed_gr_paidinfull string --Percentage of graduate federal student loan borrowers paid in full after 4 years
bbrr4_fed_gr_discharge string --Percentage of graduate federal student loan borrowers with all loans discharged after 4 years
bbrr4_fed_grcomp_n integer --Graduate completer graduate federal student loan borrower-based 4-year borrower count
bbrr4_fed_grcomp_dflt string --Percentage of graduate completer graduate federal student loan borrowers in default after 4 years
bbrr4_fed_grcomp_dlnq string --Percentage of graduate completer graduate federal student loan borrowers in delinquency after 4 years
bbrr4_fed_grcomp_fbr string --Percentage of graduate completer graduate federal student loan borrowers in forbearance after 4 years
bbrr4_fed_grcomp_dfr string --Percentage of graduate completer graduate federal student loan borrowers in deferment after 4 years
bbrr4_fed_grcomp_noprog string --Percentage of graduate completer graduate federal student loan borrowers not making progress after 4 years
bbrr4_fed_grcomp_makeprog string --Percentage of graduate completer graduate federal student loan borrowers making progress after 4 years
bbrr4_fed_grcomp_paidinfull string --Percentage of graduate completer graduate federal student loan borrowers paid in full after 4 years
bbrr4_fed_grcomp_discharge string --Percentage of graduate completer graduate federal student loan borrowers with all loans discharged after 4 years
bbrr4_fed_grnocomp_n integer --Graduate non-completer graduate federal student loan borrower-based 4-year borrower count
bbrr4_fed_grnocomp_dflt string --Percentage of graduate non-completer graduate federal student loan borrowers in default after 4 years
bbrr4_fed_grnocomp_dlnq string --Percentage of graduate non-completer graduate federal student loan borrowers in delinquency after 4 years
bbrr4_fed_grnocomp_fbr string --Percentage of graduate non-completer graduate federal student loan borrowers in forbearance after 4 years
bbrr4_fed_grnocomp_dfr string --Percentage of graduate non-completer graduate federal student loan borrowers in deferment after 4 years
bbrr4_fed_grnocomp_noprog string --Percentage of graduate non-completer graduate federal student loan borrowers not making progress after 4 years
bbrr4_fed_grnocomp_makeprog string --Percentage of graduate non-completer graduate federal student loan borrowers making progress after 4 years
bbrr4_fed_grnocomp_paidinfull string --Percentage of graduate non-completer graduate federal student loan borrowers paid in full after 4 years
bbrr4_fed_grnocomp_discharge string --Percentage of graduate non-completer graduate federal student loan borrowers with all loans discharged after 4 years
bbrr4_pp_ug_n integer --Undergraduate student Parent PLUS Loan borrower-based 4-year borrower count
bbrr4_pp_ug_dflt string --Percentage of undergraduate student Parent PLUS Loan borrowers in default after 4 years
bbrr4_pp_ug_dlnq string --Percentage of undergraduate student Parent PLUS Loan borrowers in delinquency after 4 years
bbrr4_pp_ug_fbr string --Percentage of undergraduate student Parent PLUS Loan borrowers in forbearance after 4 years
bbrr4_pp_ug_dfr string --Percentage of undergraduate student Parent PLUS Loan borrowers in deferment after 4 years
bbrr4_pp_ug_noprog string --Percentage of undergraduate student Parent PLUS Loan borrowers not making progress after 4 years
bbrr4_pp_ug_makeprog string --Percentage of undergraduate student Parent PLUS Loan borrowers making progress after 4 years
bbrr4_pp_ug_paidinfull string --Percentage of undergraduate student Parent PLUS Loan borrowers paid in full after 4 years
bbrr4_pp_ug_discharge string --Percentage of undergraduate student Parent PLUS Loan borrowers with all loans discharged after 4 years
bbrr4_pp_ugcomp_n integer --Undergraduate completer undergraduate student Parent PLUS Loan borrower-based 4-year borrower count
bbrr4_pp_ugcomp_dflt string --Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers in default after 4 years
bbrr4_pp_ugcomp_dlnq string --Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers in delinquency after 4 years
bbrr4_pp_ugcomp_fbr string --Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers in forbearance after 4 years
bbrr4_pp_ugcomp_dfr string --Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers in deferment after 4 years
bbrr4_pp_ugcomp_noprog string --Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers not making progress after 4 years
bbrr4_pp_ugcomp_makeprog string --Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers making progress after 4 years
bbrr4_pp_ugcomp_paidinfull string --Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers paid in full after 4 years
bbrr4_pp_ugcomp_discharge string --Percentage of undergraduate completer undergraduate student Parent PLUS Loan borrowers with all loans discharged after 4 years
bbrr4_pp_ugnocomp_n integer --Undergraduate non-completer undergraduate student Parent PLUS Loan borrower-based 4-year borrower count
bbrr4_pp_ugnocomp_dflt string --Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers in default after 4 years
bbrr4_pp_ugnocomp_dlnq string --Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers in delinquency after 4 years
bbrr4_pp_ugnocomp_fbr string --Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers in forbearance after 4 years
bbrr4_pp_ugnocomp_dfr string --Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers in deferment after 4 years
bbrr4_pp_ugnocomp_noprog string --Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers not making progress after 4 years
bbrr4_pp_ugnocomp_makeprog string --Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers making progress after 4 years
bbrr4_pp_ugnocomp_paidinfull string --Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers paid in full after 4 years
bbrr4_pp_ugnocomp_discharge string --Percentage of undergraduate non-completer undergraduate student Parent PLUS Loan borrowers with all loans discharged after 4 years
bbrr4_pp_ugunk_n integer --Undergraduate unknown completion status undergraduate student Parent PLUS Loan borrower-based 4-year borrower count
bbrr4_pp_ugunk_dflt string --Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers in default after 4 years
bbrr4_pp_ugunk_dlnq string --Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers in delinquency after 4 years
bbrr4_pp_ugunk_fbr string --Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers in forbearance after 4 years
bbrr4_pp_ugunk_dfr string --Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers in deferment after 4 years
bbrr4_pp_ugunk_noprog string --Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers not making progress after 4 years
bbrr4_pp_ugunk_makeprog string --Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers making progress after 4 years
bbrr4_pp_ugunk_paidinfull string --Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers paid in full after 4 years
bbrr4_pp_ugunk_discharge string --Percentage of undergraduate unknown completion status undergraduate student Parent PLUS Loan borrowers with all loans discharged after 4 years
bbrr4_fed_ind_n integer --Independent federal student loan borrower-based 4-year borrower count
bbrr4_fed_ind_dflt string --Percentage of independent federal student loan borrowers in default after 4 years
bbrr4_fed_ind_dlnq string --Percentage of independent federal student loan borrowers in delinquency after 4 years
bbrr4_fed_ind_fbr string --Percentage of independent federal student loan borrowers in forbearance after 4 years
bbrr4_fed_ind_dfr string --Percentage of independent federal student loan borrowers in deferment after 4 years
bbrr4_fed_ind_noprog string --Percentage of independent federal student loan borrowers not making progress after 4 years
bbrr4_fed_ind_makeprog string --Percentage of independent federal student loan borrowers making progress after 4 years
bbrr4_fed_ind_paidinfull string --Percentage of independent federal student loan borrowers paid in full after 4 years
bbrr4_fed_ind_discharge string --Percentage of independent federal student loan borrowers with all loans discharged after 4 years
bbrr4_fed_dep_n integer --Dependent federal student loan borrower-based 4-year borrower count
bbrr4_fed_dep_dflt string --Percentage of dependent federal student loan borrowers in default after 4 years
bbrr4_fed_dep_dlnq string --Percentage of dependent federal student loan borrowers in delinquency after 4 years
bbrr4_fed_dep_fbr string --Percentage of dependent federal student loan borrowers in forbearance after 4 years
bbrr4_fed_dep_dfr string --Percentage of dependent federal student loan borrowers in deferment after 4 years
bbrr4_fed_dep_noprog string --Percentage of dependent federal student loan borrowers not making progress after 4 years
bbrr4_fed_dep_makeprog string --Percentage of dependent federal student loan borrowers making progress after 4 years
bbrr4_fed_dep_paidinfull string --Percentage of dependent federal student loan borrowers paid in full after 4 years
bbrr4_fed_dep_discharge string --Percentage of dependent federal student loan borrowers with all loans discharged after 4 years
bbrr4_fed_pell_n integer --Pell Grant recipient federal student loan borrower-based 4-year borrower count
bbrr4_fed_pell_dflt string --Percentage of Pell Grant recipient federal student loan borrowers in default after 4 years
bbrr4_fed_pell_dlnq string --Percentage of Pell Grant recipient federal student loan borrowers in delinquency after 4 years
bbrr4_fed_pell_fbr string --Percentage of Pell Grant recipient federal student loan borrowers in forbearance after 4 years
bbrr4_fed_pell_dfr string --Percentage of Pell Grant recipient federal student loan borrowers in deferment after 4 years
bbrr4_fed_pell_noprog string --Percentage of Pell Grant recipient federal student loan borrowers not making progress after 4 years
bbrr4_fed_pell_makeprog string --Percentage of Pell Grant recipient federal student loan borrowers making progress after 4 years
bbrr4_fed_pell_paidinfull string --Percentage of Pell Grant recipient federal student loan borrowers paid in full after 4 years
bbrr4_fed_pell_discharge string --Percentage of Pell Grant recipient federal student loan borrowers with all loans discharged after 4 years
bbrr4_fed_nopell_n integer --Non-Pell Grant recipient federal student loan borrower-based 4-year borrower count
bbrr4_fed_nopell_dflt string --Percentage of non-Pell Grant recipient federal student loan borrowers in default after 4 years
bbrr4_fed_nopell_dlnq string --Percentage of non-Pell Grant recipient federal student loan borrowers in delinquency after 4 years
bbrr4_fed_nopell_fbr string --Percentage of non-Pell Grant recipient federal student loan borrowers in forbearance after 4 years
bbrr4_fed_nopell_dfr string --Percentage of non-Pell Grant recipient federal student loan borrowers in deferment after 4 years
bbrr4_fed_nopell_noprog string --Percentage of non-Pell Grant recipient federal student loan borrowers not making progress after 4 years
bbrr4_fed_nopell_makeprog string --Percentage of non-Pell Grant recipient federal student loan borrowers making progress after 4 years
bbrr4_fed_nopell_paidinfull string --Percentage of non-Pell Grant recipient federal student loan borrowers paid in full after 4 years
bbrr4_fed_nopell_discharge string --Percentage of non-Pell Grant recipient federal student loan borrowers with all loans discharged after 4 years
bbrr4_fed_male_n integer --Male federal student loan borrower-based 4-year borrower count
bbrr4_fed_male_dflt string --Percentage of male federal student loan borrowers in default after 4 years
bbrr4_fed_male_dlnq string --Percentage of male federal student loan borrowers in delinquency after 4 years
bbrr4_fed_male_fbr string --Percentage of male federal student loan borrowers in forbearance after 4 years
bbrr4_fed_male_dfr string --Percentage of male federal student loan borrowers in deferment after 4 years
bbrr4_fed_male_noprog string --Percentage of male federal student loan borrowers not making progress after 4 years
bbrr4_fed_male_makeprog string --Percentage of male federal student loan borrowers making progress after 4 years
bbrr4_fed_male_paidinfull string --Percentage of male federal student loan borrowers paid in full after 4 years
bbrr4_fed_male_discharge string --Percentage of male federal student loan borrowers with all loans discharged after 4 years
bbrr4_fed_nomale_n integer --Non-male federal student loan borrower-based 4-year borrower count
bbrr4_fed_nomale_dflt string --Percentage of non-male federal student loan borrowers in default after 4 years
bbrr4_fed_nomale_dlnq string --Percentage of non-male federal student loan borrowers in delinquency after 4 years
bbrr4_fed_nomale_fbr string --Percentage of non-male federal student loan borrowers in forbearance after 4 years
bbrr4_fed_nomale_dfr string --Percentage of non-male federal student loan borrowers in deferment after 4 years
bbrr4_fed_nomale_noprog string --Percentage of non-male federal student loan borrowers not making progress after 4 years
bbrr4_fed_nomale_makeprog string --Percentage of non-male federal student loan borrowers making progress after 4 years
bbrr4_fed_nomale_paidinfull string --Percentage of non-male federal student loan borrowers paid in full after 4 years
bbrr4_fed_nomale_discharge string --Percentage of non-male federal student loan borrowers with all loans discharged after 4 years
bbrr4_pp_ind_n integer --Independent student Parent PLUS Loan borrower-based 4-year borrower count
bbrr4_pp_ind_dflt string --Percentage of independent student Parent PLUS Loan borrowers in default after 4 years
bbrr4_pp_ind_dlnq string --Percentage of independent student Parent PLUS Loan borrowers in delinquency after 4 years
bbrr4_pp_ind_fbr string --Percentage of independent student Parent PLUS Loan borrowers in forbearance after 4 years
bbrr4_pp_ind_dfr string --Percentage of independent student Parent PLUS Loan borrowers in deferment after 4 years
bbrr4_pp_ind_noprog string --Percentage of independent student Parent PLUS Loan borrowers not making progress after 4 years
bbrr4_pp_ind_makeprog string --Percentage of independent student Parent PLUS Loan borrowers making progress after 4 years
bbrr4_pp_ind_paidinfull string --Percentage of independent student Parent PLUS Loan borrowers paid in full after 4 years
bbrr4_pp_ind_discharge string --Percentage of independent student Parent PLUS Loan borrowers with all loans discharged after 4 years
bbrr4_pp_dep_n integer --Dependent student Parent PLUS Loan borrower-based 4-year borrower count
bbrr4_pp_dep_dflt string --Percentage of dependent student Parent PLUS Loan borrowers in default after 4 years
bbrr4_pp_dep_dlnq string --Percentage of dependent student Parent PLUS Loan borrowers in delinquency after 4 years
bbrr4_pp_dep_fbr string --Percentage of dependent student Parent PLUS Loan borrowers in forbearance after 4 years
bbrr4_pp_dep_dfr string --Percentage of dependent student Parent PLUS Loan borrowers in deferment after 4 years
bbrr4_pp_dep_noprog string --Percentage of dependent student Parent PLUS Loan borrowers not making progress after 4 years
bbrr4_pp_dep_makeprog string --Percentage of dependent student Parent PLUS Loan borrowers making progress after 4 years
bbrr4_pp_dep_paidinfull string --Percentage of dependent student Parent PLUS Loan borrowers paid in full after 4 years
bbrr4_pp_dep_discharge string --Percentage of dependent student Parent PLUS Loan borrowers with all loans discharged after 4 years
bbrr4_pp_pell_n integer --Pell Grant recipient student Parent PLUS Loan borrower-based 4-year borrower count
bbrr4_pp_pell_dflt string --Percentage of Pell Grant recipient student Parent PLUS Loan borrowers in default after 4 years
bbrr4_pp_pell_dlnq string --Percentage of Pell Grant recipient student Parent PLUS Loan borrowers in delinquency after 4 years
bbrr4_pp_pell_fbr string --Percentage of Pell Grant recipient student Parent PLUS Loan borrowers in forbearance after 4 years
bbrr4_pp_pell_dfr string --Percentage of Pell Grant recipient student Parent PLUS Loan borrowers in deferment after 4 years
bbrr4_pp_pell_noprog string --Percentage of Pell Grant recipient student Parent PLUS Loan borrowers not making progress after 4 years
bbrr4_pp_pell_makeprog string --Percentage of Pell Grant recipient student Parent PLUS Loan borrowers making progress after 4 years
bbrr4_pp_pell_paidinfull string --Percentage of Pell Grant recipient student Parent PLUS Loan borrowers paid in full after 4 years
bbrr4_pp_pell_discharge string --Percentage of Pell Grant recipient student Parent PLUS Loan borrowers with all loans discharged after 4 years
bbrr4_pp_nopell_n integer --Non-Pell Grant recipient student Parent PLUS Loan borrower-based 4-year borrower count
bbrr4_pp_nopell_dflt string --Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers in default after 4 years
bbrr4_pp_nopell_dlnq string --Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers in delinquency after 4 years
bbrr4_pp_nopell_fbr string --Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers in forbearance after 4 years
bbrr4_pp_nopell_dfr string --Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers in deferment after 4 years
bbrr4_pp_nopell_noprog string --Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers not making progress after 4 years
bbrr4_pp_nopell_makeprog string --Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers making progress after 4 years
bbrr4_pp_nopell_paidinfull string --Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers paid in full after 4 years
bbrr4_pp_nopell_discharge string --Percentage of non-Pell Grant recipient student Parent PLUS Loan borrowers with all loans discharged after 4 years
bbrr4_pp_male_n integer --Male student Parent PLUS Loan borrower-based 4-year borrower count
bbrr4_pp_male_dflt string --Percentage of male student Parent PLUS Loan borrowers in default after 4 years
bbrr4_pp_male_dlnq string --Percentage of male student Parent PLUS Loan borrowers in delinquency after 4 years
bbrr4_pp_male_fbr string --Percentage of male student Parent PLUS Loan borrowers in forbearance after 4 years
bbrr4_pp_male_dfr string --Percentage of male student Parent PLUS Loan borrowers in deferment after 4 years
bbrr4_pp_male_noprog string --Percentage of male student Parent PLUS Loan borrowers not making progress after 4 years
bbrr4_pp_male_makeprog string --Percentage of male student Parent PLUS Loan borrowers making progress after 4 years
bbrr4_pp_male_paidinfull string --Percentage of male student Parent PLUS Loan borrowers paid in full after 4 years
bbrr4_pp_male_discharge string --Percentage of male student Parent PLUS Loan borrowers with all loans discharged after 4 years
bbrr4_pp_nomale_n integer --Non-male student Parent PLUS Loan borrower-based 4-year borrower count
bbrr4_pp_nomale_dflt string --Percentage of non-male student Parent PLUS Loan borrowers in default after 4 years
bbrr4_pp_nomale_dlnq string --Percentage of non-male student Parent PLUS Loan borrowers in delinquency after 4 years
bbrr4_pp_nomale_fbr string --Percentage of non-male student Parent PLUS Loan borrowers in forbearance after 4 years
bbrr4_pp_nomale_dfr string --Percentage of non-male student Parent PLUS Loan borrowers in deferment after 4 years
bbrr4_pp_nomale_noprog string --Percentage of non-male student Parent PLUS Loan borrowers not making progress after 4 years
bbrr4_pp_nomale_makeprog string --Percentage of non-male student Parent PLUS Loan borrowers making progress after 4 years
bbrr4_pp_nomale_paidinfull string --Percentage of non-male student Parent PLUS Loan borrowers paid in full after 4 years
bbrr4_pp_nomale_discharge string --Percentage of non-male student Parent PLUS Loan borrowers with all loans discharged after 4 years
control_peps string --Control of institution (PEPS)
adm_rate_supp float --Admission rate, suppressed for n<30
omenryp_nopell_all float --Percentage of all non-Pell Grant recipient students that did not receive an award and are still enrolled at this institution 8 years after entry
omenrap_nopell_all float --Percentage of all non-Pell Grant recipient students that did not receive an award and enrolled at another institution after leaving this institution within 8 years of entry
omawdp8_nopell_all float --Percentage of all non-Pell Grant recipient students receiving an award within 8 years of entry
omenrup_nopell_all float --Percentage of all non-Pell Grant recipient students that did not receive an award and whose enrollment status is unknown after leaving this institution within 8 years of entry
omenryp_nopell_firsttime float --Percentage of first-time non-Pell Grant recipient students that did not receive an award and are still enrolled at this institution 8 years after entry
omenrap_nopell_firsttime float --Percentage of first-time non-Pell Grant recipient students that did not receive an award and enrolled at another institution after leaving this institution within 8 years of entry
omawdp8_nopell_firsttime float --Percentage of first-time non-Pell Grant recipient students receiving an award within 8 years of entry
omenrup_nopell_firsttime float --Percentage of first-time non-Pell Grant recipient students that did not receive an award and whose enrollment status is unknown after leaving this institution within 8 years of entry
omenryp_nopell_notfirsttime float --Percentage of not first-time non-Pell Grant recipient students that did not receive an award and are still enrolled at this institution 8 years after entry
omenrap_nopell_notfirsttime float --Percentage of not first-time non-Pell Grant recipient students that did not receive an award and enrolled at another institution after leaving this institution within 8 years of entry
omawdp8_nopell_notfirsttime float --Percentage of not first-time non-Pell Grant recipient students receiving an award within 8 years of entry
omenrup_nopell_notfirsttime float --Percentage of not first-time non-Pell Grant recipient students that did not receive an award and whose enrollment status is unknown after leaving this institution within 8 years of entry
omacht8_nopell_all integer --Adjusted cohort count of non-Pell Grant recipeint students (denominator for the 8-year outcomes percentages)
omacht8_nopell_firsttime integer --Adjusted cohort count of first-time non-Pell Grant recipient students (denominator for the 8-year outcomes percentages)
omacht8_nopell_notfirsttime integer --Adjusted cohort count of non-first-time non-Pell Grant recipient students (denominator for the 8-year outcomes percentages)
addr string --Address of institution
pctpell_dcs float --Percentage of degree/certificate-seeking undergraduate students awarded a Pell Grant
pctfloan_dcs float --Percentage of degree/certificate-seeking undergraduate students awarded a federal loan
dcs_pell_loan integer --Number of degree/certificate-seeking undergraduate students (denominator for percent degree/certificate-seeking undergraduates receiving a pell grant or federal student loan)
pctpell_dcs_pooled_supp float --Percentage of degree/certificate-seeking undergraduate students awarded a Pell Grant, pooled in rolling averages and suppressed for small n size
pctfloan_dcs_pooled_supp float --Percentage of degree/certificate-seeking undergraduate students awarded a federal loan, pooled in rolling averages and suppressed for small n size
dcs_pell_loan_pooled integer --Number of degree/certificate-seeking undergraduate students (denominator for percent degree/certificate-seeking undergraduates receiving a pell grant or federal student loan), pooled in rolling averages
poolyrs_dcs integer --Years used for rolling averages of PCTPELL_DCS_POOLED_SUPP and PCTFLOAN_DCS_POOLED_SUPP
satvr50 float --50th percentile of SAT scores at the institution (critical reading)
satmt50 float --50th percentile of SAT scores at the institution (math)
actcm50 float --50th percentile of the ACT cumulative score
acten50 float --50th percentile of the ACT English score
actmt50 float --50th percentile of the ACT math score
count_nwne_5yr integer --Number of graduates not working and not enrolled 5 years after completing
count_wne_5yr integer --Number of graduates working and not enrolled 5 years after completing
md_earn_wne_5yr integer --Median earnings of graduates working and not enrolled 5 years after completing
gt_threshold_5yr integer --Number of graduates working and not enrolled who earned more than a high school graduate 5 years after completing
md_earn_wne_p7 integer --Median earnings of students working and not enrolled 7 years after entry
pct25_earn_wne_p7 integer --25th percentile of earnings of students working and not enrolled 7 years after entry
pct75_earn_wne_p7 integer --75th percentile of earnings of students working and not enrolled 7 years after entry
count_wne_inc1_p7 integer --Number of students working and not enrolled 7 years after entry in the lowest income tercile $0-$30,000
count_wne_inc2_p7 integer --Number of students working and not enrolled 7 years after entry in the middle income tercile $30,001-$75,000
count_wne_inc3_p7 integer --Number of students working and not enrolled 7 years after entry in the highest income tercile $75,001+ 
count_wne_indep0_p7 integer --Number of dependent students working and not enrolled 7 years after entry
count_wne_indep1_p7 integer --Number of independent students working and not enrolled 7 years after entry
count_wne_male0_p7 integer --Number of female students working and not enrolled 7 years after entry
count_wne_male1_p7 integer --Number of male students working and not enrolled 7 years after entry
gt_threshold_p7 float --Share of students earning more than a high school graduate (threshold earnings) 7 years after entry
md_earn_wne_inc1_p7 integer --Median earnings of students working and not enrolled 7 years after entry in the lowest income tercile $0-$30,000
md_earn_wne_inc2_p7 integer --Median earnings of students working and not enrolled 7 years after entry in the middle income tercile $30,001-$75,000
md_earn_wne_inc3_p7 integer --Median earnings of students working and not enrolled 7 years after entry in the highest income tercile $75,001+
md_earn_wne_indep1_p7 integer --Median earnings of independent students working and not enrolled 7 years after entry
md_earn_wne_indep0_p7 integer --Median earnings of dependent students working and not enrolled 7 years after entry
md_earn_wne_male0_p7 integer --Median earnings of non-male students working and not enrolled 7 years after entry
md_earn_wne_male1_p7 integer --Median earnings of male students working and not enrolled 7 years after entry
md_earn_wne_p9 float --Median earnings of students working and not enrolled 9 years after entry
pct25_earn_wne_p9 integer --25th percentile of earnings of students working and not enrolled 9 years after entry
pct75_earn_wne_p9 integer --75th percentile of earnings of students working and not enrolled 9 years after entry
count_wne_inc1_p9 integer --Number of students working and not enrolled 9 years after entry in the lowest income tercile $0-$30,000
count_wne_inc2_p9 integer --Number of students working and not enrolled 9 years after entry in the middle income tercile $30,001-$75,000
count_wne_inc3_p9 integer --Number of students working and not enrolled 9 years after entry in the highest income tercile $75,001+
count_wne_indep0_p9 integer --Number of dependent students working and not enrolled 9 years after entry
count_wne_indep1_p9 integer --Number of independent students working and not enrolled 9 years after entry
count_wne_male0_p9 integer --Number of non-male students working and not enrolled 9 years after entry
count_wne_male1_p9 integer --Number of male students working and not enrolled 9 years after entry
gt_threshold_p9 float --Share of students earning more than a high school graduate (threshold earnings) 9 years after entry
md_earn_wne_inc1_p9 integer --Median earnings of students working and not enrolled 9 years after entry in the lowest income tercile $0-$30,000
md_earn_wne_inc2_p9 integer --Median earnings of students working and not enrolled 9 years after entry in the middle income tercile $30,001-$75,000
md_earn_wne_inc3_p9 integer --Median earnings of students working and not enrolled 9 years after entry in the highest income tercile $75,001+
md_earn_wne_indep0_p9 integer --Median earnings of dependent students working and not enrolled 9 years after entry
md_earn_wne_indep1_p9 integer --Median earnings of independent students working and not enrolled 9 years after entry
md_earn_wne_male0_p9 integer --Median earnings of non-male students working and not enrolled 9 years after entry
md_earn_wne_male1_p9 integer --Median earnings of male students working and not enrolled 9 years after entry
count_nwne_p11 integer --Number of students not working and not enrolled 11 years after entry
count_wne_p11 integer --Number of students working and not enrolled 11 years after entry
md_earn_wne_p11 integer --Median earnings of students working and not enrolled 11 years after entry
pct25_earn_wne_p11 integer --25th percentile of earnings of students working and not enrolled 11 years after entry
pct75_earn_wne_p11 integer --75th percentile of earnings of students working and not enrolled 11 years after entry
sd_earn_wne_p11 integer --Standard deviation of earnings of students working and not enrolled 11 years after entry
count_wne_inc1_p11 integer --Number of students working and not enrolled 11 years after entry in the lowest income tercile $0-$30,000
count_wne_inc2_p11 integer --Number of students working and not enrolled 11 years after entry in the middle income tercile $30,001-$75,000
count_wne_inc3_p11 integer --Number of students working and not enrolled 11 years after entry in the highest income tercile $75,001+ 
count_wne_indep0_p11 integer --Number of dependent students working and not enrolled 11 years after entry
count_wne_indep1_p11 integer --Number of independent students working and not enrolled 11 years after entry
count_wne_male0_p11 integer --Number of female students working and not enrolled 11 years after entry
count_wne_male1_p11 integer --Number of male students working and not enrolled 11 years after entry
gt_threshold_p11 float --Share of students earning more than a high school graduate (threshold earnings) 11 years after entry
md_earn_wne_inc1_p11 integer --Median earnings of students working and not enrolled 11 years after entry in the lowest income tercile $0-$30,000
md_earn_wne_inc2_p11 integer --Median earnings of students working and not enrolled 11 years after entry in the middle income tercile $30,001-$75,000
md_earn_wne_inc3_p11 integer --Median earnings of students working and not enrolled 11 years after entry in the highest income tercile $75,001+
md_earn_wne_indep0_p11 integer --Median earnings of dependent students working and not enrolled 11 years after entry
md_earn_wne_indep1_p11 integer --Median earnings of independent students working and not enrolled 11 years after entry
md_earn_wne_male0_p11 integer --Median earnings of non-male students working and not enrolled 11 years after entry
md_earn_wne_male1_p11 integer --Median earnings of male students working and not enrolled 11 years after entry

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

---
title: CS586---group project, deliverable 2
author: Navya Sri Ambati & John O Brickley 
hauthor: Ambati & Brickley
instructor: Jesse Chaney
course: Database management systems
date: \today
---

- [ ] ER diagram of domain
- [ ] Translation to relational schema
	- Primary keys
	- Unique keys
	- Foreign keys
	- 6--10 tables
	- at least 1 view
		- "The required view should join at least 3 tables."
	- "evidence" :create(1|more) tables :schema & pop(1|more) rows
- [ ] Load data
	- From real resources
	- Show 5 rows of data per table and view, and row counts
		- Total row count of at least 1,000
- [ ] Express questions as SQL
	- Revise as needed, explaining changes
	- If all questions require only singular, unjoined tables, they are bad questions.
	- Multiple questions must involve joins of 4 or more tables

#### Questions

1. What is the connection between college sports and academics?
2. Does spending on college sports affect student's academic performances?
3. How is cost of attendance affected by funding for college sports?
4. How does increased funding for college sports affect universities, colleges, and the areas surrounding them?
5. Does sports gambling correlate with subsidies to college sports?
6. Is there a connection between subsidies to college sports teams and Title-IX investigations?
7. How many students are in high school, under grad, grad etc programs?
8. How many students are involved in both academics and sports?
9. Which colleges have the highest fees?
10. What are the top 15 schools and colleges that have good ratings?
11. Which schools and colleges support financing for academically oriented students?
12. Which schools and colleges support financing for students involved in sports?
13. How many students are involved in college sports?
14. What kinds of funding are offered to students at schools and colleges?
15. How much funding is offered to students when comparing between states?
16. Which schools and colleges are highly supportive of sports?
17. What is the variation in funding for education versus sports?
18. Which schools and colleges participate and encourage students in more than 1 sport?
19. What is the average of students who are good at both sports and academics?
20. How many consecutive wins have various college sports team had?
21. How many students, by school, have received funding based on athletics participation?
22. What is the average amount or scholarship money offered per year in each category?
23. Is there a difference in the average funding for male and female college sports teams?
24. How does any difference in the previous question compare to differences in funding based on academic merit?

#### Sources and their ingestion

We have collected the following datasets:

- [x] The "College scorecard data"^[https://collegescorecard.ed.gov/data], which, while off by an average of 10% in reported graduation rates among Pell-grant recipients^[https://hechingerreport.org/theres-finally-federal-data-on-low-income-college-graduation-rates-but-its-wrong/], gives a comprehensive view of universities in the US as a whole^[downloaded from https://ed-public-download.scorecard.network/downloads/College_Scorecard_Raw_Data_01162025.zip];

- [x] _The Huffington post_ and _Chronicle of higher education_'s data on how colleges finance their athletics^[Described at http://projects.huffingtonpost.com/ncaa/reporters-note and directly downloadable from http://hpin.s3.amazonaws.com/ncaa-financials/ncaa-financials-data.zip.];

- [x] The _Department of education_'s data on foreign gifts to and contracts with US colleges^[Described at https://studentaid.ed.gov/sa/about/data-center/school/foreign-gifts and downloadable from https://studentaid.gov/sites/default/files/ForeignGifts.xls.];

- [x] _The census bureau_’s "Quarterly summary of state and local government tax revenue^[Indexed at https://www.census.gov/programs-surveys/qtax.html and downloadable from https://www2.census.gov/programs-surveys/qtax/tables/historical/2009Q1-2024Q3-QTAX-Table1.xlsx.];

- [x] NCAA data on student athletes’ academic progress and graduation rates^[Available from https://www.icpsr.umich.edu/web/ICPSR/studies/30022# with an institutional login via PSU.];

- [x] The _Department of education_'s data on student loan default rates^[Downloadable from https://studentaid.gov/data-center/student/default.]; and

- [x] The _Department of education_'s annual school- and team-level datasets on college sports' finances^[Bandied at https://ope.ed.gov/athletics/ and downloadable for the years 2003--2023 at https://ope.ed.gov/athletics/#/datafile/list.].

In aggregate, the above datasets amount to several tens of thousands of lines.
We intend to convert each of these datasets to CSVs where they are not already distributed as such.
For preprocessing and initial sanitization, we plan to use Unix tools like Sed and Awk---that is to say, we plan on carrying out our preprocessing in the usual Unix-y way.
We plan to track down more subtle problems by enforcing column restrictions on our schemas^[Or _schemata_, if you really must.]
While we plan to import the data organized around individual colleges, we have yet to develop our database schema beyond that.

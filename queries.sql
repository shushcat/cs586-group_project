-- Q0: How many graduate and undergraduate students are enrolled at reported schools?

SELECT i.name, i.state, i.city, i.undergraduate_enrollment, i.grad_enrollment
FROM colleges_2014.institutions AS i
WHERE (i.grad_enrollment IS NOT NULL) or (i.undergraduate_enrollment IS NOT NULL)
ORDER BY i.grad_enrollment DESC;

-- Q1: No. of undergraduate students and the insititution

SELECT i.name, i.state, i.city, i.undergraduate_enrollment
FROM colleges_2014.institutions AS i
WHERE i.undergraduate_enrollment IS NOT null
ORDER BY i.undergraduate_enrollment DESC;

-- Q2: No. of graduate students and the insititution

SELECT i.name, i.state, i.city, i.grad_enrollment
FROM colleges_2014.institutions AS i
WHERE i.grad_enrollment IS NOT null
ORDER BY i.grad_enrollment DESC;

-- Q3: Which schools report charging the highest in-state tuition?

SELECT i.name, i.state, i.city, ifp.in_state_cost
FROM colleges_2014.institutional_financial_profile AS ifp
JOIN colleges_2014.institutions AS i ON ifp.unitid = i.unitid
WHERE ifp.in_state_cost IS NOT NULL
ORDER BY ifp.in_state_cost DESC
LIMIT 10;

-- Q4: Which schools report charging the highest out-state tuition?

-- Q4: Which schools report the highest and lowest ratios between in-state and out-of-state tuition?

SELECT i.name, i.state, i.city, cast((cast(ifp.in_state_cost as float)/ifp.out_state_cost) AS numeric(7,6)) AS in_to_out
FROM colleges_2014.institutional_financial_profile AS ifp
JOIN colleges_2014.institutions AS i ON ifp.unitid = i.unitid
WHERE ifp.in_state_cost IS NOT NULL
ORDER BY in_to_out ASC;

-- Q5: How much education have people, shall we say, undergone in the areas where the students at institutions with the lowest in-state to out-of-state tuition ratios come from?
-- The present dataset doesn't allow for answering this question because apparently `pct_ba` and `pct_grad_prof` weren't being reported or gathered in 2014.

SELECT i.name, i.state, i.city,
	cast((cast(ifp.in_state_cost AS float)/ifp.out_state_cost)
		AS numeric(7,6)) AS in_to_out,
	sb.pct_ba, sb.pct_grad_prof
FROM colleges_2014.institutional_financial_profile AS ifp
JOIN colleges_2014.institutions AS i ON ifp.unitid = i.unitid
JOIN colleges_2014.student_backgrounds AS sb ON ifp.unitid = sb.unitid
WHERE ifp.in_state_cost IS NOT NULL
ORDER BY in_to_out ASC;

-- Q6: What are SAT scores like in the reported schools with the lowest ratios of in-state to out-of-state tuition?

SELECT i.name, i.state, i.city,
	cast((cast(ifp.in_state_cost AS float)/ifp.out_state_cost)
		AS numeric(7,6)) AS in_to_out,
	sap.sat_avg_all
FROM colleges_2014.institutional_financial_profile AS ifp
JOIN colleges_2014.institutions AS i ON ifp.unitid = i.unitid
JOIN colleges_2014.student_academic_profile AS sap ON ifp.unitid = sap.unitid
WHERE ifp.in_state_cost IS NOT NULL AND sap.sat_avg_all IS NOT NULL
ORDER BY in_to_out ASC;

-- (Table doesn't exist.) Which schools and colleges that also report students' sexes report the lowest student-faculty ratios?

SELECT fsr.name, fsr.state, fsr.city, fsr.student_faculty_ratio
FROM colleges_2014.faculty_and_sex_ratios AS fsr
WHERE fsr.student_faculty_ratio IS NOT NULL
ORDER BY fsr.student_faculty_ratio ASC
LIMIT 15;

-- Q7: Which schools accepted the most money from foreign donors in 2014?

SELECT i.name, i.state, sum(fg.gift_amount) AS gift_sum
FROM colleges_2014.foreign_gifts AS fg
JOIN colleges_2014.institutions AS i ON fg.unitid = i.unitid
GROUP BY i.unitid
ORDER BY gift_sum DESC
LIMIT 10;

-- Q8: What is instructional spending like at those schools?

SELECT i.name, i.state, sum(fg.gift_amount) AS gift_sum, ifp.instruction_spend_per_student
FROM colleges_2014.foreign_gifts AS fg
JOIN colleges_2014.institutions AS i ON fg.unitid = i.unitid
JOIN colleges_2014.institutional_financial_profile AS ifp ON fg.unitid = ifp.unitid
GROUP BY i.unitid, ifp.instruction_spend_per_student
ORDER BY gift_sum DESC
LIMIT 10;

-- Q9: How profitable are sports at schools that reported foreign gifts?

SELECT i.name, i.state, sum(fg.gift_amount) AS gift_sum,
	cast(ifp.instruction_spend_per_student AS numeric(9,2)), af.net_revenue AS net_revenue
FROM colleges_2014.foreign_gifts AS fg
JOIN colleges_2014.institutions AS i ON fg.unitid = i.unitid
JOIN colleges_2014.institutional_financial_profile AS ifp ON fg.unitid = ifp.unitid
JOIN colleges_2014.athletics_financing AS af ON fg.unitid = af.unitid
GROUP BY i.unitid, ifp.instruction_spend_per_student,
	af.athletic_revenues, af.athletic_expenses, af.net_revenue
ORDER BY gift_sum DESC;

-- Q10: How profitable are sports at schools that reported as to whether or not their sports-related doings are profitable?

SELECT i.name, i.state, cast(ifp.instruction_spend_per_student AS numeric(9,2)),
	af.net_revenue AS net_revenue
FROM colleges_2014.institutions AS i
JOIN colleges_2014.institutional_financial_profile AS ifp ON i.unitid = ifp.unitid
JOIN colleges_2014.athletics_financing AS af ON i.unitid = af.unitid
GROUP BY i.unitid, ifp.instruction_spend_per_student,
	af.athletic_revenues, af.athletic_expenses, af.net_revenue
ORDER BY ifp.instruction_spend_per_student DESC;

-- Q11: How is the profitibility of sports distributed among schools?

SELECT cast(avg(af.net_revenue) AS numeric(10,2)) AS mean,
	cast(percentile_cont(0.5) WITHIN GROUP
		(ORDER BY af.net_revenue) AS numeric(10,2)) AS median,
	cast(MODE() WITHIN GROUP (ORDER BY af.net_revenue) AS numeric(10,2)) AS mode,
	cast(stddev(af.net_revenue) AS numeric(10,2)) AS standard_deviation
FROM colleges_2014.athletics_financing as af;

-- Q12: Which country donated most frequently to each school that reported foreign gifts?

SELECT i.name, fg.unitid,
	MODE() WITHIN GROUP (ORDER BY fg.donor_country) AS top_donor
FROM colleges_2014.foreign_gifts AS fg
join colleges_2014.institutions as i on fg.unitid = i.unitid
GROUP BY i.name, fg.unitid;

-- Q13: And again, but with a CTE:

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

-- Q14: And again in still more convoluted fashion, but this time listing the top three donor countries for each university.

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

-- Q15: Which countries donated the most money, and how much did each one donate?

SELECT fg.donor_country, sum(gift_amount) AS donated
FROM colleges_2014.foreign_gifts AS fg
GROUP BY fg.donor_country
ORDER BY donated DESC
LIMIT 10;

-- Q16: Which country donated most often?

SELECT MODE() WITHIN GROUP (ORDER BY fg.donor_country) AS donor
FROM colleges_2014.foreign_gifts AS fg;

-- Q17: Which of the schools in Oregon that report average SAT scores, in-state tuition, and out-of-state tuition have the lowest student-to-faculty ratios?

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

-- Q18: How much does each of those schools spend directly on instructing students?

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

-- Q19: Of those, which are included in the athletics financing database and what are their net revenues from athletics, broadly construed?

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

-- Q20: Which schools' graduates have the highest median debt?

SELECT i.name, i.state, i.city, sfp.grad_debt_mdn
FROM colleges_2014.student_financial_profile AS sfp
JOIN colleges_2014.institutions AS i on sfp.unitid = i.unitid
WHERE sfp.grad_debt_mdn IS NOT NULL
ORDER BY sfp.grad_debt_mdn DESC
LIMIT 10;

-- Q21: Do the schools with the largest sports subsidies have fewer students from low income or first-to-attend-college backgrounds?
-- (There doesn't seem to be any correlation.)

SELECT i.name, i.state, sfp.pell_ever, sfp.first_gen, af.subsidy
FROM colleges_2014.student_financial_profile AS sfp
JOIN colleges_2014.institutions AS i ON sfp.unitid = i.unitid
JOIN colleges_2014.athletics_financing AS af ON af.unitid = i.unitid;

-- Q22: Do schools that spend more on student instruction have higher faculty salaries?

SELECT i.name, i.state, ifp.average_faculty_salary, ifp.instruction_spend_per_student
FROM colleges_2014.institutional_financial_profile AS ifp
JOIN colleges_2014.institutions AS i ON ifp.unitid = i.unitid;

-- Q23: Which of the colleges that responded pay the most per student sports in the undergrad program?

SELECT i.name,(af.athletic_expenses - af.student_fees) / i.undergraduate_enrollment AS sports_pay_per_student
FROM colleges_2014.institutions i
JOIN colleges_2014.athletics_financing af ON i.unitid = af.unitid
WHERE af.athletic_expenses IS NOT NULL
    AND i.undergraduate_enrollment > 0
ORDER by sports_pay_per_student DESC
LIMIT 10;

-- Q24: Which of the colleges that responded pay the most per student sports in the grad program?

SELECT i.name,(af.athletic_expenses - af.student_fees) / i.grad_enrollment AS sports_pay_per_student
FROM colleges_2014.institutions i
JOIN colleges_2014.athletics_financing af ON i.unitid = af.unitid
WHERE af.athletic_expenses IS NOT NULL
    AND i.grad_enrollment > 0
ORDER by sports_pay_per_student DESC
LIMIT 10;

-- Q25: How many students are involved in both academics and sports?

SELECT i.name as college_name, SUM(i.undergraduate_enrollment) AS no_of_students_in_sports
FROM colleges_2014.institutions i
WHERE i.unitid IN (SELECT DISTINCT unitid FROM colleges_2014.athletics_financing)
GROUP BY i.name
ORDER BY no_of_students_in_sports DESC;

-- S: Statements to display first 15 rows of each table

SELECT * FROM colleges_2014.institutions limit 15;
SELECT * FROM colleges_2014.student_backgrounds limit 15;
SELECT * FROM colleges_2014.student_academic_profile limit 15;
SELECT * FROM colleges_2014.student_financial_profile limit 15;
SELECT * FROM colleges_2014.institutional_financial_profile limit 15;
SELECT * FROM colleges_2014.foreign_gifts limit 15;
SELECT * FROM colleges_2014.athletics_financing limit 15;

-- C: Count statements for all the tables

SELECT count(*) FROM colleges_2014.institutions;
SELECT count(*) FROM colleges_2014.student_backgrounds;
SELECT count(*) FROM colleges_2014.student_academic_profile;
SELECT count(*) FROM colleges_2014.student_financial_profile;
SELECT count(*) FROM colleges_2014.institutional_financial_profile;
SELECT count(*) FROM colleges_2014.foreign_gifts;
SELECT count(*) FROM colleges_2014.athletics_financing;


-- See below for a cache of cynical or vague unanswered questions.
------------------------------------------------------------------
-- Does spending on college sports affect student's academic performances?
-- Does cost of attendance correlate with funding for college sports?
----------------
-- How many consecutive wins have various college sports team had?
-- How many students are involved in college sports?
-- How many students, by school, have received funding based on athletics participation?
-- How much funding is offered to students when comparing between states?
-- Is there a connection between subsidies to college sports teams and Title-IX investigations?
-- Is there a difference in the average funding for male and female college sports teams?
-- What are the top 15 schools and colleges that have good ratings?
-- What is the average amount or scholarship money offered per year in each category?
-- What is the average of students who are good at both sports and academics?
-- What is the connection between college sports and academics?
-- What is the variation in funding for education versus sports?
-- What kinds of funding are offered to students at schools and colleges?
-- Which schools and colleges participate and encourage students in more than 1 sport?
-- Which schools and colleges support financing for academically oriented students?
-- Which schools and colleges support financing for students involved in sports?

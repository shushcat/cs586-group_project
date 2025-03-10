-- How many graduate and undergraduate students are enrolled at reported schools?

SELECT i.name, i.state, i.city, i.undergraduate_enrollment, i.grad_enrollment
FROM institutions AS i
WHERE (i.grad_enrollment IS NOT NULL) or (i.undergraduate_enrollment IS NOT NULL)
ORDER BY i.grad_enrollment DESC;

-- Which schools report charging the highest in-state tuition?

SELECT i.name, i.state, i.city, ifp.in_state_cost
FROM institutional_financial_profile AS ifp
JOIN institutions AS i ON ifp.unitid = i.unitid
WHERE ifp.in_state_cost IS NOT NULL
ORDER BY ifp.in_state_cost DESC
LIMIT 5;

-- Which schools report the highest and lowest ratios between in-state and out-of-state tuition?

SELECT i.name, i.state, i.city, cast((cast(ifp.in_state_cost as float)/ifp.out_state_cost) AS numeric(7,6)) AS in_to_out
FROM institutional_financial_profile AS ifp
JOIN institutions AS i ON ifp.unitid = i.unitid
WHERE ifp.in_state_cost IS NOT NULL
ORDER BY in_to_out ASC;

-- How much education have people, shall we say, undergone in the areas where the students at institutions with the lowest in-state to out-of-state tuition ratios come from?
-- The present dataset doesn't allow for answering this question because apparently `pct_ba` and `pct_grad_prof` weren't being reported or gathered in 2014.

SELECT i.name, i.state, i.city,
	cast((cast(ifp.in_state_cost AS float)/ifp.out_state_cost)
		AS numeric(7,6)) AS in_to_out,
	sb.pct_ba, sb.pct_grad_prof
FROM institutional_financial_profile AS ifp
JOIN institutions AS i ON ifp.unitid = i.unitid
JOIN student_backgrounds AS sb ON ifp.unitid = sb.unitid
WHERE ifp.in_state_cost IS NOT NULL
ORDER BY in_to_out ASC;

-- What are SAT scores like in the reported schools with the lowest ratios of in-state to out-of-state tuition?

SELECT i.name, i.state, i.city,
	cast((cast(ifp.in_state_cost AS float)/ifp.out_state_cost)
		AS numeric(7,6)) AS in_to_out,
	sap.sat_avg_all
FROM institutional_financial_profile AS ifp
JOIN institutions AS i ON ifp.unitid = i.unitid
JOIN student_academic_profile AS sap ON ifp.unitid = sap.unitid
WHERE ifp.in_state_cost IS NOT NULL AND sap.sat_avg_all IS NOT NULL
ORDER BY in_to_out ASC;

-- Which schools and colleges that also report students' sexes report the lowest student-faculty ratios?

SELECT fsr.name, fsr.state, fsr.city, fsr.student_faculty_ratio
FROM faculty_and_sex_ratios AS fsr
WHERE fsr.student_faculty_ratio IS NOT NULL
ORDER BY fsr.student_faculty_ratio ASC
LIMIT 15;

-- Which schools accepted the most money from foreign donors in 2014?

SELECT i.name, i.state, sum(fg.gift_amount) AS gift_sum
FROM foreign_gifts AS fg
JOIN institutions AS i ON fg.unitid = i.unitid
GROUP BY i.unitid
ORDER BY gift_sum DESC
LIMIT 10;

-- What is instructional spending like at those schools?

SELECT i.name, i.state, sum(fg.gift_amount) AS gift_sum, ifp.instruction_spend_per_student
FROM foreign_gifts AS fg
JOIN institutions AS i ON fg.unitid = i.unitid
JOIN institutional_financial_profile AS ifp ON fg.unitid = ifp.unitid
GROUP BY i.unitid, ifp.instruction_spend_per_student
ORDER BY gift_sum DESC
LIMIT 10;

-- How profitable are sports at schools that reported foreign gifts?

SELECT i.name, i.state, sum(fg.gift_amount) AS gift_sum,
	cast(ifp.instruction_spend_per_student AS numeric(9,2)), af.net_revenue AS net_revenue
FROM foreign_gifts AS fg
JOIN institutions AS i ON fg.unitid = i.unitid
JOIN institutional_financial_profile AS ifp ON fg.unitid = ifp.unitid
JOIN athletics_financing AS af ON fg.unitid = af.unitid
GROUP BY i.unitid, ifp.instruction_spend_per_student,
	af.athletic_revenues, af.athletic_expenses, af.net_revenue
ORDER BY gift_sum DESC;

-- How profitable are sports at schools that reported as to whether or not their sports-related doings are profitable?

SELECT i.name, i.state, cast(ifp.instruction_spend_per_student AS numeric(9,2)),
	af.net_revenue AS net_revenue
FROM institutions AS i
JOIN institutional_financial_profile AS ifp ON i.unitid = ifp.unitid
JOIN athletics_financing AS af ON i.unitid = af.unitid
GROUP BY i.unitid, ifp.instruction_spend_per_student,
	af.athletic_revenues, af.athletic_expenses, af.net_revenue
ORDER BY ifp.instruction_spend_per_student DESC;

-- How is the profitibility of sports distributed among schools?

SELECT cast(avg(af.net_revenue) AS numeric(10,2)) AS mean,
	cast(percentile_cont(0.5) WITHIN GROUP
		(ORDER BY af.net_revenue) AS numeric(10,2)) AS median,
	cast(MODE() WITHIN GROUP (ORDER BY af.net_revenue) AS numeric(10,2)) AS mode,
	cast(stddev(af.net_revenue) AS numeric(10,2)) AS standard_deviation
FROM athletics_financing as af;

-- Which country donated most frequently to each school that reported foreign gifts?

WITH donor_ranks AS (
	SELECT fg.unitid, fg.donor_country, count(*) AS n_gifts,
		ROW_NUMBER() OVER (PARTITION BY fg.unitid ORDER BY count(*) DESC,
			fg.donor_country) AS rank,
		sum(fg.gift_amount) AS total
	FROM foreign_gifts as fg
	GROUP BY unitid, donor_country
)

-- And again, but with a CTE:

WITH top_donor AS (
	SELECT fg.unitid,
		MODE() WITHIN GROUP (ORDER BY fg.donor_country) AS top_donor
	FROM foreign_gifts AS fg
	GROUP BY fg.unitid
) 
SELECT i.name, td.top_donor
FROM foreign_gifts AS fg
JOIN institutions AS i ON fg.unitid = i.unitid
JOIN top_donor AS td ON fg.unitid = td.unitid
GROUP BY i.name, td.top_donor;

-- And again in still more convoluted fashion, but this time listing the top three donor countries for each university.

WITH donor_ranks AS (
	SELECT fg.unitid, fg.donor_country, count(*) AS n_gifts,
		ROW_NUMBER() OVER (PARTITION BY fg.unitid ORDER BY count(*) DESC,
			fg.donor_country) AS rank,
		sum(fg.gift_amount) AS total
	FROM foreign_gifts as fg
	GROUP BY unitid, donor_country
)
SELECT i.name, dr.donor_country AS top_donor, dr.total, rank
FROM donor_ranks AS dr
JOIN institutions AS i on dr.unitid = i.unitid
WHERE rank = 1 OR rank = 2 OR rank = 3
ORDER BY i.name ASC, dr.total DESC;

-- Which countries donated the most money, and how much did each one donate?

SELECT fg.donor_country, sum(gift_amount) AS donated
FROM foreign_gifts AS fg
GROUP BY fg.donor_country
ORDER BY donated DESC
LIMIT 10;

-- Which country donated most often?

SELECT MODE() WITHIN GROUP (ORDER BY fg.donor_country) AS thisn
FROM foreign_gifts AS fg;

-- Which of the schools in Oregon that report average SAT scores, in-state tuition, and out-of-state tuition have the lowest student-to-faculty ratios?

SELECT i.name, i.state, i.city, i.student_faculty_ratio
FROM institutions AS i
JOIN student_backgrounds AS sb ON i.unitid = sb.unitid
JOIN student_academic_profile AS sap ON sb.unitid = sap.unitid
JOIN institutional_financial_profile AS ifp ON sap.unitid = ifp.unitid
WHERE sap.sat_avg_all IS NOT NULL
	AND i.student_faculty_ratio IS NOT NULL
	AND ifp.in_state_cost IS NOT NULL
	AND ifp.out_state_cost IS NOT NULL
	AND i.state = 'OR'
ORDER BY i.student_faculty_ratio;

-- How much does each of those schools spend directly on instructing students?

SELECT i.name, i.state, i.city, i.student_faculty_ratio, ifp.instruction_spend_per_student
FROM institutions AS i
JOIN student_backgrounds AS sb ON i.unitid = sb.unitid
JOIN student_academic_profile AS sap ON sb.unitid = sap.unitid
JOIN institutional_financial_profile AS ifp ON sap.unitid = ifp.unitid
WHERE sap.sat_avg_all IS NOT NULL
	AND i.student_faculty_ratio IS NOT NULL
	AND ifp.in_state_cost IS NOT NULL
	AND ifp.out_state_cost IS NOT NULL
	AND i.state = 'OR'
ORDER BY i.student_faculty_ratio;

-- Of those, which are included in the athletics financing database and what are their net revenues from athletics, broadly construed?

SELECT i.name, i.state, i.city, i.student_faculty_ratio,
	af.athletic_revenues, af.athletic_expenses, 
	(af.athletic_revenues - af.athletic_expenses) AS net
FROM institutions AS i
JOIN student_backgrounds AS sb ON i.unitid = sb.unitid
JOIN student_academic_profile AS sap ON sb.unitid = sap.unitid
JOIN institutional_financial_profile AS ifp ON sap.unitid = ifp.unitid
JOIN athletics_financing AS af ON i.unitid = af.unitid
WHERE sap.sat_avg_all IS NOT NULL
	AND i.student_faculty_ratio IS NOT NULL
	AND ifp.in_state_cost IS NOT NULL
	AND ifp.out_state_cost IS NOT NULL
	AND i.state = 'OR'
ORDER BY i.student_faculty_ratio;

-- Which schools' graduates have the highest median debt?

SELECT i.name, i.state, i.city, grad_debt_mdn
FROM student_financial_profile AS sfp
JOIN institutions AS i on sfp.unitid = i.unitid
WHERE grad_debt_mdn IS NOT NULL
ORDER BY grad_debt_mdn DESC
LIMIT 5;

-- Which schools and colleges support financing for academically oriented students?
-- Which schools and colleges support financing for students involved in sports?
-- How many students are involved in college sports?
-- What kinds of funding are offered to students at schools and colleges?
-- How much funding is offered to students when comparing between states?
-- Which schools and colleges are highly supportive of sports?
-- What is the variation in funding for education versus sports?
-- Which schools and colleges participate and encourage students in more than 1 sport?
-- What is the average of students who are good at both sports and academics?
-- How many students, by school, have received funding based on athletics participation?
-- What is the average amount or scholarship money offered per year in each category?
-- Is there a difference in the average funding for male and female college sports teams?
-- How does any difference in the previous question compare to differences in funding based on academic merit?

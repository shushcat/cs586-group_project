-- How many graduate students are enrolled at reporting schools?

SELECT i.name, i.state, i.city, i.grad_enrollment
FROM institutions AS i
WHERE i.grad_enrollment IS NOT NULL
ORDER BY i.grad_enrollment DESC;

-- How many students are involved in both academics and sports?

-- Which schools report charging the highest in-state tuition?

SELECT i.name, i.state, i.city, ifp.in_state_cost
FROM institutional_financial_profile AS ifp
JOIN institutions AS i ON ifp.unitid = i.unitid
WHERE ifp.in_state_cost IS NOT NULL
ORDER BY ifp.in_state_cost DESC
LIMIT 5;

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

-- Which schools and colleges support financing for academically oriented students?
-- Which schools and colleges support financing for students involved in sports?
-- How many students are involved in college sports?
-- What kinds of funding are offered to students at schools and colleges?
-- How much funding is offered to students when comparing between states?
-- Which schools and colleges are highly supportive of sports?
-- What is the variation in funding for education versus sports?
-- Which schools and colleges participate and encourage students in more than 1 sport?
-- What is the average of students who are good at both sports and academics?
-- How many consecutive wins have various college sports team had?
-- How many students, by school, have received funding based on athletics participation?
-- What is the average amount or scholarship money offered per year in each category?
-- Is there a difference in the average funding for male and female college sports teams?
-- How does any difference in the previous question compare to differences in funding based on academic merit?

-- What is the ranking of schools in Oregon that report average SAT scores, in-state tuition, and out-of-state tuition when ordered by student-to-faculty ratios?

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

-- Of those, which are included in the athletics financing database, and what are their net revenues from athletics, broadly construed?

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
	aND i.state = 'OR'
ORDER BY i.student_faculty_ratio;


SELECT i.name, i.state, i.city, i.student_faculty_ratio,
	ifp.in_state_cost, ifp.out_state_cost,
	sb.ugds_men, sb.ugds_women,
	sap.sat_avg_all
FROM institutions AS i
JOIN student_backgrounds AS sb ON i.unitid = sb.unitid
JOIN student_academic_profile AS sap ON sb.unitid = sap.unitid
JOIN institutional_financial_profile AS ifp ON sap.unitid = ifp.unitid
WHERE sap.sat_avg_all IS NOT NULL
	AND i.student_faculty_ratio IS NOT NULL
	AND ifp.in_state_cost IS NOT NULL
	AND ifp.out_state_cost IS NOT NULL
	aND i.state = 'OR'
ORDER BY i.student_faculty_ratio;

select * from institutions;

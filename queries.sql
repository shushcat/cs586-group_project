-- How many students are in high school, under grad, grad etc programs?
-- How many students are involved in both academics and sports?

-- Which colleges report charging the highest in-state tuition?

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
-- Which schools have the lowest student-to-faculty ratios in Oregon?
-- ...In the US?

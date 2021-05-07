
			---avg emotion intesity per emotion listed---
/*			
SELECT name, emotion_id, ROUND(AVG(intensity_percent),2) AS avg
FROM poem_emotion INNER JOIN emotion ON emotion.id = poem_emotion.emotion_id
GROUP BY name, emotion_id
ORDER BY avg DESC
*/

			---Poets by grade---
/*			
SELECT grade.name, COUNT(grade_id)
FROM author INNER JOIN grade ON grade.id = author.grade_id
GROUP BY grade_id, grade.name
ORDER BY grade.name
*/
		
			---Poets by gender and grade---
/*			
SELECT gender.name, grade.name, COUNT(grade_id)
FROM author 
	INNER JOIN grade ON grade.id = author.grade_id
	INNER JOIN gender ON author.gender_id = gender.id
WHERE gender_id = '1' OR gender_id = '2'
GROUP BY grade_id, grade.name, gender.name
ORDER BY grade.name
*/

--Trends in data show consistently more females than males in every provided grade level
				

			---



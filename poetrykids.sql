
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
				

			---Life and Death poems---
/*		
SELECT CASE 
		WHEN text ILIKE '%life%' THEN 'Life'
		WHEN text ILIKE '%death%' THEN 'Death'
END poem_description,
COUNT(id) AS num_of_poems, ROUND(AVG(char_count), 2) AS avg_char_count
FROM poem
WHERE text ILIKE '%death%' OR text ILIKE '%life%'
GROUP BY poem_description
*/


			---Poem length and Emotion intensity---
/*		
WITH poem_length_intensity AS 
(SELECT name AS emotion_name, ROUND(AVG(intensity_percent), 2) AS avg_emotion_intensity, ROUND(AVG(char_count), 2) AS avg_char_count
FROM 
poem INNER JOIN poem_emotion ON poem.id = poem_emotion.poem_id
INNER JOIN emotion ON emotion.id = poem_emotion.emotion_id
GROUP BY name
ORDER BY avg_char_count DESC)

SELECT title, poem.id, emotion.name, text, intensity_percent, char_count, avg_char_count
FROM poem 
INNER JOIN poem_emotion ON poem.id = poem_emotion.poem_id
INNER JOIN emotion ON emotion.id = poem_emotion.emotion_id
INNER JOIN poem_length_intensity ON emotion.name = poem_length_intensity.emotion_name
WHERE emotion.name ILIKE 'joy'
ORDER BY intensity_percent DESC
LIMIT 5
*/

--4/5 of the joy poems are shorter than the avg joy poem length, the most joyfull poem is about a dog--


			---Anger Poems by 1st and 5th Graders---
/*		
WITH first_grade_anger AS 
(SELECT poem.id, char_count, grade_id, intensity_percent, emotion_id
FROM poem 
INNER JOIN author USING (id)
INNER JOIN poem_emotion ON poem.id = poem_emotion.poem_id
WHERE emotion_id ='1' AND grade_id = '1'),
		
fifth_grade_anger AS 
(SELECT poem.id, char_count, grade_id, intensity_percent, emotion_id
FROM poem 
INNER JOIN author USING (id)
INNER JOIN poem_emotion ON poem.id = poem_emotion.poem_id
WHERE emotion_id ='1' AND grade_id = '5')			
			

SELECT ROUND(avg(first_grade_anger.intensity_percent), 2) AS first_grade_intensity, ROUND(avg(fifth_grade_anger.intensity_percent), 2) AS fifth_grade_intensity
FROM fifth_grade_anger FULL JOIN first_grade_anger USING (emotion_id)
*/
--5th graders write more intense poems when it comes to anger--

			---Anger Poems by 1st and 5th Graders, looking at gender---
			
		--1st grade anger poems--
/*
SELECT poem.id, gender.name, char_count, grade_id, intensity_percent, emotion_id
FROM poem 
INNER JOIN author USING (id)
INNER JOIN poem_emotion ON poem.id = poem_emotion.poem_id
INNER JOIN gender ON gender.id = author.gender_id
WHERE emotion_id ='1' AND grade_id = '1'
ORDER BY intensity_percent DESC
LIMIT 5
*/
--2 were female, 2 were male,1 was NA--

		--5th grade anger poems--
/*
SELECT poem.id, gender.name, char_count, grade_id, intensity_percent, emotion_id
FROM poem 
INNER JOIN author USING (id)
INNER JOIN poem_emotion ON poem.id = poem_emotion.poem_id
INNER JOIN gender ON gender.id = author.gender_id
WHERE emotion_id ='1' AND grade_id = '5'
ORDER BY intensity_percent DESC
LIMIT 5
*/
--4 were female, 1 was NA--

--TOTALS: 
		--females = 6
		--males = 2
		--NA = 2


			---Poets Named "Emily"---
			
SELECT grade_id, author.id, emotion.name, COUNT(emotion_id)
FROM author 
INNER JOIN poem ON poem.author_id = author.id
INNER JOIN poem_emotion ON poem_emotion.poem_id = poem.id
INNER JOIN emotion ON emotion.id = poem_emotion.emotion_id
WHERE author.name ILIKE 'emily'
GROUP BY author.id, emotion.name

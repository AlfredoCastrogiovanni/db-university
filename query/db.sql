--
-- SELECT QUERY
--

-- Selezionare tutti gli studenti nati nel 1990
SELECT * FROM `students` WHERE YEAR(`date_of_birth`) = 1990;

-- Selezionare tutti i corsi che valgono più di 10 crediti
SELECT * FROM `courses` WHERE `cfu` > 10;

-- Selezionare tutti gli studenti che hanno più di 30 anni
SELECT * FROM `students` WHERE YEAR(`date_of_birth`) < 1994;

SELECT * FROM `students` WHERE DATEDIFF(YEAR, `date_of_birth`, GETDATE()) > 30;

-- Selezionare tutti i corsi del primo semestre del primo anno di un qualsiasi corso di laurea
SELECT * FROM `courses` WHERE `period` = 'I semestre' AND `year` = 1;

-- Selezionare tutti gli appelli d'esame che avvengono nel pomeriggio (dopo le 14) del 20/06/2020
SELECT * FROM `exams` WHERE `date` = '2020-01-19' AND HOUR(`hour`) > 14;

-- Selezionare tutti i corsi di laurea magistrale
SELECT * FROM `degrees` WHERE `level` = 'magistrale';

-- Da quanti dipartimenti è composta l'università?
SELECT COUNT('id') AS `departments_number` FROM `departments`;

-- Quanti sono gli insegnanti che non hanno un numero di telefono?
SELECT COUNT('id') AS `teachers_without_number` FROM `teachers` WHERE `phone` IS NULL;

--
-- GROUP BY QUERY
--

-- Contare quanti iscritti ci sono stati ogni anno
SELECT YEAR(`enrolment_date`), COUNT(`id`) AS `students_number` FROM `students` GROUP BY YEAR(`enrolment_date`);

-- Contare gli insegnanti che hanno l'ufficio nello stesso edificio
SELECT `office_number`, COUNT(`id`) AS `teachers_number` FROM `teachers` GROUP BY `office_number`;

-- Calcolare la media dei voti di ogni appello d'esame
SELECT `exam_id`, AVG(`vote`) AS `average_vote` FROM `exam_student` GROUP BY `exam_id`;

-- Contare quanti corsi di laurea ci sono per ogni dipartimento
SELECT `department_id`, COUNT(`id`) AS `degrees_number` FROM `degrees` GROUP BY `department_id`;

--
-- JOIN QUERY
--

-- Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia
SELECT `students`.`name`, `students`.`surname` FROM `students`
JOIN `degrees` ON `degrees`.`id` = `students`.`degree_id`
WHERE `degrees`.`name` = 'Corso di Laurea in Economia';

-- Selezionare tutti i Corsi di Laurea Magistrale del Dipartimento di Neuroscienze
SELECT `degrees`.`name` AS `degrees_name`, `departments`.`name` AS `departments_name` FROM `degrees`
JOIN `departments` ON `departments`.`id` = `degrees`.`department_id`
WHERE `degrees`.`level` = 'magistrale' AND `departments`.`name` = 'Dipartimento di Neuroscienze';

-- Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)
SELECT `courses`.`name` FROM `courses`
JOIN `course_teacher` ON `course_teacher`.`course_id` = `courses`.`id`
JOIN `teachers` ON `teachers`.`id` = `course_teacher`.`teacher_id`
WHERE `course_teacher`.`teacher_id` = 44;

-- Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il relativo dipartimento, in ordine alfabetico per cognome e nome
SELECT `students`.`name`, `students`.`surname`, `degrees`.`name`, `departments`.`name` FROM `students`
JOIN `degrees` ON `degrees`.`id` = `students`.`degree_id`
JOIN `departments` ON `departments`.`id` = `degrees`.`department_id`
ORDER BY `students`.`surname`;

-- Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti
SELECT `degrees`.`name` AS `degrees_name`, `courses`.`name` AS `courses_name`, `teachers`.`name` AS `teacher_name`, `teachers`.`surname` AS `teacher_surname` FROM `degrees`
JOIN `courses` ON `courses`.`degree_id` = `degrees`.`id`
JOIN `course_teacher` ON `course_teacher`.`course_id` = `courses`.`id`
JOIN `teachers` ON `teachers`.`id` = `course_teacher`.`teacher_id`;

-- Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica
SELECT `teachers`.`name`, `teachers`.`surname`
FROM `teachers`
JOIN `course_teacher` ON `course_teacher`.`teacher_id` = `teachers`.`id`
JOIN `courses` ON `courses`.`id` = `course_teacher`.`course_id`
JOIN `degrees` ON `degrees`.`id` = `courses`.`degree_id`
JOIN `departments` ON `departments`.`id` = `degrees`.`department_id`
WHERE `departments`.`name` = 'Dipartimento di Matematica';

-- Selezionare per ogni studente il numero di tentativi sostenuti per ogni esame, stampando anche il voto massimo. Successivamente, filtrare i tentativi con voto minimo 18.
SELECT `students`.`name`, `students`.`surname`, `courses`.`name`, COUNT(*) AS `exam_numbers`, MAX(`exam_student`.`vote`) AS `max_vote` FROM `students`
JOIN `exam_student` ON `exam_student`.`student_id` = `students`.`id`
GROUP BY `students`.`id`, `courses`.`id`
HAVING `max_vote` >= 18;
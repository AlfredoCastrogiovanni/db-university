--
-- SELECT QUERY
--

-- Selezionare tutti gli studenti nati nel 1990
SELECT * FROM `students` WHERE YEAR(`date_of_birth`) = 1990;

-- Selezionare tutti i corsi che valgono più di 10 crediti
SELECT * FROM `courses` WHERE `cfu` > 10;

-- Selezionare tutti gli studenti che hanno più di 30 anni
SELECT * FROM `students` WHERE YEAR(`date_of_birth`) < 1994;

-- Selezionare tutti i corsi del primo semestre del primo anno di un qualsiasi corso di laurea
SELECT * FROM `courses` WHERE `period` = 'I semestre';

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
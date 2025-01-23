---1. Создать таблицу с факультетами: id, имя факультета, стоимость обучения
create table faculty (
	id int primary key,
	"name" varchar(50),
	education_price money);
	
--2. Создать таблицу с курсами: id, номер курса, id факультета
create table course (
	id int primary key,
	"number" int,
	faculty_id int references faculty(id));
--3. Создать таблицу с учениками: id, имя, фамилия, отчество, бюджетник/частник, id курса

create table student (
	id int primary key,
	"name" varchar(50),
	"surname" varchar(50),
	"secondname" varchar(50),
	budghet boolean,
	course_id int references course(id));

--Часть 2. Заполнение данными:
--1. Создать два факультета: Инженерный (30 000 за курс) , Экономический (49 000 за курс)
insert into faculty (id, "name", education_price) values (1, 'Инженерный', 30000.00);
insert into faculty values (2, 'Экономический', 49000.00);

--2. Создать 1 курс на Инженерном факультете: 1 курс
insert into course values (1, 1, 1);

--3. Создать 2 курса на экономическом факультете: 1, 4 курс
insert into course values (2, 1, 2);
insert into course values (3, 4, 2);

--4. Создать 5 учеников:
--Петров Петр Петрович, 1 курс инженерного факультета, бюджетник
insert into student values (1, 'Петр', 'Петров', 'Петрович', true, 1);

--Иванов Иван Иваныч, 1 курс инженерного факультета, частник
insert into student values (2, '"Иван', 'Иванов', 'Иваныч', false, 1);

--Михно Сергей Иваныч, 4 курс экономического факультета, бюджетник
insert into student values (3, 'Cергей', 'Михно', 'Иваныч', true, 3);

--Стоцкая Ирина Юрьевна, 4 курс экономического факультета, частник
insert into student values (4, '"Ирина', '"Стоцкая', '"Юрьевна', false, 3);

--Младич Настасья (без отчества), 1 курс экономического факультета, частник
insert into student values (5, 'Настасья', 'Младич', null, false, 2);


select * from student, course, faculty
--Часть 3. Выборка данных. Необходимо написать запросы, которые выведут на экран:
--1. Вывести всех студентов, кто платит больше 30_000.
select student.name, student.surname, student.secondname, faculty.education_price
from student 
join course on student.course_id = course.id
join faculty on course.faculty_id = faculty.id	
where student.budghet = false and faculty.education_price > cast(30000 as money)

--2. Перевести всех студентов Петровых на 1 курс экономического факультета.
update student set course_id = 2
where student.surname='Петров'

select student.name, student.surname, student.course_id
from student 
where student.surname='Петров'
	
--3. Вывести всех студентов без отчества или фамилии.

select student.name, student.surname, student.secondname
from student
where student.surname is null or student.secondname is null

--4. Вывести всех студентов содержащих в фамилии или в имени или в отчестве "ван". (пример name like '%Петр%' - найдет всех Петров, Петровичей, Петровых)
select student.name, student.surname, student.secondname
from student
where student.surname like '%ван%' or student.name like '%ван%' or student.secondname like '%ван%'

--5. Удалить все записи из всех таблиц.
delete from student;
delete from course; 
delete from faculty;



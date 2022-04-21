    ---1. Dept (Dept_Name, Est_Year, HoD, Budget)
    ---2. Program (Prg_Name, FK(Dept_Name), Tot_Cred, Offered_Year)
    ---3. Student (Stud_ID, Name, DoB, Address, Height, Blood_Grp, FK(Prg_Name), FK(Dept_Name))
    ---4. Course (Course_code, Title, Credit, FK(Ins_ID), FK(Sem_name))
    ---5. Stud_Take_Course (FK(Stud_ID), FK(Course_Code), FK(Semester))
    ---6. Teacher (Ins_ID, Name, Phone, Address, Blood_Grp, FK(Dept_Name))
    ---7. Semester (Sem_Name, FK(Prg_Name, Dept_Name))

SET PAGESIZE 100;

DROP TABLE Dept CASCADE CONSTRAINTS;
DROP TABLE Program CASCADE CONSTRAINTS;
DROP TABLE Student CASCADE CONSTRAINTS;
DROP TABLE Course CASCADE CONSTRAINTS;
DROP TABLE Stud_Take_Course CASCADE CONSTRAINTS;
DROP TABLE Teacher CASCADE CONSTRAINTS;
DROP TABLE Semester CASCADE CONSTRAINTS;

CREATE TABLE DEPT
(
	DEPT_NAME VARCHAR2(30),
	EST_YEAR DATE,
	HOD VARCHAR2(30),
	BUDGET NUMBER,
	CONSTRAINT DEPT_PK_1 PRIMARY KEY (DEPT_NAME)
);

CREATE TABLE PROGRAM
(
	PRG_NAME VARCHAR2(30),
	DEPT_NAME VARCHAR2(30),
	TOT_CREDIT NUMBER,
	OFFERED_YEAR DATE,
	CONSTRAINT PROGRAM_PK_1 PRIMARY KEY (PRG_NAME),
	CONSTRAINT PROGRAM_FK_1 FOREIGN KEY (DEPT_NAME) REFERENCES DEPT
);

CREATE TABLE STUDENT
(
	STUD_ID INT,
	NAME VARCHAR2(40),
	DOB DATE,
	ADDRESS VARCHAR2(100),
	HEIGHT NUMBER,
	BLOOD_GRP VARCHAR2(10),
	PRG_NAME VARCHAR2(30),
	DEPT_NAME VARCHAR2(30),
	CONSTRAINT STUDENT_PK_1 PRIMARY KEY (STUD_ID),
	CONSTRAINT STUDENT_FK_1 FOREIGN KEY (PRG_NAME) REFERENCES PROGRAM,
	CONSTRAINT STUDENT_FK_2 FOREIGN KEY (DEPT_NAME) REFERENCES DEPT
);

CREATE TABLE TEACHER
(
	INS_ID INT,
	NAME VARCHAR2(40),
	PHONE NUMBER,
	ADDRESS VARCHAR2(100),
	BLOOD_GRP VARCHAR2(10),
	DEPT_NAME VARCHAR2(30),
	CONSTRAINT TEACHER_PK_1 PRIMARY KEY (INS_ID),
	CONSTRAINT TEACHER_FK_1 FOREIGN KEY (DEPT_NAME) REFERENCES DEPT
);

CREATE TABLE SEMESTER
(
	SEM_NAME VARCHAR2(30),
	PRG_NAME VARCHAR2(30),
	DEPT_NAME VARCHAR2(30),
	CONSTRAINT SEMESTER_PK_1 PRIMARY KEY (SEM_NAME)
);

CREATE TABLE COURSE
(
	COURSE_CODE VARCHAR2(12),
	TITLE VARCHAR2(30),
	CREDIT NUMBER,
	INS_ID INT,
	SEM_NAME VARCHAR2(20),
	CONSTRAINT COURSE_PK_1 PRIMARY KEY (COURSE_CODE),
	CONSTRAINT COURSE_FK_1 FOREIGN KEY (INS_ID) REFERENCES TEACHER,
	CONSTRAINT COURSE_FK_2 FOREIGN KEY (SEM_NAME) REFERENCES SEMESTER
);

CREATE TABLE STUDENT_TAKE_COURSE
(
	STUD_ID INT,
	COURSE_CODE VARCHAR2(12),
	SEMESTER VARCHAR2(30),
	CONSTRAINT STUDENT_TAKE_COURSE_PK_1 PRIMARY KEY (STUD_ID, COURSE_CODE, SEMESTER),
	CONSTRAINT STUDENT_TAKE_COURSE_FK_1 FOREIGN KEY (STUD_ID) REFERENCES STUDENT,
	CONSTRAINT STUDENT_TAKE_COURSE_FK_2 FOREIGN KEY (COURSE_CODE) REFERENCES COURSE,
	CONSTRAINT STUDENT_TAKE_COURSE_FK_3 FOREIGN KEY (SEMESTER) REFERENCES SEMESTER
);
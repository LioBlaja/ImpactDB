DROP TABLE IF EXISTS Контракт;
DROP TABLE IF EXISTS Курс;
DROP TABLE IF EXISTS Аудитория;
DROP TABLE IF EXISTS Преподаватель;
DROP TABLE IF EXISTS Студент;
DROP TABLE IF EXISTS Факультет;

CREATE TABLE Факультет(
fid CHAR (3) NOT NULL,  --ид факультета
название VARCHAR2 (40),     --название факультета
адрес VARCHAR2 (40),        --адрес факультета
телефон VARCHAR2 (12),      --основной телефон факультета
CONSTRAINT facult_pk PRIMARY KEY(fid)
);

CREATE TABLE Студент(
sid CHAR(6) NOT NULL,   --ид студента = регистрационный номер
сnp CHAR (13),          --персональный код (CNP)
имя VARCHAR2(40) NOT NULL, --имя студента
датар DATE,             --дата рождения
адрес VARCHAR2 (40),    --адрес студента
курс NUMBER(1) NOT NULL,  --год обучения (1,2,3,4, в особых случаях 5,6)
средний_балл NUMBER (4,2),     --средний балл за последний завершенный год
стипендия NUMBER (5,0),     --текущая стипендия
fid CHAR (3) NOT NULL ,     --ид факультета, к которому относится студент
CONSTRAINT stud_pk PRIMARY KEY(sid),
CONSTRAINT facult_fk  FOREIGN KEY (fid) REFERENCES Факультет(fid) ON DELETE CASCADE
);

CREATE TABLE Преподаватель(
pid CHAR (6) NOT NULL,  --ид преподавателя
сnp CHAR (13),          --персональный код (CNP)
имя VARCHAR2 (40),      --имя преподавателя
датар DATE,             --дата рождения
fid CHAR (3) NOT NULL,  --ид факультета, к которому относится преподаватель
ученая_степень varchar2(4) NOT NULL, -- ученая степень
CONSTRAINT prof_pk PRIMARY KEY(pid),
CONSTRAINT pfacult_fk  FOREIGN KEY (fid) REFERENCES Факультет(fid) ON DELETE CASCADE,
CONSTRAINT ученая_степень_проверка CHECK(ученая_степень IN ('as', 'sl', 'conf', 'prof')) -- ассистент, старший преподаватель, доцент, профессор
);

CREATE TABLE Аудитория(
cods CHAR (4) NOT NULL, --код аудитории
этаж NUMBER (2),        --этаж
мест NUMBER (3),        --максимальное количество мест в аудитории
CONSTRAINT sala_pk PRIMARY KEY(cods)
);

CREATE TABLE Курс(
cid CHAR (5) NOT NULL,  --ид курса
название VARCHAR2 (32) NOT NULL, --название курса
fid CHAR (3) NOT NULL,  --ид факультета, предоставляющего курс
курс NUMBER(1),         --год, когда курс проводится (если факультативный, курс = NULL, напр. педагогика)
семестр NUMBER (2) NOT NULL, --семестр, когда проводится курс (1 и 2 семестры - в 1-м году, 3 и 4 - во 2-м и т.д.)
pid CHAR (6),           --ид преподавателя, ведущего курс
день VARCHAR2 (8),      --день недели, когда проходит курс
время NUMBER (2),       --время проведения курса
аудитория CHAR (4),     --код аудитории, в которой проходит курс
CONSTRAINT crs_pk PRIMARY KEY(cid),
CONSTRAINT cfacult_fk  FOREIGN KEY (fid) REFERENCES Факультет(fid) ON DELETE CASCADE,
CONSTRAINT crssala_fk  FOREIGN KEY (аудитория) REFERENCES Аудитория(cods) ON DELETE CASCADE,
CONSTRAINT crsprof_fk  FOREIGN KEY (pid) REFERENCES Преподаватель(pid) ON DELETE CASCADE
);

CREATE TABLE Контракт(
nrc NUMBER (5) NOT NULL, --номер контракта
sid CHAR (6) NOT NULL,   --ид студента, подписавшего контракт
cid CHAR(5) NOT NULL,    --ид курса, для которого заключен контракт
год NUMBER (4) NOT NULL, --календарный год подписания контракта (например, 2023 для учебного года 2023/2024)
семестр NUMBER (1),      --семестр курса, по которому подписан контракт
оценка NUMBER (4,2),     --итоговая оценка по контрактированному курсу за год
CONSTRAINT contr_pk PRIMARY KEY(nrc),
CONSTRAINT constd_fk  FOREIGN KEY (sid) REFERENCES Студент(sid) ON DELETE CASCADE,
CONSTRAINT concrs_fk  FOREIGN KEY (cid) REFERENCES Курс(cid) ON DELETE CASCADE
);

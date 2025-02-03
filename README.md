# Schema Bazei de Date Universitare

## Facultate
- **fid** (`CHAR(3)`, NOT NULL) - ID facultate (cheie primară)
- **nume** (`VARCHAR(40)`) - Numele facultății
- **adr** (`VARCHAR(40)`) - Adresa facultății
- **tel** (`VARCHAR(12)`) - Telefonul principal al facultății

## Student
- **sid** (`CHAR(6)`, NOT NULL) - ID student (număr matricol) (cheie primară)
- **cnp** (`CHAR(13)`) - Cod numeric personal
- **nume** (`VARCHAR(40)`, NOT NULL) - Numele studentului
- **datan** (`DATE`) - Data nașterii
- **adr** (`VARCHAR(40)`) - Adresa studentului
- **an** (`NUMBER(1)`, NOT NULL) - Anul de studiu (1-6)
- **media** (`NUMBER(4,2)`) - Media anuală a ultimului an absolvit
- **bursa** (`NUMBER(5,0)`) - Bursa actuală
- **fid** (`CHAR(3)`, NOT NULL) - ID facultate (cheie externă către `Facultate(fid)`)

## Profesor
- **pid** (`CHAR(6)`, NOT NULL) - ID profesor (cheie primară)
- **cnp** (`CHAR(13)`) - Cod numeric personal
- **nume** (`VARCHAR(40)`) - Numele profesorului
- **datan** (`DATE`) - Data nașterii
- **fid** (`CHAR(3)`, NOT NULL) - ID facultate (cheie externă către `Facultate(fid)`)
- **grad** (`VARCHAR2(4)`, NOT NULL) - Grad didactic (`as`, `sl`, `conf`, `prof`)

## Sala
- **cods** (`CHAR(4)`, NOT NULL) - Cod sală (cheie primară)
- **etaj** (`NUMBER(2)`) - Etajul sălii
- **nrlocuri** (`NUMBER(3)`) - Număr maxim de locuri în sală

## Curs
- **cid** (`CHAR(5)`, NOT NULL) - ID curs (cheie primară)
- **titlu** (`VARCHAR(32)`, NOT NULL) - Titlul cursului
- **fid** (`CHAR(3)`, NOT NULL) - ID facultate (cheie externă către `Facultate(fid)`)
- **an** (`NUMBER(1)`) - Anul în care se ține cursul (null dacă este opțional)
- **semestru** (`NUMBER(2)`, NOT NULL) - Semestrul în care se ține cursul
- **pid** (`CHAR(6)`) - ID profesor titular (cheie externă către `Profesor(pid)`)
- **zi** (`VARCHAR(8)`) - Ziua din săptămână în care are loc cursul
- **ora** (`NUMBER(2)`) - Ora la care are loc cursul
- **sala** (`CHAR(4)`) - Codul sălii (cheie externă către `Sala(cods)`)

## Contract
- **nrc** (`NUMBER(5)`, NOT NULL) - Număr contract (cheie primară)
- **sid** (`CHAR(6)`, NOT NULL) - ID student (cheie externă către `Student(sid)`)
- **cid** (`CHAR(5)`, NOT NULL) - ID curs (cheie externă către `Curs(cid)`)
- **an** (`NUMBER(4)`, NOT NULL) - Anul calendaristic în care s-a semnat contractul
- **semestru** (`NUMBER(1)`) - Semestrul pentru care s-a semnat contractul
- **nota** (`NUMBER(4,2)`) - Nota finală la cursul contractat

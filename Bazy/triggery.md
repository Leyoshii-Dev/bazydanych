**DYNAMIC SQL**

**Tu jest przyklad EXECUTE IMMEDIATE**

```sql
CREATE OR REPLACE PROCEDURE add_dep
    (p_name departments.department_name%TYPE,
    p_loc departments.location_id%TYPE)
AS
    v_id departments.department_id%TYPE;
BEGIN
    EXECUTE IMMEDIATE
     ’SELECT MAX(department_id)
        FROM departments’
        INTO v_id;
        EXECUTE IMMEDIATE ’INSERT INTO departments VALUES -- uzywamy tego tylko wtedy gdy CHCEMY bardzo wywolac jakies zapytanie w tym miejscu a normalnie by nie zadzialalo
        (:1, :2, NULL, :3)’
    USING v_id+10, p_name, p_loc;

    COMMIT;
END add_dep;
/
EXECUTE add_dep(’Logistics’, 2400);

```


**CURSORY**

```sql
DECLARE
    TYPE EmpCurTyp IS REF CURSOR;
    v_emp_cursor EmpCurTyp;
    emp_record employees%ROWTYPE;
    v_stmt_str VARCHAR2(200);
    v_e_job employees.job%TYPE;
BEGIN
    v_stmt_str := ’SELECT * FROM employees WHERE job_id = :j’; -- cursor do stringa zostal wrzucony
    OPEN v_emp_cursor FOR v_stmt_str USING ’MANAGER’;
    LOOP
        FETCH v_emp_cursor INTO emp_record;
        EXIT WHEN v_emp_cursor%NOTFOUND;
    END LOOP;
    CLOSE v_emp_cursor;
END;
/
```


**Triggery**


**Duze litery**
```sql
CREATE OR REPLACE TRIGGER Initcap_names
    AFTER INSERT ON astronauts -- Po dodaniu nowego rekordu do astronauts
BEGIN
    UPDATE astronauts SET      -- zmienia imie i nazwisko na pierwsze duze litery slowa, czyli szymon na Szymon
        name = Initcap(name),  
        surname = Initcap(surname);
END;
/
```
**To to samo ale z tym new, czyli przed dodaniem**
```sql

CREATE OR REPLACE TRIGGER Initcap_names
    BEFORE INSERT ON astronauts -- before przed dodaniem zmienia i przy dodawaniu juz beda nowe wartosci takie
    FOR EACH ROW
BEGIN
    :NEW.name := Initcap(:NEW.name);
    :NEW.surname := Initcap(:NEW.surname);
END;
/

```

**Warunki**


```sql
CREATE OR REPLACE TRIGGER pay_rise
    BEFORE UPDATE OF salary ON employees --przed zmiana
    FOR EACH ROW
    WHEN (Upper(NEW.job_id) NOT LIKE ’PRES%’ -- gdy id nie bedzie pres, mgr, man i vp... ma zrobic begin
        AND Upper(NEW.job_id) NOT LIKE ’%MGR%’
        AND Upper(NEW.job_id) NOT LIKE ’%MAN%’
        AND Upper(NEW.job_id) NOT LIKE ’%VP%’)
BEGIN
    IF :NEW.salary > :OLD.salary * 1.1 THEN -- no i tu jesli nowa wartosc jest wieksza niz 110% starej to zmieniamy na 110% starej wartosci
        :NEW.salary := :OLD.salary * 1.1;       -- czyli, jak ktos ma 100 i chcemy mu zwiekszyc o 20% to sie nie da tylko zwiekszy o 10% a jak mu o 5% zwiekszymy to nic sie nie stanie
    END IF;
END;
/

```

**Wiele operacji**

```sql
CREATE OR REPLACE TRIGGER emp_change
    AFTER INSERT OR DELETE OR UPDATE ON employees -- tu sobie wybieramy ktora operacje chcemy
    FOR EACH ROW
BEGIN
    IF INSERTING THEN                               -- i wtedy przez ify mozna sie odwolac, jesli akurat taka operacja jest to robimy to itp, tu akurat jest historia co kto zrobil itp
        INSERT INTO aud VALUES(’employees’, CURRENT_TIMESTAMP,
        NULL, ’Inserting of new employee’);
    END IF;
    IF DELETING THEN
        INSERT INTO aud VALUES(’employees’, CURRENT_TIMESTAMP,
        NULL, ’Deleting of employee’);
    END IF;
    IF UPDATING THEN
        INSERT INTO aud VALUES(’employees’, CURRENT_TIMESTAMP,
        NULL, ’Modification of employees data’);
    END IF;
END;

```


**Modyfikacja widoku triggerem instead of**
```sql
CREATE VIEW loc_coun AS                             -- jakis tam widok
    SELECT * FROM locations NATURAL JOIN countries;

CREATE OR REPLACE TRIGGER tr_loc_coun
    INSTEAD OF INSERT OR UPDATE ON loc_coun             -- czyli tutaj jak chcemy zmienic widok jakis to po prostu
    BEGIN
    -- ... check if it doesn’t already exists
    INSERT INTO locations VALUES (:NEW.location_id,      -- zamiast tego dodajemy do tej konkretnej tabeli która jest w widoku
    :NEW.street_address,:NEW.postal_code,
    :NEW.city, :NEW.state_province,
    :NEW.country_id);
    -- ... check if it doesn’t already exists
    INSERT INTO countries VALUES (:NEW.country_id,        -- akurat tu sa dwie wiec do dwoch te nowe dane
    :NEW.country_name, :NEW.region_id);
END;
```

**triggery systemowe**
**Tu akurat uniemozliwia to usuwanie, takie sztuczne to jest, zamiast uprawnieniami to po prostu uniemozliwia usuwanie**
```sql
CREATE OR REPLACE TRIGGER no_drop
    BEFORE DROP
    ON SCHEMA
BEGIN
    RAISE_APPLICATION_ERROR(-20123,
    User||’ number ’||Uid||’ cannot drop objects.’);
END;

CREATE TRIGGER log_errors
    AFTER SERVERERROR ON DATABASE
BEGIN
    IF (IS_SERVERERROR (1017)) THEN
        INSERT INTO server_audit(Current_timestamp,’Error - 1017’)
    END IF;
END;
```

**8.1 Exercises for Self-Practice**
```sql
--1. Create a table in which you will store logs of operations performed on a selected table (inserts, deletes, updates). Create a trigger that, after a change is made to the selected table, inserts an appropriate comment into the audit table.

--2. Extend the comments with details of the modified rows by using a row-level trigger.
-- Akurat to drugie tez przez przypadek zrobilem xd do drugiego potrzebne jest dodanie:
-- For each row to umozliwia uzycie :NEW.name
-- 'Insert - added Astronaut (' || :NEW.name || ', ' ||:NEW.surname || ')';
--
Create table logs(
    id number,
    operation_name Varchar(250),
    recorded_at date,
    who Varchar(50)
);

CREATE OR REPLACE TRIGGER tg_logs
    BEFORE INSERT OR UPDATE OR DELETE
    ON astronauts
    FOR EACH ROW
DECLARE
    v_max_id number;
    v_operation Varchar2(250);
BEGIN
    SELECT nvl(max(id), 0) + 1  into v_max_id FROM logs;
    if inserting then
        v_operation := 'Insert - added Astronaut (' || :NEW.name || ', ' ||:NEW.surname || ')';
    elsif updating then
        v_operation := 'Update';
    elsif deleting then
        v_operation := 'Delete';
    end if;
    INSERT INTO logs(id,operation_name,recorded_at,who) values (v_max_id,v_operation,CURRENT_TIMESTAMP,USER);
end;
/


INSERT into astronauts (name,surname,birth_date,death_date) values ('agata','szczota',To_Date('11-11-2046','DD-MM-YYYY'),NULL);
```



```sql
--3. Build a trigger that, during data modification, validates a relationship between the entered value and another table, e.g., a discount limited by values from another table, a salary within a defined salary range, the quantity of ordered goods not exceeding stock levels, etc.
CREATE OR REPLACE TRIGGER check_salary_range
    BEFORE INSERT OR UPDATE OF salary ON astronauts -- przed dodaniem/zmiana pensji
    FOR EACH ROW
DECLARE
    v_min_sal jobs.min_salary%TYPE;
    v_max_sal jobs.max_salary%TYPE;
BEGIN
    -- Pobieramy limity z innej tabeli (jobs) dla konkretnego stanowiska
    SELECT min_salary, max_salary 
    INTO v_min_sal, v_max_sal
    FROM jobs 
    WHERE job_id = :NEW.job_id;

    -- Sprawdzamy, czy nowa pensja nie wykracza poza te dane
    IF :NEW.salary < v_min_sal OR :NEW.salary > v_max_sal THEN
        RAISE_APPLICATION_ERROR(-20500, 
            'Blad: Pensja ' || :NEW.salary || ' nie miesci sie w widelkach (' 
            || v_min_sal || ' - ' || v_max_sal || ') dla tego stanowiska!');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        -- Jesli nie ma takiego job_id w tabeli jobs, to tez blokujemy
        RAISE_APPLICATION_ERROR(-20501, 'Nie ma takiego stanowiska w bazie!');
END;
/
```


```sql
--4. Create a trigger that completes and standardizes data being inserted into the table.
CREATE OR REPLACE TRIGGER standardize_astronaut_data
    BEFORE INSERT ON astronauts -- przed wstawieniem danych
    FOR EACH ROW
BEGIN
    -- 1. Nazwisko zawsze z duzej litery (Initcap)
    :NEW.surname := Initcap(:NEW.surname);
    
    -- 2. Mail zawsze z malych liter, zeby sie nie dublowaly przy logowaniu
    :NEW.email := Lower(:NEW.email);
    
    -- 3. Jesli ktos zapomnial podac daty rekrutacji (hire_date), wpisujemy aktualna
    IF :NEW.hire_date IS NULL THEN
        :NEW.hire_date := SYSDATE;
    END IF;
    
    -- 4. Generujemy automatyczny login (pierwsza litera imienia + nazwisko)
    :NEW.login := Lower(Substr(:NEW.name, 1, 1) || :NEW.surname);
END;
/
```


```sql
--5. Create a view, and then a trigger that enables data modification through that view.
CREATE OR REPLACE VIEW v_mission_roster AS
    SELECT m.id AS mission_id, m.name AS mission_name, a.id AS astronaut_id, a.surname
    FROM missions m
    JOIN mission_astronauts ma ON m.id = ma.mission_id
    JOIN astronauts a ON ma.astronaut_id = a.id;

-- Trigger, który pozwoli "dodawać astronautów do misji" przez ten widok
CREATE OR REPLACE TRIGGER tr_manage_roster
    INSTEAD OF INSERT ON v_mission_roster -- zamiast wstawiac do widoku...
BEGIN
    -- Logika: Widok jest tylko do odczytu, wiec trigger musi 
    -- recznie dodac powiazanie do tabeli laczacej (mission_astronauts)
    INSERT INTO mission_astronauts (mission_id, astronaut_id)
    VALUES (:NEW.mission_id, :NEW.astronaut_id);
    
    -- Mozemy tez przy okazji zaktualizowac info w logach
    INSERT INTO logs(id, operation_name, recorded_at, who)
    VALUES ((SELECT nvl(max(id),0)+1 FROM logs), 
            'New crew assignment: Mission ' || :NEW.mission_id, 
            CURRENT_TIMESTAMP, USER);
END;
/
```





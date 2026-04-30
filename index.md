**Deklaracja Zmiennych**

```sql
Declare
 v_age NUMBER(3);
Begin
    v_age := 15;
    DBMS_OUTPUT.PUT_LINE('Masz ' || v_age || 'lat');
END;
```

**Cytaty i znaki specjalne**
```sql
Declare
    v_string VARCHAR2(30) := 'I''m learning';
Begin
    DBMS_OUTPUT.PUT_LINE(v_string);
    v_string := q'[I'm bored]';
    DBMS_OUTPUT.PUT_LINE(v_string);
    v_string := nq'[Zażółć gęślą jaźń']';
    DBMS_OUTPUT.PUT_LINE(v_string);
END;
```
**q - cytaty**
**nq - znaki specjalne**


**Branie danych z tabelki**
```sql
Declare
    v_first_name astronauts.NAME%TYPE; -- typ danych z kolumny
    v_surname astronauts.SURNAME%TYPE;
BEGIN
    SELECT NAME, SURNAME 
    into v_first_name, v_surname
    from astronauts
    where id=1;

    DBMS_OUTPUT.PUT_LINE(v_first_name);
    DBMS_OUTPUT.PUT_LINE(v_surname);
END;
```

**Recordy, dzialaja tak jakbyscie klase zrobili i chuj**

```sql
Declare
    TYPE astronaut IS RECORD(
        v_name Varchar(30),
        v_surname Varchar(30)
    );
    vr_astronaut astronaut;
BEGIN
    SELECT NAME, SURNAME 
    into vr_astronaut.v_name, vr_astronaut.v_surname
    from astronauts
    where id=1;

    DBMS_OUTPUT.PUT_LINE(vr_astronaut.v_name);
    DBMS_OUTPUT.PUT_LINE(vr_astronaut.v_surname);
END;
```

**Można wszystkie dane z tabelki wziac**

```sql
Declare
    vr_astronaut ASTRONAUTS%ROWTYPE;
BEGIN
    SELECT *
    into vr_astronaut
    from astronauts
    where id=1;

    DBMS_OUTPUT.PUT_LINE(vr_astronaut.name);
    DBMS_OUTPUT.PUT_LINE(vr_astronaut.surname);
END;
```

**To jest juz spierdolone, zmienna globalna mozna powiedziec ze to jest**

```sql
VARIABLE b_salary NUMBER; -- Tworzenie zmiennej globalnej

BEGIN
    :b_salary := 2500; -- Przypisywanie jej zmiennej, wazny jest : bo to oznacza wlasnie zmienna globalna
END;
/ -- To tez w chuj wazne bo to konczy pl/sql i mozna pisac potem print

PRINT b_salary
```

**Mozna uzywac funkcji wbudowanych**
```sql
DECLARE
    v_name VARCHAR(30) := 'Jakies imie';
    v_wynik VARCHAR(30);
    v_dlugosc number;
    v_data NUMBER;
begin
    v_wynik:= UPPER(v_name); -- Duze litery
    v_dlugosc := length(v_name); -- ilosc znakow w slowie
    v_data := LAST_DAY(SYSDATE) - TRUNC(sysdate) +1; 
    DBMS_OUTPUT.PUT_LINE(v_wynik);
    DBMS_OUTPUT.PUT_LINE(v_dlugosc);
    DBMS_OUTPUT.PUT_LINE(v_data);
END;
```


**Wrzucanie dane prosto z inserta do zmiennej**

```sql
DECLARE
    v_birth_date DATE;
begin
    INSERT INTO astronauts
    (id,name,surname,birth_date,death_date)
    values
    (250,'franek','pomarancza',TO_DATE('07-05-1999','DD-MM_YYYY'),NULL)
    returning birth_date into v_birth_date; -- To wazne wrzucasz sobie dane z inserta do zmiennej
    
    DBMS_OUTPUT.PUT_LINE(v_birth_date);
END;
```

** Mozna wrzucic dane z rekordu ale musi wszystko pasować, chyba ze sobie wybierzecie dane**

```sql
Declare
    TYPE astronaut IS RECORD(
        v_id number,
        v_name Varchar(30),
        v_surname Varchar(30),
        v_birth_date DATE,
        v_death_date DATE
    );
    vr_astronaut astronaut;
BEGIN
    vr_astronaut.v_id := 300;
    vr_astronaut.v_name := 'Kolega';
    vr_astronaut.v_surname := 'Twojej mamy';
    vr_astronaut.v_birth_date := To_Date('2000-02-02','YYYY-MM-DD');
    vr_astronaut.v_death_date := NULL;

    INSERT INTO astronauts values vr_astronaut;

    -- Tak mozna sobie wybrac jak cos
    --INSERT INTO astronauts (name,surname,birth_date) values (vr_astronaut.v_name,vr_astronaut.v_surname,vr_astronaut.v_birth_date);
END;
```


**Warunki**

```sql
DECLARE
    ale Varchar(30) := 'aaaaaaaaa'; 
BEGIN
    IF length(ale) > 10 THEN
        ale := 'Imie';
    ELSIF length(ale) < 10 THEN -- Uwaga na to scierwo ELSIF jebany ELSIF :)
        ale := 'Inne imie 1';
    ELSE
        ale := 'Inne imie 2';
    END IF;
    DBMS_OUTPUT.PUT_LINE(ale);
END;
```


**CASE**
```sql
DECLARE
    ale Varchar(30) := 'aaa';
BEGIN

    CASE ale -- to mozna na rozne sposoby robic ale pokazuje taki, mozna tez warunki dac po when ale bez tego ale po CASE musi byc wtedy
        when 'a' THEN ale := 'instr1';
        when 'aa' THEN ale := 'instr2';
        when 'aaa' THEN ale := 'instr3';
        else ale := 'else';
    END case;
    DBMS_OUTPUT.PUT_LINE(ale);
END;
```


**loop to taka petla do while**

```sql
DECLARE
    ale Varchar(30) := 'aaa';
BEGIN

    loop
        ale := CONCAT(ale,'a');
        exit when length(ale) > 10;
    END loop;
    DBMS_OUTPUT.PUT_LINE(ale);
END;
```

**While taki sam jak zwykle tylko ze trzeba dodac to jebane loop**

```sql
DECLARE
    ale Varchar(30) := 'aaa';
BEGIN

    while length(ale) < 10 LOOP
        ale := CONCAT(ale, 'a');
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(ale);
END;
```


**for nawet ok ale mamy tu jebane loop znowu :)**

```sql
DECLARE
    ale Varchar(30) := 'aaa';
BEGIN

    FOR i IN 4..10 LOOP
        ale := Concat(ale,'a');
    END loop;
    DBMS_OUTPUT.PUT_LINE(length(ale));
END;
```

**Zrobione zadanie to zeby przecwiczyc**
```sql
--1. Write an anonymous block that displays the message "Hello mission!".

begin
    DBMS_OUTPUT.PUT_LINE('Hello mission!');
end;
/
--2. Create an anonymous block containing declarations of four variables and one constant of different data types. Initialize some of the variables and the constant with values. In the executable section, display the values of the variables.

DECLARE
    v_imie varchar(30);
    v_wiek number;
    v_data date;
begin
    v_imie := 'imie';
    v_wiek := 5;
    v_data := TO_DATE('2000-10-10','YYYY-MM-DD');
    DBMS_OUTPUT.PUT_LINE(v_imie ||'  '|| v_wiek ||'lat  ' || v_data);
end;
/

--3. Within an anonymous block, declare a record type copying the column types from any table and a variable of that record type. In the executable section, assign values to the fields of this variable and display the stored values.

DECLARE
    TYPE astro is RECORD(
        vr_id astronauts.id%TYPE,
        vr_name astronauts.name%TYPE,
        vr_surname astronauts.surname%TYPE,
        vr_birth_date astronauts.birth_date%TYPE,
        vr_death_date astronauts.death_date%TYPE
    );
    vr_astro astro;
BEGIN
    vr_astro.vr_id := 1;
    vr_astro.vr_name := 'imie';
    DBMS_OUTPUT.PUT_LINE(vr_astro.vr_id || ' '|| vr_astro.vr_name);
end;
/

--4. Create a record type based on a row of a selected table. Assign values to the variable and display them.

DECLARE
    astro astronauts%ROWTYPE;
BEGIN
    astro.name := 'imie';
    astro.surname := 'nazwisko';
        DBMS_OUTPUT.PUT_LINE(astro.name || ' ' || astro.surname);
END;
/

--5. Create a record type based on a row of a selected table. Retrieve values into it using a query (only one row!) and display them.

DECLARE
    astro astronauts%ROWTYPE;
BEGIN
    SELECT name, surname
    INTO astro.name, astro.surname
    FROM astronauts
    where id = 1;
    DBMS_OUTPUT.PUT_LINE(astro.name || ' ' || astro.surname);
END;
/

--6. Create a record type based on a row of a selected table and also declare a regular variable with a type copied from one attribute of the same table. In the executable section, assign values to the record variable. Then modify any row of the table using the UPDATE statement and the values from the record variable. At the same time, return an appropriate value (RETURNING INTO clause) into the additional variable.

DECLARE
    astro astronauts%ROWTYPE;
    v_name astronauts.name%TYPE;
BEGIN
    SELECT * 
    into astro
    from astronauts where id = 250;
    astro.name := 'kupa';

    UPDATE astronauts SET ROW = astro where id = 250
    RETURNING name into v_name;
    DBMS_OUTPUT.PUT_LINE(v_name);
END;
/

--7. Use the IF conditional statement to display a row from a selected table. Declare the necessary variables.

DECLARE 
    astro astronauts%ROWTYPE;
begin
    SELECT *
    into astro
    from astronauts
    where id =250;
    DBMS_OUTPUT.PUT_LINE('halo');
    if length(astro.name) > 5 then
        DBMS_OUTPUT.PUT_LINE('Twoje imie jest okej');
    elsif length(astro.name) =5 then
        DBMS_OUTPUT.PUT_LINE('Jeszcze jedna literka');
    else
        DBMS_OUTPUT.PUT_LINE('Za krótkie imie!!!');
    end if;
end;
/


--8. Retrieve any string from the database. Display it vertically, letter by letter, using three different types of loops in turn.


DECLARE
    v_name astronauts.NAME%TYPE;
    counter simple_integer := 1;
begin
    SELECT name
    into v_name
    from astronauts
    where id=250;

    LOOP
        DBMS_OUTPUT.PUT_LINE(SUBSTR(v_name,counter,1)); -- Trzeba pamietac ze tu indeksy sa od 1...
        counter := counter +1;
        exit when counter = length(v_name)+1;
    end loop;

    DBMS_OUTPUT.PUT_LINE('');
    counter := 1;

    WHILE counter <= length(v_name) loop
        DBMS_OUTPUT.PUT_LINE(SUBSTR(v_name,counter,1)); -- Trzeba pamietac ze tu indeksy sa od 1...
        counter := counter +1;
    end loop;

    DBMS_OUTPUT.PUT_LINE('');

    FOR i IN 1..length(v_name) loop
        DBMS_OUTPUT.PUT_LINE(SUBSTR(v_name,i,1)); -- Trzeba pamietac ze tu indeksy sa od 1...
    end loop;
end;
/
```
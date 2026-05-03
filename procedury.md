**Procedura**

```sql
CREATE OR REPLACE PROCEDURE dodaj 
    (p1 number := 100 ,p2 number default 200) -- Wartosci domyslne, oczywiscie oracle ma downa i ma dwa rozne przypisania domyslne ktore sa tym samym
IS -- To zamienne slowo za declare bo w procedurach nie mozna uzywac declare XD ale to robi to samo :)
    p3 number;
Begin 
    p3 := p1 +p2;
    DBMS_OUTPUT.PUT_LINE('wynik dodawania: ' || p3);
end dodaj;
/

--Tu oracle jest zjebany i nie da sie po instrukcji napisac komentarza tylko trzeba przed
-- dla debili
EXECUTE dodaj; 
-- to to samo ale nie dla debili
EXECUTE dodaj(); 
--nie zmieniajac p1 mozemy zmienic tak p2
EXECUTE dodaj(p2 => 100); 
-- normalne przesylanie argumentow
EXECUTE dodaj(1,2);
-- tu tylko zmieniamy 1 argument 
EXECUTE dodaj(1);
```

**Procedura rekurencyjna**

```sql
CREATE OR REPLACE PROCEDURE enumeration (p_i NUMBER) 
AS -- wlasnie tutaj zamiast is jest as, jaka jest roznica? Zadna kurwa bo to ma downa :)
    v_iter NUMBER := 0;
BEGIN
    IF p_i > 0 THEN
        FOR v_iter IN 1..p_i LOOP

        dbms_output.put(v_iter);
        END LOOP;
        dbms_output.put_line(' ');
        enumeration(p_i-1); -- ta linijka nam mowi ze to rekurencja, petla ktora za kazdym razem wypisuje jedna liczbe mniej 12345, 1234... itp
    END IF;
END enumeration;
/
-- Trzy sposoby jak mozna wywolac procedure
execute enumeration(2);

Begin
    enumeration(2);
end;

call enumeration(2); -- to nie dziala albo po prostu jest zjebane chyba to dziala w sql tylko

DESCRIBE enumeration; -- Tu mozecie sobie zobaczyc co przyjmuje i jakies tam informacje o procedurze
SELECT text FROM user_source
WHERE name = 'ENUMERATION' and type = 'PROCEDURE'; -- To wgl jest ciekawe i każda linijke kodu tej procedury tym dostajecie
```




**Przykladowa procedura IN OUT jak to dziala**

```sql
CREATE OR REPLACE PROCEDURE zwiekszZasob
(p_id IN INVENTORIES.id%TYPE,                   -- IN chodzi o to ze przekazujemy tu dane do niej
    p_res_id IN INVENTORIES.resource_id%TYPE,   -- IN chodzi o to ze przekazujemy tu dane do niej
    p_quantity OUT INVENTORIES.quantity%TYPE)   -- OUT przekazujemy zmienna do ktorej bedzie wrzucone co do tej zmiennej
IS
BEGIN
    SELECT quantity
    INTO p_quantity                             -- Tutaj przypisujemy wartosc do p_quantity
    from INVENTORIES
    where id = p_id AND resource_id = p_res_id; -- Tutaj uzywamy tych id do wybrania ktory zasob chcemy 
END zwiekszZasob;
/


DECLARE
    v_quantity INVENTORIES.QUANTITY%TYPE;       -- W tej zmiennej bedzie wynik
BEGIN
    zwiekszZasob(1,2,v_quantity);                   -- wywolanie procedury
    DBMS_OUTPUT.PUT_LINE('Ilosc zasobu: ' || v_quantity); 

END;
```


**Funkcje, roznia sie od procedur tym ze cos zwracaja**

```sql
CREATE OR REPLACE FUNCTION mail (p_id number) -- Tworzenie funkcji
    return VARCHAR2                           -- Typ zwracany
IS
    v_mail Varchar2(50);
BEGIN
    SELECT Lower(last_name)||'@'||            -- jakies tam zapytanie ktore tworzy maila z imienia i id
        Lower(Substr(department_name,1,2)) ||
        department_id ||'.com'
        INTO v_mail
        FROM employees JOIN departments
        USING (department_id)
        WHERE employee_id = p_id;
        RETURN v_mail;                        -- zwracamy tego maila utworzonego
END mail;


declare
    mail Varchar(50);
begin
    mail := mail(5);
    dbms_output.put_line(mail);
end;

SELECT first_name, mail(employee_id) FROM employees; -- mozna tez w taki sposob uzyc funkcji

VARIABLE b_mail VARCHAR2(50);
EXECUTE :b_mail := mail(200); -- albo w taki sposob
PRINT b_mail; -- i nastepnie wypisac mail
```


**Package(Specyfikacja) - tutaj robimy taki interface do ktorego bedziemy sie potem odwolywac**

```sql
CREATE OR REPLACE PACKAGE emp_wages AS
    FUNCTION wages RETURN NUMBER;
    FUNCTION wages_in_dep (p_id NUMBER)
    RETURN NUMBER;
    FUNCTION average RETURN NUMBER;
    FUNCTION average_in_dep (p_id NUMBER)
    RETURN NUMBER;
    PROCEDURE increase(p_amount NUMBER);
    PROCEDURE increase(p_amount NUMBER,
    p_id NUMBER);
END emp_wages;
```


**Package body(ciało) - tu jest całe miesko naszych funkcji i danych wszystkich**


```sql
CREATE OR REPLACE PACKAGE BODY emp_wages
AS
    FUNCTION wages RETURN NUMBER            -- Mozna tworzyc cokolwiek chcemy w tym, funkcje kursory, zmienne itp i ich kod nie bedzie widoczny z zewnatrz
    AS                                      -- po wywolaniu takiej paczki cała sie ona laduje do pamieci ram i mamy blyskawiczny dostep do funkcji itp
        v_sum NUMBER;
    BEGIN
        SELECT Sum(salary+Nvl(commission_pct,0)*salary)
        INTO v_sum FROM employees;
        RETURN v_sum;
    END wages;

    FUNCTION wages_in_dep(p_id NUMBER)
        RETURN NUMBER
    AS
        v_sum NUMBER;
    BEGIN
        SELECT Sum(salary+Nvl(commission_pct,0)*salary)
        INTO v_sum FROM employees
        WHERE department_id = p_id;
        RETURN v_sum;
    END wages_in_dep;

    FUNCTION average RETURN NUMBER
    AS
        v_ave NUMBER;
    BEGIN
        SELECT Avg(salary) INTO v_ave FROM employees;
        RETURN v_ave;
END average;




SELECT emp_wages.wages() FROM dual;          -- SQL  tak mozemy np to wywolac ladnie dual to jakas pusta tabela bo nie da sie nic nie napisac po FROM

begin
    DBMS_OUTPUT.PUT_LINE(emp_wages.wages()); -- PL/SQL
end;
```


**Zadania 6.1**

```sql
--1. Create a procedure that inserts the text "Hello mission!" into a test table. Test the procedure.
CREATE OR REPLACE PROCEDURE jakistekst
IS
    v_zmienna Varchar(30);
    v_zmienna2 Varchar(30) := 'Hello mission!';
begin
    v_zmienna := 'Hello mission!';
    dbms_output.put_line(v_zmienna);
end jakistekst;
/

execute jakistekst;

--2. Create a procedure that displays the text "Hello " 
-- followed by a name provided as an input parameter. Test its operation.
CREATE OR REPLACE PROCEDURE jakistekst(p_name Varchar default 'Hello World!')
IS

begin
    dbms_output.put_line(p_name);
end jakistekst;
/

execute jakistekst;
execute jakistekst('hello world!');
execute jakistekst(p_name => 'hello world!1');

--3. Add an OUT parameter to the procedure from the previous task.
CREATE OR REPLACE PROCEDURE jakistekst(p_name OUT Varchar)
IS
begin
    p_name := 'Udalo sie zmienic';
    dbms_output.put_line(p_name);
end jakistekst;
/


DECLARE
    v_name Varchar(30);
BEGIN
    jakistekst(v_name);
    dbms_output.put_line(v_name);
END;

--4. Test the IN OUT parameter mode.
CREATE OR REPLACE PROCEDURE jakistekst(p_name IN OUT Varchar)
IS
begin
    dbms_output.put_line(p_name);
    p_name := 'Udalo sie zmienic';
end jakistekst;
/



DECLARE
    v_name Varchar(30) := 'Hello Wordl!';
BEGIN
    jakistekst(v_name);
    dbms_output.put_line(v_name);
END;


--5. Create a function analogous to the procedure from task 2. Test it inside a query.

CREATE OR REPLACE FUNCTION jakasfunkcja (p_name Varchar)   
return Varchar

as

BEGIN
    dbms_output.put_line(p_name);
    return p_name;
end jakasfunkcja;
/


SELECT jakasfunkcja('hello world!') as funkcja from dual;


--6. Create a procedure that displays and modifies selected rows of your table.
create or replace procedure edytuj(p_name astronauts.name%type, p_new_name astronauts.name%type)
IS

begin
    dbms_output.put_line(p_name);
    UPDATE astronauts set name = p_new_name where name = p_name;
end edytuj;
/


DECLARE
    v_name astronauts.name%type;
BEGIN
    SELECT name into v_name from astronauts where id = 250;
    edytuj(v_name,'gejuszek');
END;
/

select * from astronauts;


--7. Create a procedure that handles
-- two cursors, where the second cursor is parameterized with values obtained from the first one.


create or replace procedure jakiesgowno
is
    CURSOR c_mission IS
        SELECT id from missions where finished_at is null;
    
    v_mission missions.id%type;

    CURSOR c_astronauts(c_id missions.id%type) IS
        SELECT name from astronauts join mission_astronauts on astronauts.id = mission_astronauts.astronaut_id where mission_id = c_id;
    v_astronaut astronauts.name%type;
BEGIN
    Open c_mission;
    loop 
        fetch c_mission into v_mission;
        exit when c_mission%notfound OR c_mission%notfound is null;
        Open c_astronauts(v_mission);
        dbms_output.put_line('Misja: ' || v_mission);
        loop
            fetch c_astronauts into v_astronaut;
            exit when c_astronauts%notfound OR c_astronauts%notfound is null;
            dbms_output.put_line(v_astronaut);
        end loop;
        close c_astronauts;

    end loop;
    close c_mission;
end jakiesgowno;
/
execute jakiesgowno;

```


**7.1 Exercises for Self-Practice**
```sql

--1. Implement a parameterized function that calculates a value based on your data,
-- for example: the difference in an astronaut’s weight over a given period of time,
-- the average temperature at a specific location, the number of potato packages ;) etc. Test the function.


create or replace function ObliczSredniaEnergie(p_id_base bases.id%type, date_from energy.recorded_at%type, date_to energy.recorded_at%type)
return NUMBER

is
    v_srednia number;
begin

    select avg(energy_produced_kwh-energy_consumed_kwh) into v_srednia
     from energy where base_id = p_id_base and recorded_at between date_from and date_to;

    return v_srednia;

end ObliczSredniaEnergie;
/


DECLARE

begin
    dbms_output.put_line(ObliczSredniaEnergie(1,TO_DATE('10-03-2046','DD-MM-YYYY'),TO_DATE('10-03-2046','DD-MM-YYYY')));
end;






```
**Cursors and Exception Handling**

**Podstawowy kursor, służa one do pobierania wielu wierszy w przeciwienstwie do takiego select * into ktory tylko jeden pobierze nam**

```sql
DECLARE
    CURSOR c_astronauts(c_id number) IS -- jak funkcja ma po prostu argument, ALE NIE MUSI MIEC
        SELECT * from astronauts where id = c_id; -- zapytanie przez ktore chcemy otrzymac dane
    v_astronaut astronauts%ROWTYPE;
BEGIN
    Open c_astronauts(1); -- Wysylamy ze chcemy id 1 no i to nam da tego astroanute co ma id 1
    FETCH c_astronauts INTO v_astronaut; -- Tu mozemy przypisac do tej zmiennej tego astroanute
    DBMS_OUTPUT.PUT_LINE(v_astronaut.name); -- No i wypisac go na spokojnie
    CLOSE c_astronauts; -- Pamietajcie zeby zamknac bo chujnia bedzie potem
END;
```
**Uzywanie petli chociaz to jest taki chujowy przyklad no ale taki mamy pozniej bedzie lepszy**

```sql
DECLARE
    CURSOR c_astronauts(c_id number) IS
        SELECT * from astronauts where id = c_id;
    v_astronaut astronauts%ROWTYPE;
BEGIN
    Open c_astronauts(1);
    LOOP
        FETCH c_astronauts INTO v_astronaut;
        exit when c_astronauts%NOTFOUND OR c_astronauts%NOTFOUND IS NULL; -- O to chodzi w tym przykladzie ze mozna sobie wyjsc jak sie skoncza rekordy
        DBMS_OUTPUT.PUT_LINE(v_astronaut.name);
    end loop;
    DBMS_OUTPUT.PUT_LINE(c_astronauts%ROWCOUNT || ' astronautow'); -- Rowcount pokazuje ile jest wierszy

    CLOSE c_astronauts;
END;
```
**Tu fajny przyklad jak mozna sobie wszystkie dane wyciagnac, czyli po prostu robimy kursor bez argumentow i petla for sobie wypisujemy**

```sql
DECLARE
    CURSOR c_astronauts IS
        SELECT * from astronauts where 1;
BEGIN
    
    FOR v_astronaut IN c_astronauts LOOP
        DBMS_OUTPUT.PUT_LINE(c_astronauts%ROWCOUNT || v_astronaut.name);
    end loop;
END;
```

**Mozna rowniez robic cos takiego, czyli zamiast cursor to tutaj sobie to wpisac jakby ktos bardzo chcial, raczej chujowe ale mozna**

```sql
BEGIN
    FOR v_astronaut IN (SELECT * from astronauts where 1) LOOP
        DBMS_OUTPUT.PUT_LINE(v_astronaut.name);
    end loop;
END;
```


**Exceptions - czyli wyjątki :)**

```sql
DECLARE
    v_liczba number := 10;
    v_liczba1 number := 0;
BEGIN
    v_liczba := v_liczba / v_liczba1;

    EXCEPTION -- Jesli cos pojdzie nie tak w kodzie to exception zostanie wyłapany tutaj, jesli mamy nazwe tego wyjatku to mozna wpisac zamiast zero divide
        when zero_divide then
            DBMS_OUTPUT.PUT_LINE ('Nie dziel przez 0'); -- wiadomosc dla debila co popelnil blad
            DBMS_OUTPUT.PUT_LINE(SQLCODE); -- to jest kod erroru za chwile powiem co to jest, znaczy no napisze
            DBMS_OUTPUT.PUT_LINE(SQLERRM); -- to jest Co to za error, wiadomosc czego dotyczy
end;
```
**To jest ten sam kod ale uzywamy tutaj tego kodu error z SQLCODE zamiast nazwy wyjatku**

```sql
DECLARE
    v_liczba number := 10;
    v_liczba1 number := 0;
    exp1 EXCEPTION;
    PRAGMA EXCEPTION_INIT(exp1, -1476); -- trzeba zapamietac to gowno
BEGIN
    v_liczba := v_liczba / v_liczba1;

    EXCEPTION
        when exp1 then -- i potem odwolujemy sie do nazwy naszego wyjatku ktorego stworzylismy zamiast do jego prawdziwej nazwy, niektore wyjatki nie posiadaja nazw ale te najczestrze juz maja odsylam do pdfa jak ktos chce zobaczyc ich nazwy :)
            DBMS_OUTPUT.PUT_LINE ('Nie dziel przez 0');
            DBMS_OUTPUT.PUT_LINE(SQLCODE);
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
end;
```



**Tu jest przyklad jak mozna samemu wywolywac wlasne wyjatki**

```sql
DECLARE
    e_zero_value Exception;
    v_id SIMPLE_INTEGER :=0;
Begin
    BEGIN

        IF v_id = 0 THEN
            RAISE e_zero_value; -- To jest ta linijka, no i potem jest w tych przykladach pokazane ze jak ...
        END IF;
            dbms_output.put_line('cos');
        EXCEPTION
            WHEN TOO_MANY_ROWS THEN -- ...tutaj nie zostanie wylapany...
                dbms_output.put_line('Too many rows.'); 
    END;

    EXCEPTION -- To tutaj go sie zlapie :)
        WHEN e_zero_value THEN
            dbms_output.put_line('Invalid ID value.');
END;
```

**Tu jest przyklad jak mozna wywolywac wyjatki systemowe, dodalem do tego rowniez jak to wylapac bo oczywiscie chuj wie jaka to ma nazwe**
```sql
DECLARE
    v_id number := 0;
    exp Exception;
    PRAGMA EXCEPTION_INIT(exp,-20002); -- trzeba dodac to gowno
BEGIN

    if v_id = 0 then
        Raise_application_error(-20002,'Invalid ID'); -- Ta linijka odpowiada za wywolanie wyjatku systemowego
    else
        dbms_output.put_line('dziala');
    end if;

    Exception
        when exp then -- i tu sie odwolac
            dbms_output.put_line('error'); 
END;
```
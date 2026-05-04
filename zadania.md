**Wybrana tabela: ROVERS**

**1. Funkcja: Status i lokalizacja operacyjna**
```sql
--Zadanie: Napisz funkcję, która dla łazika o podanym ID (parametr) zwróci łańcuch znaków zawierający jego nazwę, aktualny status (tekstowo z tabeli rover_statuses) oraz nazwę bazy, w której aktualnie przebywa.

--Wymagania: Obsługa błędów (brak łazika o danym ID) oraz zwrot pełnego zdania (np. "Łazik Curiosity II jest obecnie w stanie: W bazie - Ładowanie, przypisany do bazy: Ares Prime").

create or replace function roverStatus
(p_id rovers.id%Type) return varchar2
as
  v_info varchar2(200);
  v_nazwa_rover varchar2(30);
  v_status varchar2(30);
  v_nazwa_bazy varchar2(30);
begin

    Select rovers.name as r_name, rover_statuses.name as rs_name, bases.name as b_name 
    into v_nazwa_rover, v_status, v_nazwa_bazy
    from rovers 
    join rover_statuses on rovers.rover_status_id = rover_statuses.id
    join bases on bases.id = rovers.base_id
    where rovers.id = p_id;
    v_info := v_nazwa_rover || ' ' || v_status || ' '|| v_nazwa_bazy;
    
    return v_info;
    Exception
        when NO_DATA_FOUND then return 'Nie znaleziono rover o takim id';
end roverStatus;
/
begin
    dbms_output.put_line(roverStatus(55));
end;
/



```


**2. Funkcja: Audyt wydajności i ładunku**
```sql
--Zadanie: Napisz funkcję, która dla łazika o podanej nazwie (parametr) zwróci opis jego parametrów technicznych: poziom baterii oraz informację o maksymalnej ładowności (max_capacity_kg).

--Wymagania: Dodatkowa logika wewnątrz: jeśli bateria jest poniżej 20%, opis musi zawierać ostrzeżenie "WYMAGANE ŁADOWANIE". Jeśli powyżej 80% – "GOTOWY DO TRASY". Obsługa błędu przy błędnej nazwie łazika.


create or replace function audit_wyd(p_name rovers.name%type) return Varchar2
is
    v_battery_level rovers.BATTERY_LEVEL%TYPE;
    v_max_capacity_kg rovers.MAX_CAPACITY_KG%TYPE;
    v_info varchar2(50) := '';
begin
    Select battery_level, max_capacity_kg into v_battery_level, v_max_capacity_kg from rovers where name = p_name;

    if v_battery_level >=80 then
        v_info := 'Gotowy do trasy';
    elsif v_battery_level <= 20 then
        v_info := 'WYMAGANE ŁADOWANIE';
    end if;

    return v_info || ' ' || v_battery_level || '% '|| v_max_capacity_kg || ' kg';

    exception
        when no_data_found then return 'Brak lazika o takiej nazwie';
end audit_wyd;
/

begin 
    dbms_output.put_line(audit_wyd('Scout D'));
    dbms_output.put_line(audit_wyd('Goliath'));
    dbms_output.put_line(audit_wyd('Ares Transport 1'));
    dbms_output.put_line(audit_wyd('aaaaa'));
end;
/
```
**3. Funkcja: Ostatnia aktywność (Anomalia/Misja)**
```sql
--Zadanie: Napisz funkcję, która dla konkretnego łazika (parametr ID) zwróci opis ostatniej misji (objective), która nie została jeszcze zakończona (brak daty finished_at), wraz z informacją o jej poziomie trudności (severity_levels).

--Wymagania: Jeśli łazik nie jest w żadnej misji, funkcja powinna zwrócić komunikat: "Łazik jest obecnie wolny od zadań operacyjnych". Obsługa błędów dla nieistniejącego ID


create or replace function anomalia
(p_id rovers.id%type) return varchar2
is
    type r1 is record(
        obj missions.objective%type,
        sev severity_levels.name%type
    );
    v_info r1;
begin
    SELECT objective, severity_levels.name as s_name
    into v_info.obj, v_info.sev
    from missions
    join severity_levels on severity_levels.id = missions.severity_level_id
    where finished_at is null and rover_id = p_id order by started_at desc FETCH FIRST 1 ROWS ONLY;

    return 'Cel - '||v_info.obj || ' Poziom zagrozenia - ' || v_info.sev;
    exception
        when no_data_found then return 'Łazik jest obecnie wolny od zadań operacyjnych';

end anomalia;
/
begin

    for i in (Select id from rovers) loop
        dbms_output.put_line(anomalia(i.id));
    end loop;

end;
/
```

**Niggery**


```sql
--1. Wyzwalacz: Strażnik Energii (Walidacja przed misją) Ten wyzwalacz ma za zadanie pilnować bezpieczeństwa łazików przed wyruszeniem w teren.  Moment uruchomienia: Reaguje przed (BEFORE) każdą aktualizacją (UPDATE) statusu w tabeli łazików.  Warunek (Condition): Sprawdza, czy nowa wartość statusu (:NEW) to "Aktywny - W misji" oraz czy poziom baterii tego łazika jest niższy niż 20%.  Działanie (Action): Jeśli bateria jest zbyt słaba, wyzwalacz wywołuje błąd aplikacji, który przerywa transakcję i uniemożliwia zmianę statusu. Dzięki temu żaden rozładowany łazik nie opuści bazy.

create or replace trigger tg_straznik
    before update on rovers
    for each row
declare
    v_rover_status_id rover_statuses.id%type;
    v_rover_battery rovers.battery_level%type;
begin
    Select id into v_rover_status_id from rover_statuses where name = 'Aktywny - W misji';
    if :new.rover_status_id = v_rover_status_id then
        if :old.battery_level <= 20 then
            raise_application_error(-20001, 'Rover is too low on battery to go on mission');
        end if;
    end if;
end tg_straznik;
/

UPDATE rovers set rover_status_id = 1 where id = 4;

```


```sql
--2. Wyzwalacz: Blokada "Teleportacji" (Integralność lokalizacji)Ten mechanizm dba o to, aby dane o lokalizacji łazika były zgodne z jego stanem faktycznym.  Moment uruchomienia: Uruchamia się przed (BEFORE) próbą zmiany identyfikatora bazy macierzystej w tabeli łazików.  Warunek (Condition): Wyzwalacz sprawdza stan łazika sprzed edycji (:OLD). Jeśli łazik aktualnie posiada status "Aktywny - W misji", każda próba przypisania go do innej bazy zostaje uznana za błąd logiczny.  Działanie (Action): System blokuje operację i wyświetla komunikat, że nie można przenieść łazika do innej bazy, dopóki fizycznie nie wróci on z trasy i nie zmieni statusu na "W bazie".

create or replace trigger tg_teleportation
    before update on rovers
    for each row
declare
    v_id rover_statuses.id%type;
begin
    Select id into v_id from rover_statuses where name ='Aktywny - W misji';
    if :old.rover_status_id = v_id then
        if :old.base_id <> :new.base_id then
            raise_application_error(-20067,'Nie mozna przeniesc lazika do innej bazy dopoki nie skonczy misji');
        end if;
    end if;
end;
/

Update rovers set base_id = 2 where id = 2;
```


```sql
--3. Create a view, and then a trigger that enables data modification through that view.

create or replace trigger tg_modify_v_rover_fleet_status
    instead of update on v_rover_fleet_status
    for each row
declare
    v_id rover_statuses.id%type;
    v_base_id bases.id%type;
begin
    if :old.current_status <> :new.current_status then
        Select id into v_id from rover_statuses where name = :new.current_status;
        Update rovers set rover_status_id = v_id where name = :old.rover_name;
    end if;
    if :old.assigned_base <> :new.assigned_base then
        SELECT id into v_base_id from bases where name = :new.assigned_base;
        Update rovers set base_id = v_base_id where name = :old.rover_name;
    end if;
    if (:old.rover_name <> :new.rover_name) OR (:old.battery_percent <> :new.battery_percent) OR (:old.max_capacity_kg <> :new.max_capacity_kg) then
        Update rovers set name = :new.rover_name, battery_level = :new.battery_percent, max_capacity_kg = :new.max_capacity_kg where name = :old.rover_name and battery_level = :old.battery_percent and max_capacity_kg = :old.max_capacity_kg;
    end if;

    exception
        when NO_DATA_FOUND then raise_application_error(-20067,'Nie znaleziono bazy lub statusu o podanej nazwie');
end;
/


UPDATE v_rover_fleet_status 
SET current_status = 'Aktywny - W misji' 
WHERE rover_name = 'Scout D';

```

```sql
create or replace trigger signed_energy
    before insert on energy
    for each row
begin
    if :new.energy_produced_kwh < 0  or :new.energy_consumed_kwh < 0 or :new.energy_stored_kwh < 0 or :new.energy_released_kwh < 0 or :new.energy_wasted_kwh < 0 then
        raise_application_error(-20067,'Blad kurwo jebana');
    end if;

end;
/
 

insert into energy(id, recorded_at,energy_produced_kwh,energy_consumed_kwh,energy_stored_kwh,energy_released_kwh,energy_wasted_kwh,base_id)
 values(106,To_Date('11-01-2046','MM-DD-YYYY'),  500, 100,  100, 120, -10,1);

```

create or replace trigger battery_name
    before insert on energy
    for each row

begin

        :new.name := Initcap(:new.name);


end;
/
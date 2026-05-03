create or replace PACKAGE astronaut_base
AS

    e_insufficient_resources EXCEPTION;
    e_wrong_location         EXCEPTION;
    e_mission_active         EXCEPTION;


    PROCEDURE transfer_resource_to_base(
        p_res_id NUMBER,
        p_quantity NUMBER,
        p_from_rover_id NUMBER DEFAULT NULL,
        p_to_base_id NUMBER DEFAULT NULL
    );

    PROCEDURE transfer_resource_to_rover
    (
        p_res_id NUMBER,
        p_quantity NUMBER,
        p_to_rover_id NUMBER DEFAULT NULL,
        p_from_base_id NUMBER DEFAULT NULL
     );


    PROCEDURE assign_crew_to_mission(p_mission_id NUMBER, p_astronaut_id NUMBER);


    PROCEDURE print_base_inventory_report(p_base_id NUMBER);


    FUNCTION get_net_energy(p_base_id NUMBER, p_date DATE) RETURN NUMBER;


    FUNCTION is_astronaut_ready(p_astro_id NUMBER) RETURN BOOLEAN;


end astronaut_base;




create or replace PACKAGE BODY astronaut_base
AS
    -- Transfers specified resources from a rover to a base and ensures inventory consistency
    PROCEDURE transfer_resource_to_base(
        p_res_id NUMBER,
        p_quantity NUMBER,
        p_from_rover_id NUMBER DEFAULT NULL,
        p_to_base_id NUMBER DEFAULT NULL
    )
    AS
        v_quantity inventories.quantity%TYPE;
        v_is_record NUMBER;
    begin
        select quantity into v_quantity from inventories
        where rover_id = p_from_rover_id AND resource_id = p_res_id;

        if v_quantity < p_quantity then
            raise e_insufficient_resources;
        end if;

        UPDATE inventories SET quantity = quantity - p_quantity where rover_id = p_from_rover_id and resource_id = p_res_id;

        SELECT count(*) into v_is_record from inventories where base_id = p_to_base_id AND resource_id =  p_res_id;

        if v_is_record = 0 then
            INSERT INTO inventories (base_id,rover_id,resource_id,quantity)
            values (p_to_base_id,NULL,p_res_id,p_quantity);
        else
            UPDATE inventories SET quantity = quantity + p_quantity where base_id = p_to_base_id and resource_id = p_res_id;
        end if;

        EXCEPTION
            when NO_DATA_FOUND then dbms_output.put_line('No resource in rover');
            when e_insufficient_resources then dbms_output.put_line('Insufficient resources');


    end transfer_resource_to_base;
    -- Transfers specified resources from a base to a rover and ensures inventory consistency
    PROCEDURE transfer_resource_to_rover
    (
        p_res_id NUMBER,
        p_quantity NUMBER,
        p_to_rover_id NUMBER DEFAULT NULL,
        p_from_base_id NUMBER DEFAULT NULL)
    IS
       v_quantity inventories.quantity%TYPE;
        v_is_record NUMBER;
    begin
        select quantity into v_quantity from inventories
        where base_id = p_from_base_id AND resource_id = p_res_id;

        if v_quantity < p_quantity then
            raise e_insufficient_resources;
        end if;

        UPDATE inventories SET quantity = quantity - p_quantity where base_id = p_from_base_id and resource_id = p_res_id;

        SELECT count(*) into v_is_record from inventories where rover_id = p_to_rover_id AND resource_id =  p_res_id;

        if v_is_record = 0 then
            INSERT INTO inventories (base_id,rover_id,resource_id,quantity)
            values (NULL,p_to_rover_id,p_res_id,p_quantity);
        else
            UPDATE inventories SET quantity = quantity + p_quantity where rover_id = p_to_rover_id and resource_id = p_res_id;
        end if;

        EXCEPTION
            when NO_DATA_FOUND then dbms_output.put_line('No resource');
            when e_insufficient_resources then dbms_output.put_line('Insufficient resources');

    end transfer_resource_to_rover;
    -- Assigns an astronaut to a mission while verifying they are alive and not currently assigned to another mission
    PROCEDURE assign_crew_to_mission(p_mission_id NUMBER, p_astronaut_id NUMBER)
    as
        v_base_id number;
        v_rover_id number;
        v_is_base_id number;
        v_is_astronaut number;
    begin
        SELECT base_id into v_base_id from crew_logs where astronaut_id = p_astronaut_id and left_at is NULL;
        SELECT rover_id into v_rover_id from missions where id = p_mission_id;

        SELECT base_id into v_is_base_id from rovers where id = v_rover_id;
        if v_is_base_id =v_base_id then
            SELECT count(*) into v_is_astronaut from mission_astronauts where mission_id = p_mission_id and astronaut_id=p_astronaut_id;
            if  v_is_astronaut = 0 then
                INSERT INTO mission_astronauts (mission_id,astronaut_id) values (p_mission_id,p_astronaut_id);
            else
                raise e_mission_active;
            end if;
        else
            raise e_wrong_location;
        end if;

        Exception
            when e_mission_active then dbms_output.put_line('The astronaut is already assigned to this mission');
            when e_wrong_location then dbms_output.put_line(q'[This is not the astronaut's base]');
    end assign_crew_to_mission;
    -- Displays a comprehensive report of all resources currently held by the base
    PROCEDURE print_base_inventory_report(p_base_id NUMBER)
    AS
        Cursor c_inv IS
            SELECT resources.name, inventories.quantity, units.name as unit_name
            from inventories 
            join resources ON resources.id = inventories.resource_id
            join units ON units.id = resources.unit_id
            where inventories.base_id = p_base_id;
        v_rec c_inv%ROWTYPE;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('--- RAPORT ZAPASÓW BAZY ID: ' || p_base_id || ' ---');
        OPEN c_inv;
        LOOP
            FETCH c_inv INTO v_rec;
            EXIT WHEN c_inv%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('Zasób: ' || v_rec.name || ' | Ilość: ' || v_rec.quantity || ' ' || v_rec.unit_name);
        END LOOP;
        CLOSE c_inv;
    end print_base_inventory_report;
    -- Retrieves the net energy balance for a given base on a specific date
    FUNCTION get_net_energy(p_base_id NUMBER, p_date DATE) RETURN NUMBER
    IS
        v_energy_produced number;
        v_energy_consumed number;
    BEGIN
        SELECT energy_produced_kwh, energy_consumed_kwh into v_energy_produced, v_energy_consumed from energy where base_id = p_base_id AND recorded_at = p_date;

        return v_energy_produced - v_energy_consumed;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN RETURN NULL;
    end get_net_energy;
    -- Validates astronaut readiness and current deployment status
    FUNCTION is_astronaut_ready(p_astro_id NUMBER) RETURN BOOLEAN
    IS
        v_is_dead date;
        v_is_active number;
    begin
        SELECT DEATH_DATE into v_is_dead from astronauts where id=p_astro_id;
        if v_is_dead is  null then

            SELECT count(*) into v_is_active from missions
            join mission_astronauts ON missions.id = mission_astronauts.mission_id
            where mission_astronauts.astronaut_id = p_astro_id AND finished_at is null;

            if v_is_active = 0 then
                return true;
            else
                return false;
            end if;

        else
            return FALSE;
        end if;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN dbms_output.put_line('No astronaut found');
    end is_astronaut_ready;



end astronaut_base;




create or replace TRIGGER astronauts_standardization -- Capitalizes names and surnames and also ensures death date is not earlier than birth date
BEFORE INSERT OR UPDATE ON astronauts
FOR EACH ROW
BEGIN

    :new.name := INITCAP(:new.name);
    :new.surname := INITCAP(:new.surname);

    IF :new.death_date IS NOT NULL AND :new.death_date < :new.birth_date THEN
        RAISE_APPLICATION_ERROR(-20001, 'Error, u can not die before u born!');
    END IF;
END;




create or replace TRIGGER mission_end_rover_in_base -- This trigger automatically sets rover's status id to 3 which is 'parked in the base' 
AFTER UPDATE OF finished_at ON missions
FOR EACH ROW
WHEN (new.finished_at IS NOT NULL)
BEGIN

    UPDATE rovers
    SET rover_status_id = 3
    WHERE id = :new.rover_id;

    DBMS_OUTPUT.PUT_LINE('Propagation: Rover for mission ' || :new.id || ' status updated to available.');
END;

create or replace TRIGGER modify_view_current_crew -- Trigger that edits underlying tables via the view
INSTEAD OF UPDATE ON v_current_crew
FOR EACH ROW
DECLARE
    v_astro_id NUMBER;
    v_base_id  NUMBER;
BEGIN

    SELECT id INTO v_astro_id FROM astronauts WHERE name = :old.astronaut_name AND surname = :old.astronaut_surname;
    SELECT id INTO v_base_id FROM bases WHERE name = :new.base_name;

    IF :old.base_name <> :new.base_name THEN
        UPDATE crew_logs 
        SET left_at = SYSDATE 
        WHERE astronaut_id = v_astro_id AND left_at IS NULL;
        
        INSERT INTO crew_logs (astronaut_id, base_id, joined_at)
        VALUES (v_astro_id, v_base_id, SYSDATE);

        DBMS_OUTPUT.PUT_LINE('View Update: Astronaut ' || :old.astronaut_surname || ' moved to base ' || :new.base_name);
    END IF;
END;



SET SERVEROUTPUT ON;

BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Preparing Test Environment ---');
    

    DELETE FROM mission_astronauts WHERE mission_id = 1 AND astronaut_id = 1;
    
    UPDATE crew_logs SET left_at = SYSDATE WHERE astronaut_id = 1 AND left_at IS NULL;
    INSERT INTO crew_logs (astronaut_id, base_id, joined_at, left_at) 
    VALUES (1, 1, DATE '2035-06-01', NULL);

    DELETE FROM inventories WHERE rover_id = 1 AND resource_id = 1;
    INSERT INTO inventories (resource_id, quantity, rover_id, base_id) VALUES (1, 100, 1, NULL);

    COMMIT;
END;
/

-- 1. TEST: Transfer zasobów (Rover -> Base)
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Testing: Transfer to Base ---');
    astronaut_base.transfer_resource_to_base(1, 50, 1, 1);
END;
/

-- 2. TEST: Transfer zasobów (Base -> Rover)
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Testing: Transfer to Rover ---');
    astronaut_base.transfer_resource_to_rover(1, 20, 1, 1);
END;
/

-- 3. TEST: Gotowość astronauty 
DECLARE
    v_ready BOOLEAN;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Testing: Astronaut Readiness ---');
    v_ready := astronaut_base.is_astronaut_ready(1);
    IF v_ready THEN DBMS_OUTPUT.PUT_LINE('Jan Kowalski is READY.'); 
    ELSE DBMS_OUTPUT.PUT_LINE('Jan Kowalski is NOT READY.'); END IF;
END;
/

-- 4. TEST: Przypisanie do misji 
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Testing: Crew Assignment ---');
    astronaut_base.assign_crew_to_mission(1, 1);
END;
/

-- 5. TEST: Raport inwentarza
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Testing: Inventory Report ---');
    astronaut_base.print_base_inventory_report(1);
END;
/

-- 6. TEST: Bilans energii
DECLARE
    v_bal NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Testing: Energy Balance ---');
    v_bal := astronaut_base.get_net_energy(1, DATE '2046-03-10');
    DBMS_OUTPUT.PUT_LINE('Balance for Base 1 (2046-03-10): ' || v_bal || ' kWh');
END;
/

COMMIT;
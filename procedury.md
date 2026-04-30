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



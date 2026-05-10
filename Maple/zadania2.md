**Testowanie hipotez o wartości oczekiwanej, wariancji i wskaźniku struktury dla jednej populacji - chuj wie co to znaczy**

**Zadnie 2.1**
```python
with(Statistics);
czasy_twojej_starej := [133, 146, 151, 149, 162, 133, 142, 156, 155, 137, 139, 145, 152, 130, 140];
n := nops(czasy_twojej_starej);
                            n := 15
mu0 := 140; # to jest hipoteza zerowa

odchylenie := 10; #odchylenie mamy w poleceniu napisane
                        odchylenie := 10
srednia := evalf(Mean(czasy_twojej_starej), 4);
                        srednia := 144.7
z_obliczone := evalf((srednia - mu0)*sqrt(n)/odchylenie, 4); # statystyka testowa 
                      z_obliczone := 1.820
z_krytyczne := evalf(Quantile(Normal(0, 1), 1 - 0.05/2), 4); # Wartość krytyczna
                      z_krytyczne := 1.960
#Teraz wazna rzecz, jesli z_obliczone jest w zakresie z_krytyczne czyli od -z_krytyczne do +z_krytyczne to jest git, to oczywiscie zalezy od hipotezy jaka jest podana bo czasem jest poprawnie jak wyjdzie po za zakres xd                     
print("Tak, przecietny czas wykonywania tego zestawienia jest rowny 140 s");
 "Tak, przecietny czas wykonywania tego zestawienia jest rowny 140 s"
print("Statystyka testowa Z ma standardowy rozkład normalny $N(0, 1)$.");
"Statystyka testowa Z ma standardowy rozklad normalny $N(0, 1)$."
```

**Zadanie 2.2**
```python

czas_pracy_twojej_starej := [3.0, 10.5, 8.0, 13.5, 10.0, 10.5, 8.5, 11.5, 7.5, 13.0, 8.0, 12.0, 7.5, 16.5, 13];
n1 := nops(czas_pracy_twojej_starej);
mu01 := 12;
                           mu01 := 12
odchylenie1 := evalf(StandardDeviation(czas_pracy_twojej_starej), 4);
                      odchylenie1 := 3.278
srednia1 := evalf(Mean(czas_pracy_twojej_starej), 4);
                       srednia1 := 10.20
z_obliczone1 := evalf((srednia1 - mu01)*sqrt(n1)/odchylenie1, 4);
                     z_obliczone1 := -2.127
z_krytyczne := evalf(Quantile(StudentT(n1 - 1), 0.03), 4); # w tym przypadku obliczamy tylko lewostronnie to czyli nie 1-0.03/2 tylko samo 0.03
                     z_krytyczne := -2.046
print("Tak, przecietny czas pracy baterii jest krótszy niz 12 h");
   "Tak, przecietny czas pracy baterii jest krￃﾳtszy niz 12 h"
print("Statystyka testowa ma standardowy rozklad studenta z n-1 stopniami swobody");
   "Statystyka testowa ma standardowy rozklad studenta z n-1 stopniami swobody"
```


**Zadanie 2.3**

```python
waga_twojej_starej := [203, 205, 199, 197, 178, 187, 190, 199, 204, 201, 196, 191, 181, 184, 195, 199];
n2 := nops(waga_twojej_starej);
mu02 := 200;
                          mu02 := 200
odchylenie2 := evalf(StandardDeviation(waga_twojej_starej), 4);
                      odchylenie2 := 8.316
srednia2 := evalf(Mean(waga_twojej_starej), 4);
                       srednia2 := 194.3
z_obliczone2 := evalf((srednia2 - mu02)*sqrt(n2)/odchylenie2, 4);
                     z_obliczone2 := -2.742
z_krytyczne := evalf(Quantile(StudentT(n2 - 1), 0.04), 4);
                     z_krytyczne := -1.878
print("Tak, konsument ma prawo zgłosić tego producenta masła do inspekcji handlowej");
   "Tak, konsument ma prawo zglosil tego producenta masla do inspekcji handlowej"
print("Statystyka testowa ma standard rozklad studenta z n-1 stopniami swobody");
    "Statystyka testowa ma standard rozklad studenta z n-1 stopniami swobody"
```

**Zadanie 2.4**

```python
srednica_szyi_twojej_starej := [32.28, 35.05, 39.23, 40.03, 37.25, 33.33, 36.08, 35.02, 38.09, 37.21, 43.70, 31.25, 43.11, 37.93, 41.02, 38.29, 31.88, 37.17, 37.28, 37.09, 36.62, 38.05, 36.93, 36.99, 36.68, 37.90, 34.80, 35.67, 41.52, 37.02];
n3 := nops(srednica_szyi_twojej_starej);
mu03 := 35;
                           mu03 := 35

odchylenie3 := evalf(StandardDeviation(srednica_szyi_twojej_starej), 4);
                      odchylenie3 := 2.928

srednia3 := evalf(Mean(srednica_szyi_twojej_starej), 4);
                       srednia3 := 37.15

z_obliczone3 := evalf((srednia3 - mu03)*sqrt(n3)/odchylenie3, 4);
                     z_obliczone3 := 4.022

z_krytyczne := evalf(Quantile(StudentT(n3 - 1), 1 - 0.05), 4); # Tu natomiast obliczamy tylko prawostronnie czyli 1-0.05 
                      z_krytyczne := 1.699

print("Tak, mozna uznac ze przeciętna srednica drzew w tym lesie jest wieksza niż 35cm");
"Tak, mozna uznac ze przeciￄﾙtna srednica drzew w tym lesie jest wieksza niz 35cm"


print("Statystyka testowa ma standard rozklad studenta z n-1 stopniami swobody");
    "Statystyka testowa ma standard rozklad studenta z n-1 stopniami swobody"
```


**Zadanie 2.5**
```python
czasy_badania_odbytu_twojej_starej := [40, 28, 57, 32, 18, 26, 48, 30, 43, 30, 45, 23, 39, 27, 55, 25, 43, 35, 24, 38];
NULL;
n5 := nops(czasy_badania_odbytu_twojej_starej);
                            n5 := 20

mu05 := 35;
srednia5 := evalf(Mean(czasy_badania_odbytu_twojej_starej), 4);
                       srednia5 := 35.30
odchylenie5 := evalf(StandardDeviation(czasy_badania_odbytu_twojej_starej), 4);
                      odchylenie5 := 10.85
z_obliczone5 := evalf((srednia5 - mu05)*sqrt(n5)/odchylenie5, 4);
                     z_obliczone5 := 0.1237
z_krytyczne := evalf(Quantile(StudentT(n5 - 1), 1 - 0.05), 4); # Sprawdzamy czy wyszedl poza zakres i jesli nie to znaczy ze sie nie zwiekszyl czas
                      z_krytyczne := 1.729
print("Na podstawie tych danych nie mozna stwierdzic ze czas potrzebny na wykonanie tego badania zwiekszyl się");
    "Na podstawie tych danych nie mozna stwierdzic ze czas potrzebny na wykonanie tego badania zwiekszyl sie"
print("Statystyka testowa ma standard rozkladu studenta z n-1 stopniami swobody");
    "Statystyka testowa ma standard rozkladu studenta z n-1 stopniami swobody"
```

**Zadanie 2.6**
```python
norma_sekund_twojej_starej_na_pieska := [40, 28, 57, 32, 18, 26, 48, 30, 43, 30, 45, 23, 39, 27, 55, 25, 43, 35, 24, 38];
n6 := nops(norma_sekund_twojej_starej_na_pieska);
mu06 := 35;
srednia6 := evalf(Mean(norma_sekund_twojej_starej_na_pieska), 4);
                       srednia6 := 35.30
odchylenie6 := evalf(StandardDeviation(norma_sekund_twojej_starej_na_pieska), 4);
                      odchylenie6 := 10.85
z_obliczone6 := evalf((srednia6 - mu06)*sqrt(n6)/odchylenie6, 4);
                     z_obliczone6 := 0.1237
z_krytyczne := evalf(Quantile(StudentT(n6 - 1), 0.03), 4);
                     z_krytyczne := -2.000
print("Wydajnosc nie obnizyla sie");
                  "Wydajnosc nie obnizyla sie"
print("Statystyka testowa ma standard rozkladu Studenta z n-1 stopniami swobody");
    "Statystyka testowa ma standard rozkladu Studenta z n-1 stopniami swobody"
```


**Zadanie 2.7**
```python
awarie_twojej_starej := [0, 1, 2, 3, 4, 5, 6];
liczba_dni_twojej_starej := [13, 33, 20, 15, 10, 7, 2];
srednia7 := evalf(Mean(awarie_twojej_starej, weights = liczba_dni_twojej_starej), 4);
                       srednia7 := 2.050
odchylenie7 := evalf(StandardDeviation(awarie_twojej_starej, weights = liczba_dni_twojej_starej), 4);
                      odchylenie7 := 1.717
mu07 := 2;
n7 := add(liczba_dni_twojej_starej);
z_obliczone7 := evalf((srednia7 - mu07)*sqrt(n7)/odchylenie7, 4);
                     z_obliczone7 := 0.2912
z_krytyczne7 := evalf(Quantile(StudentT(n7 - 1), 1 - 0.04), 4);
                     z_krytyczne7 := 1.769
print("Przecietna ilosc awarii nie jest wieksza od 2");
        "Przecietna ilosc awarii nie jest wieksza od 2"
print("Statystyka testowa ma standard rozkladu Studenta z n-1 stopniami swobody");
    "Statystyka testowa ma standard rozkladu Studenta z n-1 stopniami swobody"
```

**Zadanie 2.8**
```python
mu08 := 5000;
odchylenie8 := 800;
n8 := 100;
srednia8 := 4800;
z_obliczone8 := evalf((srednia8 - mu08)*sqrt(n8)/odchylenie8, 4);
                     z_obliczone8 := -2.500
z_krytyczne8 := evalf(Quantile(Normal(0, 1), 0.05), 4);
                     z_krytyczne8 := -1.645
print("Tak, przy poziomie istotnosci 0.05 mozna uznac ze srednia liczba uzytkownikow spadla");
  "Tak, przy poziomie istotnosci 0.05 mozna uznac ze srednia liczba uzytkownikow spadla"
print("Statystyka testowa ma standardowy rozklad normalny 0 do 1");
  "Statystyka testowa ma standardowy rozklad normalny 0 do 1"
```

**Zadanie 2.9** Tu sa wariacje zjebane
```python
srednice_cipy_twojej_starej := [29.5, 32.5, 35.5, 38.5, 41.5];
liczba_drzew_w_cipie_twojej_starej := [10, 50, 68, 56, 16];
mu09 := 9;
n9 := add(liczba_drzew_w_cipie_twojej_starej);
                           n9 := 200
wariacja9 := evalf(Variance(srednice_cipy_twojej_starej, weights = liczba_drzew_w_cipie_twojej_starej), 4);
                       wariacja9 := 12.77
c1 := Quantile(ChiSquare(n9 - 1), 1 - 0.02/2);  #obliczamy chi kwadrat gorny
                     c1 := 248.328595992838
c2 := Quantile(ChiSquare(n9 - 1), 0.02/2);      #obliczamy chi kwadrat dolny
                     c2 := 155.548465743568
print("Tak, na poziomie istotnosci 0.02 srednica drzew wynosi 9cm^2");      # jesli sie miesci w granicach tych chikwadrat to w tym przypadku znaczy ze hipoteza sie zgadza :)
 "Tak, na poziomie istotnosci 0.02 srednica drzew wynosi 9cm^2"
print("Statystyka testowa ma rozklad chi-kwadrat(x^2) z n-1 stopniami swobody");
"Statystyka testowa ma rozklad chi-kwadrat(x^2) z n-1 stopniami swobody"
```


**Zadanie 2.10**
```python
pomiary_cipy_twojej_starej := [7.02, 6.83, 7.10, 6.97, 6.98, 7.10, 7.01, 6.93, 7.05, 6.96, 6.75, 7.09, 7.15, 6.85, 6.8];
odchylenie10 := evalf(StandardDeviation(pomiary_cipy_twojej_starej), 4);
                     odchylenie10 := 0.1207
n10 := nops(pomiary_cipy_twojej_starej);
                           n10 := 15
mu010 := 0.1;
srednia10 := evalf(Mean(pomiary_cipy_twojej_starej), 4);
                       srednia10 := 6.973
chi_obliczone10 := evalf((n10 - 1)*odchylenie10^2/mu010^2, 4);
                    chi_obliczone10 := 20.40
c101 := Quantile(ChiSquare(n10 - 1), 1 - 0.02/2);
                    c101 := 29.1412377244437
c102 := Quantile(ChiSquare(n10 - 1), 0.02/2);
                    c102 := 4.66042543861292
c1011 := Quantile(ChiSquare(n10 - 1), 1 - 0.01/2);
                   c1011 := 31.3193496159106
c1021 := Quantile(ChiSquare(n10 - 1), 0.01/2);
                   c1021 := 4.07467505364446
print("Nie, na poziomie istotnosci 0.02 oraz 0.01 nie rozregulowal sie amperomierz");
 "Nie, na poziomie istotnosci 0.02 oraz 0.01 nie rozregulowal sie amperomierz"
print("Statystyyka testowa ma rozklad chi-kwadrat(x^2) z n-1 stopmiami swobody");
    "Statystyyka testowa ma rozklad chi-kwadrat(x^2) z n-1 stopmiami swobody"
```


**Zadanie 2.11**
```python
wariacja11 := 27.5;
mu011 := 25;
n11 := 30;
c11 := Quantile(ChiSquare(n11 - 1), 1 - 0.01);
                    c11 := 49.5878846941643
chi_obliczone11 := evalf((n11 - 1)*wariacja11/mu011, 4);
                    chi_obliczone11 := 31.90
print("Na poziomie istotnosci 0.01 nie można uznac ze czas pracy dojazdu jest wiekszy od 25");
  "Na poziomie istotnosci 0.01 nie moￅﾼna uznac ze czas pracy dojazdu jest wiekszy od 25"
print("Statystyyka testowa ma rozklad chi-kwadrat(x^2) z n-1 stopmiami swobody");
    "Statystyyka testowa ma rozklad chi-kwadrat(x^2) z n-1 stopmiami swobody"
```

**Zadanie 2.12**
```python
n12 := 30;
srednice_zwisajacych_cycow_twojej_starej := [32.28, 35.05, 39.23, 40.13, 37.25, 33.33, 36.08, 35.12, 38.09, 37.21, 43.70, 31.25, 43.11, 37.93, 41.02, 38.29, 31.88, 37.17, 37.28, 37.09, 36.62, 38.05, 36.93, 36.99, 36.68, 37.90, 34.80, 35.67, 38.52, 37.02];
srednice_zwisajacych_cycow_twojej_starej40 := select(x -> 40 < x, srednice_zwisajacych_cycow_twojej_starej);
 srednice_zwisajacych_cycow_twojej_starej40 := [40.13, 43.70, 43.11, 41.02]
m12 := nops(srednice_zwisajacych_cycow_twojej_starej40);
                            m12 := 4
mu012 := 0.15;
p12 := evalf(m12/n12, 4);
                         p12 := 0.1333
z_obliczone12 := evalf((p12 - mu012)/sqrt(mu012*(1 - mu012)/n12), 4);
                    z_obliczone12 := -0.2562
z_krytyczne12 := evalf(Quantile(Normal(0, 1), 0.04), 4);
                    z_krytyczne12 := -1.751
print("Nie ma podstaw do odrzucenia hipotezy zerowej. Nie można uznać, że drzew o średnicy > 40cm jest istotnie mniej niż 15%."); # to jest zjebane ale 13.33% jest blisko 15% wiec statystycznie jesli jedno drzewo by sie roznilo to by był inny wynik dlatego nie mozna odrzucic hipotezy zerowej
"Nie ma podstaw do odrzucenia hipotezy zerowej. Nie mozna uznac, ze drzew o srednicy > 40cm jest istotnie mniej niz 15%."
print("Statystyka testowa ma rozklad normalny 0 1");
          "Statystyka testowa ma rozklad normalny 0 1"
```

**Zadanie 2.13**
```python
p0 := 0.08;
n13 := 100;
m13 := 3;
p_cos := evalf(m13/n13, 4);
                        p_cos := 0.03000
z_obliczone13 := evalf((p_cos - p0)/sqrt(p0*(1 - p0)/n13), 4);
                    z_obliczone13 := -1.843
z_krytyczne13 := evalf(Quantile(Normal(0, 1), 0.02), 4);
                    z_krytyczne13 := -2.054
print("Nie zalecam kierownikowi wdrożenia nowego procesu produkcyjnego bo mogl to byc po prostu przypadek a wynik jest bardzo bliski");
"Nie zalecam kierownikowi wdrozenia nowego procesu produkcyjnego bo mogl to byc po prostu przypadek a wynik jest bardzo bliski"
print("Statystyka testowa ma rozklad normalny 0 1");
          "Statystyka testowa ma rozklad normalny 0 1"
```

**Zadanie 2.14**
```python
n14 := 150;
m14 := 53;
p014 := 0.30;
p14 := evalf(m14/n14, 4);
                         p14 := 0.3533
z_obliczone14 := evalf((p14 - p014)/sqrt(p014*(1 - p014)/n14), 4);
                     z_obliczone14 := 1.424
z_krytyczne14 := evalf(Quantile(Normal(0, 1), 1 - 0.05), 4);
                     z_krytyczne14 := 1.645
print("Nie mozna stwierdzic ze wiecej niz 30% pracownikow ma zaklocenia sluchu");
    "Nie mozna stwierdzic ze wiecej niz 30% pracownikow ma zaklocenia sluchu"
print("Statystyka testowa ma rozklad normalny 0 1");
          "Statystyka testowa ma rozklad normalny 0 1"
```


**Zadanie 2.15**
```python
p015 := 0.39;
n15 := 300;
p15 := 0.34;
z_obliczone := evalf((p15 - p015)/sqrt(p015*(1 - p015)/n15), 4);
                     z_obliczone := -1.776
z_krytyczne := evalf(Quantile(Normal(0, 1), 0.04), 4);
                     z_krytyczne := -1.751
print("Tak, mozna powiedziec ze na poziomie istotnosci 0.04 partia cieszy sie mniejszym poparciem");
 "Tak, mozna powiedziec ze na poziomie istotnosci 0.04 partia cieszy sie mniejszym poparciem"
print("Statystyka testowa ma rozklad normalny 0 1");
          "Statystyka testowa ma rozklad normalny 0 1"
```

**Zadanie 2.16**
```python
p016 := 0.1;
n16 := 200;
p16 := evalf(28/n16, 4);
z_obliczone16 := evalf((p16 - p016)/sqrt(p016*(1 - p016)/n16), 4);
                     z_obliczone16 := 1.886
z_krytyczne16 := evalf(Quantile(Normal(0, 1), 1 - 0.03), 4);
                     z_krytyczne16 := 1.881
print("Tak, mamy wystarczajace dowody by podwazyc zapewnienia producenta");
    "Tak, mamy wystarczajace dowody by podwazyc zapewnienia producenta"
print("Statystyka testowa ma rozklad normalny 0 1");
          "Statystyka testowa ma rozklad normalny 0 1"
```
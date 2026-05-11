**Zadanie 3: Testowanie hipotez o wartości oczekiwanej, wariancji i wskaźniku struktury dla dwóch populacji.**


**Zadanie 3.1**
```python
with(Statistics);
grupa1 := [3952, 3566, 4131, 3713, 4019, 3792, 3281, 3413, 3676, 2875, 2837, 3617, 4086, 3387, 3085, 2724, 5312, 3683, 2221, 3818]; #bierzemy 2 grupy i obliczamy ich srednia i ilosc osob
odchylenie1 := 620;
n1 := nops(grupa1);
srednia1 := evalf(Mean(grupa1), 4);

grupa2 := [4047, 4219, 3836, 4611, 3444, 4055, 4073, 3868, 3702, 4300, 3694, 3621, 4564, 4662, 4489, 3978, 3572, 4258, 3748, 3961];
odchylenie2 := 440;
n2 := nops(grupa2);
srednia2 := evalf(Mean(grupa2), 4);
z_obliczone1 := evalf((srednia2 - srednia1)/sqrt(odchylenie1^2/n1 + odchylenie2^2/n2), 4);  # i tu mamy taki super wzór :)
                     z_obliczone1 := 2.800
z_krytyczne1 := evalf(Quantile(Normal(0, 1), 1 - 0.01), 4);
                     z_krytyczne1 := 2.326
print("Tak, mozna stwierdzic ze pojemnosc pluc jest wieksza u studnetow czynnie uprawiajacych sport");
    "Tak, mozna stwierdzic ze pojemnosc pluc jest wieksza u studnetow czynnie uprawiajacych sport"
print("Statystyka testowa ma rozklad normalny 0  1");
         "Statystyka testowa ma rozklad normalny 0  1"
```

**Zadanie 3.2**
```python
zespol1 := [188, 192, 187, 178, 179, 175, 177, 178, 185, 190, 176];
n1 := nops(zespol1);
srednia1 := evalf(Mean(zespol1), 4);
odchylenie1 := evalf(StandardDeviation(zespol1), 4);

zespol2 := [190, 179, 185, 186, 183, 184, 179, 180, 191, 189];
n2 := nops(zespol2);
srednia2 := evalf(Mean(zespol2), 4);
odchylenie2 := evalf(StandardDeviation(zespol2), 4);

wariacja1 := odchylenie1^2; # nie znamy wariacji wiec musimy ja obliczyc
wariacja2 := odchylenie2^2; # nie znamy wariacji wiec musimy ja obliczyc
polaczona_wariacja := evalf(sqrt(((n1 - 1)*wariacja1 + (n2 - 1)*wariacja2)/(n1 + n2 - 2)), 4);  # nowy wzor
                  polaczona_wariacja := 5.442
t_obliczone2 := evalf((srednia1 - srednia2)/(polaczona_wariacja*sqrt(1/n1 + 1/n2)), 4); # nowy wzor
                    t_obliczone2 := -0.9674
z_krytyczne21 := evalf(Quantile(StudentT(n1 + n2 - 2), 1 - 0.01/2), 4); # no i tu stopnie swobody sa inne n1+n2-2
                     z_krytyczne21 := 2.861
print("Tak sredni czas jest jednakowy na poziomie istotnosci 0.01");
  "Tak sredni czas jest jednakowy na poziomie istotnosci 0.01"
print("Statystyka testowa ma rozklad Studenta z n1 +n2 -2 stopniamy swobody");
 "Statystyka testowa ma rozklad Studenta z n1 +n2 -2 stopniamy swobody"
```

**Zadanie 3.3**
```python
welnix := [74.8, 75.1, 73.0, 72.8, 76.2, 74.6, 76.0, 73.4, 72.9, 71.6];
n1 := nops(welnix);
srednia1 := evalf(Mean(welnix), 4);
wariacja1 := evalf(Variance(welnix), 4);

bialy_puch := [55.9, 57.8, 54.6, 59.0, 57.1, 58.2, 57.6, 60.3, 61.2, 65.5, 59.2, 64.3];
n2 := nops(bialy_puch);
srednia2 := evalf(Mean(bialy_puch), 4);
odchylenie2 := evalf(StandardDeviation(bialy_puch), 4);
wariacja2 := odchylenie2^2;

t_obliczone3 := evalf((srednia1 - srednia2)/sqrt(wariacja1/n1 + wariacja2/n2), 4);
                     t_obliczone3 := 14.20
z_krytyczne3 := evalf(Quantile(StudentT(n1 + n2 - 2), 1 - 0.04), 4);
                     z_krytyczne3 := 1.844
print("Zdecydowanie welnix jest lepszy"); #skad wiemy ze welnix jest lepszy? w t_obliczone3 odejmujemy srednia1 od srednia2 wiec sprawdzamy tym CZY WELNIX jest rzeczywiscie lepszy od bialego puchu
               "Zdecydowanie welnix jest lepszy"
print("Statystyka testowa ma rozklad StudentaT z n1+n2-2 stopniamy swobody");
 "Statystyka testowa ma rozklad StudentaT z n1+n2-2 stopniamy swobody"
```

**Zadanie 3.4**
```python
liczba_usterek1 := [0, 1, 2, 3, 4];
liczba_wyrobow1 := [48, 95, 202, 103, 52];
n1 := add(liczba_wyrobow);
srednia1 := evalf(Mean(liczba_usterek1, weights = liczba_wyrobow1), 4);
                       srednia1 := 2.032
wariacja1 := evalf(Variance(liczba_usterek1, weights = liczba_wyrobow1), 4);
                       wariacja1 := 1.618
liczba_wyrobow2 := [30, 88, 142, 97, 43];
n2 := add(liczba_wyrobow2);
srednia2 := evalf(Mean(liczba_usterek1, weights = liczba_wyrobow2), 4);
                       srednia2 := 2.087
wariacja2 := evalf(Variance(liczba_usterek1, weights = liczba_wyrobow2), 4);
                       wariacja2 := 1.580
t_obliczone4 := evalf((srednia1 - srednia2)/sqrt(wariacja1/n1 + wariacja2/n2), 4);
                    t_obliczone4 := -0.6488
z_krytyczne4 := evalf(Quantile(StudentT(n1 + n2 - 2), 0.02), 4);
                     z_krytyczne4 := -2.057
print("Liczba usterek na odziale produkcji 1 nie jest istotnie nizsza niz na oddziale 2");
"Liczba usterek na odziale produkcji 1 nie jest istotnie nizsza niz na oddziale 2"
print("Statystyka testowa ma rozklad studenta z n1 + n2 - 2 stopniamy swobody "); # moznaby bylo tu uzyc normalnego ale i tak nie ma roznicy miedzy nimi gdy jest tak duzo prób(n1,n2)
"Statystyka testowa ma rozklad studenta z n1 + n2 - 2 stopniamy swobody "
```

**Zadanie 3.5**
```python
przed_ciaza := [63.5, 65.0, 57.0, 69.5, 75.0, 73.5, 83.5, 76.5, 92.0, 72.5, 94.0, 100.0, 85.5, 97.0, 68.0];
po_ciazy := [61.0, 60.0, 58.0, 66.5, 72.0, 69.0, 77.5, 76.5, 80.5, 71.0, 88.0, 75.5, 83.0, 94.5, 65.5];
roznice := [seq(przed_ciaza[i] - po_ciazy[i], i = 1 .. n1)]; # i to jest zjebane bo teraz porownujemy te same osoby przed i po i dlatego trzeba ogarnac roznice z tego
srednia_D := evalf(Mean(roznice), 4);
                       srednia_D := 4.933
odchylenie_D := evalf(StandardDeviation(roznice), 4);
                     odchylenie_D := 6.158
n := nops(roznice);
t_obliczone5 := evalf(srednia_D*sqrt(n)/odchylenie_D, 4);  
                     t_obliczone5 := 3.103
z_krytyczne5 := evalf(Quantile(StudentT(n - 1), 1 - 0.02), 4);
                     z_krytyczne5 := 2.264
print("Tak, dieta jest skuteczna");
                  "Tak, dieta jest skuteczna"
print("Statystyka testowa ma rozklad studenta z n1-1 stopniami swobody");
"Statystyka testowa ma rozklad studenta z n1-1 stopniami swobody"
```


**Zadanie 3.6**
```python
stary_algorytm := [12, 15, 11, 18, 14, 16, 13, 17, 19, 15];
nowy_algorytm := [10, 14, 9, 15, 13, 14, 11, 15, 16, 13];
roznica := stary_algorytm - nowy_algorytm;
           roznica := [2, 1, 2, 3, 1, 2, 2, 2, 3, 2]
srednia := evalf(Mean(roznica), 4);
odchylenie := evalf(StandardDeviation(roznica), 4);
n := nops(roznica);
t_obliczone := evalf(srednia*sqrt(n)/odchylenie, 4);
                      t_obliczone := 9.486
z_krytyczne := evalf(Quantile(StudentT(n - 1), 1 - 0.01), 4);
                      z_krytyczne := 2.821
print("Algorytm jest o wiele lepszy");
                 "Algorytm jest o wiele lepszy"
print("Statystyka testowa ma rozklad Studenta o n-1 stopniach swobody");
"Statystyka testowa ma rozklad Studenta o n-1 stopniach swobody"
```

**Zadanie 3.7**
```python
amp1 := [7.02, 6.83, 7.10, 6.97, 6.98, 7.12, 7.01, 6.93, 7.05, 6.96];
amp2 := [4.31, 4.11, 3.94, 3.92, 3.91, 3.90, 3.89, 4.20, 3.95, 4.00, 3.75, 3.86, 4.03, 4.06, 4.17];
n1 := nops(amp1);
n2 := nops(amp2);
wariacja1 := evalf(Variance(amp1), 4);
wariacja2 := evalf(Variance(amp2), 4);
NULL;
t_obliczone := wariacja2/wariacja1;
                   t_obliczone := 3.075084364
z_krytyczne := evalf(Quantile(FRatioDistribution(n2 - 1, n1 - 1), 1 - 0.01/2), 4); # wez nie pytaj co to kurwa jest :)
                      z_krytyczne := 6.089
```


**Zadanie 3.8**
```python
Amper := [7.02, 6.83, 7.10, 6.97, 6.98, 7.12, 7.01, 6.93, 7.05, 6.96, 7.11, 7.09, 6.93];
Meter := [7.01, 6.73, 7.15, 6.97, 7.18, 7.10, 7.08, 6.95, 7.03, 6.92];
n1 := nops(Amper);
n2 := nops(Meter);
wariacja1 := evalf(Variance(Amper), 4);
wariacja2 := evalf(Variance(Meter), 4);
t_obliczone := wariacja2/wariacja1;
                   t_obliczone := 2.315103813
z_krytyczne := evalf(Quantile(FRatioDistribution(n2 - 1, n1 - 1), 1 - 0.03/2), 4);
                      z_krytyczne := 3.950
print("Polecam kupic amperomierze Amper bo nie roznia się zbytnio od amperomierzy Meter a są tansze");
"Polecam kupic amperomierze Amper bo nie roznia siￄﾙ zbytnio od amperomierzy Meter a sￄﾅ tansze"
print("Statystyka testowa ma rozklad F-Snedecora z stopniami swobody n2-1 i n1 -1");
"Statystyka testowa ma rozklad F-Snedecora z stopniami swobody n2-1 i n1 -1"
```


**Zadanie 3.9**
```python
liczba_usterek1 := [0, 1, 2, 3, 4];
liczba_wyrobow1 := [48, 95, 202, 103, 52];
liczba_wyrobow2 := [30, 88, 142, 97, 43];
n1 := add(liczba_wyrobow1);
k1 := liczba_wyrobow1[1] + liczba_wyrobow1[2];
n2 := add(liczba_wyrobow2);
k2 := liczba_wyrobow2[1] + liczba_wyrobow2[2];
p1 := evalf(k1/n1, 4);
p2 := evalf(k2/n2, 4);
p_sr := evalf((k1 + k2)/(n1 + n2), 4);
z_obliczone := evalf((p1 - p2)/sqrt(p_sr*(1 - p_sr)*(1/n1 + 1/n2)), 4);
                     z_obliczone := -0.2957
z_krytyczne := evalf(Quantile(Normal(0, 1), 1 - 0.02/2), 4);
                      z_krytyczne := 2.326
print("Roznica miedzy 28.6% a 29.5% jest statystycznie nieistotna, nie odrzucamy hipotezy");
 "Roznica miedzy 28.6% a 29.5% jest statystycznie nieistotna, nie odrzucamy hipotezy"
print("Statystyka testowa ma rozkald normalny 0 1");
          "Statystyka testowa ma rozkald normalny 0 1"
```

**Zadanie 3.10**
```python
liczba_awarii := [0, 1, 2, 3, 4];
liczba_dni1 := [139, 20, 11, 7, 5];
liczba_dni2 := [148, 14, 11, 4, 6];
n1 := add(liczba_dni1);
k1 := n1 - liczba_dni1[1] - liczba_dni1[2];
n2 := add(liczba_dni2);
k2 := n2 - liczba_dni2[1] - liczba_dni2[2];
p1 := evalf(k1/n1, 4);
p2 := evalf(k2/n2, 4);
p_sr := evalf((k1 + k2)/(n1 + n2), 4);
z_obliczone := evalf((p1 - p2)/sqrt(p_sr*(1 - p_sr)*(1/n1 + 1/n2)), 4);
                     z_obliczone := 0.3403
z_krytyczne := evalf(Quantile(Normal(0, 1), 1 - 0.02/2), 4);
                      z_krytyczne := 2.326
print("Procent dni w ktorych byly conajmniej 2 awarie byl jednakowy w obydwu okresach roku");
"Procent dni w ktorych byly conajmniej 2 awarie byl jednakowy w obydwu okresach roku"
print("Statystyka testowa rozkladu normalna 0 1");
           "Statystyka testowa rozkladu normalna 0 1"
```

**Zadanie 3.11**
```python
n1 := 87;
                            n1 := 87
k1 := 21;
                            k1 := 21
n2 := 113;
                           n2 := 113
k2 := 9;
                            k2 := 9
p1 := evalf(k1/n1);
                       p1 := 0.2413793103
p2 := evalf(k2/n2);
                      p2 := 0.07964601770
p_sr := evalf((k1 + k2)/(n1 + n2), 4);
z_obliczone := evalf((p1 - p2)/sqrt(p_sr*(1 - p_sr)*(1/n1 + 1/n2)), 4);
                      z_obliczone := 3.177
z_krytyczne := evalf(Quantile(Normal(0, 1), 1 - 0.01), 4);
                      z_krytyczne := 2.326
print("Tak odsetek zmarłych na ta chorobe jest wyzszy wsrod chorych z pierwszej grupy");
"Tak odsetek zmarￅﾂych na ta chorobe jest wyzszy wsrod chorych z pierwszej grupy"
print("Statystyka testowa ma rozklad normalny 0 1");
          "Statystyka testowa ma rozklad normalny 0 1"
```

**Zadanie 3.12**
```python
baterie1 := [506, 376, 473, 400, 542, 534, 476, 356, 422, 504, 438, 496, 523, 466, 430];
baterie2 := [419, 491, 403, 460, 487, 410, 458, 434, 393, 408, 457, 414, 382, 549, 418, 508, 431];
n1 := nops(baterie1);
n2 := nops(baterie2);
srednia1 := evalf(Mean(baterie1), 4);
srednia2 := evalf(Mean(baterie2), 4);
ochylenie1 := evalf(StandardDeviation(baterie1), 4);
ochylenie2 := evalf(StandardDeviation(baterie2), 4);
z_obliczone1 := evalf((srednia1 - srednia2)/sqrt(ochylenie1^2/n1 + ochylenie2^2/n2), 4);
                     z_obliczone1 := 1.100
z_krytyczne := evalf(Quantile(StudentT(n1 + n2 - 2), 1 - 0.03), 4);
                      z_krytyczne := 1.955
print("Na podstawie wyników czas pracy baterii 1 producenta nie jest dłuższy");
"Na podstawie wynikￃﾳw czas pracy baterii 1 producenta nie jest dluzszy"
print("Statystyka testowa ma rozklad studenta z n1 +n2-2 stopniami swobody");
 "Statystyka testowa ma rozklad studenta z n1 +n2-2 stopniami swobody"
```

**Zadanie 3.13**
```python
n1 := 130;
k1 := 14;
n2 := 150;
k2 := 13;
p1 := evalf(k1/n1, 4);
p2 := evalf(k2/n2, 4);
p_sr := evalf((k1 + k2)/(n1 + n2));
z_obliczone := evalf((p2 - p1)/sqrt(p_sr*(1 - p_sr)*(1/n1 + 1/n2)), 4);
                     z_obliczone := -0.5946
z_krytyczne := evalf(Quantile(Normal(0, 1), 0.03), 4);
                     z_krytyczne := -1.881
print("Nie mozna stwierdzic ze odzial II na poziomie 0.03 powoduje lepsza jakosc produkcji");
 "Nie mozna stwierdzic ze odzial II na poziomie 0.03 powoduje lepsza jakosc produkcji"
print("Statystyka testowa ma rozklad normalny 0 1");
          "Statystyka testowa ma rozklad normalny 0 1"
```

**Zadanie 3.14**
```python
stopien1 := [3.52, 3.81, 3.63, 4.02, 4.25, 3.37, 3.92, 4.11, 3.67, 4.07];
stopien2 := [3.61, 3.75, 3.92, 4.06, 4.52, 3.56, 3.86, 4.06, 3.84, 4.25];
wynik2 := stopien2 - stopien1;
 wynik2 := [0.09, -0.06, 0.29, 0.04, 0.27, 0.19, -0.06, -0.05, 0.17, 0.18]
srednia := evalf(Mean(wynik2), 4);
                       srednia := 0.1060
odchylenie := evalf(StandardDeviation(wynik2), 4);
                      odchylenie := 0.1339
t_obliczone := evalf(srednia*sqrt(nops(wynik2))/odchylenie);
                   t_obliczone := 2.503371411
z_krytyczne := evalf(Quantile(StudentT(nops(wynik2) - 1), 1 - 0.02), 4);
                      z_krytyczne := 2.398
z_krytyczne1 := evalf(Quantile(StudentT(nops(wynik2) - 1), 1 - 0.01), 4);
                     z_krytyczne1 := 2.821
print("Na poziomie istotnosci 0.02 studenci drugiego stopnia maja lepsze srednie ale juz na poziomie istotnosci 0.01 nie maja");
"Na poziomie istotnosci 0.02 studenci drugiego stopnia maja lepsze srednie ale juz na poziomie istotnosci 0.01 nie maja"
print("Statystyka testowa ma rozklad studenta z n-1 stopniami swobody");
"Statystyka testowa ma rozklad studenta z n-1 stopniami swobody"
```

**Zadanie 3.15**
```python
n := 30;
zaklad1 := 65;
zaklad2 := 90;
t_obliczone := evalf(zaklad2/zaklad1, 4);
                      t_obliczone := 1.385
z_krytyczne := evalf(Quantile(FRatioDistribution(n - 1, n - 1), 1 - 0.03/2), 4);
                      z_krytyczne := 2.280
print("Tak wariacje czasu dojazdu do pracy w obydwu zakladach sa jednakowe");
  "Tak wariacje czasu dojazdu do pracy w obydwu zakladach sa jednakowe"
print("Statystyka testowa ma rozklad F-Snedecora z stopniami swobody n-1 i n -1");
"Statystyka testowa ma rozklad F-Snedecora z stopniami swobody n-1 i n -1"
```
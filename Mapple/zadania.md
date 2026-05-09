**Witam, to jest plik z tego gównianego przedmiotu aby każdy mógł się nauczyć (nikt sie nie nauczy wiem) jebać ten przedmiot :))))**

**Estymacja punktowa i przedziałowa**

**Zadanie 1.1** Wzory dla wartości oczekiwanej, średniej lub przeciętnej
```python 
with(Statistics); # to mega wazne to jest jakas biblioteka

czasy := [133, 146, 151, 149, 162, 133, 142, 156, 155, 137, 139, 145, 152, 130, 140]; # tablica

srednia := evalf(Mean(czasy), 3); # Mean to srednia, evalf zaokraglenie

print(srednia);
                            145.
odchylenie := 10;

n := nops(czasy); # nops to length
                            n := 15

blad_standardowy := evalf(odchylenie/sqrt(n), 4); # taki wzór :)
                blad_standardowy := 2.582

u_alfa := Quantile(Normal(0, 1), 1 - 0.05/2); # taki wzór ;)
                u_alfa := 1.95996398453944

blad_maksymalny := evalf(u_alfa*blad_standardowy, 4); # taki wzór :)
                    blad_maksymalny := 5.061
```
**Zadanie 1.2**


```python
zuzycie := [6.78, 7.52, 8.15, 7.35, 7.92, 8.28, 7.77, 7.51, 8.19];
odchylenie2 := StandardDeviation(zuzycie);      # tym razem nie znamy naszego odchylenia wiec trzeba go tak obliczyc
                odchylenie2 := 0.483022888806639
n2 := nops(zuzycie);
                            n2 := 9
blad_standardowy2 := evalf(odchylenie2/sqrt(nops(zuzycie)), 4); # tu standardowo tak
                  blad_standardowy2 := 0.1610

u_alfa2 := Quantile(StudentT(n2 - 1), 1 - 0.01/2);      # Uzywamy StudentT gdy nie znamy odchylenia albo jest mała ilosc prób (n2)
                  u_alfa2 := 3.35537539111690

blad_maksymalny2 := evalf(u_alfa2*blad_standardowy2, 4); # tu standardowo tak
                   blad_maksymalny2 := 0.5402
dolny := evalf(Mean(zuzycie) - blad_maksymalny2, 4);    # tu obliczamy to gówno 99% bo to przedzial
                         dolny := 7.179
gorny := evalf(Mean(zuzycie) + blad_maksymalny2, 4);    # a przedzial to od <7.179, 8.259>
                         gorny := 8.259
```

**Zadanie 1.3**

```python
dni := [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10];                  # Tu zajebiste zadanie z wagami
pracownicy := [5, 12, 10, 14, 17, 12, 7, 20, 11, 6, 3];     # 2 tabelki robimy
n3 := add(pracownicy);                                      # to jest liczba prob bo bylo 117 pracownikow
                           n3 := 117

srednia3 := evalf(Mean(dni, weights = pracownicy), 4);      # i tu liczbymy srednia wazona, tym mean, srednia z dni ale bierzemy wagi jako pracownikow
                       srednia3 := 4.752

odchylenie3 := evalf(StandardDeviation(dni, weights = pracownicy), 4);  # liczymy sobie odchylenie tak samo jak srednia z wagami
                      odchylenie3 := 2.824

blad_standardowy3 := evalf(odchylenie3/sqrt(n3), 4);    # tu standardowo
                  blad_standardowy3 := 0.2611

u_alfa3 := Quantile(StudentT(n3 - 1), 1 - 0.05/2);      # nie znamy odchylenia wiec uzywamy StudentT
                  u_alfa3 := 1.98062600245820

blad_maksymalny3 := evalf(u_alfa3*blad_standardowy3, 4); # tu standardowo
                   blad_maksymalny3 := 0.5171

dolny2 := evalf(srednia3 - blad_maksymalny3, 4); # tu standardowo
                        dolny2 := 4.235

gorny2 := evalf(srednia3 + blad_maksymalny3, 4); # tu standardowo
                        gorny2 := 5.269
```


**Zadanie 1.4**
```python
przedzial := [5, 15, 25, 35, 45];       # Tu trzeba zapamietac ze jak sa przedzialy to wyciagamy srednia z kazdego przedzialu
oceniajacy := [7, 12, 68, 51, 35];
n4 := add(oceniajacy);
srednia4 := evalf(Mean(przedzial, weights = oceniajacy), 4);
                       srednia4 := 30.49
odchylenie4 := evalf(StandardDeviation(przedzial, weights = oceniajacy), 4);
                      odchylenie4 := 12.06
blad_standardowy4 := evalf(odchylenie4/sqrt(n4), 4);
                  blad_standardowy4 := 0.9167
u_alfa4 := Quantile(StudentT(n4 - 1), 1 - 0.02/2);
                  u_alfa4 := 2.34822320422780
blad_maksymalny4 := evalf(u_alfa4*blad_standardowy4, 4);
                   blad_maksymalny4 := 2.153
dolna4 := evalf(srednia4 - blad_maksymalny4, 4);
                        dolna4 := 28.34
gorna4 := evalf(srednia4 + blad_maksymalny4, 4);
                        gorna4 := 32.64
```

**Zadanie 1.5**
```python
dni_hospitalizacji := [2, 4.5, 7.5, 11.5, 18.5, 26.5];
     dni_hospitalizacji := [2, 4.5, 7.5, 11.5, 18.5, 26.5]
liczba_osob := [77, 44, 18, 6, 4, 1];
              liczba_osob := [77, 44, 18, 6, 4, 1]
n5 := add(liczba_osob);
                           n5 := 150
srednia5 := evalf(Mean(dni_hospitalizacji, weights = liczba_osob), 4);
                       srednia5 := 4.377
odchylenie5 := evalf(StandardDeviation(dni_hospitalizacji, weights = liczba_osob), 4);
                      odchylenie5 := 4.814
blad_standardowy5 := evalf(odchylenie5/sqrt(n5), 4);
                  blad_standardowy5 := 0.3931
u_alfa5 := Quantile(StudentT(n5 - 1), 1 - 0.02/2);
                  u_alfa5 := 2.35163489506851
blad_maksymalny5 := evalf(u_alfa5*blad_standardowy5, 4);
                   blad_maksymalny5 := 0.9244
dolna5 := evalf(srednia5 - blad_maksymalny5, 4);
                        dolna5 := 3.453
gorna5 := evalf(srednia5 + blad_maksymalny5, 4);
                        gorna5 := 5.301
```

**Zadanie 1.6** Wzory są inne bo liczymy dla odchylenia standardowego

```python
czasy_dojazdu := [25, 26, 23, 27, 22, 29, 22, 27, 21, 33, 29, 18, 22, 30, 19, 21, 27, 16, 32, 29, 32, 22, 21, 27, 24, 29, 22, 29, 24, 33];
                            n6 := 30
wariancja6 := Variance(czasy_dojazdu);      # tu mamy spierdolone zadanie bo trzeba obliczyc wariacje 
                 wariancja6 := 20.9988505747126
c1 := Quantile(ChiSquare(29), 1 - 0.02/2);  #wzor1
c2 := Quantile(ChiSquare(29), 0.02/2);      #wzor2
                     c1 := 49.5878846941643
                     c2 := 14.2564555118153
dolny_sigma6 := evalf(sqrt(29*wariancja6/c1), 4);   # Dane do przedziału (wariancja i kwantyle Chi-kwadrat dla alfa=0.02) bo 98% było
gorny_sigma6 := evalf(sqrt(29*wariancja6/c2), 4);   
                     dolny_sigma6 := 3.504
                     gorny_sigma6 := 6.536
```

**Zadanie 1.7**

```python
srednice := [32.28, 35.05, 39.23, 40.03, 37.25, 33.33, 36.08, 35.02, 38.09, 37.21, 43.70, 31.25, 43.11, 37.93, 41.02, 38.29, 31.88, 37.17, 37.28, 37.09, 36.62, 38.05, 36.93, 36.99, 36.68, 37.90, 34.80, 35.67, 40.62, 39.01];
estymator_pkt := evalf(StandardDeviation(srednice), 4); # tu estymator jest odchyleniem standardowym wiec tez taki wzor bierzemy
                     estymator_pkt := 2.906
war7 := Variance(srednice);
c1_7 := Quantile(ChiSquare(29), 1 - 0.04/2);
                    c1_7 := 46.6926994532743
c2_7 := Quantile(ChiSquare(29), 0.04/2);
                    c2_7 := 15.5744866534261
dolny_sigma7 := evalf(sqrt(29*war7/c1_7), 4);
gorny_sigma7 := evalf(sqrt(29*war7/c2_7), 4);
                     dolny_sigma7 := 2.290
                     gorny_sigma7 := 3.966
```


**Zadanie 1.8** Tu obliczamy FRAKCJE :)
```python
odleglosci := [2.5, 7.5, 12.5, 20, 32.5, 50, 75, 95];
      odleglosci := [2.5, 7.5, 12.5, 20, 32.5, 50, 75, 95]
liczba_studentow := [60, 45, 37, 20, 12, 9, 6, 3];
       liczba_studentow := [60, 45, 37, 20, 12, 9, 6, 3]
n8 := add(liczba_studentow);                                    # potrzebujemy do tego wszystkich studentow
                           n8 := 192
m8 := liczba_studentow[1] + liczba_studentow[2] + liczba_studentow[3];  # i tylko tych co są z danego przedzialu <0,15) km
                           m8 := 142
p8 := evalf(m8/n8, 4);                              # tu obliczamy Frakcje czyli proporcje
                          p8 := 0.7396
blad_standardowy8 := evalf(sqrt(p8*(1 - p8)/n8), 4);
                  blad_standardowy8 := 0.03167
u_alfa8 := Quantile(Normal(0, 1), 1 - 0.05/2);      # uzywamy tutaj Normal bo nie mamy sredniej
                  u_alfa8 := 1.95996398453944
blad_maksymalny8 := evalf(u_alfa8*blad_standardowy8, 4);
                  blad_maksymalny8 := 0.06207
dolny8 := evalf(p8 - blad_maksymalny8, 4);  # i ten wzor tez jest inny
                        dolny8 := 0.6775
gorny8 := evalf(p8 + blad_maksymalny8, 4); # i ten wzor tez jest inny
                        gorny8 := 0.8017
```

**Zadanie 1.9**
```python
oceny := [1, 2, 3, 4, 5, 6];
liczba_uczniow := [3, 14, 34, 45, 18, 3];
n9 := add(liczba_uczniow);
                           n9 := 117
m9 := liczba_uczniow[4] + liczba_uczniow[5] + liczba_uczniow[6];
                            m9 := 66
p9 := evalf(m9/n9, 4);                                  # estymator punktowy jest frakcja wiec to tez obliczamy
                          p9 := 0.5641
blad_standardowy9 := evalf(sqrt(p9*(1 - p9)/n9), 4);
                  blad_standardowy9 := 0.04585
u_alfa9 := Quantile(Normal(0, 1), 1 - 0.05/2);              # trzeba zapamietac ze Normal sie tu uzywa do tych frakcji
                  u_alfa9 := 1.95996398453944
blad_maksymalny9 := evalf(u_alfa9*blad_standardowy9, 4);
                  blad_maksymalny9 := 0.08986
dolny9 := evalf(p9 - blad_maksymalny9, 4);
                        dolny9 := 0.4742
gorny := evalf(p9 + blad_maksymalny9, 4);
                        gorny := 0.6540
```

**Zadanie 1.10**
```python
numery_butow := [39, 40, 38, 37, 37, 36, 35, 37, 36, 39, 38, 40, 40, 41, 39, 38, 38, 36, 36, 37, 38, 38, 39, 39, 34, 35, 36, 36, 37, 37, 39, 37, 40, 37, 38, 37, 37, 40, 41, 36, 37, 35, 37, 37, 40, 36, 37, 37, 38, 37, 36, 37, 37, 39, 37, 38, 35, 36, 37, 37];
n10 := nops(numery_butow);
                           n10 := 60
m10 := table(Tally(numery_butow))[37]; # tu trzeba sobie jakos wyciagnac ilosc tych butow z numerem 37 Tally pokazuje ile dla np 37 jest elementow, table zamienia to w tablice jakas i potem sobie wyciagamy te z 37
                           m10 := 21
p10 := evalf(m10/n10, 4);
                         p10 := 0.3500
blad_standardowy10 := evalf(sqrt(p10*(1 - p10)/n10), 4);
                 blad_standardowy10 := 0.06158
u_alfa10 := Quantile(Normal(0, 1), 1 - 0.05/2);
                  u_alfa10 := 1.95996398453944
blad_maksymalny10 := evalf(u_alfa10*blad_standardowy10, 4);
                  blad_maksymalny10 := 0.1207
dolny10 := evalf(p10 - blad_maksymalny10, 4);
                       dolny10 := 0.2293
gorny10 := evalf(p10 + blad_maksymalny10, 4);
                       gorny10 := 0.4707
```
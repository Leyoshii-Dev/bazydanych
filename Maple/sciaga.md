**1**
```
Scenariusz A znane odchylenie z góry
Kiedy: W treści zadania podane jest konkretne "odchylenie standardowe populacji".
Rozkład: Normalny
blad_standardowy = odchylenie/pierwiastek(n)
alfa = rozklad normalny
blad_maksymalny = alfa*blad_standardowy
Scenariusz B: NIE znasz odchylenia (liczysz je z próby)
Kiedy: Liczysz odchylenie sam komendą lub masz małą liczbę prób n<30
rozklad t-Studenta
Scenariusz C: Dane w tabeli (Wagi/Przedziały)
Kiedy: Masz tabelkę (np. "liczba dni" i "liczba pracowników").
obliczamy srednia z wagami
dolny= srednia-blad_maksymalny
gory= srednia+blad_maksymalny
Wariacje
Stosujemy, gdy zadanie pyta o "zróżnicowanie", "rozrzut" lub wprost o "odchylenie standardowe" w populacji.
ROZKLAD chi kwadrat n - 1
obliczamy wariacje z tablicy
dwa kwantyle c1 i c2 dla koncow przedzialu
dolny = pierwiastek((n-1)*wariacja/c1)
gorny = pierwiastek((n-1)*wariacja/c2)
Frakcje
Stosujemy, gdy zadanie pyta o "odsetek", "procent" lub "prawdopodobieństwo" (np. jaki procent osób ma dany numer buta)
p=m/n
gdzie m to ten procent osob a n to calosc
blad_standardowy = pierwiastek(p*(1-p)/n)
dolny = p-blad_maksymalny
gory =  p+blad_maksymalny
```
**2**
```
Test dla Średniej (mu)
Stosujesz, gdy w zadaniu pytają: „Czy przeciętna wartość wynosi X?”, „Czy czas się skrócił/wydłużył?”
Scenariusz A: Znasz odchylenie populacji
rozklad normalny
z_obliczone= (srednia-mu0)*pierwiastek(n)/odchylenie
Scenariusz B: NIE znasz odchylenia (liczysz je z próby)
liczmy odchylenie sami
rozklad t-Studenta
z_obliczone= (srednia-mu0)*pierwiastek(n)/odchylenie_obliczone
Test dla Wariancji lub Odchylenia
Stosujesz, gdy sprawdzasz „rozregulowanie” maszyn lub czy rozrzut wyników jest zgodny z normą
rozklad chi kwadrat
liczymy wariacje tablicy
wariacja = odchylenie^2 jak by był potrzebny
t_obliczone = (n-1)*wariacja/wariacja0
c1 i c2 chi kwadrat(n-1), 1-0.02 a drugi 0.02 np
Test dla Frakcji / Proporcji p
Stosujesz, gdy zadanie operuje procentami: „Czy więcej niż 30% ma problem?”, „Czy poparcie spadło poniżej 40%?”.
zawsze rozklad normalny
p=m/n - m to procent konkretny a n to calosc
p0 - jakies procenty moze byc, pewnie w tresci zadania
z_obliczone = (p-p0)/pierwiastek(p0*(1-p0)/n)
KLUCZ:
Czy jest rozny/rowny od - dwustronny
Czy jest mniejszy lewostronny
Czy jest wiekszy prawostronny

```
**3**
```
1. Porównanie dwóch średnich (Niezależne grupy)
Stosujesz, gdy masz dwie osobne grupy (np. mężczyźni vs kobiety, Zakład A vs Zakład B).
Scenariusz A: Znasz odchylenia (odchylenie1, odchylenie2)
Kiedy: Odchylenia są podane w treści zadania.
rozklad normalny
z_obliczone = (srednia1-srednia2)/pierwiastek((odchylenie1^2/n1)+(odchylenie2^2/n2))
Scenariusz B: NIE znasz odchyleń (Model z "wariancją połączoną")
Kiedy: Masz małe grupy i zakładasz, że ich wariancje są podobne .
rozklad tStudenta n1+n2-2
wariancja_polaczona = pierwiastek((n1-1)*wariancja1+(n2-1)*wariancja2/(n1+n2-2))
t_obliczone= (srednia1-srednia2)/(wariancja_polaczona*pierwiastek((1/n1)+(1/n2)))
2. Test dla par (Zależne grupy / Przed i Po)
Stosujesz, gdy badasz tę samą osobę dwa razy (np. waga przed i po diecie, algorytm stary i nowy na tych samych danych) .
Trik: Tworzysz nową listę różnic
Rozkład: t-Studenta
robimy tylko test dla tej sredniej z listy roznice
t_obliczone = (srednia*pierwiastek(n)/odchylenie)
3. Porównanie dwóch wariancji (Test FRD )
rozklad F-Snedecora (n1-1,n2-1)
 Stosujesz, gdy sprawdzasz, która grupa jest "bardziej stabilna" lub czy rozrzut wyników jest taki sam.
t_obliczone = wariacja_wieksza/wariacja_mniejsza
4. Porównanie dwóch frakcji / proporcji (p1 vs p2)
Stosujesz, gdy porównujesz procenty (np. czy w Regionie A jest więcej chorych niż w Regionie B) .
rozklad normalny
p_sr = (k1+k2)/(n1+n2) - gdzie k1 i k2 to sa te procenty a n to calosc
z_obliczone = (p1-p2)/pierwiastek(p_sr*(1-p_sr)*((1/n1)+(1/n2)))
```
**4**
```
Tworzymy Macierz 
zmienne w(wiersze) i k(kolumny) ilosc kolumn i wierszy
n_total - dodajemy wszystkie wartosci recznie albo przez petle
suma_kolumn - tyle ile jest kolumn to ma byc elementow w tabeli i to jest suma kolumn
suma_wierszy - tyle ile jest wierszy to ma byc elementow w tabeli i to jest suma wierszy
Tworzymy Macierz E z (w,k)
robimy petle w petli od 1 do w i od 1 do k
w srodku robimy 
E[i,j] (suma_wierszy[i]*suma_kolumn[j]/n_total)

chi_kwadrat - suma, suma, (A[i,j]-E[i,j])^2/E[i,j]
jak jest  macierz 2x2 to uzywamy wartosc_bezwzgledna((A[i,j]-E[i,j]-0.5)^2)

chi_krytyczne - tu ma byc ten rozklad ChiKwadrat(w-1*k-1)
```


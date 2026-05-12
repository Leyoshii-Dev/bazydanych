****

**Zadanie 4.1**
```python
with(Statistics);
A := Matrix([[143, 130, 161, 125], [15, 9, 10, 7]]);
                        [143  130  161  125]
                   A := [                  ]
                        [15    9   10    7 ]
w := 2;
k := 4;
n_total := 150*4;
                         n_total := 600
suma_kolumn := [158, 139, 171, 132];
              suma_kolumn := [158, 139, 171, 132]
suma_wierszy := [559, 41];
                   suma_wierszy := [559, 41]
E := Matrix(w, k);
for i to w do
    for j to k do E[i, j] := suma_wierszy[i]*suma_kolumn[j]/n_total; end do;
end do;
chikwadrat := evalf(add(add((A[i, j] - E[i, j])^2/E[i, j], j = 1 .. k), i = 1 .. w), 4);
                      chikwadrat := 2.531
chi_krytyczne := evalf(Quantile(ChiSquare(3), 1 - 0.05), 4);
                     chi_krytyczne := 7.815
print("Jakos produkcji nie zalezy od regionu");
            "Jakos produkcji nie zalezy od regionu"
print("Statystyka testowa ma rozklad chi square 3");
          "Statystyka testowa ma rozklad chi square 3"
```

**Zadanie 4.2**
```python
A := Matrix([[364, 142], [363, 232], [161, 219]]);
                             [364  142]
                             [        ]
                        A := [363  232]
                             [        ]
                             [161  219]
w := 3;
k := 2;
n_total := add(add(A[i, j], i = 1 .. w), j = 1 .. k);
suma_kolumn := [(364 + 363) + 161, (142 + 232) + 219];
suma_wierszy := [364 + 142, 363 + 232, 161 + 219];
E := Matrix(w, k);
for i to w do
    for j to k do E[i, j] := suma_wierszy[i]*suma_kolumn[j]/n_total; end do;
end do;
chikwadrat := evalf(add(add((A[i, j] - E[i, j])^2/E[i, j], j = 1 .. k), i = 1 .. w), 4);
                      chikwadrat := 79.49
chi_krytyczne := evalf(Quantile(ChiSquare(2), 1 - 0.02), 4);
                     chi_krytyczne := 7.824
print("Tak, istnieje ogromna zaleznosc miedzy plcia a zarobkami");
   "Tak, istnieje ogromna zaleznosc miedzy plcia a zarobkami"
print("Statystyka testowa ma rozklad chisquare z 2 stopniami swobody");
"Statystyka testowa ma rozklad chisquare z 2 stopniami swobody"
```

**Zadanie 4.3**
```python
A := Matrix([[61, 22], [56, 63], [64, 103]]);
                              [61  22 ]
                              [       ]
                         A := [56  63 ]
                              [       ]
                              [64  103]
w := 3;
k := 2;
n_total := add(add(A[i, j], i = 1 .. w), j = 1 .. k);
                         n_total := 369
suma_kolumn := [(61 + 56) + 64, (22 + 63) + 103];
suma_wierszy := [61 + 22, 56 + 63, 64 + 103];
E := Matrix(w, k);
for i to w do
    for j to k do E[i, j] := suma_wierszy[i]*suma_kolumn[j]/n_total; end do;
end do;
chi_kwadrat := evalf(add(add((A[i, j] - E[i, j])^2/E[i, j], j = 1 .. k), i = 1 .. w), 4);
                      chi_kwadrat := 27.72
chi_krytyczne := evalf(Quantile(ChiSquare(2), 1 - 0.04), 4);
                     chi_krytyczne := 6.438
print("Tak, istnieje ogromna zaleznosc miedzy frekwencja na wykladach a wynikami egzaminu");
"Tak, istnieje ogromna zaleznosc miedzy frekwencja na wykladach a wynikami egzaminu"
print("Statystyka testowa ma rozklad chisquare z 2 stopniami swobody");
"Statystyka testowa ma rozklad chisquare z 2 stopniami swobody"
```
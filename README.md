Temat
=====

Tematem projektu jest tworzenie witraży na podstawie zdjęć wykorzystując
segmentację barwną.

Działanie
=========

Projekt został zrealizowany w Matlabie R2020b. Na początku można
załadować dowolny obraz. Następnie wybrać próg (im większy próg, tym
mniej trójkątów), czy witraż ma mieć krawędzie i rozpocząć segmentację.
Na koniec można zapisać powstały obraz - witraż.

Implementacja i algorytmy
=========================

Ogólny zarys implementacji rozwiązania można przedstawić w kilku
krokach:

-   Znalezienie wierzchołków trójkątów

-   Przeprowadzenie triangulacji

-   Uśrednienie kolorów

-   Dodanie krawędzi trójkątów

Poszczególne kroki zostały szerzej omówione w poniższych sekcjach.

Znalezienie wierzchołków trójkątów
----------------------------------

Aby wykonać triangulację obrazu, w pierwszym kroku wykorzystujemy
generator liczb losowych matlaba, w celu przypisania każdemu pikselowi
obrazu losowej wartości. Dla naszych zastosowań użyliśmy funkcji
**randn**, generującej rozkład normalny.

Na podstawie wygenerowanych wartości wybieramy jako wierzchołki
trójkątów piksele, które spełniają nierówność: wartość przypisana do
piksela jest większa niż zadany przez nas próg. Próg ten jest
modyfikowalny z poziomu interfejsu aplikacji, co umożliwia użytkownikowi
zmianę ilości trójkątów generowanych przez program.

Dodatkowo, w celu uzyskania bardziej estetycznego efektu, piksele będące
na krawędziach obrazu mają większe prawdopodobieństwo bycia wylosowanymi
(próg dostarczony przez użytkownika jest obniżany o stałą wartość). Z
tych samych względów wierzchołki obrazu zawsze są wierzchołkami
trójkątów.

Triangulacja
------------

Triangulacja jest generowana przez funkcję matlaba **delaunay**. Nie
mieliśmy z nią problemów i wydaje się sprawdzać w naszej implementacji.

Uśrednienie kolorów
-------------------

Ta część zadania polegała na znalezieniu średniego koloru pikseli
zawartych w każdym z trójkątów, i wypełnienia nim obrazka wyjściowego.
Rozwiązanie, które stworzyliśmy opiera się o funkcję matlaba
**poly2mask**, zastosowaną przez nas do testowania pikseli na bycie
zawartymi w rozważanym trójkącie.

W rozwiązaniu iterujemy po kolejnych trójkątach, przerysowując do
wynikowego obrazka trójkąty wypełnione znalezionym średnim kolorem.

Dodanie krawędzi trójkątów
--------------------------

Krawędzie trójkątów zostały dodane używając funkcji **triplot**, do
której zostały przekazane wyliczone wcześniej z funkcji delaunay
wierzchołki trójkątów. Powstały wykres został nałożony na otrzymany
witraż.

Napotkane problemy
==================

Największym problemem jaki napotkaliśmy była szybkość działania programu
- początkowe, niezoptymalizowane wersje wykonywały segmentacje przez
długi czas (kilkadziesiąt sekund) nawet dla niedużych obrazów.

Optymalizacja której dokonaliśmy opierała się głównie na zastąpieniu
sposobu sprawdzania przynależności piksela do wnętrza trójkąta. Zamiast
sprawdzać każdy piksel poprzez obliczenia na koordynatach, użyliśmy
funkcji **poly2mask** matlaba, która pozwala na uzyskanie maski wartości
logicznych o rozmiarze bounding boxa trójkąta. Zastosowanie takiego
podejścia znacznie przyspieszyło program.

Drugim sposobem optymalizacji początkowej wersji było użycie jak
najmniejszej liczby pętli i zastąpienie ich indeksowaniem matlaba oraz
operacjami na macierzach.

Początkowo także rysowanie krawędzi zajmowało bardzo dużo czasu,
ponieważ rysowaliśmy szukając na obrazie granic pomiędzy dwoma kolorami.
Dzięki narysowaniu wykresu trójkątów na podstawie wierzchołków i
nałożeniu ich na obraz, dodawanie krawędzi stało się dużo szybsze.

Finalna wersja programu wykonuje te same operacje co początkowa
kilkadziesiąt razy szybciej (kilka-kilkanaście sekund).

Napotkaliśmy jeszcze jeden drobny problem. Podczas wykonywania
segmentacji kliknięcie na wybrany obraz (po lewej stronie) powoduje
zatrzymanie segmentacji w danym momencie i przez to niepoprawny wynik.

Analiza testowych wyników
=========================

Ostateczna wersja programu pozwala na dość szybkie wygenerowanie
segmentacji dla obrazu. W uruchomieniach testowych, przeprowadzonych z
progiem 3.0, uzyskaliśmy dla różnych rozmiarów obrazów średnie czasy (po
5 uruchomień):

-   HD - 2.08 sekund

-   Full HD - 4.38 sekund

-   2K - 7.85 sekund

-   4K - 18.38 sekund

Testy wykonywane były z wyłączonymi krawędziami trójkątów. Włączenie
krawędzi spowodowało wydłużenie czasu generacji średnio o 26%. Jak widać
zwiększenie rozmiaru obrazu negatywnie wpływa na prędkość programu,
jednak nawet dla dużych rozmiarów czas wykonania jest akceptowalny.

Testowane obrazy były w formacie jpg, aplikacja nie gwarantuje zawsze
poprawnej obsługi formatu png, choć pozostawiono możliwość odczytu tego
formatu. Inne formaty nie zostały przetestowane.

Podział pracy
=============

-   Piotr Jasiński:\
    Pierwsza wersja funkcji generującej segmentację, współudział w
    późniejszych poprawkach i optymalizacji.

-   Olga Kubiszyn:\
    Dodawanie krawędzi trójkątów i optymalizacja.

-   Jan Zajda:\
    Interfejs graficzny, poprawa wydajności segmentacji.


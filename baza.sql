-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Czas generowania: 04 Gru 2021, 14:56
-- Wersja serwera: 10.4.21-MariaDB
-- Wersja PHP: 7.3.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `gtsd`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `adres`
--

CREATE TABLE `adres` (
  `Ulica` varchar(255) NOT NULL,
  `Miasto` varchar(255) NOT NULL,
  `Kod_pocztowy` varchar(255) NOT NULL,
  `Kraj` varchar(255) NOT NULL,
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `kategorie_sklep`
--

CREATE TABLE `kategorie_sklep` (
  `id_kat` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `podkategorie_sklep`
--

CREATE TABLE `podkategorie_sklep` (
  `id_kat` varchar(255) NOT NULL,
  `nazwa_podkategorii` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `produkty`
--

CREATE TABLE `produkty` (
  `cena` float NOT NULL,
  `cena_prom` float NOT NULL,
  `opis` varchar(255) NOT NULL,
  `nazwa` varchar(255) NOT NULL,
  `id_kat` varchar(255) NOT NULL,
  `id_produktu` int(11) NOT NULL,
  `zdjecie` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `uzytkownik`
--

CREATE TABLE `uzytkownik` (
  `id` int(11) NOT NULL,
  `typ` varchar(255) NOT NULL,
  `koszyk` varchar(255) NOT NULL,
  `haslo` varchar(255) NOT NULL,
  `mail` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `zamowienie`
--

CREATE TABLE `zamowienie` (
  `id` int(11) NOT NULL,
  `uzytkownik` int(11) NOT NULL,
  `data` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `zamowienie_realizacja`
--

CREATE TABLE `zamowienie_realizacja` (
  `id_zamowienia` int(11) NOT NULL,
  `id_produktu` int(11) NOT NULL,
  `ilosc` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `zdjecia`
--

CREATE TABLE `zdjecia` (
  `typ` varchar(255) NOT NULL,
  `zdjecie` varchar(255) NOT NULL,
  `id_zdjecia` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `zdjecia_produkt`
--

CREATE TABLE `zdjecia_produkt` (
  `id_produkt` int(11) NOT NULL,
  `id_zdjecia` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `adres`
--
ALTER TABLE `adres`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `kategorie_sklep`
--
ALTER TABLE `kategorie_sklep`
  ADD PRIMARY KEY (`id_kat`);

--
-- Indeksy dla tabeli `podkategorie_sklep`
--
ALTER TABLE `podkategorie_sklep`
  ADD PRIMARY KEY (`id_kat`);

--
-- Indeksy dla tabeli `produkty`
--
ALTER TABLE `produkty`
  ADD PRIMARY KEY (`id_produktu`),
  ADD KEY `kat` (`id_kat`),
  ADD KEY `zdj` (`zdjecie`);

--
-- Indeksy dla tabeli `uzytkownik`
--
ALTER TABLE `uzytkownik`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mail` (`mail`);

--
-- Indeksy dla tabeli `zamowienie`
--
ALTER TABLE `zamowienie`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uzytkownik` (`uzytkownik`);

--
-- Indeksy dla tabeli `zamowienie_realizacja`
--
ALTER TABLE `zamowienie_realizacja`
  ADD KEY `id_prod` (`id_produktu`),
  ADD KEY `id_zamow` (`id_zamowienia`);

--
-- Indeksy dla tabeli `zdjecia`
--
ALTER TABLE `zdjecia`
  ADD PRIMARY KEY (`id_zdjecia`);

--
-- Ograniczenia dla zrzutów tabel
--

--
-- Ograniczenia dla tabeli `adres`
--
ALTER TABLE `adres`
  ADD CONSTRAINT `id` FOREIGN KEY (`id`) REFERENCES `uzytkownik` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ograniczenia dla tabeli `podkategorie_sklep`
--
ALTER TABLE `podkategorie_sklep`
  ADD CONSTRAINT `pk` FOREIGN KEY (`id_kat`) REFERENCES `kategorie_sklep` (`id_kat`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ograniczenia dla tabeli `produkty`
--
ALTER TABLE `produkty`
  ADD CONSTRAINT `kat` FOREIGN KEY (`id_kat`) REFERENCES `podkategorie_sklep` (`id_kat`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `zdj` FOREIGN KEY (`zdjecie`) REFERENCES `zdjecia` (`id_zdjecia`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Ograniczenia dla tabeli `zamowienie`
--
ALTER TABLE `zamowienie`
  ADD CONSTRAINT `uzytkownik` FOREIGN KEY (`uzytkownik`) REFERENCES `uzytkownik` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ograniczenia dla tabeli `zamowienie_realizacja`
--
ALTER TABLE `zamowienie_realizacja`
  ADD CONSTRAINT `id_prod` FOREIGN KEY (`id_produktu`) REFERENCES `produkty` (`id_produktu`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `id_zamow` FOREIGN KEY (`id_zamowienia`) REFERENCES `zamowienie` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

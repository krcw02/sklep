SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;


CREATE TABLE `adres` (
  `Ulica` varchar(255) NOT NULL,
  `Miasto` varchar(255) NOT NULL,
  `Kod_pocztowy` varchar(255) NOT NULL,
  `Kraj` varchar(255) NOT NULL,
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `kategorie_sklep` (
  `id_kat` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `podkategorie_sklep` (
  `id_kat` varchar(255) NOT NULL,
  `nazwa_podkategorii` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `produkty` (
  `cena` float NOT NULL,
  `cena_prom` float NOT NULL,
  `opis` varchar(255) NOT NULL,
  `nazwa` varchar(255) NOT NULL,
  `id_kat` varchar(255) NOT NULL,
  `id_produktu` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `uzytkownik` (
  `id` int(11) NOT NULL,
  `typ` varchar(255) NOT NULL,
  `koszyk` varchar(255) NOT NULL,
  `haslo` varchar(255) NOT NULL,
  `mail` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `zamowienie` (
  `id` int(11) NOT NULL,
  `uzytkownik` int(11) NOT NULL,
  `data` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `zamowienie_realizacja` (
  `id_zamowienia` int(11) NOT NULL,
  `id_produktu` int(11) NOT NULL,
  `ilosc` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `zdjecia` (
  `typ` varchar(255) NOT NULL,
  `zdjecie` varchar(255) NOT NULL,
  `id_zdjecia` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `zdjecia_produkt` (
  `id_produkt` int(11) NOT NULL,
  `id_zdjecia` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


ALTER TABLE `adres`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `kategorie_sklep`
  ADD PRIMARY KEY (`id_kat`);

ALTER TABLE `podkategorie_sklep`
  ADD PRIMARY KEY (`id_kat`);

ALTER TABLE `produkty`
  ADD PRIMARY KEY (`id_produktu`),
  ADD KEY `kat` (`id_kat`);

ALTER TABLE `uzytkownik`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `zamowienie`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uzytkownik` (`uzytkownik`);

ALTER TABLE `zamowienie_realizacja`
  ADD KEY `id_prod` (`id_produktu`),
  ADD KEY `id_zamow` (`id_zamowienia`);

ALTER TABLE `zdjecia`
  ADD PRIMARY KEY (`id_zdjecia`);


ALTER TABLE `adres`
  ADD CONSTRAINT `id` FOREIGN KEY (`id`) REFERENCES `uzytkownik` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `podkategorie_sklep`
  ADD CONSTRAINT `pk` FOREIGN KEY (`id_kat`) REFERENCES `kategorie_sklep` (`id_kat`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `produkty`
  ADD CONSTRAINT `kat` FOREIGN KEY (`id_kat`) REFERENCES `podkategorie_sklep` (`id_kat`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `zamowienie`
  ADD CONSTRAINT `uzytkownik` FOREIGN KEY (`uzytkownik`) REFERENCES `uzytkownik` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `zamowienie_realizacja`
  ADD CONSTRAINT `id_prod` FOREIGN KEY (`id_produktu`) REFERENCES `produkty` (`id_produktu`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `id_zamow` FOREIGN KEY (`id_zamowienia`) REFERENCES `zamowienie` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

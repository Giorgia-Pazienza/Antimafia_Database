/* Creazione del database */
CREATE DATABASE IF NOT EXISTS DB_Progetto;

/* Utilizza il database */
USE DB_Progetto;

/* Disabilita i check delle chiavi esterne temporaneamente */ 
SET foreign_key_checks = 0;

/* Eliminare le tabelle esistenti */ 
DROP TABLE IF EXISTS Città;
DROP TABLE IF EXISTS Clan_Mafioso;
DROP TABLE IF EXISTS Pena;
DROP TABLE IF EXISTS Processo;
DROP TABLE IF EXISTS Carcere;
DROP TABLE IF EXISTS Tribunale;
DROP TABLE IF EXISTS Giudice;
DROP TABLE IF EXISTS Vittima;
DROP TABLE IF EXISTS Famiglia;
DROP TABLE IF EXISTS Relazione;
DROP TABLE IF EXISTS Detenuto;
DROP TABLE IF EXISTS Condanna;
DROP TABLE IF EXISTS Risiede;
DROP TABLE IF EXISTS Coinvolto;
DROP TABLE IF EXISTS Detenzione;
DROP TABLE IF EXISTS Programma_di_Reinserimento;

/* Abilitare i check delle chiavi esterne */ 
SET foreign_key_checks = 1;

/* CREAZIONE DELLE TABELLE */

CREATE TABLE Città (
    ID_Città INT PRIMARY KEY,
    Nome_Città VARCHAR(255),
    Regione VARCHAR(255)
);

CREATE TABLE Clan_Mafioso (
    Nome_Clan VARCHAR(255) PRIMARY KEY,
    Data_Fondazione DATE
);

CREATE TABLE Pena (
    ID_Pena INT PRIMARY KEY,
    Tipo_Pena VARCHAR(255),
    Variazione_Pena VARCHAR(255),
    Data_Inizio_Pena DATE,
    Data_Fine_Pena DATE
);

CREATE TABLE Processo (
    Numero_Seriale INT PRIMARY KEY,
    Tipo_Processo VARCHAR(255),
    Inizio_Processo DATE,
    Fine_Processo DATE,
    Sezione_Processo VARCHAR(255),
    Riinvio_Processo BOOLEAN
);

CREATE TABLE Carcere (
    ID_Carcere INT PRIMARY KEY,
    Nome_Carcere VARCHAR(255),
    Tipo_Carcere VARCHAR(255),
    Numero_Detenuti INT,
    Indirizzo_Carcere VARCHAR(255)
);

CREATE TABLE Tribunale (
    ID_Tribunale INT PRIMARY KEY,
    Indirizzo_Tribunale VARCHAR(255),
    Nome_Tribunale VARCHAR(255),
    Numero_Aula VARCHAR(20),
    Capienza_Aula INT
);

CREATE TABLE Giudice (
    Codice_Fiscale_Giudice VARCHAR(16) PRIMARY KEY,
    Nome_Giudice VARCHAR(16), 
    Cognome_Giudice VARCHAR(16), 
    Data_Nascita_Giudice DATE
);

CREATE TABLE Vittima (
    Codice_Fiscale_Vittima VARCHAR(16) PRIMARY KEY,
    Nome_Vittima VARCHAR(255),
    Cognome_Vittima VARCHAR(255),
    Data_Nascita DATE,
    Data_Decesso DATE,
    Circostanze TEXT
);

CREATE TABLE Famiglia (
    Nome_Famiglia VARCHAR(255) PRIMARY KEY,
    Data_Fondazione DATE,
    Numero_Componenti INT,
    Capo_Famiglia VARCHAR(255),
    Nome_Clan VARCHAR(255),
    FOREIGN KEY (Nome_Clan) REFERENCES Clan_Mafioso(Nome_Clan)
);

CREATE TABLE Relazione (
    Nome_Famiglia1 VARCHAR(225),
    Nome_Famiglia2 VARCHAR(225),
    Legame VARCHAR(225),
    PRIMARY KEY (Nome_Famiglia1, Nome_Famiglia2),
    FOREIGN KEY (Nome_Famiglia1) REFERENCES Famiglia (Nome_Famiglia),
    FOREIGN KEY (Nome_Famiglia2) REFERENCES Famiglia (Nome_Famiglia)
);

CREATE TABLE Detenuto (
    Codice_Fiscale_Detenuto VARCHAR(16) PRIMARY KEY,
    Nome_Detenuto VARCHAR(255),
    Cognome_Detenuto VARCHAR(255),
    Data_Nascita DATE,
    Nome_Famiglia VARCHAR(255),
    ID_Città INT,
    FOREIGN KEY (Nome_Famiglia) REFERENCES Famiglia (Nome_Famiglia),
    FOREIGN KEY (ID_Città) REFERENCES Città (ID_Città)
);

CREATE TABLE Condanna (
    Numero_Sentenza INT PRIMARY KEY,
    Info_Condanna TEXT,
    Data_Condanna DATE,
    Numero_Seriale INT,
    Codice_Fiscale_Giudice VARCHAR(16),
    ID_Pena INT,
    Codice_Fiscale_Detenuto VARCHAR(16),
    FOREIGN KEY (Numero_Seriale) REFERENCES Processo (Numero_Seriale),
    FOREIGN KEY (Codice_Fiscale_Giudice) REFERENCES Giudice (Codice_Fiscale_Giudice),
    FOREIGN KEY (ID_Pena) REFERENCES Pena (ID_Pena),
    FOREIGN KEY (Codice_Fiscale_Detenuto) REFERENCES Detenuto (Codice_Fiscale_Detenuto)
);

CREATE TABLE Risiede (
    Codice_Fiscale_Giudice VARCHAR(16),
    ID_Tribunale INT,
    Inizio_Operato DATE,
    PRIMARY KEY (Codice_Fiscale_Giudice, ID_Tribunale),
    FOREIGN KEY (Codice_Fiscale_Giudice) REFERENCES Giudice (Codice_Fiscale_Giudice),
    FOREIGN KEY (ID_Tribunale) REFERENCES Tribunale (ID_Tribunale)
);

CREATE TABLE Coinvolto (
    Codice_Fiscale_Detenuto VARCHAR(16),
    Codice_Fiscale_Vittima VARCHAR(16),
    PRIMARY KEY (Codice_Fiscale_Detenuto, Codice_Fiscale_Vittima),
    FOREIGN KEY (Codice_Fiscale_Detenuto) REFERENCES Detenuto (Codice_Fiscale_Detenuto),
    FOREIGN KEY (Codice_Fiscale_Vittima) REFERENCES Vittima (Codice_Fiscale_Vittima)
);

CREATE TABLE Detenzione (
    Codice_Fiscale_Detenuto VARCHAR(16),
    ID_Carcere INT,
    PRIMARY KEY (Codice_Fiscale_Detenuto, ID_Carcere),
    FOREIGN KEY (Codice_Fiscale_Detenuto) REFERENCES Detenuto (Codice_Fiscale_Detenuto),
    FOREIGN KEY (ID_Carcere) REFERENCES Carcere (ID_Carcere)
);

CREATE TABLE Programma_di_Reinserimento (
    Nome_Progetto VARCHAR(255) PRIMARY KEY,
    Tipo_Programma VARCHAR(255),
    Durata_Programma INT,  
    Codice_Fiscale_Detenuto VARCHAR(16),
    FOREIGN KEY (Codice_Fiscale_Detenuto) REFERENCES Detenuto (Codice_Fiscale_Detenuto)
);

/* INSERIMENTO DEI DATI */

INSERT INTO Città (ID_Città, Nome_Città, Regione)
VALUES (01, 'Palermo', 'Sicilia'),
(02, 'Casal di Principe', 'Campania'),
(03, 'Milano', 'Lombardia'),
(04, 'Roma', 'Lazio'),
(05, 'Sassari', 'Sardegna'),
(06, 'Catanzaro', 'Calabria'),
(07, 'Padova', 'Veneto');

INSERT INTO Clan_Mafioso (Nome_Clan, Data_Fondazione)
VALUES ('Cosa Nostra', '1980-01-01'),
('Clan dei Casalesi', '1975-01-01'),
('Anonima Sequestri', '1960-01-01'),
('Clan dei Casamonica', '1970-01-01'),
('\'Ndrangheta', '1900-01-01'),
('Mala del Brenta', '1970-01-01'),
('Banda della Comasina', '1970-01-01');

INSERT INTO Pena (ID_Pena, Tipo_Pena, Variazione_Pena, Data_Inizio_Pena, Data_Fine_Pena)
VALUES (1, 'Reclusione', 'Nessuna', '1993-04-11', 'Ergastolo'),
(2, 'Reclusione', 'Nessuna', '1984-12-21', 'Ergastolo'),
(3, 'Reclusione', 'Nessuna', '2012-09-11', 'Ergastolo'),
(4, 'Reclusione', 'Nessuna', '2010-06-16', '2040-06-16'),
(5, 'Reclusione', 'Nessuna', '1994-05-11', 'Ergastolo'),
(6, 'Reclusione', 'Nessuna', '2000-12-16', '2030-12-16'),
(7, 'Reclusione', 'Nessuna', '2008-08-11', '2033-08-11'),
(8, 'Reclusione', 'Nessuna', '2016-03-11', '2036-03-11'),
(9, 'Reclusione', 'Nessuna', '1975-07-02', 'Ergastolo'),
(10, 'Reclusione', 'Nessuna', '2010-07-11', '2040-07-11'),
(11, 'Reclusione', 'Nessuna', '1994-03-02', '2019-03-02'),
(12, 'Reclusione', 'Nessuna', '1977-09-02', '2007-09-02');

INSERT INTO Processo (Numero_Seriale, Tipo_Processo, Inizio_Processo, Fine_Processo, Sezione_Processo, Riinvio_Processo)
VALUES (1, 'Penale', '2023-08-24', '2024-01-15', 'Corte d\'Assise', FALSE),
(2, 'Penale', '1968-12-29', '1970-01-16', 'Corte d\'Assise', FALSE),
(3, 'Penale', '2021-02-17', '2024-01-17', 'Corte d\'Assise', FALSE),
(4, 'Penale', '2023-05-12', '2024-01-18', 'Corte d\'Assise', FALSE),
(5, 'Penale', '2022-12-21', '2024-01-19', 'Corte d\'Assise', FALSE),
(6, 'Penale', '2022-03-08', '2024-01-20', 'Corte d\'Assise', FALSE),
(7, 'Penale', '2020-01-04', '2024-01-21', 'Corte d\'Assise', FALSE),
(8, 'Penale', '2022-11-23', '2024-01-22', 'Corte d\'Assise', FALSE),
(9, 'Penale', '2023-04-11', '2024-01-23', 'Corte d\'Assise', FALSE),
(10, 'Penale', '2022-10-05', '2024-01-24', 'Corte d\'Assise', FALSE),
(11, 'Penale', '2023-07-19', '2024-01-25', 'Corte d\'Assise', FALSE),
(12, 'Penale', '2024-01-26', '2024-05-19', 'Corte d\'Assise', FALSE);

INSERT INTO Carcere (ID_Carcere, Nome_Carcere, Tipo_Carcere, Numero_Detenuti, Indirizzo_Carcere)
VALUES (1001, 'Carcere dell\'Ucciardone', 'Massima Sicurezza', 402, 'Via Enrico Albanese 3, 90139 Palermo PA'),
(1002, 'Carcere di Rebibbia', 'Media Sicurezza', 1525, 'Via Bartolo Longo 72, 00156 Roma RM'),
(1003, 'Carcere di Badu \'e Carros', 'Media Sicurezza', 155, 'Via Badu e Carros 1, 08100 Nuoro NU'),
(1004, 'Carcere di Santa Maria Capua Vetere', 'Media Sicurezza', 940, 'Corso Aldo Moro 239, 81055 Santa Maria Capua Vetere CE'),
(1005, 'Carcere di Opera', 'Massima Sicurezza', 1311, 'Via Camporgnago 40, 20141 Milano MI'),
(1006, 'Carcere di Palmi', 'Media Sicurezza', 163, 'Via Trodio 2, 89015 Palmi RC'),
(1007, 'Carcere di Treviso', 'Istituto minorile maschile', 12, 'Via Santa Bona Nuova 5/b, 31100 Treviso TV'),
(1008, 'Carcere di Volterra', 'Media Sicurezza', 183, 'Rampa di Castello 4, 56048 Volterra PI'),
(1009, 'Carcere di San Donato', 'Media Sicurezza', 354, 'Via San Donato 2, 65129 Pescara PE');

INSERT INTO Tribunale (ID_Tribunale, Indirizzo_Tribunale, Nome_Tribunale, Numero_Aula, Capienza_Aula)
VALUES (2001, 'Viale Alessandro Guidoni 61, 50127 Firenze FI', 'Palazzo di Giustizia di Firenze', 'Corte d\'Assise 1', 234),
(2002, 'Piazza Vittorio Emanuele Orlando 1, 90138 Palermo PA', 'Palazzo di Giustizia di Palermo', 'Corte d\'Assise 2', 250),
(2003, 'Via Giuseppe Bonaparte 38, 81055 Santa Maria Capua Vetere CE', 'Tribunale di Santa Maria Capua Vetere', 'Aula bunker 2', 400),
(2004, 'Via Roma Verso Scampia 350, 80144 Napoli NA', 'Carcere di Secondigliano', 'Aula bunker 3', 450),
(2005, 'Via Roma Verso Scampia, 350, 80144 Napoli NA', 'Carcere di Secondigliano', 'Aula bunker 5', 450),
(2006, 'Viale Alessandro Guidoni 61, 50127 Firenze FI', 'Tribunale di Firenze', 'II 1', 40),
(2007, 'Piazza Aldo Moro 3, 09170 Oristano OR', 'Tribunale di Oristano', 'C 1', 20),
(2008, 'Via Avvenire Paterlini 1, 42124 Reggio Emilia RE', 'Tribunale di Reggio Emilia', '41', 24),
(2009, 'Via Camporgnago 40, 20141 Milano MI', 'Carcere di Opera', 'Aula bunker 6', 420),
(2010, 'Via Trodio 2, 89015 Palmi RC', 'Carcere di Palmi', 'Aula bunker 7', 450),
(2011, 'Via Niccolò Tommaseo 55, 35131 Padova PD', 'Tribunale di Padova', '61', 22);

INSERT INTO Giudice (Codice_Fiscale_Giudice, Nome_Giudice, Cognome_Giudice, Data_Nascita_Giudice)
VALUES ('MNGLMP65T32B456D', 'Francesco', 'Mancini', '1965-05-12'),
('RSSPNT80R54C678E', 'Elena', 'Meli', '1980-04-05'),
('VRNCMT72S13D890F', 'Marco', 'Verdi', '1972-09-13'),
('BNCLMP60T95E123G', 'Laura', 'Bianchi', '1960-10-05'),
('MNGLMP70R43F456H', 'Andrea', 'Conti', '1970-03-04'),
('RSSPNT85R65G789I', 'Giulia', 'Rossi', '1985-02-01'),
('VRNCMT77T14H012J', 'Fabio', 'Verdi', '1977-01-14'),
('BNCLMP62R061345K', 'Sofia', 'Bianchi', '1962-06-06'),
('MNGLMP75R56J678L', 'Luca', 'Perrone', '1975-05-06'),
('RSSPNT90R77K890M', 'Alessia', 'Rossi', '1990-04-07'),
('MNGLMP80R67L012N', 'Matteo', 'Esposito', '1980-06-07'),
('RSSPNT95R88M123O', 'Chiara', 'Russo', '1995-05-08');

INSERT INTO Vittima (Codice_Fiscale_Vittima, Nome_Vittima, Cognome_Vittima, Data_Nascita, Data_Decesso, Circostanze)
VALUES ('CLJFNC42E23A176L', 'Francesco', 'Claujano', '1942-05-23', '1982-01-19', 'Ucciso per ordine di Salvatore Riina'),
('DMRMRA21A25G273Q', 'Mauro', 'De Mauro', '1921-01-25', '1979-09-26', 'Rapito e ucciso per ordine di Salvatore Riina'),
('MPSPPN48A05C708P', 'Peppino', 'Impastato', '1948-01-05', '1978-05-09', 'Ucciso per ordine di Salvatore Riina'),
('RSSGPP66A06E932C', 'Giuseppe', 'Russo', '1966-01-06', '1998-01-24', 'Ucciso in un agguato a Casal di Principe insieme al collega Ciro Nuvoletta'),
('NVLCRI77C221234U', 'Ciro', 'Nuvoletta', '1977-03-22', '1998-01-24', 'Ucciso in un agguato a Casal di Principe insieme al collega Giuseppe Russo'),
('KSSFRK84E09Z401M', 'Farouk', 'Kassam', '1984-05-09', NULL, 'Rapito nel 1992, venne rilasciato dopo 6 mesi'),
('CVZNNI57R18G224E', 'Nino', 'Cavazzola', '1957-10-18', '1980-08-06', 'Ucciso durante una lite per il controllo del clan da Felice Maniero'),
('FBRDDR40B18D969Z', 'Fabrizio', 'De André', '1940-02-18', '1999-01-11', 'Rapito nel 1979 insieme alla compagna Dori Ghezzi, venne rilasciato dopo 4 mesi'),
('DROGZZ46C70E530I', 'Dori', 'Ghezzi', '1946-03-30', NULL, 'Rapita nel 1979 insieme al compagno Fabrizio De André, venne rilasciata dopo 4 mesi');

INSERT INTO Famiglia (Nome_Famiglia, Data_Fondazione, Numero_Componenti, Capo_Famiglia, Nome_Clan)
VALUES ('Clan dei Corleonesi', '1970-01-01', 30, 'Totò Riina', 'Cosa Nostra'),
('Famiglia di Porta Nuova', '1950-01-01', 20, 'Tommaso Buscetta', 'Cosa Nostra'),
('Famiglia Zagaria', '1975-01-01', 50, 'Michele Zagaria', 'Clan dei Casalesi'),
('Famiglia Iovine', '1975-01-01', 45, 'Antonio Iovine', 'Clan dei Casalesi'),
('Criminale Autonomo', '1980-01-01', 1, 'N/D', 'Anonima Sequestri'),
('Famiglia Casamonica', '1960-01-01', 100, 'Vittorio Casamonica', 'Clan dei Casamonica'),
('Alvaro di Sinopoli', '1900-01-01', 70, 'Carmine Alvaro', '\'Ndrangheta'),
('\'Ndrina dei Pelle', '1900-01-01', 60, 'Giuseppe Pelle', '\'Ndrangheta'),
('Mala del Brenta', '1965-01-01', 30, 'Felice Maniero', 'Mala del Brenta'),
('Banda della Comasina', '1970-01-01', 15, 'Renato Vallanzasca', 'Banda della Comasina');

INSERT INTO Relazione (Nome_Famiglia1, Nome_Famiglia2, Legame)
VALUES ('Clan dei Corleonesi', 'Famiglia di Porta Nuova', 'Rivalità'),
('Famiglia Zagaria', 'Famiglia Iovine', 'Alleanza'),
('Alvaro di Sinopoli', '\'Ndrina dei Pelle', 'Alleanza');

INSERT INTO Detenuto (Codice_Fiscale_Detenuto, Nome_Detenuto, Cognome_Detenuto, Data_Nascita, Nome_Famiglia, ID_Città)
VALUES ('RNISVT30S16D009R', 'Salvatore', 'Riina', '1930-11-16', 'Clan dei Corleonesi', 01),
('BSCTMS28L13G273Y', 'Tommaso', 'Buscetta', '1928-07-13', 'Famiglia di Porta Nuova', 01),
('ZGRMHL58E21H798F', 'Michele', 'Zagaria', '1958-05-21', 'Famiglia Zagaria', 02),
('VNINTN64P20H798D', 'Antonio', 'Iovine', '1964-09-20', 'Famiglia Iovine', 02),
('BOEMTT57S09E736E', 'Matteo', 'Boe', '1957-11-09', 'Criminale Autonomo', 05),
('MSNGZN42D04G097C', 'Graziano', 'Mesina', '1942-04-04', 'Criminale Autonomo', 05),
('CSMNTN68H22H501S', 'Antonio', 'Casamonica', '1968-06-22', 'Famiglia Casamonica', 04),
('CSMPQL81M19H501X', 'Pasquale', 'Casamonica', '1981-07-19', 'Famiglia Casamonica', 04),
('LVRDNC24T051753B', 'Domenico', 'Alvaro', '1924-12-05', 'Alvaro di Sinopoli', 06),
('PLLGPP60M20H970K', 'Giuseppe', 'Pelle', '1960-08-20', '\'Ndrina dei Pelle', 06),
('MNRFLC54P02B546E', 'Felice', 'Maniero', '1954-09-02', 'Mala del Brenta', 07),
('VLLRNT50E04F205F', 'Renato', 'Vallanzasca Costantini', '1950-05-04', 'Banda della Comasina', 03);

INSERT INTO Condanna (Numero_Sentenza, Info_Condanna, Data_Condanna, Numero_Seriale, Codice_Fiscale_Giudice, ID_Pena, Codice_Fiscale_Detenuto)
VALUES (15, 'Ergastolo per associazione mafiosa e omicidio', '1993-04-10', 1, 'MNGLMP65T32B456D', 1, 'RNISVT30S16D009R'),
(16, 'Ergastolo per associazione mafiosa e traffico di droga', '1984-12-20', 2, 'RSSPNT80R54C678E', 2, 'BSCTMS28L13G273Y'),
(17, 'Ergastolo per associazione mafiosa e estorsione', '2012-09-10', 3, 'VRNCMT72S13D890F', 3, 'ZGRMHL58E21H798F'),
(18, '30 anni per associazione mafiosa', '2010-06-15', 4, 'BNCLMP60T95E123G', 4, 'VNINTN64P20H798D'),
(19, 'Ergastolo per sequestro di persona', '1994-05-10', 5, 'MNGLMP70R43F456H', 5, 'BOEMTT57S09E736E'),
(20, '30 anni per omicidio e rapina', '2000-12-15', 6, 'RSSPNT85R65G789I', 6, 'MSNGZN42D04G097C'),
(21, '25 anni per associazione mafiosa e traffico di droga', '2008-08-10', 7, 'VRNCMT77T14H012J', 7, 'CSMNTN68H22H501S'),
(22, '20 anni per associazione mafiosa', '2016-03-10', 8, 'BNCLMP62R061345K', 8, 'CSMPQL81M19H501X'),
(23, 'Ergastolo per associazione mafiosa e omicidio', '1975-07-01', 9, 'MNGLMP75R56J678L', 9, 'LVRDNC24T051753B'),
(24, '30 anni per associazione mafiosa', '2010-07-10', 10, 'RSSPNT90R77K890M', 10, 'PLLGPP60M20H970K'),
(25, '25 anni per associazione mafiosa e rapina', '1994-03-01', 11, 'MNGLMP80R67L012N', 11, 'MNRFLC54P02B546E'),
(26, '30 anni per omicidio e rapina', '1977-09-01', 12, 'RSSPNT95R88M123O', 12, 'VLLRNT50E04F205F');

INSERT INTO Risiede (Codice_Fiscale_Giudice, ID_Tribunale, Inizio_Operato)
VALUES ('MNGLMP65T32B456D', 2001, '1995-10-10'),
('RSSPNT80R54C678E', 2002, '2007-03-03'),
('VRNCMT72S13D890F', 2003, '2000-12-20'),
('BNCLMP60T95E123G', 2004, '1992-05-05'),
('MNGLMP70R43F456H', 2005, '1997-02-02'),
('RSSPNT85R65G789I', 2006, '2010-01-01'),
('VRNCMT77T14H012J', 2007, '2004-04-04'),
('BNCLMP62R061345K', 2008, '1994-03-03'),
('MNGLMP75R56J678L', 2009, '2003-07-07'),
('RSSPNT90R77K890M', 2010, '2012-12-12'),
('MNGLMP80R67L012N', 2011, '2008-08-08'),
('RSSPNT95R88M123O', 2005, '2015-05-05');

INSERT INTO Coinvolto (Codice_Fiscale_Detenuto, Codice_Fiscale_Vittima)
VALUES ('RNISVT30S16D009R', 'CLJFNC42E23A176L'),
('RNISVT30S16D009R', 'DMRMRA21A25G273Q'),
('RNISVT30S16D009R', 'MPSPPN48A05C708P'),
('VNINTN64P20H798D', 'RSSGPP66A06E932C'),
('VNINTN64P20H798D', 'NVLCRI77C221234U'),
('BOEMTT57S09E736E', 'KSSFRK84E09Z401M'),
('MNRFLC54P02B546E', 'CVZNNI57R18G224E'),
('MSNGZN42D04G097C', 'FBRDDR40B18D969Z'),
('MSNGZN42D04G097C', 'DROGZZ46C70E530I');

INSERT INTO Detenzione (Codice_Fiscale_Detenuto, ID_Carcere)
VALUES ('RNISVT30S16D009R', 1001),
('RNISVT30S16D009R', 1005),
('RNISVT30S16D009R', 1002),
('BSCTMS28L13G273Y', 1001),
('BSCTMS28L13G273Y', 1002),
('ZGRMHL58E21H798F', 1004),
('ZGRMHL58E21H798F', 1001),
('ZGRMHL58E21H798F', 1005),
('VNINTN64P20H798D', 1004),
('VNINTN64P20H798D', 1001),
('VNINTN64P20H798D', 1003),
('VNINTN64P20H798D', 1005),
('BOEMTT57S09E736E', 1005),
('MSNGZN42D04G097C', 1001),
('MSNGZN42D04G097C', 1003),
('MSNGZN42D04G097C', 1005),
('CSMNTN68H22H501S', 1002),
('CSMPQL81M19H501X', 1002),
('LVRDNC24T051753B', 1006),
('PLLGPP60M20H970K', 1006),
('MNRFLC54P02B546E', 1007),
('MNRFLC54P02B546E', 1002),
('MNRFLC54P02B546E', 1001),
('MNRFLC54P02B546E', 1008),
('MNRFLC54P02B546E', 1009),
('VLLRNT50E04F205F', 1008);

INSERT INTO Programma_di_Reinserimento (Nome_Progetto, Tipo_Programma, Durata_Programma, Codice_Fiscale_Detenuto)
VALUES ('Riabilitazione Sociale', 'Programma di Rieducazione', '2 anni', 'RNISVT30S16D009R'),
('Testimone di Giustizia', 'Programma di Protezione', '3 anni', 'BSCTMS28L13G273Y'),
('Educazione alla Legalità', 'Programma Educativo', '1 anno', 'ZGRMHL58E21H798F'),
('Lavoro all\'Esterno', 'Programma di Lavoro', '3 anni', 'VNINTN64P20H798D'),
('Psicoterapia e Supporto', 'Programma Psicoterapeutico', '2 anni', 'BOEMTT57S09E736E'),
('Integrazione Sociale', 'Programma di Integrazione', '2 anni', 'MSNGZN42D04G097C'),
('Formazione Professionale', 'Programma di Formazione', '1 anno', 'CSMNTN68H22H501S'),
('Supporto alla Vita', 'Programma di Supporto', '2 anni', 'CSMPQL81M19H501X'),
('Prevenzione Recidiva', 'Programma Preventivo', '3 anni', 'LVRDNC24T051753B'),
('Riabilitazione Psicosociale', 'Programma Psicosociale', '2 anni', 'PLLGPP60M20H970K'),
('Recupero alla Vita', 'Programma di Recupero', '3 anni', 'MNRFLC54P02B546E'),
('Riconciliazione Sociale', 'Programma di Riconciliazione', '2 anni', 'VLLRNT50E04F205F');

/* Creazione del database */
CREATE DATABASE IF NOT EXISTS DB_Antimafia;

/* Utilizza il database */
USE DB_Antimafia;

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

/* Creazione delle tabelle */
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
    Nome_Giudice VARCHAR(255), -- Aumentato da 16 a 255
    Cognome_Giudice VARCHAR(255), -- Aumentato da 16 a 255
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
    PRIMARY KEY(Nome_Famiglia1, Nome_Famiglia2),
    FOREIGN KEY (Nome_Famiglia1) REFERENCES Famiglia(Nome_Famiglia),
    FOREIGN KEY (Nome_Famiglia2) REFERENCES Famiglia(Nome_Famiglia)
);

CREATE TABLE Detenuto (
    Codice_Fiscale_Detenuto VARCHAR(16) PRIMARY KEY,
    Nome_Detenuto VARCHAR(255),
    Cognome_Detenuto VARCHAR(255),
    Data_Nascita DATE,
    Nome_Famiglia VARCHAR(255),
    ID_Città INT,
    FOREIGN KEY (Nome_Famiglia) REFERENCES Famiglia(Nome_Famiglia),
    FOREIGN KEY (ID_Città) REFERENCES Città(ID_Città)
);

CREATE TABLE Condanna (
    Numero_Sentenza INT PRIMARY KEY,
    Info_Condanna TEXT,
    Data_Condanna DATE,
    Numero_Seriale INT,
    Codice_Fiscale_Giudice VARCHAR(16),
    ID_Pena INT,
    Codice_Fiscale_Detenuto VARCHAR(16),
    ID_Tribunale INT, -- AGGIUNTA COLONNA MANCANTE
    FOREIGN KEY (Numero_Seriale) REFERENCES Processo(Numero_Seriale),
    FOREIGN KEY (Codice_Fiscale_Giudice) REFERENCES Giudice(Codice_Fiscale_Giudice),
    FOREIGN KEY (ID_Tribunale) REFERENCES Tribunale(ID_Tribunale),
    FOREIGN KEY (ID_Pena) REFERENCES Pena(ID_Pena), -- Aggiunto vincolo coerente
    FOREIGN KEY (Codice_Fiscale_Detenuto) REFERENCES Detenuto(Codice_Fiscale_Detenuto) -- Aggiunto vincolo coerente
);

CREATE TABLE Risiede (
    Codice_Fiscale_Giudice VARCHAR(16),
    ID_Tribunale INT,
    Inizio_Operato DATE,
    PRIMARY KEY (Codice_Fiscale_Giudice, ID_Tribunale),
    FOREIGN KEY (Codice_Fiscale_Giudice) REFERENCES Giudice(Codice_Fiscale_Giudice),
    FOREIGN KEY (ID_Tribunale) REFERENCES Tribunale(ID_Tribunale)
);

CREATE TABLE Detenzione (
    Codice_Fiscale_Detenuto VARCHAR(16),
    ID_Carcere INT,
    PRIMARY KEY (Codice_Fiscale_Detenuto, ID_Carcere),
    FOREIGN KEY (Codice_Fiscale_Detenuto) REFERENCES Detenuto(Codice_Fiscale_Detenuto),
    FOREIGN KEY (ID_Carcere) REFERENCES Carcere(ID_Carcere)
);

CREATE TABLE Programma_di_Reinserimento (
    Nome_Progetto VARCHAR(255) PRIMARY KEY,
    Tipo_Programma VARCHAR(255),
    Durata_Programma INT,
    Codice_Fiscale_Detenuto VARCHAR(16),
    FOREIGN KEY (Codice_Fiscale_Detenuto) REFERENCES Detenuto(Codice_Fiscale_Detenuto)
);

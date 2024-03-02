DROP TABLE Vinyl;

DROP TABLE Caseta;

DROP TABLE CD;

DROP TABLE Chitara;

DROP TABLE Orga;

DROP TABLE Instrumente;

DROP TABLE Audio;

DROP TABLE Recomandari;

DROP TABLE Preferinte;

DROP TABLE CosCumparaturi;

DROP TABLE Produse;

DROP TABLE Utilizator;

-- Tabela Utilizator
CREATE TABLE Utilizator (
    UserId INT PRIMARY KEY,
    Nume VARCHAR(50) NOT NULL,
    Prenume VARCHAR(50) NOT NULL,
    Email VARCHAR(50) NOT NULL,
    Telefon VARCHAR(15) NOT NULL,
    Data_Inregistrare DATE
);

-- Tabela Produse
CREATE TABLE Produse (
    ProdusId INT PRIMARY KEY,
    DenumireProdus VARCHAR(50) NOT NULL,
    Pret DECIMAL(10, 2),
    Stoc INT,
    Data_Inregistrare DATE
);

-- Tabela CosCumparaturi
CREATE TABLE CosCumparaturi (
    UserId_FK1 INT,
    ProdusId_FK1 INT,
    FOREIGN KEY (UserId_FK1) REFERENCES Utilizator(UserId),
    FOREIGN KEY (ProdusId_FK1) REFERENCES Produse(ProdusId),
    PRIMARY KEY (UserId_FK1, ProdusId_FK1)
);

-- Tabela Preferinte
CREATE TABLE Preferinte (
    PreferintaId INT PRIMARY KEY,
    UserId_FK2 INT,
    PreferintaProdusId INT,
    FOREIGN KEY (UserId_FK2) REFERENCES Utilizator(UserId),
    FOREIGN KEY (PreferintaProdusId) REFERENCES Produse(ProdusId)
);

-- Tabela Recomandari
CREATE TABLE Recomandari (
    RecomandareId INT PRIMARY KEY,
    RecomandareProdusId INT,
    UserId_FK3 INT,
    FOREIGN KEY (UserId_FK3) REFERENCES Utilizator(UserId),
    FOREIGN KEY (RecomandareProdusId) REFERENCES Produse(ProdusId)
);

-- Tabela Instrumente
CREATE TABLE Instrumente (
    InstrumentId INT PRIMARY KEY,
    ProdusId_FK4 INT,
    FOREIGN KEY (ProdusId_FK4) REFERENCES Produse(ProdusId)
);

-- Tabela Artist
CREATE TABLE Artist (
    ArtistId INT PRIMARY KEY,
    NumeArtist VARCHAR(50) NOT NULL
);

-- Tabela Audio
CREATE TABLE Audio (
    AudioId INT PRIMARY KEY,
    ProdusId_FK5 INT,
    FOREIGN KEY (ProdusId_FK5) REFERENCES Produse(ProdusId)
);

-- Tabela Chitara
CREATE TABLE Chitara (
    ChitaraId INT PRIMARY KEY,
    Material VARCHAR(50) NOT NULL,
    InstrumentId_FK6 INT,
    FOREIGN KEY (InstrumentId_FK6) REFERENCES Instrumente(InstrumentId)
);

-- Tabela Orga
CREATE TABLE Orga (
    OrgaId INT PRIMARY KEY,
    TipOrga VARCHAR(50) NOT NULL,
    InstrumentId_FK7 INT,
    FOREIGN KEY (InstrumentId_FK7) REFERENCES Instrumente(InstrumentId)
);

-- Tabela CD
CREATE TABLE CD (
    CDId INT PRIMARY KEY,
    TitluCD VARCHAR(70) NOT NULL,
    Gen VARCHAR(20) NOT NULL,
    ArtistId_FK8 INT,
    AudioId_FK8 INT,
    FOREIGN KEY (AudioId_FK8) REFERENCES Audio(AudioId),
    FOREIGN KEY (ArtistId_FK8) REFERENCES Artist(ArtistId)
);

-- Tabela Vinyl
CREATE TABLE Vinyl (
    VinylId INT PRIMARY KEY,
    TitluVinyl VARCHAR(70) NOT NULL,
    Gen VARCHAR(20) NOT NULL,
    ArtistId_FK9 INT,
    AudioId_FK9 INT,
    FOREIGN KEY (AudioId_FK9) REFERENCES Audio(AudioId),
    FOREIGN KEY (ArtistId_FK9) REFERENCES Artist(ArtistId)
);

-- Tabela Caseta
CREATE TABLE Caseta (
    CasetaId INT PRIMARY KEY,
    TitluCaseta VARCHAR(70) NOT NULL,
    Gen VARCHAR(20) NOT NULL,
    ArtistId_FK10 INT,
    AudioId_FK10 INT,
    FOREIGN KEY (AudioId_FK10) REFERENCES Audio(AudioId),
    FOREIGN KEY (ArtistId_FK10) REFERENCES Artist(ArtistId)
);

-- Adaugare constrangeri de integritate pentru tabela Utilizator
ALTER TABLE Utilizator
ADD CONSTRAINT chk_Email_Format CHECK (Email LIKE '%_@__%.__%');

-- Adaugare constrangeri de integritate pentru tabela Produse
ALTER TABLE Produse
ADD CONSTRAINT chk_Pret_NonNegative CHECK (Pret >= 0);

-- Inserare valori pentru tabela Utilizator
INSERT INTO Utilizator (UserId, Nume, Prenume, Email, Telefon, Data_Inregistrare)
VALUES (1,'Popescu','Ion','popescu.ion@example.com','0721123456',TO_DATE('2022-01-01', 'YYYY-MM-DD'));

INSERT INTO Utilizator (UserId, Nume, Prenume, Email, Telefon, Data_Inregistrare)
VALUES (2,'Ionescu','Maria','ionescu.maria@example.com','0732123456',TO_DATE('2022-01-02', 'YYYY-MM-DD'));

INSERT INTO Utilizator (UserId, Nume, Prenume, Email, Telefon, Data_Inregistrare)
VALUES (3,'Radulescu','Ana','radulescu.ana@example.com','0745123456',TO_DATE('2022-01-03', 'YYYY-MM-DD'));

INSERT INTO Utilizator (UserId, Nume, Prenume, Email, Telefon, Data_Inregistrare)
VALUES (4,'Dumitrescu','Mihai','dumitrescu.mihai@example.com','0756123456',TO_DATE('2022-01-04', 'YYYY-MM-DD'));

INSERT INTO Utilizator (UserId, Nume, Prenume, Email, Telefon, Data_Inregistrare)
VALUES (5,'Georgescu','Elena','georgescu.elena@example.com','0767123456',TO_DATE('2022-01-05', 'YYYY-MM-DD'));

INSERT INTO Utilizator (UserId, Nume, Prenume, Email, Telefon, Data_Inregistrare)
VALUES (6,'Constantinescu','Andrei','constantinescu.andrei@example.com','0778123456',TO_DATE('2022-01-06', 'YYYY-MM-DD'));

INSERT INTO Utilizator (UserId, Nume, Prenume, Email, Telefon, Data_Inregistrare)
VALUES (7,'Gheorghiu','Ioana','gheorghiu.ioana@example.com','0789123456',TO_DATE('2022-01-07', 'YYYY-MM-DD'));

INSERT INTO Utilizator (UserId, Nume, Prenume, Email, Telefon, Data_Inregistrare)
VALUES (8,'Iacob','Cristina','iacob.cristina@example.com','0790123456',TO_DATE('2022-01-08', 'YYYY-MM-DD'));

INSERT INTO Utilizator (UserId, Nume, Prenume, Email, Telefon, Data_Inregistrare)
VALUES (9,'Florescu','Alexandru','florescu.alexandru@example.com','0701123456',TO_DATE('2022-01-09', 'YYYY-MM-DD'));

-- Inserare valori pentru tabela Utilizator
INSERT INTO Utilizator (UserId, Nume, Prenume, Email, Telefon, Data_Inregistrare)
VALUES (10,'Vasilescu','Raluca','vasilescu.raluca@example.com','0712123456',TO_DATE('2022-01-10', 'YYYY-MM-DD'));

-- Adaugare produs 1
INSERT INTO Produse (ProdusId, DenumireProdus, Pret, Stoc, Data_Inregistrare)
VALUES (1, 'Chitara Fender Stratocaster', 29.99, 50, TO_DATE('2024-01-12', 'YYYY-MM-DD'));

-- Adaugare produs 2
INSERT INTO Produse (ProdusId, DenumireProdus, Pret, Stoc, Data_Inregistrare)
VALUES (2, 'Chitara Gibson Les Paul', 49.99, 30, TO_DATE('2024-01-12', 'YYYY-MM-DD'));

-- Adaugare produs 3
INSERT INTO Produse (ProdusId, DenumireProdus, Pret, Stoc, Data_Inregistrare)
VALUES (3, 'Chitara Yamaha Acustica', 19.99, 20, TO_DATE('2024-01-13', 'YYYY-MM-DD'));

-- Adaugare produs 4
INSERT INTO Produse (ProdusId, DenumireProdus, Pret, Stoc, Data_Inregistrare)
VALUES (4, 'Chitara Ibanez Electrica', 39.99, 10, TO_DATE('2024-01-13', 'YYYY-MM-DD'));

-- Adaugare produs 5
INSERT INTO Produse (ProdusId, DenumireProdus, Pret, Stoc, Data_Inregistrare)
VALUES (5, 'Chitara Martin Dreadnought', 59.99, 5, TO_DATE('2024-01-14', 'YYYY-MM-DD'));

-- Adaugare produs 6
INSERT INTO Produse (ProdusId, DenumireProdus, Pret, Stoc, Data_Inregistrare)
VALUES (6, 'Chitara Taylor Grand Auditorium', 79.99, 15, TO_DATE('2024-01-14', 'YYYY-MM-DD'));

-- Adaugare produs 7
INSERT INTO Produse (ProdusId, DenumireProdus, Pret, Stoc, Data_Inregistrare)
VALUES (7, 'Chitara PRS Custom 24', 99.99, 25, TO_DATE('2024-01-15', 'YYYY-MM-DD'));

-- Adaugare produs 8
INSERT INTO Produse (ProdusId, DenumireProdus, Pret, Stoc, Data_Inregistrare)
VALUES (8, 'Chitara Epiphone SG', 69.99, 35, TO_DATE('2024-01-15', 'YYYY-MM-DD'));

-- Adaugare produs 9
INSERT INTO Produse (ProdusId, DenumireProdus, Pret, Stoc, Data_Inregistrare)
VALUES (9, 'Chitara Washburn Folk', 89.99, 40, TO_DATE('2024-01-16', 'YYYY-MM-DD'));

-- Adaugare produs 10
INSERT INTO Produse (ProdusId, DenumireProdus, Pret, Stoc, Data_Inregistrare)
VALUES (10, 'Chitara Jackson Soloist', 109.99, 12, TO_DATE('2024-01-16', 'YYYY-MM-DD'));

-- Adaugare produs 60
INSERT INTO Produse (ProdusId, DenumireProdus, Pret, Stoc, Data_Inregistrare)
VALUES (51, 'Chitara Fender Stratocaster 2', 29.99, 50, TO_DATE('2024-01-17', 'YYYY-MM-DD'));

-- Adaugare produs 61
INSERT INTO Produse (ProdusId, DenumireProdus, Pret, Stoc, Data_Inregistrare)
VALUES (52, 'Chitara Gibson Les Paul 2', 49.99, 30, TO_DATE('2024-01-17', 'YYYY-MM-DD'));

-- Adaugare produs 11
INSERT INTO Produse (ProdusId, DenumireProdus, Pret, Stoc, Data_Inregistrare)
VALUES (11, 'Orga Yamaha Stage Piano', 119.99, 18, TO_DATE('2024-01-17', 'YYYY-MM-DD'));

-- Adaugare produs 12
INSERT INTO Produse (ProdusId, DenumireProdus, Pret, Stoc, Data_Inregistrare)
VALUES (12, 'Orga Roland Digital', 129.99, 22, TO_DATE('2024-01-17', 'YYYY-MM-DD'));

-- Adaugare produs 13
INSERT INTO Produse (ProdusId, DenumireProdus, Pret, Stoc, Data_Inregistrare)
VALUES (13, 'Orga Korg Workstation', 139.99, 27, TO_DATE('2024-01-18', 'YYYY-MM-DD'));

-- Adaugare produs 14
INSERT INTO Produse (ProdusId, DenumireProdus, Pret, Stoc, Data_Inregistrare)
VALUES (14, 'Orga Casio Portable', 149.99, 33, TO_DATE('2024-01-18', 'YYYY-MM-DD'));

-- Adaugare produs 15
INSERT INTO Produse (ProdusId, DenumireProdus, Pret, Stoc, Data_Inregistrare)
VALUES (15, 'Orga Nord Electro', 159.99, 8, TO_DATE('2024-01-19', 'YYYY-MM-DD'));

-- Adaugare produs 16
INSERT INTO Produse (ProdusId, DenumireProdus, Pret, Stoc, Data_Inregistrare)
VALUES (16, 'Orga Hammond B3', 169.99, 14, TO_DATE('2024-01-19', 'YYYY-MM-DD'));

-- Adaugare produs 17
INSERT INTO Produse (ProdusId, DenumireProdus, Pret, Stoc, Data_Inregistrare)
VALUES (17, 'Orga Kawai Concert', 179.99, 19, TO_DATE('2024-01-20', 'YYYY-MM-DD'));

-- Adaugare produs 18
INSERT INTO Produse (ProdusId, DenumireProdus, Pret, Stoc, Data_Inregistrare)
VALUES (18, 'Orga Kurzweil Stage', 189.99, 24, TO_DATE('2024-01-20', 'YYYY-MM-DD'));

-- Adaugare produs 19
INSERT INTO Produse (ProdusId, DenumireProdus, Pret, Stoc, Data_Inregistrare)
VALUES (19, 'Orga Clavia Nord Stage', 199.99, 29, TO_DATE('2024-01-21', 'YYYY-MM-DD'));

-- Adaugare produs 20
INSERT INTO Produse (ProdusId, DenumireProdus, Pret, Stoc, Data_Inregistrare)
VALUES (20, 'Orga Yamaha Portable', 209.99, 34, TO_DATE('2024-01-21', 'YYYY-MM-DD'));


-- Adaugare 10 produse pentru Orga in tabela Instrumente
-- Adaugare instrument 1
INSERT INTO Instrumente (InstrumentId, ProdusId_FK4)
VALUES (1, 1);

-- Adaugare instrument 2
INSERT INTO Instrumente (InstrumentId, ProdusId_FK4)
VALUES (2, 2);

-- Adaugare instrument 3
INSERT INTO Instrumente (InstrumentId, ProdusId_FK4)
VALUES (3, 3);

-- Adaugare instrument 4
INSERT INTO Instrumente (InstrumentId, ProdusId_FK4)
VALUES (4, 4);

-- Adaugare instrument 5
INSERT INTO Instrumente (InstrumentId, ProdusId_FK4)
VALUES (5, 5);

-- Adaugare instrument 6
INSERT INTO Instrumente (InstrumentId, ProdusId_FK4)
VALUES (6, 6);

-- Adaugare instrument 7
INSERT INTO Instrumente (InstrumentId, ProdusId_FK4)
VALUES (7, 7);

-- Adaugare instrument 8
INSERT INTO Instrumente (InstrumentId, ProdusId_FK4)
VALUES (8, 8);

-- Adaugare instrument 9
INSERT INTO Instrumente (InstrumentId, ProdusId_FK4)
VALUES (9, 9);

-- Adaugare instrument 10
INSERT INTO Instrumente (InstrumentId, ProdusId_FK4)
VALUES (10, 10);

-- Adaugare produs pentru Orga Yamaha Stage Piano
INSERT INTO Instrumente (InstrumentId, ProdusId_FK4)
VALUES (11, 11);

-- Adaugare produs pentru Orga Roland Digital
INSERT INTO Instrumente (InstrumentId, ProdusId_FK4)
VALUES (12, 12);

-- Adaugare produs pentru Orga Korg Workstation
INSERT INTO Instrumente (InstrumentId, ProdusId_FK4)
VALUES (13, 13);

-- Adaugare produs pentru Orga Casio Portable
INSERT INTO Instrumente (InstrumentId, ProdusId_FK4)
VALUES (14, 14);

-- Adaugare produs pentru Orga Nord Electro
INSERT INTO Instrumente (InstrumentId, ProdusId_FK4)
VALUES (15, 15);

-- Adaugare produs pentru Orga Hammond B3
INSERT INTO Instrumente (InstrumentId, ProdusId_FK4)
VALUES (16, 16);

-- Adaugare produs pentru Orga Kawai Concert
INSERT INTO Instrumente (InstrumentId, ProdusId_FK4)
VALUES (17, 17);

-- Adaugare produs pentru Orga Kurzweil Stage
INSERT INTO Instrumente (InstrumentId, ProdusId_FK4)
VALUES (18, 18);

-- Adaugare produs pentru Orga Clavia Nord Stage
INSERT INTO Instrumente (InstrumentId, ProdusId_FK4)
VALUES (19, 19);

-- Adaugare produs pentru Orga Yamaha Portable
INSERT INTO Instrumente (InstrumentId, ProdusId_FK4)
VALUES (20, 20);

-- Adaugare instrument 21
INSERT INTO Instrumente (InstrumentId, ProdusId_FK4)
VALUES (21, 51);

-- Adaugare instrument 22
INSERT INTO Instrumente (InstrumentId, ProdusId_FK4)
VALUES (22, 52);

-- Adaugare produs pentru Chitara Fender Stratocaster
INSERT INTO Chitara (ChitaraId, Material, InstrumentId_FK6)
VALUES (1, 'Cedar', 1);

-- Adaugare produs pentru Chitara Gibson Les Paul
INSERT INTO Chitara (ChitaraId, Material, InstrumentId_FK6)
VALUES (2, 'Cedar', 2);

-- Adaugare produs pentru Chitara Yamaha Acustica
INSERT INTO Chitara (ChitaraId, Material, InstrumentId_FK6)
VALUES (3, 'Spruce', 3);

-- Adaugare produs pentru Chitara Ibanez Electrica
INSERT INTO Chitara (ChitaraId, Material, InstrumentId_FK6)
VALUES (4, 'Spruce', 4);

-- Adaugare produs pentru Chitara Martin Dreadnought
INSERT INTO Chitara (ChitaraId, Material, InstrumentId_FK6)
VALUES (5, 'Rosewood', 5);

-- Adaugare produs pentru Chitara Taylor Grand Auditorium
INSERT INTO Chitara (ChitaraId, Material, InstrumentId_FK6)
VALUES (6, 'Cedar', 6);

-- Adaugare produs pentru Chitara PRS Custom 24
INSERT INTO Chitara (ChitaraId, Material, InstrumentId_FK6)
VALUES (7, 'Rosewood', 7);

-- Adaugare produs pentru Chitara Epiphone SG
INSERT INTO Chitara (ChitaraId, Material, InstrumentId_FK6)
VALUES (8, 'Rosewood', 8);

-- Adaugare produs pentru Chitara Washburn Folk
INSERT INTO Chitara (ChitaraId, Material, InstrumentId_FK6)
VALUES (9, 'Cedar', 9);

-- Adaugare produs pentru Chitara Jackson Soloist
INSERT INTO Chitara (ChitaraId, Material, InstrumentId_FK6)
VALUES (10, 'Spruce', 10);

INSERT INTO Chitara (ChitaraId, Material, InstrumentId_FK6)
VALUES (11, 'Rosewood', 21);

-- Adaugare produs pentru Chitara Gibson Les Paul
INSERT INTO Chitara (ChitaraId, Material, InstrumentId_FK6)
VALUES (12, 'Rosewood', 22);

-- Adaugare produs pentru Orga Yamaha Stage Piano
INSERT INTO Orga (OrgaId, TipOrga, InstrumentId_FK7)
VALUES (1, 'Digitala', 11);

-- Adaugare produs pentru Orga Roland Digital
INSERT INTO Orga (OrgaId, TipOrga, InstrumentId_FK7)
VALUES (2, 'Portable', 12);

-- Adaugare produs pentru Orga Korg Workstation
INSERT INTO Orga (OrgaId, TipOrga, InstrumentId_FK7)
VALUES (3, 'Portable', 13);

-- Adaugare produs pentru Orga Casio Portable
INSERT INTO Orga (OrgaId, TipOrga, InstrumentId_FK7)
VALUES (4, 'Portable', 14);

-- Adaugare produs pentru Orga Nord Electro
INSERT INTO Orga (OrgaId, TipOrga, InstrumentId_FK7)
VALUES (5, 'Synthesizer', 15);

-- Adaugare produs pentru Orga Hammond B3
INSERT INTO Orga (OrgaId, TipOrga, InstrumentId_FK7)
VALUES (6, 'Synthesizer', 16);

-- Adaugare produs pentru Orga Kawai Concert
INSERT INTO Orga (OrgaId, TipOrga, InstrumentId_FK7)
VALUES (7, 'Synthesizer', 17);

-- Adaugare produs pentru Orga Kurzweil Stage
INSERT INTO Orga (OrgaId, TipOrga, InstrumentId_FK7)
VALUES (8, 'Digitala', 18);

-- Adaugare produs pentru Orga Clavia Nord Stage
INSERT INTO Orga (OrgaId, TipOrga, InstrumentId_FK7)
VALUES (9, 'Synthesizer', 19);

-- Adaugare produs pentru Orga Yamaha Portable
INSERT INTO Orga (OrgaId, TipOrga, InstrumentId_FK7)
VALUES (10, 'Digitala', 20);

-- Adaugare produs pentru CD Muzica
INSERT INTO Produse (ProdusId, DenumireProdus, Pret, Stoc, Data_Inregistrare)
VALUES 
    (21, 'CD Muzica', 12.99, 50, TO_DATE('2024-01-22', 'YYYY-MM-DD'));

INSERT INTO Produse (ProdusId, DenumireProdus, Pret, Stoc, Data_Inregistrare)
VALUES 
    (22, 'CD Muzica', 13.99, 30, TO_DATE('2024-01-22', 'YYYY-MM-DD'));

INSERT INTO Produse (ProdusId, DenumireProdus, Pret, Stoc, Data_Inregistrare)
VALUES 
    (23, 'CD Muzica', 12.59, 20, TO_DATE('2024-01-23', 'YYYY-MM-DD'));

INSERT INTO Produse (ProdusId, DenumireProdus, Pret, Stoc, Data_Inregistrare)
VALUES 
    (24, 'CD Muzica', 13.59, 10, TO_DATE('2024-01-23', 'YYYY-MM-DD'));

INSERT INTO Produse (ProdusId, DenumireProdus, Pret, Stoc, Data_Inregistrare)
VALUES 
    (25, 'CD Muzica', 14.09, 30, TO_DATE('2024-01-24', 'YYYY-MM-DD'));

INSERT INTO Produse (ProdusId, DenumireProdus, Pret, Stoc, Data_Inregistrare)
VALUES 
    (26, 'CD Muzica', 14.99, 15, TO_DATE('2024-01-24', 'YYYY-MM-DD'));

INSERT INTO Produse (ProdusId, DenumireProdus, Pret, Stoc, Data_Inregistrare)
VALUES 
    (27, 'CD Muzica', 15.99, 25, TO_DATE('2024-01-25', 'YYYY-MM-DD'));

INSERT INTO Produse (ProdusId, DenumireProdus, Pret, Stoc, Data_Inregistrare)
VALUES 
    (28, 'CD Muzica', 14.59, 35, TO_DATE('2024-01-25', 'YYYY-MM-DD'));

INSERT INTO Produse (ProdusId, DenumireProdus, Pret, Stoc, Data_Inregistrare)
VALUES 
    (29, 'CD Muzica', 12.09, 40, TO_DATE('2024-01-26', 'YYYY-MM-DD'));

INSERT INTO Produse (ProdusId, DenumireProdus, Pret, Stoc, Data_Inregistrare)
VALUES 
    (30, 'CD Muzica', 13.09, 22, TO_DATE('2024-01-26', 'YYYY-MM-DD'));

-- Adaugare produs pentru Vinyl Muzica
INSERT INTO Produse (ProdusId, DenumireProdus, Pret, Stoc, Data_Inregistrare)
VALUES 
    (31, 'Vinyl Muzica', 39.99, 30, TO_DATE('2024-01-27', 'YYYY-MM-DD'));

INSERT INTO Produse (ProdusId, DenumireProdus, Pret, Stoc, Data_Inregistrare)
VALUES 
    (32, 'Vinyl Muzica', 42.99, 18, TO_DATE('2024-01-27', 'YYYY-MM-DD'));

INSERT INTO Produse (ProdusId, DenumireProdus, Pret, Stoc, Data_Inregistrare)
VALUES 
    (33, 'Vinyl Muzica', 45.99, 25, TO_DATE('2024-01-28', 'YYYY-MM-DD'));

INSERT INTO Produse (ProdusId, DenumireProdus, Pret, Stoc, Data_Inregistrare)
VALUES 
    (34, 'Vinyl Muzica', 49.99, 12, TO_DATE('2024-01-28', 'YYYY-MM-DD'));

INSERT INTO Produse (ProdusId, DenumireProdus, Pret, Stoc, Data_Inregistrare)
VALUES 
    (35, 'Vinyl Muzica', 52.99, 20, TO_DATE('2024-01-29', 'YYYY-MM-DD'));

INSERT INTO Produse (ProdusId, DenumireProdus, Pret, Stoc, Data_Inregistrare)
VALUES 
    (36, 'Vinyl Muzica', 55.99, 28, TO_DATE('2024-01-29', 'YYYY-MM-DD'));

INSERT INTO Produse (ProdusId, DenumireProdus, Pret, Stoc, Data_Inregistrare)
VALUES 
    (37, 'Vinyl Muzica', 59.99, 15, TO_DATE('2024-01-30', 'YYYY-MM-DD'));

INSERT INTO Produse (ProdusId, DenumireProdus, Pret, Stoc, Data_Inregistrare)
VALUES 
    (38, 'Vinyl Muzica', 62.99, 10, TO_DATE('2024-01-30', 'YYYY-MM-DD'));

INSERT INTO Produse (ProdusId, DenumireProdus, Pret, Stoc, Data_Inregistrare)
VALUES 
    (39, 'Vinyl Muzica', 65.99, 18, TO_DATE('2024-01-31', 'YYYY-MM-DD'));

INSERT INTO Produse (ProdusId, DenumireProdus, Pret, Stoc, Data_Inregistrare)
VALUES 
    (40, 'Vinyl Muzica', 69.99, 23, TO_DATE('2024-01-31', 'YYYY-MM-DD'));


-- Adaugare produs pentru Caseta Muzica
INSERT INTO Produse (ProdusId, DenumireProdus, Pret, Stoc, Data_Inregistrare)
VALUES 
    (41, 'Caseta Muzica', 5.99, 40, TO_DATE('2024-02-01', 'YYYY-MM-DD'));

INSERT INTO Produse (ProdusId, DenumireProdus, Pret, Stoc, Data_Inregistrare)
VALUES 
    (42, 'Caseta Muzica', 6.99, 25, TO_DATE('2024-02-01', 'YYYY-MM-DD'));

INSERT INTO Produse (ProdusId, DenumireProdus, Pret, Stoc, Data_Inregistrare)
VALUES 
    (43, 'Caseta Muzica', 4.99, 30, TO_DATE('2024-02-02', 'YYYY-MM-DD'));

INSERT INTO Produse (ProdusId, DenumireProdus, Pret, Stoc, Data_Inregistrare)
VALUES 
    (44, 'Caseta Muzica', 3.99, 15, TO_DATE('2024-02-02', 'YYYY-MM-DD'));

INSERT INTO Produse (ProdusId, DenumireProdus, Pret, Stoc, Data_Inregistrare)
VALUES 
    (45, 'Caseta Muzica', 8.99, 22, TO_DATE('2024-02-03', 'YYYY-MM-DD'));

INSERT INTO Produse (ProdusId, DenumireProdus, Pret, Stoc, Data_Inregistrare)
VALUES 
    (46, 'Caseta Muzica', 3.59, 28, TO_DATE('2024-02-03', 'YYYY-MM-DD'));

INSERT INTO Produse (ProdusId, DenumireProdus, Pret, Stoc, Data_Inregistrare)
VALUES 
    (47, 'Caseta Muzica', 4.59, 12, TO_DATE('2024-02-04', 'YYYY-MM-DD'));

INSERT INTO Produse (ProdusId, DenumireProdus, Pret, Stoc, Data_Inregistrare)
VALUES 
    (48, 'Caseta Muzica', 7.99, 20, TO_DATE('2024-02-04', 'YYYY-MM-DD'));

INSERT INTO Produse (ProdusId, DenumireProdus, Pret, Stoc, Data_Inregistrare)
VALUES 
    (49, 'Caseta Muzica', 10.09, 18, TO_DATE('2024-02-05', 'YYYY-MM-DD'));

INSERT INTO Produse (ProdusId, DenumireProdus, Pret, Stoc, Data_Inregistrare)
VALUES 
    (50, 'Caseta Muzica', 2.99, 10, TO_DATE('2024-02-05', 'YYYY-MM-DD'));

INSERT INTO Artist (ArtistId, NumeArtist) VALUES (1, 'John Mayer');
INSERT INTO Artist (ArtistId, NumeArtist) VALUES (2, 'Adele');
INSERT INTO Artist (ArtistId, NumeArtist) VALUES (3, 'Ed Sheeran');
INSERT INTO Artist (ArtistId, NumeArtist) VALUES (4, 'Beyoncé');
INSERT INTO Artist (ArtistId, NumeArtist) VALUES (5, 'Taylor Swift');
INSERT INTO Artist (ArtistId, NumeArtist) VALUES (6, 'Drake');
INSERT INTO Artist (ArtistId, NumeArtist) VALUES (7, 'Coldplay');
INSERT INTO Artist (ArtistId, NumeArtist) VALUES (8, 'Lady Gaga');
INSERT INTO Artist (ArtistId, NumeArtist) VALUES (9, 'Bruno Mars');
INSERT INTO Artist (ArtistId, NumeArtist) VALUES (10, 'Katy Perry');
INSERT INTO Artist (ArtistId, NumeArtist) VALUES (11, 'Eminem');
INSERT INTO Artist (ArtistId, NumeArtist) VALUES (12, 'Rihanna');
INSERT INTO Artist (ArtistId, NumeArtist) VALUES (13, 'Justin Bieber');
INSERT INTO Artist (ArtistId, NumeArtist) VALUES (14, 'Ariana Grande');
INSERT INTO Artist (ArtistId, NumeArtist) VALUES (15, 'Michael Jackson');
INSERT INTO Artist (ArtistId, NumeArtist) VALUES (16, 'Queen');
INSERT INTO Artist (ArtistId, NumeArtist) VALUES (17, 'Elton John');
INSERT INTO Artist (ArtistId, NumeArtist) VALUES (18, 'The Beatles');
INSERT INTO Artist (ArtistId, NumeArtist) VALUES (19, 'Bob Marley');
INSERT INTO Artist (ArtistId, NumeArtist) VALUES (20, 'David Bowie');
INSERT INTO Artist (ArtistId, NumeArtist) VALUES (21, 'Prince');
INSERT INTO Artist (ArtistId, NumeArtist) VALUES (22, 'Whitney Houston');
INSERT INTO Artist (ArtistId, NumeArtist) VALUES (23, 'Frank Sinatra');
INSERT INTO Artist (ArtistId, NumeArtist) VALUES (24, 'Dua Lipa');
INSERT INTO Artist (ArtistId, NumeArtist) VALUES (25, 'Billie Eilish');
INSERT INTO Artist (ArtistId, NumeArtist) VALUES (26, 'Travis Scott');
INSERT INTO Artist (ArtistId, NumeArtist) VALUES (27, 'Post Malone');
INSERT INTO Artist (ArtistId, NumeArtist) VALUES (28, 'Lil Nas X');
INSERT INTO Artist (ArtistId, NumeArtist) VALUES (29, 'Cardi B');
INSERT INTO Artist (ArtistId, NumeArtist) VALUES (30, 'The Weeknd');

INSERT INTO Audio (AudioId, ProdusId_FK5) VALUES (1, 21);
INSERT INTO Audio (AudioId, ProdusId_FK5) VALUES (2, 22);
INSERT INTO Audio (AudioId, ProdusId_FK5) VALUES (3, 23);
INSERT INTO Audio (AudioId, ProdusId_FK5) VALUES (4, 24);
INSERT INTO Audio (AudioId, ProdusId_FK5) VALUES (5, 25);
INSERT INTO Audio (AudioId, ProdusId_FK5) VALUES (6, 26);
INSERT INTO Audio (AudioId, ProdusId_FK5) VALUES (7, 27);
INSERT INTO Audio (AudioId, ProdusId_FK5) VALUES (8, 28);
INSERT INTO Audio (AudioId, ProdusId_FK5) VALUES (9, 29);
INSERT INTO Audio (AudioId, ProdusId_FK5) VALUES (10, 30);
INSERT INTO Audio (AudioId, ProdusId_FK5) VALUES (11, 31);
INSERT INTO Audio (AudioId, ProdusId_FK5) VALUES (12, 32);
INSERT INTO Audio (AudioId, ProdusId_FK5) VALUES (13, 33);
INSERT INTO Audio (AudioId, ProdusId_FK5) VALUES (14, 34);
INSERT INTO Audio (AudioId, ProdusId_FK5) VALUES (15, 35);
INSERT INTO Audio (AudioId, ProdusId_FK5) VALUES (16, 36);
INSERT INTO Audio (AudioId, ProdusId_FK5) VALUES (17, 37);
INSERT INTO Audio (AudioId, ProdusId_FK5) VALUES (18, 38);
INSERT INTO Audio (AudioId, ProdusId_FK5) VALUES (19, 39);
INSERT INTO Audio (AudioId, ProdusId_FK5) VALUES (20, 40);
INSERT INTO Audio (AudioId, ProdusId_FK5) VALUES (21, 41);
INSERT INTO Audio (AudioId, ProdusId_FK5) VALUES (22, 42);
INSERT INTO Audio (AudioId, ProdusId_FK5) VALUES (23, 43);
INSERT INTO Audio (AudioId, ProdusId_FK5) VALUES (24, 44);
INSERT INTO Audio (AudioId, ProdusId_FK5) VALUES (25, 45);
INSERT INTO Audio (AudioId, ProdusId_FK5) VALUES (26, 46);
INSERT INTO Audio (AudioId, ProdusId_FK5) VALUES (27, 47);
INSERT INTO Audio (AudioId, ProdusId_FK5) VALUES (28, 48);
INSERT INTO Audio (AudioId, ProdusId_FK5) VALUES (29, 49);
INSERT INTO Audio (AudioId, ProdusId_FK5) VALUES (30, 50);

INSERT INTO CD (CDId, TitluCD, Gen, ArtistId_FK8, AudioId_FK8) VALUES (1, 'John Mayer - Continuum', 'Rock', 1, 1);
INSERT INTO CD (CDId, TitluCD, Gen, ArtistId_FK8, AudioId_FK8) VALUES (2, 'Adele - 21', 'Pop', 2, 2);
INSERT INTO CD (CDId, TitluCD, Gen, ArtistId_FK8, AudioId_FK8) VALUES (3, 'Ed Sheeran - ÷', 'Pop', 3, 3);
INSERT INTO CD (CDId, TitluCD, Gen, ArtistId_FK8, AudioId_FK8) VALUES (4, 'Beyoncé - Lemonade', 'RnB', 4, 4);
INSERT INTO CD (CDId, TitluCD, Gen, ArtistId_FK8, AudioId_FK8) VALUES (5, 'Taylor Swift - 1989', 'Pop', 5, 5);
INSERT INTO CD (CDId, TitluCD, Gen, ArtistId_FK8, AudioId_FK8) VALUES (6, 'Drake - Views', 'Rap', 6, 6);
INSERT INTO CD (CDId, TitluCD, Gen, ArtistId_FK8, AudioId_FK8) VALUES (7, 'Coldplay - A Head Full of Dreams', 'Pop', 7, 7);
INSERT INTO CD (CDId, TitluCD, Gen, ArtistId_FK8, AudioId_FK8) VALUES (8, 'Lady Gaga - The Fame', 'Pop', 8, 8);
INSERT INTO CD (CDId, TitluCD, Gen, ArtistId_FK8, AudioId_FK8) VALUES (9, 'Bruno Mars - 24K Magic', 'Pop', 9, 9);
INSERT INTO CD (CDId, TitluCD, Gen, ArtistId_FK8, AudioId_FK8) VALUES (10, 'Katy Perry - Teenage Dream', 'Pop', 10, 5);
INSERT INTO CD (CDId, TitluCD, Gen, ArtistId_FK8, AudioId_FK8) VALUES (11, 'Eminem - The Marshall Mathers LP', 'Rap', 11, 7);
INSERT INTO CD (CDId, TitluCD, Gen, ArtistId_FK8, AudioId_FK8) VALUES (12, 'Rihanna - Anti', 'RnB', 12, 1);
INSERT INTO CD (CDId, TitluCD, Gen, ArtistId_FK8, AudioId_FK8) VALUES (13, 'Justin Bieber - Purpose', 'Pop', 13, 3);
INSERT INTO CD (CDId, TitluCD, Gen, ArtistId_FK8, AudioId_FK8) VALUES (14, 'Ariana Grande - Thank U, Next', 'Pop', 14, 4);
INSERT INTO CD (CDId, TitluCD, Gen, ArtistId_FK8, AudioId_FK8) VALUES (15, 'Michael Jackson - Thriller', 'Pop', 15, 4);
INSERT INTO CD (CDId, TitluCD, Gen, ArtistId_FK8, AudioId_FK8) VALUES (16, 'Queen - A Night at the Opera', 'Rock', 16, 5);
INSERT INTO CD (CDId, TitluCD, Gen, ArtistId_FK8, AudioId_FK8) VALUES (17, 'Elton John - Goodbye Yellow Brick Road', 'Rock', 17, 7);
INSERT INTO CD (CDId, TitluCD, Gen, ArtistId_FK8, AudioId_FK8) VALUES (18, 'The Beatles - Sgt. Peppers Lonely Hearts Club Band', 'Rock', 18, 9);
INSERT INTO CD (CDId, TitluCD, Gen, ArtistId_FK8, AudioId_FK8) VALUES (19, 'Bob Marley - Legend', 'Reggae', 19, 10);
INSERT INTO CD (CDId, TitluCD, Gen, ArtistId_FK8, AudioId_FK8) VALUES (20, 'David Bowie - The Rise and Fall of Ziggy Stardust', 'Rock', 20, 1);
INSERT INTO CD (CDId, TitluCD, Gen, ArtistId_FK8, AudioId_FK8) VALUES (21, 'Prince - Purple Rain', 'Pop', 21, 2);
INSERT INTO CD (CDId, TitluCD, Gen, ArtistId_FK8, AudioId_FK8) VALUES (22, 'Whitney Houston - Whitney', 'RnB', 22, 5);
INSERT INTO CD (CDId, TitluCD, Gen, ArtistId_FK8, AudioId_FK8) VALUES (23, 'Frank Sinatra - Songs Swingin Lovers!', 'Jazz', 23, 3);
INSERT INTO CD (CDId, TitluCD, Gen, ArtistId_FK8, AudioId_FK8) VALUES (24, 'Dua Lipa - Future Nostalgia', 'Pop', 24, 4);
INSERT INTO CD (CDId, TitluCD, Gen, ArtistId_FK8, AudioId_FK8) VALUES (25, 'Billie Eilish - When We All Fall Asleep, Where Do We Go?', 'Pop', 25, 5);
INSERT INTO CD (CDId, TitluCD, Gen, ArtistId_FK8, AudioId_FK8) VALUES (26, 'Travis Scott - Astroworld', 'Rap', 26, 6);
INSERT INTO CD (CDId, TitluCD, Gen, ArtistId_FK8, AudioId_FK8) VALUES (27, 'Post Malone - Hollywoods Bleeding', 'Rap', 27, 6);
INSERT INTO CD (CDId, TitluCD, Gen, ArtistId_FK8, AudioId_FK8) VALUES (28, 'Lil Nas X - Montero', 'Rap', 28, 6);
INSERT INTO CD (CDId, TitluCD, Gen, ArtistId_FK8, AudioId_FK8) VALUES (29, 'Cardi B - Invasion of Privacy', 'Rap', 29, 6);
INSERT INTO CD (CDId, TitluCD, Gen, ArtistId_FK8, AudioId_FK8) VALUES (30, 'The Weeknd - After Hours', 'RnB', 30, 9);
INSERT INTO CD (CDId, TitluCD, Gen, ArtistId_FK8, AudioId_FK8) VALUES (31, 'John Mayer - Altceva', 'Rock', 1, 5);

INSERT INTO Vinyl (VinylId, TitluVinyl, Gen, ArtistId_FK9, AudioId_FK9) VALUES (1, 'John Mayer - Continuum - Vinyl', 'Rock', 1, 11);
INSERT INTO Vinyl (VinylId, TitluVinyl, Gen, ArtistId_FK9, AudioId_FK9) VALUES (2, 'Adele - 21 - Vinyl', 'Pop', 2, 12);
INSERT INTO Vinyl (VinylId, TitluVinyl, Gen, ArtistId_FK9, AudioId_FK9) VALUES (3, 'Ed Sheeran - ÷ - Vinyl', 'Pop', 3, 13);
INSERT INTO Vinyl (VinylId, TitluVinyl, Gen, ArtistId_FK9, AudioId_FK9) VALUES (4, 'Beyoncé - Lemonade - Vinyl', 'RnB', 4, 14);
INSERT INTO Vinyl (VinylId, TitluVinyl, Gen, ArtistId_FK9, AudioId_FK9) VALUES (5, 'Taylor Swift - 1989 - Vinyl', 'Pop', 5, 11);
INSERT INTO Vinyl (VinylId, TitluVinyl, Gen, ArtistId_FK9, AudioId_FK9) VALUES (6, 'Drake - Views - Vinyl', 'Rap', 6, 16);
INSERT INTO Vinyl (VinylId, TitluVinyl, Gen, ArtistId_FK9, AudioId_FK9) VALUES (7, 'Coldplay - A Head Full of Dreams - Vinyl', 'Pop', 7, 17);
INSERT INTO Vinyl (VinylId, TitluVinyl, Gen, ArtistId_FK9, AudioId_FK9) VALUES (8, 'Lady Gaga - The Fame - Vinyl', 'Pop', 8, 16);
INSERT INTO Vinyl (VinylId, TitluVinyl, Gen, ArtistId_FK9, AudioId_FK9) VALUES (9, 'Bruno Mars - 24K Magic - Vinyl', 'Pop', 9, 16);
INSERT INTO Vinyl (VinylId, TitluVinyl, Gen, ArtistId_FK9, AudioId_FK9) VALUES (10, 'Katy Perry - Teenage Dream - Vinyl', 'Pop', 10, 20);
INSERT INTO Vinyl (VinylId, TitluVinyl, Gen, ArtistId_FK9, AudioId_FK9) VALUES (11, 'Eminem - The Marshall Mathers LP - Vinyl', 'Rap', 11, 17);
INSERT INTO Vinyl (VinylId, TitluVinyl, Gen, ArtistId_FK9, AudioId_FK9) VALUES (12, 'Rihanna - Anti - Vinyl', 'RnB', 12, 20);
INSERT INTO Vinyl (VinylId, TitluVinyl, Gen, ArtistId_FK9, AudioId_FK9) VALUES (13, 'Justin Bieber - Purpose - Vinyl', 'Pop', 13, 20);
INSERT INTO Vinyl (VinylId, TitluVinyl, Gen, ArtistId_FK9, AudioId_FK9) VALUES (14, 'Ariana Grande - Thank U, Next - Vinyl', 'Pop', 14, 16);
INSERT INTO Vinyl (VinylId, TitluVinyl, Gen, ArtistId_FK9, AudioId_FK9) VALUES (15, 'Michael Jackson - Thriller - Vinyl', 'Pop', 15, 15);
INSERT INTO Vinyl (VinylId, TitluVinyl, Gen, ArtistId_FK9, AudioId_FK9) VALUES (16, 'Queen - A Night at the Opera - Vinyl', 'Rock', 16, 15);
INSERT INTO Vinyl (VinylId, TitluVinyl, Gen, ArtistId_FK9, AudioId_FK9) VALUES (17, 'Elton John - Goodbye Yellow Brick Road - Vinyl', 'Rock', 17, 17);
INSERT INTO Vinyl (VinylId, TitluVinyl, Gen, ArtistId_FK9, AudioId_FK9) VALUES (18, 'The Beatles - Sgt. Peppers Lonely Hearts Club Band - Vinyl', 'Rock', 18, 19);
INSERT INTO Vinyl (VinylId, TitluVinyl, Gen, ArtistId_FK9, AudioId_FK9) VALUES (19, 'Bob Marley - Legend - Vinyl', 'Reggae', 19, 20);
INSERT INTO Vinyl (VinylId, TitluVinyl, Gen, ArtistId_FK9, AudioId_FK9) VALUES (20, 'David Bowie - The Rise and Fall of Ziggy Stardust - Vinyl', 'Rock', 20, 20);
INSERT INTO Vinyl (VinylId, TitluVinyl, Gen, ArtistId_FK9, AudioId_FK9) VALUES (21, 'Prince - Purple Rain - Vinyl', 'Pop', 21, 20);
INSERT INTO Vinyl (VinylId, TitluVinyl, Gen, ArtistId_FK9, AudioId_FK9) VALUES (22, 'Whitney Houston - Whitney - Vinyl', 'RnB', 22, 12);
INSERT INTO Vinyl (VinylId, TitluVinyl, Gen, ArtistId_FK9, AudioId_FK9) VALUES (23, 'Frank Sinatra - Songs Swingin Lovers! - Vinyl', 'Jazz', 23, 13);
INSERT INTO Vinyl (VinylId, TitluVinyl, Gen, ArtistId_FK9, AudioId_FK9) VALUES (24, 'Dua Lipa - Future Nostalgia - Vinyl', 'Pop', 24, 14);
INSERT INTO Vinyl (VinylId, TitluVinyl, Gen, ArtistId_FK9, AudioId_FK9) VALUES (25, 'Billie Eilish - When We All Fall Asleep, Where Do We Go? - Vinyl', 'Pop', 25, 16);
INSERT INTO Vinyl (VinylId, TitluVinyl, Gen, ArtistId_FK9, AudioId_FK9) VALUES (26, 'Travis Scott - Astroworld - Vinyl', 'Rap', 26, 17);
INSERT INTO Vinyl (VinylId, TitluVinyl, Gen, ArtistId_FK9, AudioId_FK9) VALUES (27, 'Post Malone - Hollywoods Bleeding - Vinyl', 'Rap', 27, 16);
INSERT INTO Vinyl (VinylId, TitluVinyl, Gen, ArtistId_FK9, AudioId_FK9) VALUES (28, 'Lil Nas X - Montero - Vinyl', 'Rap', 28, 17);
INSERT INTO Vinyl (VinylId, TitluVinyl, Gen, ArtistId_FK9, AudioId_FK9) VALUES (29, 'Cardi B - Invasion of Privacy - Vinyl', 'Rap', 29, 11);
INSERT INTO Vinyl (VinylId, TitluVinyl, Gen, ArtistId_FK9, AudioId_FK9) VALUES (30, 'The Weeknd - After Hours - Vinyl', 'RnB', 30, 11);
INSERT INTO Vinyl (VinylId, TitluVinyl, Gen, ArtistId_FK9, AudioId_FK9) VALUES (31, 'John Mayer - Altceva - Vinyl', 'Rock', 1, 11);
INSERT INTO Vinyl (VinylId, TitluVinyl, Gen, ArtistId_FK9, AudioId_FK9) VALUES (32, 'John Mayer - Nou - Vinyl', 'Rock', 1, 11);
INSERT INTO Vinyl (VinylId, TitluVinyl, Gen, ArtistId_FK9, AudioId_FK9) VALUES (33, 'John Mayer - Vechi - Vinyl', 'Rock', 1, 11);
INSERT INTO Vinyl (VinylId, TitluVinyl, Gen, ArtistId_FK9, AudioId_FK9) VALUES (34, 'John Mayer - Best Songs - Vinyl', 'Rock', 1, 11);

INSERT INTO Caseta (CasetaId, TitluCaseta, Gen, ArtistId_FK10, AudioId_FK10) VALUES (1, 'John Mayer - Continuum - Caseta', 'Rock', 1, 21);
INSERT INTO Caseta (CasetaId, TitluCaseta, Gen, ArtistId_FK10, AudioId_FK10) VALUES (2, 'Adele - 21 - Caseta', 'Pop', 2, 22);
INSERT INTO Caseta (CasetaId, TitluCaseta, Gen, ArtistId_FK10, AudioId_FK10) VALUES (3, 'Ed Sheeran - ÷ - Caseta', 'Pop', 3, 22);
INSERT INTO Caseta (CasetaId, TitluCaseta, Gen, ArtistId_FK10, AudioId_FK10) VALUES (4, 'Beyoncé - Lemonade - Caseta', 'RnB', 4, 24);
INSERT INTO Caseta (CasetaId, TitluCaseta, Gen, ArtistId_FK10, AudioId_FK10) VALUES (5, 'Taylor Swift - 1989 - Caseta', 'Pop', 5, 25);
INSERT INTO Caseta (CasetaId, TitluCaseta, Gen, ArtistId_FK10, AudioId_FK10) VALUES (6, 'Drake - Views - Caseta', 'Rap', 6, 25);
INSERT INTO Caseta (CasetaId, TitluCaseta, Gen, ArtistId_FK10, AudioId_FK10) VALUES (7, 'Coldplay - A Head Full of Dreams - Caseta', 'Pop', 7, 25);
INSERT INTO Caseta (CasetaId, TitluCaseta, Gen, ArtistId_FK10, AudioId_FK10) VALUES (8, 'Lady Gaga - The Fame - Caseta', 'Pop', 8, 28);
INSERT INTO Caseta (CasetaId, TitluCaseta, Gen, ArtistId_FK10, AudioId_FK10) VALUES (9, 'Bruno Mars - 24K Magic - Caseta', 'Pop', 9, 29);
INSERT INTO Caseta (CasetaId, TitluCaseta, Gen, ArtistId_FK10, AudioId_FK10) VALUES (10, 'Katy Perry - Teenage Dream - Caseta', 'Pop', 10, 21);
INSERT INTO Caseta (CasetaId, TitluCaseta, Gen, ArtistId_FK10, AudioId_FK10) VALUES (11, 'Eminem - The Marshall Mathers LP - Caseta', 'Rap', 11, 22);
INSERT INTO Caseta (CasetaId, TitluCaseta, Gen, ArtistId_FK10, AudioId_FK10) VALUES (12, 'Rihanna - Anti - Caseta', 'RnB', 12, 22);
INSERT INTO Caseta (CasetaId, TitluCaseta, Gen, ArtistId_FK10, AudioId_FK10) VALUES (13, 'Justin Bieber - Purpose - Caseta', 'Pop', 13, 22);
INSERT INTO Caseta (CasetaId, TitluCaseta, Gen, ArtistId_FK10, AudioId_FK10) VALUES (14, 'Ariana Grande - Thank U, Next - Caseta', 'Pop', 14, 24);
INSERT INTO Caseta (CasetaId, TitluCaseta, Gen, ArtistId_FK10, AudioId_FK10) VALUES (15, 'Michael Jackson - Thriller - Caseta', 'Pop', 15, 24);
INSERT INTO Caseta (CasetaId, TitluCaseta, Gen, ArtistId_FK10, AudioId_FK10) VALUES (16, 'Queen - A Night at the Opera - Caseta', 'Rock', 16, 26);
INSERT INTO Caseta (CasetaId, TitluCaseta, Gen, ArtistId_FK10, AudioId_FK10) VALUES (17, 'Elton John - Goodbye Yellow Brick Road - Caseta', 'Rock', 17, 27);
INSERT INTO Caseta (CasetaId, TitluCaseta, Gen, ArtistId_FK10, AudioId_FK10) VALUES (18, 'The Beatles - Sgt. Peppers Lonely Hearts Club Band - Caseta', 'Rock', 18, 30);
INSERT INTO Caseta (CasetaId, TitluCaseta, Gen, ArtistId_FK10, AudioId_FK10) VALUES (19, 'Bob Marley - Legend - Caseta', 'Reggae', 19, 30);
INSERT INTO Caseta (CasetaId, TitluCaseta, Gen, ArtistId_FK10, AudioId_FK10) VALUES (20, 'David Bowie - The Rise and Fall of Ziggy Stardust - Caseta', 'Rock', 20, 30);
INSERT INTO Caseta (CasetaId, TitluCaseta, Gen, ArtistId_FK10, AudioId_FK10) VALUES (21, 'Prince - Purple Rain - Caseta', 'Pop', 21, 30);
INSERT INTO Caseta (CasetaId, TitluCaseta, Gen, ArtistId_FK10, AudioId_FK10) VALUES (22, 'Whitney Houston - Whitney - Caseta', 'RnB', 22, 24);
INSERT INTO Caseta (CasetaId, TitluCaseta, Gen, ArtistId_FK10, AudioId_FK10) VALUES (23, 'Frank Sinatra - Songs Swingin Lovers! - Caseta', 'Jazz', 23, 23);
INSERT INTO Caseta (CasetaId, TitluCaseta, Gen, ArtistId_FK10, AudioId_FK10) VALUES (24, 'Dua Lipa - Future Nostalgia - Caseta', 'Pop', 24, 24);
INSERT INTO Caseta (CasetaId, TitluCaseta, Gen, ArtistId_FK10, AudioId_FK10) VALUES (25, 'Billie Eilish - When We All Fall Asleep, Where Do We Go? - Caseta', 'Pop', 25, 25);
INSERT INTO Caseta (CasetaId, TitluCaseta, Gen, ArtistId_FK10, AudioId_FK10) VALUES (26, 'Travis Scott - Astroworld - Caseta', 'Rap', 26, 29);
INSERT INTO Caseta (CasetaId, TitluCaseta, Gen, ArtistId_FK10, AudioId_FK10) VALUES (27, 'Post Malone - Hollywoods Bleeding - Caseta', 'Rap', 27, 29);
INSERT INTO Caseta (CasetaId, TitluCaseta, Gen, ArtistId_FK10, AudioId_FK10) VALUES (28, 'Lil Nas X - Montero - Caseta', 'Rap', 28, 29);
INSERT INTO Caseta (CasetaId, TitluCaseta, Gen, ArtistId_FK10, AudioId_FK10) VALUES (29, 'Cardi B - Invasion of Privacy - Caseta', 'Rap', 29, 23);
INSERT INTO Caseta (CasetaId, TitluCaseta, Gen, ArtistId_FK10, AudioId_FK10) VALUES (30, 'The Weeknd - After Hours - Caseta', 'RnB', 30, 23);
INSERT INTO Caseta (CasetaId, TitluCaseta, Gen, ArtistId_FK10, AudioId_FK10) VALUES (31, 'John Mayer - Altceva - Caseta', 'Rock', 1, 21);
INSERT INTO Caseta (CasetaId, TitluCaseta, Gen, ArtistId_FK10, AudioId_FK10) VALUES (32, 'John Mayer - Nou - Caseta', 'Rock', 1, 21);
INSERT INTO Caseta (CasetaId, TitluCaseta, Gen, ArtistId_FK10, AudioId_FK10) VALUES (33, 'John Mayer - Vechi - Caseta', 'Rock', 1, 21);

INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (1, 1);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (1, 2);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (1, 17);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (1, 27);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (1, 32);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (1, 37);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (1, 41);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (1, 2);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (1, 9);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (1, 19);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (1, 29);

INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (2, 3);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (2, 5);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (2, 18);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (2, 28);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (2, 38);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (2, 43);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (2, 13);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (2, 20);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (2, 30);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (2, 40);

INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (3, 4);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (3, 7);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (3, 19);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (3, 29);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (3, 39);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (3, 14);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (3, 24);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (3, 35);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (3, 41);

INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (4, 6);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (4, 8);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (4, 20);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (4, 30);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (4, 40);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (4, 25);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (4, 35);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (4, 2);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (4, 12);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (4, 42);

INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (5, 9);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (5, 11);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (5, 21);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (5, 31);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (5, 36);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (5, 46);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (5, 3);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (5, 13);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (5, 23);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (5, 34);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (5, 47);

INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (6, 10);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (6, 12);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (6, 22);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (6, 26);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (6, 32);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (6, 47);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (6, 7);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (6, 18);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (6, 24);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (6, 34);

INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (7, 13);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (7, 23);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (7, 33);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (7, 8);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (7, 19);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (7, 25);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (7, 35);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (7, 45);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (7, 18);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (7, 29);

INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (8, 14);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (8, 24);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (8, 34);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (8, 48);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (8, 29);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (8, 19);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (8, 36);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (8, 46);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (8, 6);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (8, 17);

INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (9, 15);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (9, 25);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (9, 35);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (9, 47);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (9, 7);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (9, 17);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (9, 28);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (9, 40);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (9, 30);

INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (10, 16);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (10, 26);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (10, 36);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (10, 1);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (10, 41);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (10, 8);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (10, 20);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (10, 18);
INSERT INTO CosCumparaturi (UserId_FK1, ProdusId_FK1) VALUES (10, 28);

INSERT INTO Preferinte (PreferintaId, UserId_FK2, PreferintaProdusId) VALUES (1, 1, 5);
INSERT INTO Preferinte (PreferintaId, UserId_FK2, PreferintaProdusId) VALUES (2, 2, 12);
INSERT INTO Preferinte (PreferintaId, UserId_FK2, PreferintaProdusId) VALUES (3, 3, 28);
INSERT INTO Preferinte (PreferintaId, UserId_FK2, PreferintaProdusId) VALUES (4, 4, 42);
INSERT INTO Preferinte (PreferintaId, UserId_FK2, PreferintaProdusId) VALUES (5, 5, 15);
INSERT INTO Preferinte (PreferintaId, UserId_FK2, PreferintaProdusId) VALUES (6, 6, 32);
INSERT INTO Preferinte (PreferintaId, UserId_FK2, PreferintaProdusId) VALUES (7, 7, 18);
INSERT INTO Preferinte (PreferintaId, UserId_FK2, PreferintaProdusId) VALUES (8, 8, 29);
INSERT INTO Preferinte (PreferintaId, UserId_FK2, PreferintaProdusId) VALUES (9, 9, 40);
INSERT INTO Preferinte (PreferintaId, UserId_FK2, PreferintaProdusId) VALUES (10, 10, 1);
INSERT INTO Preferinte (PreferintaId, UserId_FK2, PreferintaProdusId) VALUES (11, 1, 23);
INSERT INTO Preferinte (PreferintaId, UserId_FK2, PreferintaProdusId) VALUES (12, 2, 36);
INSERT INTO Preferinte (PreferintaId, UserId_FK2, PreferintaProdusId) VALUES (13, 3, 47);
INSERT INTO Preferinte (PreferintaId, UserId_FK2, PreferintaProdusId) VALUES (14, 4, 8);
INSERT INTO Preferinte (PreferintaId, UserId_FK2, PreferintaProdusId) VALUES (15, 5, 19);

INSERT INTO Recomandari (RecomandareId, UserId_FK3, RecomandareProdusId) VALUES (1, 1, 3);
INSERT INTO Recomandari (RecomandareId, UserId_FK3, RecomandareProdusId) VALUES (2, 2, 16);
INSERT INTO Recomandari (RecomandareId, UserId_FK3, RecomandareProdusId) VALUES (3, 3, 29);
INSERT INTO Recomandari (RecomandareId, UserId_FK3, RecomandareProdusId) VALUES (4, 4, 45);
INSERT INTO Recomandari (RecomandareId, UserId_FK3, RecomandareProdusId) VALUES (5, 5, 6);
INSERT INTO Recomandari (RecomandareId, UserId_FK3, RecomandareProdusId) VALUES (6, 6, 25);
INSERT INTO Recomandari (RecomandareId, UserId_FK3, RecomandareProdusId) VALUES (7, 7, 36);
INSERT INTO Recomandari (RecomandareId, UserId_FK3, RecomandareProdusId) VALUES (8, 8, 47);
INSERT INTO Recomandari (RecomandareId, UserId_FK3, RecomandareProdusId) VALUES (9, 9, 9);
INSERT INTO Recomandari (RecomandareId, UserId_FK3, RecomandareProdusId) VALUES (10, 10, 20);
INSERT INTO Recomandari (RecomandareId, UserId_FK3, RecomandareProdusId) VALUES (11, 1, 32);
INSERT INTO Recomandari (RecomandareId, UserId_FK3, RecomandareProdusId) VALUES (12, 2, 43);
INSERT INTO Recomandari (RecomandareId, UserId_FK3, RecomandareProdusId) VALUES (13, 3, 14);
INSERT INTO Recomandari (RecomandareId, UserId_FK3, RecomandareProdusId) VALUES (14, 4, 25);
INSERT INTO Recomandari (RecomandareId, UserId_FK3, RecomandareProdusId) VALUES (15, 5, 36);
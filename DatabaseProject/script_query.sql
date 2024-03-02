CREATE OR REPLACE PACKAGE pck_aplicatie AS
    PROCEDURE raport_artist_audio_disponibil_toate_formatele(
        out_cursor OUT SYS_REFCURSOR,
        artist_name_param IN VARCHAR2
    );

    PROCEDURE raport_chitara_acelasi_material(
        out_cursor OUT SYS_REFCURSOR,
        user_id_param IN NUMBER
    );

    PROCEDURE raport_recomandare_audio_acelasi_pret(
        out_cursor OUT SYS_REFCURSOR,
        user_id_param IN NUMBER
    );
END pck_aplicatie;
/

CREATE OR REPLACE PACKAGE BODY pck_aplicatie AS
    PROCEDURE raport_artist_audio_disponibil_toate_formatele(
        out_cursor OUT SYS_REFCURSOR,
        artist_name_param IN VARCHAR2
    ) AS
    BEGIN
        OPEN out_cursor FOR
            SELECT 
                artist_name_param AS Artist,
                COUNT(DISTINCT C.CasetaId) AS NumarCasetaDisponibile,
                COUNT(DISTINCT CD.CDId) AS NumarCDDisponibile,
                COUNT(DISTINCT V.VinylId) AS NumarVinylDisponibile
            FROM Artist A
            LEFT JOIN Caseta C ON A.ArtistId = C.ArtistId_FK10
            LEFT JOIN CD ON A.ArtistId = CD.ArtistId_FK8
            LEFT JOIN Vinyl V ON A.ArtistId = V.ArtistId_FK9 AND V.TitluVinyl LIKE '% - Vinyl'
            WHERE 
                A.NumeArtist = artist_name_param
                AND C.AudioId_FK10 IN (SELECT ProdusId FROM Produse WHERE Stoc > 0)
                AND CD.AudioId_FK8 IN (SELECT ProdusId FROM Produse WHERE Stoc > 0)
                AND V.AudioId_FK9 IN (SELECT ProdusId FROM Produse WHERE Stoc > 0)
            GROUP BY A.NumeArtist;

        COMMIT;
    END raport_artist_audio_disponibil_toate_formatele;

    PROCEDURE raport_chitara_acelasi_material(
        out_cursor OUT SYS_REFCURSOR,
        user_id_param IN NUMBER
    ) AS
    BEGIN
        OPEN out_cursor FOR
            -- Query 6
            SELECT 
                P.ProdusId,
                P.DenumireProdus,
                P.Pret,
                P.Stoc
            FROM Produse P
            JOIN Instrumente I ON P.ProdusId = I.ProdusId_FK4
            JOIN Chitara C ON I.InstrumentId = C.InstrumentId_FK6
            WHERE 
                C.Material = (SELECT C.Material FROM Chitara C
                                JOIN Preferinte P ON C.InstrumentId_FK6 = P.PreferintaProdusId
                                WHERE P.UserId_FK2 = user_id_param)
                AND P.ProdusId NOT IN (SELECT PreferintaProdusId FROM Preferinte WHERE UserId_FK2 = user_id_param);

        COMMIT;
    END raport_chitara_acelasi_material;

    PROCEDURE raport_recomandare_audio_acelasi_pret(
        out_cursor OUT SYS_REFCURSOR,
        user_id_param IN NUMBER
    ) AS
    BEGIN
        OPEN out_cursor FOR
            -- Query 4
            SELECT
                CD.CDId,
                CD.TitluCD,
                CD.Gen,
                CD.ArtistId_FK8,
                CD.AudioId_FK8
            FROM
                Recomandari R
            JOIN
                Produse P ON R.RecomandareProdusId = P.ProdusId
            JOIN
                Audio A ON P.ProdusId = A.ProdusId_FK5
            JOIN
                CD ON A.AudioId = CD.AudioId_FK8
            WHERE
                R.UserId_FK3 = user_id_param;

        COMMIT;
    END raport_recomandare_audio_acelasi_pret;
END pck_aplicatie;
/

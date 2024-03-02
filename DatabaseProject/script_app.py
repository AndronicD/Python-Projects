import cx_Oracle
import grafice

class OracleConnection:

    def __init__(self, host, port, schema, username, password):
        self.host = host
        self.port = port
        self.schema = schema
        self.username = username
        self.password = password

    def openConnection(self):
        try:
            dsn_tns = cx_Oracle.makedsn(self.host, self.port, self.schema)
            self.db = cx_Oracle.connect(self.username, self.password, dsn_tns)
            self.cursor = self.db.cursor()

            with open('script_create.sql', 'r') as f:
                script = f.read()

            # Split the script into individual statements
            statements = script.split(';')

            # Execute each SQL statement
            for statement in statements:
                statement = statement.strip()
                if statement:
                    try:
                        self.cursor.execute(statement)
                        print(f"Statement executed successfully: {statement}")
                    except cx_Oracle.DatabaseError as ex:
                        error, = ex.args
                        print(f"Error code: {error.code}, message: {error.message}")

            print("Script execution completed!")
            print("Connection open!")
        except Exception as e:
            print("Connection not open!")
            print(e)

    def closeConnection(self):
        try:
            self.cursor.close()
            self.db.close()
            print("Connection close!")
        except Exception as e:
            print("Connection not closed!")
            print(e)

    def raport_artist_audio_disponibil_toate_formatele(self, artistName):
        try:
            out_cursor = self.cursor.var(cx_Oracle.CURSOR)
            self.cursor.callproc("pck_aplicatie.raport_artist_audio_disponibil_toate_formatele", [out_cursor, artistName])
            result = out_cursor.getvalue().fetchone()

            # Unpack the result
            artist, num_caseta, num_cd, num_vinyl = result
            grafice.show_graphic_1(artist, num_caseta, num_cd, num_vinyl)
        except Exception as e:
            print(e)

    def raport_recomandare_audio_acelasi_pret(self, idUser):
        try:
            out_cursor = self.cursor.var(cx_Oracle.CURSOR)
            self.cursor.callproc("pck_aplicatie.raport_recomandare_audio_acelasi_pret", [out_cursor, idUser])

            data = [row for row in out_cursor.getvalue()]
            grafice.show_graphic_2(data)
        except Exception as e:
            print(e)

    def raport_chitara_acelasi_material(self, idUser):
        try:
            out_cursor = self.cursor.var(cx_Oracle.CURSOR)
            self.cursor.callproc("pck_aplicatie.raport_chitara_acelasi_material", [out_cursor, idUser])

            data = [row for row in out_cursor.getvalue()]
            grafice.show_graphic_3(data)
        except Exception as e:
            print(e)

if __name__ == "__main__":
    oc = OracleConnection('localhost', 1521, 'XE', 'system', 'parolaAiaPuternic4')
    oc.openConnection()
    
    # # Apelul procedurii 2
    print("Rezultate raport_recomandare_audio_acelasi_pret")
    oc.raport_recomandare_audio_acelasi_pret(6)

    # # Apelul procedurii 3
    print("Rezultate raport_chitara_acelasi_material")
    oc.raport_chitara_acelasi_material(1)

     # # Apelul procedurii 1
    print("Rezultate raport_artist_audio_disponibil_toate_formatele")
    oc.raport_artist_audio_disponibil_toate_formatele('John Mayer')
    
    oc.closeConnection()
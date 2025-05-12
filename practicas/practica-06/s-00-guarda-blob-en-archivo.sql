CREATE OR REPLACE PROCEDURE guarda_blob_en_archivo (
  v_directory_name IN VARCHAR2,
  v_dest_file_name IN VARCHAR2,
  v_table_name IN VARCHAR2,
  v_blob_column_name IN VARCHAR2,
  v_pk_column_name1 IN VARCHAR2,
  v_pk_column_value1 IN VARCHAR2,
  v_pk_column_name2 IN VARCHAR2 DEFAULT NULL,
  v_pk_column_value2 IN VARCHAR2 DEFAULT NULL
) IS
  v_file UTL_FILE.FILE_TYPE;
  v_buffer_size NUMBER := 32767;
  v_buffer RAW(32767);
  v_blob BLOB;
  v_blob_length NUMBER;
  v_position NUMBER;
  v_query VARCHAR2(2000);
BEGIN
  -- Construye el query dinámico según el número de claves primarias
  IF v_pk_column_name2 IS NULL THEN
    v_query := 'SELECT ' || v_blob_column_name || ' FROM ' || v_table_name || 
               ' WHERE ' || v_pk_column_name1 || ' = :val1';
  ELSE
    v_query := 'SELECT ' || v_blob_column_name || ' FROM ' || v_table_name || 
               ' WHERE ' || v_pk_column_name1 || ' = :val1 AND ' || 
               v_pk_column_name2 || ' = :val2';
  END IF;

  -- Ejecuta el query dinámico de forma segura
  IF v_pk_column_name2 IS NULL THEN
    EXECUTE IMMEDIATE v_query INTO v_blob USING v_pk_column_value1;
  ELSE
    EXECUTE IMMEDIATE v_query INTO v_blob USING v_pk_column_value1, v_pk_column_value2;
  END IF;

  -- Resto del procedimiento igual...
  v_blob_length := DBMS_LOB.getlength(v_blob);
  v_position := 1;
  v_file := UTL_FILE.fopen(v_directory_name, v_dest_file_name, 'wb', 32767);

  -- Lee el archivo por partes hasta completar
  WHILE v_position < v_blob_length LOOP
    DBMS_LOB.read(v_blob, v_buffer_size, v_position, v_buffer);
    UTL_FILE.put_raw(v_file, v_buffer, TRUE);
    v_position := v_position + v_buffer_size;
  END LOOP;

  UTL_FILE.fclose(v_file);

EXCEPTION
  WHEN OTHERS THEN
    IF UTL_FILE.is_open(v_file) THEN
      UTL_FILE.fclose(v_file);
    END IF;
    RAISE;
END;
/
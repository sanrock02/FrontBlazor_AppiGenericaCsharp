-- PROCEDIMIENTOS ALMACENADOS CRUD
-- Base de Datos: BdConocimiento
-- Tablas: docente, alianza, docente_departamento, evaluacion_docente, experiencia, 
--         reconocimiento, red_docente, intereses_futuros, estudio_ac, estudios_realizados,
--         apoyo_profesoral, beca, red

-- ============================================================================
-- TABLA: docente
-- ============================================================================

CREATE PROCEDURE SP_Crear_Docente
    @cedula INT,
    @nombres NVARCHAR(60),
    @apellidos NVARCHAR(60),
    @genero NVARCHAR(12),
    @cargo NVARCHAR(30),
    @fecha_nacimiento DATE,
    @correo NVARCHAR(70),
    @telefono NVARCHAR(20),
    @url_cvlac NVARCHAR(128),
    @fecha_actualizacion DATE,
    @escalafon NVARCHAR(45),
    @perfil NVARCHAR(MAX),
    @cat_minciencia NVARCHAR(45) = NULL,
    @conv_minciencia NVARCHAR(45),
    @nacionalidaad NVARCHAR(45),
    @linea_investigacion_principal INT = NULL
AS
BEGIN
    INSERT INTO docente (cedula, nombres, apellidos, genero, cargo, fecha_nacimiento, 
                         correo, telefono, url_cvlac, fecha_actualizacion, escalafon, 
                         perfil, cat_minciencia, conv_minciencia, nacionalidaad, 
                         linea_investigacion_principal)
    VALUES (@cedula, @nombres, @apellidos, @genero, @cargo, @fecha_nacimiento, 
            @correo, @telefono, @url_cvlac, @fecha_actualizacion, @escalafon, 
            @perfil, @cat_minciencia, @conv_minciencia, @nacionalidaad, 
            @linea_investigacion_principal);
END;
GO

CREATE PROCEDURE SP_Listar_Docente
AS
BEGIN
    SELECT cedula, nombres, apellidos, genero, cargo, fecha_nacimiento, 
           correo, telefono, url_cvlac, fecha_actualizacion, escalafon, 
           perfil, cat_minciencia, conv_minciencia, nacionalidaad, 
           linea_investigacion_principal
    FROM docente;
END;
GO

CREATE PROCEDURE SP_Obtener_Docente
    @cedula INT
AS
BEGIN
    SELECT cedula, nombres, apellidos, genero, cargo, fecha_nacimiento, 
           correo, telefono, url_cvlac, fecha_actualizacion, escalafon, 
           perfil, cat_minciencia, conv_minciencia, nacionalidaad, 
           linea_investigacion_principal
    FROM docente
    WHERE cedula = @cedula;
END;
GO

CREATE PROCEDURE SP_Actualizar_Docente
    @cedula INT,
    @nombres NVARCHAR(60),
    @apellidos NVARCHAR(60),
    @genero NVARCHAR(12),
    @cargo NVARCHAR(30),
    @fecha_nacimiento DATE,
    @correo NVARCHAR(70),
    @telefono NVARCHAR(20),
    @url_cvlac NVARCHAR(128),
    @fecha_actualizacion DATE,
    @escalafon NVARCHAR(45),
    @perfil NVARCHAR(MAX),
    @cat_minciencia NVARCHAR(45) = NULL,
    @conv_minciencia NVARCHAR(45),
    @nacionalidaad NVARCHAR(45),
    @linea_investigacion_principal INT = NULL
AS
BEGIN
    UPDATE docente
    SET nombres = @nombres,
        apellidos = @apellidos,
        genero = @genero,
        cargo = @cargo,
        fecha_nacimiento = @fecha_nacimiento,
        correo = @correo,
        telefono = @telefono,
        url_cvlac = @url_cvlac,
        fecha_actualizacion = @fecha_actualizacion,
        escalafon = @escalafon,
        perfil = @perfil,
        cat_minciencia = @cat_minciencia,
        conv_minciencia = @conv_minciencia,
        nacionalidaad = @nacionalidaad,
        linea_investigacion_principal = @linea_investigacion_principal
    WHERE cedula = @cedula;
END;
GO

CREATE PROCEDURE SP_Eliminar_Docente
    @cedula INT
AS
BEGIN
    DELETE FROM docente WHERE cedula = @cedula;
END;
GO

-- ============================================================================
-- TABLA: red
-- ============================================================================

CREATE PROCEDURE SP_Crear_Red
    @idr INT,
    @nombre NVARCHAR(45),
    @url NVARCHAR(45),
    @pais NVARCHAR(45)
AS
BEGIN
    INSERT INTO red (idr, nombre, url, pais)
    VALUES (@idr, @nombre, @url, @pais);
END;
GO

CREATE PROCEDURE SP_Listar_Red
AS
BEGIN
    SELECT idr, nombre, url, pais FROM red;
END;
GO

CREATE PROCEDURE SP_Obtener_Red
    @idr INT
AS
BEGIN
    SELECT idr, nombre, url, pais FROM red WHERE idr = @idr;
END;
GO

CREATE PROCEDURE SP_Actualizar_Red
    @idr INT,
    @nombre NVARCHAR(45),
    @url NVARCHAR(45),
    @pais NVARCHAR(45)
AS
BEGIN
    UPDATE red
    SET nombre = @nombre, url = @url, pais = @pais
    WHERE idr = @idr;
END;
GO

CREATE PROCEDURE SP_Eliminar_Red
    @idr INT
AS
BEGIN
    DELETE FROM red WHERE idr = @idr;
END;
GO

-- ============================================================================
-- TABLA: alianza
-- ============================================================================

CREATE PROCEDURE SP_Crear_Alianza
    @aliado BIGINT,
    @departamento INT,
    @fecha_inicio DATE,
    @fecha_fin DATE = NULL,
    @docente INT = NULL
AS
BEGIN
    INSERT INTO alianza (aliado, departamento, fecha_inicio, fecha_fin, docente)
    VALUES (@aliado, @departamento, @fecha_inicio, @fecha_fin, @docente);
END;
GO

CREATE PROCEDURE SP_Listar_Alianza
AS
BEGIN
    SELECT aliado, departamento, fecha_inicio, fecha_fin, docente FROM alianza;
END;
GO

CREATE PROCEDURE SP_Obtener_Alianza
    @aliado BIGINT,
    @departamento INT
AS
BEGIN
    SELECT aliado, departamento, fecha_inicio, fecha_fin, docente 
    FROM alianza
    WHERE aliado = @aliado AND departamento = @departamento;
END;
GO

CREATE PROCEDURE SP_Actualizar_Alianza
    @aliado BIGINT,
    @departamento INT,
    @fecha_inicio DATE,
    @fecha_fin DATE = NULL,
    @docente INT = NULL
AS
BEGIN
    UPDATE alianza
    SET fecha_inicio = @fecha_inicio, fecha_fin = @fecha_fin, docente = @docente
    WHERE aliado = @aliado AND departamento = @departamento;
END;
GO

CREATE PROCEDURE SP_Eliminar_Alianza
    @aliado BIGINT,
    @departamento INT
AS
BEGIN
    DELETE FROM alianza WHERE aliado = @aliado AND departamento = @departamento;
END;
GO

-- ============================================================================
-- TABLA: docente_departamento
-- ============================================================================

CREATE PROCEDURE SP_Crear_Docente_Departamento
    @docente INT,
    @departamento INT,
    @dedicacion NVARCHAR(15),
    @modalidad NVARCHAR(45),
    @fecha_ingreso DATE,
    @fecha_salida DATE = NULL
AS
BEGIN
    INSERT INTO docente_departamento (docente, departamento, dedicacion, modalidad, fecha_ingreso, fecha_salida)
    VALUES (@docente, @departamento, @dedicacion, @modalidad, @fecha_ingreso, @fecha_salida);
END;
GO

CREATE PROCEDURE SP_Listar_Docente_Departamento
AS
BEGIN
    SELECT docente, departamento, dedicacion, modalidad, fecha_ingreso, fecha_salida 
    FROM docente_departamento;
END;
GO

CREATE PROCEDURE SP_Obtener_Docente_Departamento
    @docente INT,
    @departamento INT
AS
BEGIN
    SELECT docente, departamento, dedicacion, modalidad, fecha_ingreso, fecha_salida 
    FROM docente_departamento
    WHERE docente = @docente AND departamento = @departamento;
END;
GO

CREATE PROCEDURE SP_Actualizar_Docente_Departamento
    @docente INT,
    @departamento INT,
    @dedicacion NVARCHAR(15),
    @modalidad NVARCHAR(45),
    @fecha_ingreso DATE,
    @fecha_salida DATE = NULL
AS
BEGIN
    UPDATE docente_departamento
    SET dedicacion = @dedicacion, modalidad = @modalidad, 
        fecha_ingreso = @fecha_ingreso, fecha_salida = @fecha_salida
    WHERE docente = @docente AND departamento = @departamento;
END;
GO

CREATE PROCEDURE SP_Eliminar_Docente_Departamento
    @docente INT,
    @departamento INT
AS
BEGIN
    DELETE FROM docente_departamento 
    WHERE docente = @docente AND departamento = @departamento;
END;
GO

-- ============================================================================
-- TABLA: evaluacion_docente
-- ============================================================================

CREATE PROCEDURE SP_Crear_Evaluacion_Docente
    @calificacion FLOAT,
    @semestre NVARCHAR(45),
    @docente INT
AS
BEGIN
    INSERT INTO evaluacion_docente (calificacion, semestre, docente)
    VALUES (@calificacion, @semestre, @docente);
END;
GO

CREATE PROCEDURE SP_Listar_Evaluacion_Docente
AS
BEGIN
    SELECT id, calificacion, semestre, docente FROM evaluacion_docente;
END;
GO

CREATE PROCEDURE SP_Obtener_Evaluacion_Docente
    @id INT
AS
BEGIN
    SELECT id, calificacion, semestre, docente FROM evaluacion_docente WHERE id = @id;
END;
GO

CREATE PROCEDURE SP_Actualizar_Evaluacion_Docente
    @id INT,
    @calificacion FLOAT,
    @semestre NVARCHAR(45),
    @docente INT
AS
BEGIN
    UPDATE evaluacion_docente
    SET calificacion = @calificacion, semestre = @semestre, docente = @docente
    WHERE id = @id;
END;
GO

CREATE PROCEDURE SP_Eliminar_Evaluacion_Docente
    @id INT
AS
BEGIN
    DELETE FROM evaluacion_docente WHERE id = @id;
END;
GO

-- ============================================================================
-- TABLA: experiencia
-- ============================================================================

CREATE PROCEDURE SP_Crear_Experiencia
    @nombre_cargo NVARCHAR(45),
    @institucion NVARCHAR(45),
    @tipo NVARCHAR(45),
    @fecha_inicio DATE,
    @fecha_fin DATE = NULL,
    @docente INT
AS
BEGIN
    INSERT INTO experiencia (nombre_cargo, institucion, tipo, fecha_inicio, fecha_fin, docente)
    VALUES (@nombre_cargo, @institucion, @tipo, @fecha_inicio, @fecha_fin, @docente);
END;
GO

CREATE PROCEDURE SP_Listar_Experiencia
AS
BEGIN
    SELECT id, nombre_cargo, institucion, tipo, fecha_inicio, fecha_fin, docente 
    FROM experiencia;
END;
GO

CREATE PROCEDURE SP_Obtener_Experiencia
    @id INT
AS
BEGIN
    SELECT id, nombre_cargo, institucion, tipo, fecha_inicio, fecha_fin, docente 
    FROM experiencia WHERE id = @id;
END;
GO

CREATE PROCEDURE SP_Actualizar_Experiencia
    @id INT,
    @nombre_cargo NVARCHAR(45),
    @institucion NVARCHAR(45),
    @tipo NVARCHAR(45),
    @fecha_inicio DATE,
    @fecha_fin DATE = NULL,
    @docente INT
AS
BEGIN
    UPDATE experiencia
    SET nombre_cargo = @nombre_cargo, institucion = @institucion, tipo = @tipo,
        fecha_inicio = @fecha_inicio, fecha_fin = @fecha_fin, docente = @docente
    WHERE id = @id;
END;
GO

CREATE PROCEDURE SP_Eliminar_Experiencia
    @id INT
AS
BEGIN
    DELETE FROM experiencia WHERE id = @id;
END;
GO

-- ============================================================================
-- TABLA: reconocimiento
-- ============================================================================

CREATE PROCEDURE SP_Crear_Reconocimiento
    @tipo NVARCHAR(45),
    @fecha DATE,
    @institucion NVARCHAR(45),
    @nombre NVARCHAR(45),
    @ambito NVARCHAR(45),
    @docente INT
AS
BEGIN
    INSERT INTO reconocimiento (tipo, fecha, institucion, nombre, ambito, docente)
    VALUES (@tipo, @fecha, @institucion, @nombre, @ambito, @docente);
END;
GO

CREATE PROCEDURE SP_Listar_Reconocimiento
AS
BEGIN
    SELECT id, tipo, fecha, institucion, nombre, ambito, docente FROM reconocimiento;
END;
GO

CREATE PROCEDURE SP_Obtener_Reconocimiento
    @id INT
AS
BEGIN
    SELECT id, tipo, fecha, institucion, nombre, ambito, docente FROM reconocimiento WHERE id = @id;
END;
GO

CREATE PROCEDURE SP_Actualizar_Reconocimiento
    @id INT,
    @tipo NVARCHAR(45),
    @fecha DATE,
    @institucion NVARCHAR(45),
    @nombre NVARCHAR(45),
    @ambito NVARCHAR(45),
    @docente INT
AS
BEGIN
    UPDATE reconocimiento
    SET tipo = @tipo, fecha = @fecha, institucion = @institucion, nombre = @nombre, 
        ambito = @ambito, docente = @docente
    WHERE id = @id;
END;
GO

CREATE PROCEDURE SP_Eliminar_Reconocimiento
    @id INT
AS
BEGIN
    DELETE FROM reconocimiento WHERE id = @id;
END;
GO

-- ============================================================================
-- TABLA: red_docente
-- ============================================================================

CREATE PROCEDURE SP_Crear_Red_Docente
    @red INT,
    @docente INT,
    @fecha_inicio DATE,
    @fecha_fin NVARCHAR(45) = NULL,
    @act_destacadas NVARCHAR(MAX)
AS
BEGIN
    INSERT INTO red_docente (red, docente, fecha_inicio, fecha_fin, act_destacadas)
    VALUES (@red, @docente, @fecha_inicio, @fecha_fin, @act_destacadas);
END;
GO

CREATE PROCEDURE SP_Listar_Red_Docente
AS
BEGIN
    SELECT red, docente, fecha_inicio, fecha_fin, act_destacadas FROM red_docente;
END;
GO

CREATE PROCEDURE SP_Obtener_Red_Docente
    @red INT,
    @docente INT
AS
BEGIN
    SELECT red, docente, fecha_inicio, fecha_fin, act_destacadas FROM red_docente
    WHERE red = @red AND docente = @docente;
END;
GO

CREATE PROCEDURE SP_Actualizar_Red_Docente
    @red INT,
    @docente INT,
    @fecha_inicio DATE,
    @fecha_fin NVARCHAR(45) = NULL,
    @act_destacadas NVARCHAR(MAX)
AS
BEGIN
    UPDATE red_docente
    SET fecha_inicio = @fecha_inicio, fecha_fin = @fecha_fin, act_destacadas = @act_destacadas
    WHERE red = @red AND docente = @docente;
END;
GO

CREATE PROCEDURE SP_Eliminar_Red_Docente
    @red INT,
    @docente INT
AS
BEGIN
    DELETE FROM red_docente WHERE red = @red AND docente = @docente;
END;
GO

-- ============================================================================
-- TABLA: estudios_realizados
-- ============================================================================

CREATE PROCEDURE SP_Crear_Estudios_Realizados
    @id INT,
    @titulo NVARCHAR(45),
    @universidad NVARCHAR(50),
    @fecha DATE,
    @tipo NVARCHAR(45),
    @ciudad NVARCHAR(45),
    @docente INT,
    @ins_acreditada BIT,
    @metodologia NVARCHAR(45),
    @perfil_egresado NVARCHAR(MAX),
    @pais NVARCHAR(45)
AS
BEGIN
    INSERT INTO estudios_realizados (id, titulo, universidad, fecha, tipo, ciudad, docente, 
                                     ins_acreditada, metodologia, perfil_egresado, pais)
    VALUES (@id, @titulo, @universidad, @fecha, @tipo, @ciudad, @docente, 
            @ins_acreditada, @metodologia, @perfil_egresado, @pais);
END;
GO

CREATE PROCEDURE SP_Listar_Estudios_Realizados
AS
BEGIN
    SELECT id, titulo, universidad, fecha, tipo, ciudad, docente, ins_acreditada, 
           metodologia, perfil_egresado, pais FROM estudios_realizados;
END;
GO

CREATE PROCEDURE SP_Obtener_Estudios_Realizados
    @id INT
AS
BEGIN
    SELECT id, titulo, universidad, fecha, tipo, ciudad, docente, ins_acreditada, 
           metodologia, perfil_egresado, pais FROM estudios_realizados WHERE id = @id;
END;
GO

CREATE PROCEDURE SP_Actualizar_Estudios_Realizados
    @id INT,
    @titulo NVARCHAR(45),
    @universidad NVARCHAR(50),
    @fecha DATE,
    @tipo NVARCHAR(45),
    @ciudad NVARCHAR(45),
    @docente INT,
    @ins_acreditada BIT,
    @metodologia NVARCHAR(45),
    @perfil_egresado NVARCHAR(MAX),
    @pais NVARCHAR(45)
AS
BEGIN
    UPDATE estudios_realizados
    SET titulo = @titulo, universidad = @universidad, fecha = @fecha, tipo = @tipo,
        ciudad = @ciudad, docente = @docente, ins_acreditada = @ins_acreditada,
        metodologia = @metodologia, perfil_egresado = @perfil_egresado, pais = @pais
    WHERE id = @id;
END;
GO

CREATE PROCEDURE SP_Eliminar_Estudios_Realizados
    @id INT
AS
BEGIN
    DELETE FROM estudios_realizados WHERE id = @id;
END;
GO

-- ============================================================================
-- TABLA: estudio_ac (Area Conocimiento - Estudios)
-- ============================================================================

CREATE PROCEDURE SP_Crear_Estudio_AC
    @estudio INT,
    @area_conocimiento INT
AS
BEGIN
    INSERT INTO estudio_ac (estudio, area_conocimiento)
    VALUES (@estudio, @area_conocimiento);
END;
GO

CREATE PROCEDURE SP_Listar_Estudio_AC
AS
BEGIN
    SELECT estudio, area_conocimiento FROM estudio_ac;
END;
GO

CREATE PROCEDURE SP_Obtener_Estudio_AC
    @estudio INT,
    @area_conocimiento INT
AS
BEGIN
    SELECT estudio, area_conocimiento FROM estudio_ac
    WHERE estudio = @estudio AND area_conocimiento = @area_conocimiento;
END;
GO

CREATE PROCEDURE SP_Actualizar_Estudio_AC
    @estudio INT,
    @area_conocimiento INT
AS
BEGIN
    -- Tabla de relación no necesita actualización, solo delete e insert
    DELETE FROM estudio_ac WHERE estudio = @estudio AND area_conocimiento = @area_conocimiento;
    INSERT INTO estudio_ac (estudio, area_conocimiento)
    VALUES (@estudio, @area_conocimiento);
END;
GO

CREATE PROCEDURE SP_Eliminar_Estudio_AC
    @estudio INT,
    @area_conocimiento INT
AS
BEGIN
    DELETE FROM estudio_ac WHERE estudio = @estudio AND area_conocimiento = @area_conocimiento;
END;
GO

-- ============================================================================
-- TABLA: apoyo_profesoral
-- ============================================================================

CREATE PROCEDURE SP_Crear_Apoyo_Profesoral
    @estudios INT,
    @con_apoyo BIT,
    @institucion NVARCHAR(45),
    @tipo NVARCHAR(45)
AS
BEGIN
    INSERT INTO apoyo_profesoral (estudios, con_apoyo, institucion, tipo)
    VALUES (@estudios, @con_apoyo, @institucion, @tipo);
END;
GO

CREATE PROCEDURE SP_Listar_Apoyo_Profesoral
AS
BEGIN
    SELECT estudios, con_apoyo, institucion, tipo FROM apoyo_profesoral;
END;
GO

CREATE PROCEDURE SP_Obtener_Apoyo_Profesoral
    @estudios INT
AS
BEGIN
    SELECT estudios, con_apoyo, institucion, tipo FROM apoyo_profesoral WHERE estudios = @estudios;
END;
GO

CREATE PROCEDURE SP_Actualizar_Apoyo_Profesoral
    @estudios INT,
    @con_apoyo BIT,
    @institucion NVARCHAR(45),
    @tipo NVARCHAR(45)
AS
BEGIN
    UPDATE apoyo_profesoral
    SET con_apoyo = @con_apoyo, institucion = @institucion, tipo = @tipo
    WHERE estudios = @estudios;
END;
GO

CREATE PROCEDURE SP_Eliminar_Apoyo_Profesoral
    @estudios INT
AS
BEGIN
    DELETE FROM apoyo_profesoral WHERE estudios = @estudios;
END;
GO

-- ============================================================================
-- TABLA: beca
-- ============================================================================

CREATE PROCEDURE SP_Crear_Beca
    @estudios INT,
    @tipo NVARCHAR(45),
    @institucion NVARCHAR(80),
    @fecha_inicio DATE,
    @fecha_fin DATE = NULL
AS
BEGIN
    INSERT INTO beca (estudios, tipo, institucion, fecha_inicio, fecha_fin)
    VALUES (@estudios, @tipo, @institucion, @fecha_inicio, @fecha_fin);
END;
GO

CREATE PROCEDURE SP_Listar_Beca
AS
BEGIN
    SELECT estudios, tipo, institucion, fecha_inicio, fecha_fin FROM beca;
END;
GO

CREATE PROCEDURE SP_Obtener_Beca
    @estudios INT
AS
BEGIN
    SELECT estudios, tipo, institucion, fecha_inicio, fecha_fin FROM beca WHERE estudios = @estudios;
END;
GO

CREATE PROCEDURE SP_Actualizar_Beca
    @estudios INT,
    @tipo NVARCHAR(45),
    @institucion NVARCHAR(80),
    @fecha_inicio DATE,
    @fecha_fin DATE = NULL
AS
BEGIN
    UPDATE beca
    SET tipo = @tipo, institucion = @institucion, fecha_inicio = @fecha_inicio, fecha_fin = @fecha_fin
    WHERE estudios = @estudios;
END;
GO

CREATE PROCEDURE SP_Eliminar_Beca
    @estudios INT
AS
BEGIN
    DELETE FROM beca WHERE estudios = @estudios;
END;
GO

-- ============================================================================
-- TABLA: intereses_futuros
-- ============================================================================
-- Nota: La estructura de esta tabla no está completa en el script original
-- Se asume una estructura básica similar a otras tablas de docente

CREATE PROCEDURE SP_Crear_Intereses_Futuros
    @id INT,
    @docente INT,
    @interes NVARCHAR(255)
AS
BEGIN
    INSERT INTO intereses_futuros (id, docente, interes)
    VALUES (@id, @docente, @interes);
END;
GO

CREATE PROCEDURE SP_Listar_Intereses_Futuros
AS
BEGIN
    SELECT id, docente, interes FROM intereses_futuros;
END;
GO

CREATE PROCEDURE SP_Obtener_Intereses_Futuros
    @id INT
AS
BEGIN
    SELECT id, docente, interes FROM intereses_futuros WHERE id = @id;
END;
GO

CREATE PROCEDURE SP_Actualizar_Intereses_Futuros
    @id INT,
    @docente INT,
    @interes NVARCHAR(255)
AS
BEGIN
    UPDATE intereses_futuros
    SET docente = @docente, interes = @interes
    WHERE id = @id;
END;
GO

CREATE PROCEDURE SP_Eliminar_Intereses_Futuros
    @id INT
AS
BEGIN
    DELETE FROM intereses_futuros WHERE id = @id;
END;
GO

-- ============================================================================
-- PROCEDIMIENTOS PARA OBTENER DATOS DE REFERENCIA (CLAVES FORÁNEAS)
-- ============================================================================

CREATE PROCEDURE SP_Listar_Docentes_Simple
AS
BEGIN
    SELECT cedula, nombres, apellidos FROM docente;
END;
GO

CREATE PROCEDURE SP_Listar_Redes_Simple
AS
BEGIN
    SELECT idr, nombre FROM red;
END;
GO

-- Para aliados (aunque no es una tabla CRUD aquí, es referencia en alianza)
CREATE PROCEDURE SP_Listar_Aliados_Simple
AS
BEGIN
    SELECT nit, razon_social FROM aliado;
END;
GO

-- Para áreas de conocimiento
CREATE PROCEDURE SP_Listar_Areas_Conocimiento_Simple
AS
BEGIN
    SELECT id, gran_area, area, disciplina FROM area_conocimiento;
END;
GO

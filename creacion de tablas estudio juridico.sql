
CREATE SCHEMA IF NOT exists estudio_juridico;

USE estudio_juridico;
-- TABLA DE PERSONAS --
CREATE table personas (
	id_persona INT NOT NULL UNIQUE auto_increment,
	domicilio INT NOT NULL,
    nombre VARCHAR (50) NOT NULL,
    apellido VARCHAR (50) NOT NULL,
    email VARCHAR (200) NOT NULL,
    no_telefono INT NOT NULL,
    dni INT NOT NULL,
    CONSTRAINT PK_personas PRIMARY KEY (id_persona)
    );
    
-- TABLA DE CLIENTES --
CREATE TABLE clientes (
	id_cliente INT NOT NULL UNIQUE auto_increment,
    id_persona INT NOT NULL UNIQUE,
    CONSTRAINT PK_clientes PRIMARY KEY (id_cliente)
    );

-- TABLA DE PROFESIONALES --
CREATE TABLE profesionales  (
	id_profesional INT NOT NULL UNIQUE auto_increment,
    id_persona INT NOT NULL UNIQUE,
    CONSTRAINT PK_profesionales PRIMARY KEY (id_profesional)
	);
    
-- TABLA DE DOMICILIOS --
CREATE TABLE domicilios (
	id_domicilio INT NOT NULL UNIQUE AUTO_INCREMENT,
	calle VARCHAR(150) NOT NULL,
	altura VARCHAR(4) NOT NULL,
    piso VARCHAR(4), 
    departamento VARCHAR(4),
    id_localidad INT NOT NULL,
CONSTRAINT PK_domicilios PRIMARY KEY (id_domicilio)
	);

-- TABLA DE LOCALIDADES --
CREATE TABLE localidades (
	id_localidad INT NOT NULL UNIQUE auto_increment,
	nombre VARCHAR(150)	NOT NULL,
	id_provincia INT NOT NULL,
	CONSTRAINT PK_localidades PRIMARY KEY (id_localidad)
	);
    
-- TABLA DE PROVINCIAS --
CREATE TABLE provincias (
	id_provincia INT NOT NULL UNIQUE AUTO_INCREMENT,
    id_pais INT NOT NULL,
    nombre	VARCHAR(150) NOT NULL UNIQUE,
	CONSTRAINT PK_provincias PRIMARY KEY (id_provincia)
	);
    
-- TABLA DE PAISES --
CREATE TABLE paises (
	id_pais INT NOT NULL UNIQUE	AUTO_INCREMENT,
    nombre VARCHAR(150) NOT NULL UNIQUE,
	CONSTRAINT PK_paises PRIMARY KEY (id_pais)
	);

-- TABLA DE RAMAS --
CREATE TABLE ramas (
	id_rama INT NOT NULL UNIQUE auto_increment,
    denominacion VARCHAR(150) NOT NULL UNIQUE,
    CONSTRAINT PK_ramas PRIMARY KEY (id_rama)
    );

-- TABLA DE CONSULTAS --
CREATE TABLE consultas (
	id_consulta INT NOT NULL UNIQUE auto_increment,
    jurisdiccion INT NOT NULL,
    descripcion VARCHAR(1000),
    CONSTRAINT PK_consultas PRIMARY KEY (id_consulta)
    );
 
 -- TABLA DE COMPROBANTES --
 CREATE TABLE comprobantes (
	no_comprobante VARCHAR(50) NOT NULL UNIQUE,
    id_persona INT, -- SE AGREGA ESTE ATRIBUTO PORQUE LOS HONORARIOS EN OCACIONES NO LOS PAGA EL CLIENTE --
    valor DECIMAL (10,2) NOT NULL,
    CONSTRAINT PK_comprobantes PRIMARY KEY (no_comprobante)
    );
    
-- TABLA DE CONTRATOS --
CREATE TABLE contratos (
	id_contrato INT NOT NULL UNIQUE auto_increment,
    id_consulta INT NOT NULL,
    id_profesional INT NOT NULL,
    no_comprobante VARCHAR(50),
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    CONSTRAINT PK_contratos PRIMARY KEY (id_contrato)
    );

-- TABLA DE HONORARIOS --
CREATE TABLE honorarios (
	id_honorario INT NOT NULL UNIQUE auto_increment,
    id_contrato INT NOT NULL,
    no_comprobante VARCHAR(50),
    resolucion VARCHAR(80),
	CONSTRAINT PK_honorarios PRIMARY KEY (id_honorario)
    );
    
-- TABLA PROVINCIA_PROFESIONALES --
CREATE TABLE provincias_profesionales (
	id_profesional INT NOT NULL,
    id_provincia INT NOT NULL,
    matricula VARCHAR(30) NOT NULL,
    CONSTRAINT PK_provincias_profesionales PRIMARY KEY  (id_profesional, id_provincia)
    );

-- TABLA RAMAS_PROFESIONALES --
CREATE TABLE ramas_profesionales (
	id_profesional INT NOT NULL,
    id_rama INT NOT NULL,
    CONSTRAINT PK_ramas_profesionales PRIMARY KEY  (id_profesional, id_rama)
    );

-- TABLA CONSULTAS_RAMAS --
CREATE TABLE consultas_ramas (
	id_consulta INT NOT NULL,
    id_rama INT NOT NULL,
    CONSTRAINT PK_consulta_ramas PRIMARY KEY  (id_consulta, id_rama)
    );

-- TABLA CLIENTES_CONSULTAS --
CREATE TABLE consultas_clientes (
	id_cliente INT NOT NULL,
    id_consulta INT NOT NULL,
    CONSTRAINT PK_clientes_consulta PRIMARY KEY  (id_cliente, id_consulta)
    );

-- CREACION DE CLAVES FORANEAS --

ALTER TABLE personas
ADD CONSTRAINT FK_domicilio_personas
FOREIGN KEY (domicilio)
REFERENCES domicilios (id_domicilio);

ALTER TABLE clientes
ADD CONSTRAINT FK_id_persona_clientes
FOREIGN KEY (id_persona)
REFERENCES personas (id_persona);

ALTER TABLE profesionales
ADD CONSTRAINT FK_id_persona_profesionales
FOREIGN KEY (id_persona)
REFERENCES personas (id_persona);

ALTER TABLE domicilios
ADD CONSTRAINT FK_id_localidad_domicilios
FOREIGN KEY (id_localidad)
REFERENCES localidades (id_localidad);

ALTER TABLE localidades
ADD CONSTRAINT FK_id_provincia_localidades
FOREIGN KEY (id_provincia)
REFERENCES provincias (id_provincia);

ALTER TABLE provincias
ADD CONSTRAINT FK_id_pais_provincias
FOREIGN KEY (id_pais)
REFERENCES paises (id_pais);

ALTER TABLE consultas
ADD CONSTRAINT FK_jurisdiccion_consultas
FOREIGN KEY (jurisdiccion)
REFERENCES provincias (id_provincia);

ALTER TABLE comprobantes
ADD CONSTRAINT FK_id_persona_comprobantes
FOREIGN KEY (id_persona)
REFERENCES personas (id_persona);

ALTER TABLE contratos
ADD CONSTRAINT FK_id_consulta_contratos
FOREIGN KEY (id_consulta)
REFERENCES consultas (id_consulta);
ALTER TABLE contratos
ADD CONSTRAINT FK_id_profesional_contratos
FOREIGN KEY (id_profesional)
REFERENCES profesionales (id_profesional);
ALTER TABLE contratos
ADD CONSTRAINT FK_no_comprobante_contratos
FOREIGN KEY (no_comprobante)
REFERENCES comprobantes (no_comprobante);

ALTER TABLE honorarios
ADD CONSTRAINT FK_id_contrato_honorarios
FOREIGN KEY (id_contrato)
REFERENCES contratos (id_contrato);
ALTER TABLE honorarios
ADD CONSTRAINT FK_no_comprobante_honorarios
FOREIGN KEY (no_comprobante)
REFERENCES comprobantes (no_comprobante);

ALTER TABLE provincias_profesionales
ADD CONSTRAINT FK_id_profesional_provincias_profesionales
FOREIGN KEY (id_profesional)
REFERENCES profesionales (id_profesional);
ALTER TABLE provincias_profesionales
ADD CONSTRAINT FK_id_provincia_provincias_profesionales
FOREIGN KEY (id_provincia)
REFERENCES provincias (id_provincia);

ALTER TABLE ramas_profesionales
ADD CONSTRAINT FK_id_profesional_ramas_profesionales
FOREIGN KEY (id_profesional)
REFERENCES profesionales (id_profesional);
ALTER TABLE ramas_profesionales
ADD CONSTRAINT FK_id_rama_ramas_profesionales
FOREIGN KEY (id_rama)
REFERENCES ramas (id_rama);

ALTER TABLE consultas_ramas
ADD CONSTRAINT FK_id_rama_consultas_ramas
FOREIGN KEY (id_rama)
REFERENCES ramas (id_rama);
ALTER TABLE consultas_ramas
ADD CONSTRAINT FK_id_consulta_consultas_ramas
FOREIGN KEY (id_consulta)
REFERENCES consultas (id_consulta);

ALTER TABLE consultas_clientes
ADD CONSTRAINT FK_id_consulta_consultas_clientes
FOREIGN KEY (id_consulta)
REFERENCES consultas (id_consulta);
ALTER TABLE consultas_clientes
ADD CONSTRAINT FK_id_cliente_consultas_clientes
FOREIGN KEY (id_cliente)
REFERENCES clientes (id_cliente);

-- end of file -- 

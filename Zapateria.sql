CREATE DATABASE ZAPATOS;

CREATE TABLE TIPOPRODUCTO
(
	idTipoProducto int NOT NULL,
    nomTipoProducto varchar(50),
    CONSTRAINT PK_TIPOPRODUCTO_idTipoProducto PRIMARY KEY (idTipoProducto)
);

CREATE TABLE PRODUCTOS
(
	idProducto int NOT NULL,
    nomProducto varchar(50) NOT NULL,
    idTipoProducto int NOT NULL,
    CONSTRAINT PK_PRODUCTOS_idProducto PRIMARY KEY (idProducto),
    CONSTRAINT FK_PRODUCTOS_idTipoProducto FOREIGN KEY (idTipoProducto) 
    REFERENCES TIPOPRODUCTO (idTipoProducto) ON DELETE CASCADE
);

CREATE TABLE TAMAÑO
(
	idTamaño int NOT NULL,
    nomTamaño varchar(25),
    CONSTRAINT PK_TAMAÑO_idTamaño PRIMARY KEY (idTamaño)
);

CREATE TABLE TAMAÑOPRODUCTO 
(
	idProducto int NOT NULL,
    idTamaño int NOT NULL,
    costo double NOT NULL,
    CONSTRAINT PK_TAMAÑOPRODUCTO_idProducto_idTamaño PRIMARY KEY (idProducto, idTamaño),
    CONSTRAINT FK_TAMAÑOPRODUCTO_idProducto FOREIGN KEY (idProducto)
    REFERENCES PRODUCTOS (idProducto) ON DELETE CASCADE,
    CONSTRAINT FK_TAMAÑOPRODUCTO_idTamaño FOREIGN KEY (idTamaño)
    REFERENCES TAMAÑO (idTamaño) ON DELETE CASCADE
);

CREATE TABLE ESTADO
(
	idEstado int NOT NULL,
    nomEstado varchar(50),
    CONSTRAINT PK_ESTADO_idEstado PRIMARY KEY (idEstado)
);

CREATE TABLE CIUDAD
(
	idCiudad int NOT NULL,
    nomCiudad varchar(50),
    idEstado int NOT NULL,
    CONSTRAINT PK_CIUDAD_idCiudad PRIMARY KEY (idCiudad),
    CONSTRAINT FK_CIUDAD_idESTADO FOREIGN KEY (idEstado) REFERENCES ESTADO (idEstado) ON DELETE CASCADE
);

CREATE TABLE TIPOLOCALES
(
	idTipoLocal int NOT NULL,
    nomTipoLocal varchar(50),
    CONSTRAINT PK_TIPOLOCALES_idTipoLocal PRIMARY KEY (idTipoLocal)
);

CREATE TABLE LOCALES
(
	idLocal int NOT NULL,
    nomLocal varchar(50) NOT NULL,
    idTipoLocal int NOT NULL,
    idCiudad int NOT NULL,
    CONSTRAINT PK_LOCALES_idLocal PRIMARY KEY (idLocal),
    CONSTRAINT FK_LOCALES_idTipoLocal FOREIGN KEY (idTipoLocal) 
    REFERENCES TIPOLOCALES (idTipoLocal) ON DELETE CASCADE
);

CREATE TABLE TICKETS
(
	idTicket int NOT NULL,
    fechaVenta date NOT NULL,
    idLocal int NOT NULL,
    status char(1) NOT NULL,
    fechaSeparacion date NOT NULL,
    CONSTRAINT PK_TICKETS_idTicket PRIMARY KEY (idTicket),
    CONSTRAINT FK_TICKETS_idLocal FOREIGN KEY (idLocal) 
    REFERENCES LOCALES (idLocal) ON DELETE CASCADE
);

CREATE TABLE TICKETSITEMS 
(
	idTicket int NOT NULL,
    idProducto int NOT NULL,
    idTamaño int NOT NULL,
    precioVenta double NOT NULL,
    cantidad int NOT NULL,
    CONSTRAINT PK_TICKETSITEMS_idTicket_idProducto_idTamaño PRIMARY KEY (idTicket, idProducto, idTamaño),
    CONSTRAINT FK_TICKETSITEMS_idTicket FOREIGN KEY (idTicket) 
    REFERENCES TICKETS (idTicket) ON DELETE CASCADE,
    CONSTRAINT FK_TICKETSITEMS_idProducto FOREIGN KEY (idProducto)
    REFERENCES PRODUCTOS (idProducto),
    CONSTRAINT FK_TICKETSITEMS_idTamaño FOREIGN KEY (idTamaño)
    REFERENCES TAMAÑO (idTamaño)
);

CREATE TABLE PRECIOTIPOLOCAL
(
	idProducto int NOT NULL,
    idLocal int NOT NULL,
    precio double NOT NULL,
    CONSTRAINT PK_PRECIOTIPOLOCAL_idProducto_idLocal PRIMARY KEY (idProducto, idLocal),
    CONSTRAINT FK_PRECIOTIPOLOCAL_idProducto FOREIGN KEY (idProducto) 
    REFERENCES PRODUCTOS (idProducto) ON DELETE CASCADE,
    CONSTRAINT FK_PRECIOTIPOLOCAL_idLocal FOREIGN KEY (idLocal)
    REFERENCES LOCALES (idLocal) ON DELETE CASCADE
);
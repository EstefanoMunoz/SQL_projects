-- Estructura para la base de datos --		-- Esquema definitivo --			-- Campos --

Create DataBase tiendaelectronica;			-- Para crear base de datos: (DDL) --
Use tiendaelectronica;						-- Para ingresar a la base de datos --

-- Creación de Tablas --

Create Table producto(								-- Creación tabla: Producto --
	ID_producto INT NOT NULL AUTO_INCREMENT,
	name_producto VARCHAR(20) NOT NULL,				-- Varchar: Cadena de caracteres del tipo alfanumerico --
    stock INT NOT NULL,
    precio INT(10) NOT NULL,
    PRIMARY KEY (ID_producto)
);

Create Table factura_venta(							-- Creación tabla: Factura de Venta --
	Nro_factura INT NOT NULL AUTO_INCREMENT,
    RUT_cliente VARCHAR(10) NOT NULL,
    ID_producto INT NOT NULL,			-- Cuando se ingresen los registros, hay que ver digitar el ID manualmente porque el id se crea en la tabla producto --
    cantidad_productos INT NOT NULL,
    descuento INT,
    PRIMARY KEY (Nro_factura)
);

Create Table empleado (								-- Creación tabla: Empleado --
	RUT VARCHAR(10) NOT NULL,
    nombre VARCHAR(20) NOT NULL,
    apellido_paterno VARCHAR(20) NOT NULL,
    apellido_materno VARCHAR(20) NOT NULL,
    email VARCHAR(30) NOT NULL,
    calle VARCHAR(30) NOT NULL,
    ciudad VARCHAR(30) NOT NULL,
    nro_domicilio INT(5) NOT NULL,
    es_vendedor BOOL, 			-- Aqui se mostrara si el empleado es vendedor (True) o no (False) --
    es_administrador BOOL,		-- Aqui se mostrará si el empleado es administrador (True) o no (False) --
    PRIMARY KEY (RUT)
);

Create Table proveedor(								-- Creación tabla: Proveedor --
	RUT VARCHAR(10) NOT NULL PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    apellido_paterno VARCHAR(20) NOT NULL,
    apellido_materno VARCHAR(20) NOT NULL,
    name_empresa_distribucion VARCHAR(50) NOT NULL,
    calle VARCHAR(30),
    ciudad VARCHAR(30),
    region VARCHAR(30),
    RUT_administrador VARCHAR(10) NOT NULL,
    nro_orden INT NOT NULL,		-- El número de orden no puede ser autoincremental, ya que los campos autoincrementales deben ser claves primarias. (Corrección y Analisis) , (Estefano, ten lo en cuenta) --
    cantidad INT NOT NULL,
    costo INT(10) NOT NULL,
    fecha_emision DATE,
    FOREIGN KEY (RUT_administrador) REFERENCES empleado (RUT) ON DELETE RESTRICT ON UPDATE RESTRICT		-- Para que esto funcione, se debe crear primero la tabla donde se encuentra la clave primaria (RUT del administrador en la tabla empleado) correspondiente a la clave foránea que
);																										-- se va a crear en esta tabla (aqui sera RUT_Administrador como clave foranea). Por cierto, la clave primaria está en la tabla empleado, no en la tabla 
																										-- administrador, de hecho, la tabla administrador no existe en tu esquema ya que utilizaste la estrategia
																										-- de crear una sola tabla para la jerarquía de clases. (Es por eso que el profe movio la tabla empleado encima de la tabla proovedor)

Create Table cliente(								-- Creación tabla: Cliente --
	RUT VARCHAR(10) NOT NULL,
    nombre VARCHAR(20) NOT NULL,
    apellido_paterno VARCHAR(20) NOT NULL,
    apellido_materno VARCHAR(20) NOT NULL,
	email VARCHAR(30) NOT NULL,
    calle VARCHAR(30) NOT NULL,
    ciudad VARCHAR(30) NOT NULL,
    nro_domicilio INT(5) NOT NULL,
    PRIMARY KEY (RUT)
);

Create Table admin_gestiona_empleado(				-- Creación tabla: Administrador Gestiona Empleado --
	RUT_administrador VARCHAR(10) NOT NULL,
    RUT_empleado VARCHAR(10) NOT NULL,
    PRIMARY KEY (RUT_administrador, RUT_empleado),
    FOREIGN KEY (RUT_administrador) REFERENCES empleado (RUT) ON DELETE RESTRICT ON UPDATE RESTRICT,		    -- En las tablas que son producto de la transformación de cardinalidades N:M, las claves primarias --
    FOREIGN KEY (RUT_empleado) REFERENCES empleado (RUT) ON DELETE RESTRICT ON UPDATE RESTRICT   			-- son a la vez claves foráneas. (Es por eso que se escriben estas dos lineas mas) , (Corrección y Analisis) --
);

Create Table admin_consulta_producto(				-- Creación tabla: Administrador Consulta Producto --
	RUT_administrador VARCHAR(10) NOT NULL,
    ID_producto INT NOT NULL,
    PRIMARY KEY (RUT_administrador, ID_producto),
    FOREIGN KEY (RUT_administrador) REFERENCES empleado (RUT) ON DELETE RESTRICT ON UPDATE RESTRICT,		    -- En las tablas que son producto de la transformación de cardinalidades N:M, las claves primarias --
    FOREIGN KEY (ID_producto) REFERENCES producto (ID_producto) ON DELETE RESTRICT ON UPDATE RESTRICT		-- son a la vez claves foráneas. (Es por eso que se escriben estas dos lineas mas) , (Corrección y Analisis) --
);

Create Table admin_consulta_cliente(				-- Creación tabla: Administrador Consulta Cliente --
	RUT_administrador VARCHAR(10) NOT NULL,
    RUT_cliente VARCHAR(10) NOT NULL,
    PRIMARY KEY (RUT_administrador, RUT_cliente),
    FOREIGN KEY (RUT_administrador) REFERENCES empleado (RUT) ON DELETE RESTRICT ON UPDATE RESTRICT,    		-- En las tablas que son producto de la transformación de cardinalidades N:M, las claves primarias --
    FOREIGN KEY (RUT_cliente) REFERENCES cliente (RUT) ON DELETE RESTRICT ON UPDATE RESTRICT					-- son a la vez claves foráneas. (Es por eso que se escriben estas dos lineas mas) , (Corrección y Analisis) --
);

Create Table vendedor_emite_factura(				-- Creación tabla: Vendedor Emite Factura --
	RUT_vendedor VARCHAR(10) NOT NULL,
    Nro_factura INT NOT NULL,
    PRIMARY KEY (RUT_vendedor, Nro_factura),
    FOREIGN KEY (RUT_vendedor) REFERENCES empleado (RUT) ON DELETE RESTRICT ON UPDATE RESTRICT,     			-- En las tablas que son producto de la transformación de cardinalidades N:M, las claves primarias
    FOREIGN KEY (Nro_Factura) REFERENCES factura_venta (Nro_factura) ON DELETE RESTRICT ON UPDATE RESTRICT   -- son a la vez claves foráneas. (Es por eso que se escriben estas dos lineas mas) , (Corrección y Analisis) --
);

Create Table vendedor_consulta_producto(			-- Creación tabla: Vendedor Consulta Producto --
	RUT_vendedor VARCHAR(10) NOT NULL,
    ID_producto INT NOT NULL,
    PRIMARY KEY (RUT_vendedor, ID_producto),
    FOREIGN KEY (RUT_vendedor) REFERENCES empleado (RUT) ON DELETE RESTRICT ON UPDATE RESTRICT,    			-- En las tablas que son producto de la transformación de cardinalidades N:M, las claves primarias --
	FOREIGN KEY (ID_producto) REFERENCES producto (ID_producto) ON DELETE RESTRICT ON UPDATE RESTRICT	    -- son a la vez claves foráneas. (Es por eso que se escriben estas dos lineas mas) , (Corrección y Analisis) --
);

Create Table cliente_compra_producto(				-- Creación tabla: Cliente Compra Producto --
	RUT_cliente VARCHAR(10) NOT NULL,
    ID_producto INT NOT NULL,
    PRIMARY KEY (RUT_cliente, ID_producto),
    FOREIGN KEY (RUT_cliente) REFERENCES cliente (RUT),    			-- En las tablas que son producto de la transformación de cardinalidades N:M, las claves primarias --
	FOREIGN KEY (ID_producto) REFERENCES producto (ID_producto)		-- son a la vez claves foráneas.  (Es por eso que se escriben estas dos lineas mas) , (Corrección y Analisis) --
);																   

Create Table telefono_empleado(						-- Creación tabla: Telefono Empleado --
	RUT_empleado VARCHAR(10) NOT NULL,
    telefono VARCHAR(9),
    PRIMARY KEY (RUT_empleado, telefono),
    FOREIGN KEY (RUT_empleado) REFERENCES  empleado (RUT) ON DELETE RESTRICT ON UPDATE RESTRICT	    -- En las tablas que son producto de la transformación de atributos multivaluados, la clave primarias --
);																									-- proveniente de la tabla donde se encuentra el atributo multivaluado es a la vez clave foránea. (Es por eso que se escribe una linea mas) , (Corrección y Analisis) --

Create Table telefono_cliente(						-- Creación tabla: Telefono Cliente --
	RUT_cliente VARCHAR(10) NOT NULL,
    telefono VARCHAR(9),
    PRIMARY KEY (RUT_cliente, telefono),
    FOREIGN KEY (RUT_cliente) REFERENCES  cliente (RUT) ON DELETE RESTRICT ON UPDATE RESTRICT    -- En las tablas que son producto de la transformación de atributos multivaluados, la clave primarias --
);    																							 -- proveniente de la tabla donde se encuentra el atributo multivaluado es a la vez clave foránea. (Es por eso que se escribe una linea mas) , (Corrección y Analisis) --
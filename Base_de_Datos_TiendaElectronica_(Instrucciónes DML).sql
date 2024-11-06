-- Estructura para la base de datos --

drop database if exists tiendaelectronica;
Create DataBase tiendaelectronica;
Use tiendaelectronica;

-- Creación de Tablas --

Create Table producto(								-- Creación tabla: Productos --
	ID_producto INT NOT NULL AUTO_INCREMENT,
	name_producto VARCHAR(20) NOT NULL,
    stock INT NOT NULL,
    precio INT(10) NOT NULL,
    PRIMARY KEY (ID_producto)
);

Create Table factura_venta(							-- Creación tabla: Factura de Venta --
	Nro_factura INT NOT NULL AUTO_INCREMENT,
    RUT_cliente VARCHAR(10) NOT NULL,
    ID_producto INT NOT NULL,
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
    es_vendedor BOOL,
    es_administrador BOOL,
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
    nro_orden INT NOT NULL,
    cantidad INT NOT NULL,
    costo INT(10) NOT NULL,
    fecha_emision DATE,
    FOREIGN KEY (RUT_administrador) REFERENCES empleado (RUT) ON DELETE RESTRICT ON UPDATE RESTRICT
);

Create Table cliente(								-- Creación tabla: Cliente --
	RUT VARCHAR(10) NOT NULL,
    nombre VARCHAR(20) NOT NULL,
    apellido_paterno VARCHAR(20) NOT NULL,
    apellido_materno VARCHAR(20) NOT NULL,
	email VARCHAR(60) NOT NULL,
    calle VARCHAR(30) NOT NULL,
    ciudad VARCHAR(30) NOT NULL,
    nro_domicilio INT(5) NOT NULL,
    PRIMARY KEY (RUT)
);

Create Table admin_gestiona_empleado(				-- Creación tabla: Administrador Gestiona Empleado --
	RUT_administrador VARCHAR(10) NOT NULL,
    RUT_empleado VARCHAR(10) NOT NULL,
    PRIMARY KEY (RUT_administrador, RUT_empleado),
    FOREIGN KEY (RUT_administrador) REFERENCES empleado (RUT) ON DELETE RESTRICT ON UPDATE RESTRICT,
    FOREIGN KEY (RUT_empleado) REFERENCES empleado (RUT) ON DELETE RESTRICT ON UPDATE RESTRICT
);

Create Table admin_consulta_producto(				-- Creación tabla: Administrador Consulta Producto --
	RUT_administrador VARCHAR(10) NOT NULL,
    ID_producto INT NOT NULL,
    PRIMARY KEY (RUT_administrador, ID_producto),
    FOREIGN KEY (RUT_administrador) REFERENCES empleado (RUT) ON DELETE RESTRICT ON UPDATE RESTRICT,
    FOREIGN KEY (ID_producto) REFERENCES producto (ID_producto) ON DELETE RESTRICT ON UPDATE RESTRICT
);

Create Table admin_consulta_cliente(				-- Creación tabla: Administrador Consulta Cliente --
	RUT_administrador VARCHAR(10) NOT NULL,
    RUT_cliente VARCHAR(10) NOT NULL,
    PRIMARY KEY (RUT_administrador, RUT_cliente),
    FOREIGN KEY (RUT_administrador) REFERENCES empleado (RUT) ON DELETE RESTRICT ON UPDATE RESTRICT,
    FOREIGN KEY (RUT_cliente) REFERENCES cliente (RUT) ON DELETE RESTRICT ON UPDATE RESTRICT
);

Create Table vendedor_emite_factura(				-- Creación tabla: Vendedor Emite Factura --
	RUT_vendedor VARCHAR(10) NOT NULL,
    Nro_factura INT NOT NULL,
    PRIMARY KEY (RUT_vendedor, Nro_factura),
    FOREIGN KEY (RUT_vendedor) REFERENCES empleado (RUT) ON DELETE RESTRICT ON UPDATE RESTRICT,
    FOREIGN KEY (Nro_Factura) REFERENCES factura_venta (Nro_factura) ON DELETE RESTRICT ON UPDATE RESTRICT
);

Create Table vendedor_consulta_producto(			-- Creación tabla: Vendedor Consulta Producto --
	RUT_vendedor VARCHAR(10) NOT NULL,
    ID_producto INT NOT NULL,
    PRIMARY KEY (RUT_vendedor, ID_producto),
    FOREIGN KEY (RUT_vendedor) REFERENCES empleado (RUT) ON DELETE RESTRICT ON UPDATE RESTRICT,
	FOREIGN KEY (ID_producto) REFERENCES producto (ID_producto) ON DELETE RESTRICT ON UPDATE RESTRICT
);

Create Table cliente_compra_producto(				-- Creación tabla: Cliente Compra Producto --
	RUT_cliente VARCHAR(10) NOT NULL,
    ID_producto INT NOT NULL,
    PRIMARY KEY (RUT_cliente, ID_producto),
    FOREIGN KEY (RUT_cliente) REFERENCES cliente (RUT),
	FOREIGN KEY (ID_producto) REFERENCES producto (ID_producto)
);																   

Create Table telefono_empleado(						-- Creación tabla: Telefono Empleado --
	RUT_empleado VARCHAR(10) NOT NULL,
    telefono VARCHAR(9),
    PRIMARY KEY (RUT_empleado, telefono),
    FOREIGN KEY (RUT_empleado) REFERENCES  empleado (RUT) ON DELETE RESTRICT ON UPDATE RESTRICT
);

Create Table telefono_cliente(						-- Creación tabla: Telefono Cliente --
	RUT_cliente VARCHAR(10) NOT NULL,
    telefono VARCHAR(9),
    PRIMARY KEY (RUT_cliente, telefono),
    FOREIGN KEY (RUT_cliente) REFERENCES  cliente (RUT) ON DELETE RESTRICT ON UPDATE RESTRICT
);

-- Ingreso de Registros --

Insert Into producto (name_producto, stock, precio)										-- Ingreso de Resgistros en la tabla Producto --
Values
("Lavadora", 50, 500000),
("Horno", 30, 350000),
("Aspiradora", 40, 300000),
("Cafetera", 60, 150000),
("Refrigerador", 25, 700000);

Insert Into factura_venta (RUT_cliente, ID_producto, cantidad_productos, descuento)			-- Ingreso de Resgistros en la tabla Factura de Venta --
Values
("24832571-9", 1, 2, -70000),
("26726149-4", 2, 3, -70000),
("21538216-k", 3, 2, -70000),
("21798324-7", 4, 1, 0),
("23864201-5", 5, 1, 0);

Insert Into empleado (RUT, nombre, apellido_paterno, apellido_materno, email, calle, ciudad, nro_domicilio, es_vendedor, es_administrador)			-- Ingreso de Resgistros en la tabla Empleado --
Values
("21246861-9", "Alfonso", "Gonzalez", "Monsalve", "alfonsogonzalez61@gmail.com", "Las Petunias", "Santiago", 221, False, True),					-- Admin --
("24339857-2", "Marta", "Pérez", "García", "martaperez57@gmail.com", "Presidente Manuel Montolla", "Santiago", "513", True, False),				-- Empleado / Vendedor --
("26216948-6", "Alejandro", "Rodríguez", "López", "alejandrorodriguez48@gmail.com", "Las Camelias", "Antofagasta", "752", True, False),			-- Empleado / Vendedor --
("21466855-7", "Valentina", "Martínez", "Ruiz", "valentinamartinez55@gmail.com", "La Esperanza", "Concepción", "128", False, True),				-- Admin --
("21564824-k", "Carlos", "Sánchez", "González", "carlossanchez24@gmail.com", "4 de Septiembre", "Talca", "937", False, True),					-- Admin --
("23456789-3", "Paula", "Mendoza", "Silva", "paulamendoza89@gmail.com", "Avenida de las Palmeras", "Temuco", 102, True , False),				-- Empleado / Vendedor --
("23567890-1", "Daniel", "Morales", "González", "danielmorales90@gmail.com", "Paseo del Bosque", "Viña del Mar", 215, False , True),			-- Admin --
("24678901-k", "Catalina", "Rojas", "Soto", "catalinarojas01@gmail.com", "Runas Flores", "Antofagasta", 389, True, False),						-- Empleado / Vendedor --
("25789012-8", "Eduardo", "Castillo", "Pérez", "eduardocastillo12@gmail.com", "Boulevard de las Mariposas", "La Serena", 124, True, False),		-- Empleado / Vendedor --
("26890123-4", "Javiera", "Valentina", "Ortiz", "javiervalentinao23@gmail.com", "Los Sueños", "Puerto Montt", 503, False, True);				-- Admin --

Insert Into proveedor (RUT, nombre, apellido_paterno, apellido_materno, name_empresa_distribucion, calle, ciudad, region, RUT_administrador, nro_orden, cantidad, costo, fecha_emision)			-- Ingreso de Resgistros en la tabla Proovedor --
Values
("12345678-9", "María", "González", "Silva", "ElectroTech", "Avenida del Sol", "Valdivia", "Los Ríos", "21246861-9", 52341, 50, 125000000, "2023-03-02"),
("98765432-1", "Juan", "Rodríguez", "Pérez", "TechHub", " Las Flores", "La Serena", "Coquimbo", "21466855-7", 68134, 30, 5250000, "2022-08-27"),
("11223344-5", "Carolina", "Sánchez", "Vargas", "ElectroWare", "Paseo de la Montaña", "Chillán", "Ñuble", "21564824-k", 46843, 40, 6000000, "2023-07-18"),
("55555555-k", "Andrés", "Fernández", "Morales", "SmartLiving", "Ruado Mar", "Iquique", "Tarapacá", "23567890-1", 23571, 60, 4500000, "2022-09-06"),
("26912807-6", "Claudia", "Vidal", "Rojas", "FutureHome", "Avenida de la Luna", "Puerto Montt", "Los Lagos", "26890123-4", 42135, 25, 8750000, "2023-01-21");

Insert Into cliente (RUT, nombre, apellido_paterno, apellido_materno, email, calle, ciudad, nro_domicilio)			-- Ingreso de Resgistros en la tabla Cliente --
Values
("24832571-9", "Gabriela", "Soto", "Gómez", "gabrielasotogomez33@gmail.com", "Avenida de los Volcanes", "Valdivia", 315),
("26726149-4", "Nicolás", "Leiva", "Valenzuela", "nicolasleivavalenzuela44@gmail.com", "Paseo del Mar", "Antofagasta", 208),
("21538216-k", "Francisca", "Palma", "Rojas", "franciscapalmarojas55@gmail.com", "Rua das Estrelas", "Concepción", 426),
("21798324-7", "Sergio", "Ortega", "Maldonado", "sergioortegamaldonado66@gmail.com", "Calle de las Rosas", "Valparaíso", 137),
("23864201-5", "Romina", "Pizarro", "Muñoz", "rominapizarromunoz77@gmail.com", "Avenida de las Aves", "La Serena", 503);

Insert Into admin_gestiona_empleado (RUT_administrador, RUT_empleado)			-- Ingreso de Resgistros en la tabla Administrador Gestiona Empleado --
Values
("21246861-9", "24339857-2"),
("21466855-7", "26216948-6"),
("21564824-k", "23456789-3"),
("23567890-1", "24678901-k"),
("26890123-4", "25789012-8");

Insert Into admin_consulta_producto (RUT_administrador, ID_producto)			-- Ingreso de Resgistros en la tabla Administrador Consulta Producto --
values
("21246861-9", 1),
("21466855-7", 2),
("21564824-k", 3),
("23567890-1", 4),
("26890123-4", 5);

Insert Into admin_consulta_cliente (RUT_administrador, RUT_cliente)				-- Ingreso de Resgistros en la tabla Administrador Consulta Cliente --
Values
("21246861-9", "24832571-9"),
("21466855-7", "26726149-4"),
("21564824-k", "21538216-k"),
("23567890-1", "21798324-7"),
("26890123-4", "23864201-5");

Insert Into vendedor_emite_factura (RUT_vendedor, Nro_factura)			-- Ingreso de Resgistros en la tabla Vendedor Emite Factura --
Values																	-- Aunque aqui parezca que estan las mismas "values" que en la tabla vendedor consulta productos, los resultados son diferentes --
("24339857-2", 1),
("26216948-6", 2),
("23456789-3", 3),
("24678901-k", 4),
("25789012-8", 5);

Insert Into vendedor_consulta_producto (RUT_vendedor, ID_producto)		-- Ingreso de Resgistros en la tabla Vendedor Consulta Producto --
Values																 	-- Aunque aqui parezca que estan las mismas "values" que en la tabla vendedor emite factura, los resultados son diferentes --
("24339857-2", 1),
("26216948-6", 2),
("23456789-3", 3),
("24678901-k", 4),
("25789012-8", 5);

Insert Into cliente_compra_producto (RUT_cliente, ID_producto)			-- Ingreso de Resgistros en la tabla Cliente Compra Producto --
Values
("24832571-9", 1),
("26726149-4", 2),
("21538216-k", 3),
("21798324-7", 4),
("23864201-5", 5);

Insert Into telefono_empleado (RUT_empleado, telefono)					-- Ingreso de Resgistros en la tabla Telefono del Empleado --
Values
("24339857-2", "93421768"),
("26216948-6", "98504312"),
("23456789-3", "97658234"),
("24678901-k", "99876543"),
("25789012-8", "92345678");

Insert Into telefono_cliente (RUT_cliente, telefono)					-- Ingreso de Resgistros en la tabla Telefono del Cliente --
Values
("24832571-9", "97621345"),
("26726149-4", "99456789"),
("21538216-k", "98123456"),
("21798324-7", "96387451"),
("23864201-5", "99901234");

-- Generación de Consultas --

Select * From producto;											-- 1.- Consulta que muestra el Inventario general de la tienda. --

Select * From cliente;											-- 2.- Consulta que muestra a los Clientes. --

Select RUT, nombre, apellido_paterno, apellido_materno, email, calle, ciudad, nro_domicilio, es_administrador From empleado Where es_administrador = 1;				-- 3.- Consulta que muestra solo a los empleados administradores de la empresa --

SELECT
-- Datos de los administradores
e1.RUT AS "RUT del Administrador", 
e1.nombre AS "Nombre del Administrador", 
e1.apellido_paterno AS "Apellido Paterno del Administrador", 
e1.apellido_materno AS "Apellido Materno del Administrador", 
e1.es_administrador AS "Verificación de Empleado Administrador", -- este campo no sería necesario realmente
-- Datos de los vendedores
e2.RUT AS "RUT del Vendedor gestionado por el Administrador",
e2.nombre AS "Nombre del Vendedor",
e2.apellido_paterno AS "Apellido Paterno del Vendedor", 
e2.apellido_materno AS "Apellido Materno del Vendedor"
-- Uso del INNER JOIN dos veces
FROM admin_gestiona_empleado AS age -- tabla admin_gestiona_empleado y su Alias
-- Primera combinación con la tabla empleados, es decir, con e1
INNER JOIN empleado AS e1 ON age.RUT_administrador = e1.RUT
-- segunda combinación con la tabla empleados, es decir, con e2 
INNER JOIN empleado AS e2 ON age.RUT_empleado = e2.RUT;									-- 4.- Consulta que muestra a los Empleados que gestionan los Administradores --

SELECT RUT AS "RUT del Vendedor", nombre AS "Nombre del Vendedor", apellido_paterno AS "Apellido Paterno del Vendedor", apellido_materno AS "Apellido Materno del Vendedor", es_vendedor AS "Verificación de Empleado Vendedor", name_producto AS "Nombre del Producto", stock AS "Stock", precio AS "Precio" FROM empleado inner join vendedor_consulta_producto on empleado.RUT = vendedor_consulta_producto.RUT_vendedor inner join producto on vendedor_consulta_producto.ID_producto = producto.ID_producto;		-- 5.- Consulta que muestre los productos que consultan los vendedores --




/* Realizar 5 consultas SELECT: - 2 consultas que utilicen dos tablas 
								- 3 consultas simples (1 tabla por consulta)

Consultas:
1.- Consulta que muestre los productos. (Tabla de producto)
2.- Consulta que muestre a los clientes. (Tabla de Clientes)
3.- Consulta que muestre solo a los empleados administradores. (Filtrado en la tabla de Empleados)
4.- Consulta que muestre a los empleados que gestionan los administradores (Tabla Empleados (Administradores) + Tabla Administrador gestiona Empleados + "Tabla Empleado (Vendedores)")
5.- Consulta que muestre los productos que consultan los vendedores (Tabla Empleados (Vendores) + Tabla vendedor_consulta_producto + Tabla producto)*/
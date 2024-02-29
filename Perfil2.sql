DROP DATABASE if EXISTS perfil2;

CREATE DATABASE perfil2;

USE perfil2;

CREATE TABLE clientes(
    cliente_id BINARY(16) PRIMARY KEY DEFAULT UUID(),
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    telefono VARCHAR(10),
    direccion VARCHAR(255)
);

CREATE TABLE empleados(
    empleado_id BINARY(16) PRIMARY KEY DEFAULT UUID(),
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    cargo VARCHAR(50),
    fecha_contratacion DATE,
    salario DECIMAL(10,2)
);

CREATE TABLE pedidos(
    pedido_id BINARY(16) PRIMARY KEY DEFAULT UUID(),
    cliente_id BINARY(16), -- Cambiado a BINARY(16)
    fecha_pedido DATE,
    total DECIMAL(10,2),
    estado VARCHAR(20),
    empleado_id BINARY(16) -- Cambiado a BINARY(16)
);

CREATE TABLE productos(
    producto_id BINARY(16) PRIMARY KEY DEFAULT UUID(),
    nombre VARCHAR(100),
    descripcion VARCHAR(300),
    precio DECIMAL(10,2),
    existencias INT
);

CREATE TABLE detalles_pedido(
    detalle_id BINARY(16) PRIMARY KEY DEFAULT UUID(),
    pedido_id BINARY(16), -- Cambiado a BINARY(16)
    producto_id BINARY(16), -- Cambiado a BINARY(16)
    cantidad INT,
    precio_unitario DECIMAL(10,2),
    subtotal DECIMAL(10,2)
);

-- Agrega las restricciones de clave foránea después de haber ajustado los tipos de datos
ALTER TABLE pedidos
ADD CONSTRAINT fk_pedidos_clientes FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id);

ALTER TABLE pedidos
ADD CONSTRAINT fk_pedidos_empleados FOREIGN KEY (empleado_id) REFERENCES empleados(empleado_id);

ALTER TABLE detalles_pedido
ADD CONSTRAINT fk_detalles_pedido_pedidos FOREIGN KEY (pedido_id) REFERENCES pedidos(pedido_id);

ALTER TABLE detalles_pedido
ADD CONSTRAINT fk_detalles_pedido_productos FOREIGN KEY (producto_id) REFERENCES productos(producto_id);

-- TRIGGER para ACTUALIZAR la CANTIDAD EN EXISTENCIAS de un producto DESPUES de haber INSERTADO un nuevo registro en detalles_pedido

DELIMITER //

CREATE TRIGGER actualizar_existencias
AFTER INSERT ON detalles_pedido
FOR EACH ROW
BEGIN
    UPDATE productos
    SET existencias = existencias - NEW.cantidad
    WHERE producto_id = NEW.producto_id;
END//

DELIMITER ;
  


-- Tabla de clientes (NO depende de otras tablas)

DELIMITER |

CREATE PROCEDURE insert_clientes(
    IN cliente_id VARCHAR(36),
    IN nombre VARCHAR(50),
    IN apellido VARCHAR(50),
    IN telefono VARCHAR(10),
    IN direccion VARCHAR(255) 
)
BEGIN
    DECLARE id_uuid VARCHAR(36);
    SET id_uuid = UUID();
    
    INSERT INTO clientes (cliente_id, nombre, apellido, telefono, direccion) 
    VALUES (id_uuid, nombre, apellido, telefono, direccion); 
END|

DELIMITER ;

CALL insert_clientes('Raman1','Bangalore1','Computers1','7777-771', 'boulevard los heroes1');
CALL insert_clientes('Raman2','Bangalore2','Computers2','7777-7772', 'boulevard los heroes2');
CALL insert_clientes('Raman3','Bangalore3','Computers3','7777-773', 'boulevard los heroes3');
CALL insert_clientes('Raman4','Bangalore4','Computers4','7777-774', 'boulevard los heroes4');
CALL insert_clientes('Raman5','Bangalore5','Computers5','7777-775', 'boulevard los heroes5');
CALL insert_clientes('Raman7','Bangalore7','Computers7','7777-777', 'boulevard los heroes7');
CALL insert_clientes('Raman8','Bangalore8','Computers8','7777-778', 'boulevard los heroes8');
CALL insert_clientes('Raman9','Bangalore9','Computers9','7777-779', 'boulevard los heroes9');
CALL insert_clientes('Raman10','Bangalore10','Computers10','7777-7770', 'boulevard los heroes10');
CALL insert_clientes('Raman11','Bangalore11','Computers11','7777-7712', 'boulevard los heroes11');
CALL insert_clientes('Raman12','Bangalore12','Computers12','7777-7713', 'boulevard los heroes12');
CALL insert_clientes('Raman13','Bangalore13','Computers13','7777-7714', 'boulevard los heroes13');
CALL insert_clientes('Raman14','Bangalore14','Computers14','7777-7715', 'boulevard los heroes14');
CALL insert_clientes('Raman15','Bangalore15','Computers15','7777-7716', 'boulevard los heroes15');


-- Tabla de empleados (NO depende de otras tablas)
DELIMITER |

CREATE PROCEDURE insert_empleados(
    IN empleado_id VARCHAR(36),
    IN nombre VARCHAR(50),
    IN apellido VARCHAR(50),
    IN cargo VARCHAR(10),
    IN fecha_contratacion DATE,
    IN salario DECIMAL(10,2)
)
BEGIN
    DECLARE id_uuid VARCHAR(36);
    SET id_uuid = UUID();
    
    INSERT INTO empleados (empleado_id, nombre, apellido, cargo, fecha_contratacion, salario) 
    VALUES (id_uuid, nombre, apellido, cargo, fecha_contratacion, salario); 
END|

DELIMITER ;

CALL insert_empleados('Roberto','jose','Bangalore','jefe','01-01-2020', 950.090);
CALL insert_empleados('Roberto1','jose1','Bangalore1','jefe','2020-01-01', 950.800);
CALL insert_empleados('Roberto2','jose2','Bangalore2','jefe','2020-01-01', 950.080);
CALL insert_empleados('Roberto3','jose3','Bangalore1','jefe','2020-01-01', 950.009);
CALL insert_empleados('Roberto4','jose4','Bangalore2','jefe','2020-01-01', 950.007);
CALL insert_empleados('Roberto5','jose5','Bangalore1','jefe','2020-01-01', 950.030);
CALL insert_empleados('Roberto6','jose6','Bangalore2','jefe','2020-01-01', 950.080);
CALL insert_empleados('Roberto7','jose7','Bangalore1','jefe','2020-01-01', 950.0900);
CALL insert_empleados('Roberto8','jose8','Bangalore2','jefe','2020-01-01', 950.006);
CALL insert_empleados('Roberto9','jose9','Bangalore1','jefe','2020-01-01', 950.008);
CALL insert_empleados('Roberto10','jose10','Bangalore2','jefe','2020-01-01', 950.090);
CALL insert_empleados('Roberto11','jose11','Bangalore1','jefe','2020-01-01', 950.009);
CALL insert_empleados('Roberto12','jose12','Bangalore2','jefe','2020-01-01', 950.000);
CALL insert_empleados('Roberto13','jose13','Bangalore1','jefe','2020-01-01', 950.007);
CALL insert_empleados('Roberto14','jose14','Bangalore2','jefe','2020-01-01', 950.008);



-- Tabla de productos (NO depende de otras tablas)
DELIMITER |

CREATE PROCEDURE insert_productos(
    IN producto_id VARCHAR(36),
    IN nombre VARCHAR(50),
    IN descripcion VARCHAR(50),
    IN precio DECIMAL(10,2),
    IN existencias INT
)
BEGIN
    DECLARE id_uuid VARCHAR(36);
    SET id_uuid = UUID();

    INSERT INTO productos (producto_id, nombre, descripcion, precio, existencias)
VALUES(uuid() ,nombre, descripcion, precio, existencias);
END

DELIMITER ;


CALL insert_productos('jabon1','adove','es rojo', 130.5, 3);
CALL insert_productos('shampoo2','pantene','es azul', 150.75, 5);
CALL insert_productos('toalla3','charmin','es verde', 99.99, 8);
CALL insert_productos('cepillo4','colgate','es amarillo', 49.99, 10);
CALL insert_productos('pasta de dientes5','colgate','es blanca', 79.99, 12);
CALL insert_productos('crema facial6','nivea','es rosada', 199.99, 15);
CALL insert_productos('champu7','pantene','es transparente', 119.99, 20);
CALL insert_productos('gel de baño8','dove','es celeste', 89.99, 25);
CALL insert_productos('toallitas humedas9','huggies','es morado', 79.99, 30);
CALL insert_productos('desodorante10','rexona','es blanco', 59.99, 35);
CALL insert_productos('jabon de tocador11','dove','es beige', 49.99, 40);
CALL insert_productos('crema corporal12','nivea','es cafe', 199.99, 45);
CALL insert_productos('acondicionador13','herbal essences','es verde', 129.99, 50);
CALL insert_productos('locion corporal14','jergens','es naranja', 169.99, 55);
CALL insert_productos('pasta dental15','sensodyne','es azul', 89.99, 60);

-- Tabla de pedidos (depende de: empleados y clientes)
DELIMITER |

CREATE PROCEDURE insert_pedidos(
    IN pedido_id VARCHAR(36),
    IN cliente_id VARCHAR(36),
    IN fecha_pedido DATE,
    IN total DECIMAL(10,2),
    IN estado VARCHAR(20),
    IN empleado_id VARCHAR(36)
)
BEGIN
    DECLARE id_uuid VARCHAR(36);
    SET id_uuid = UUID();

    INSERT INTO pedidos (pedido_id, cliente_id, fecha_pedido, total, estado, empleado_id)
VALUES(uuid() ,cliente_id, fecha_pedido, total, estado, empleado_id);
END

DELIMITER ;

CALL insert_pedidos('jamon1','Raman9','01-01-2020', 150.00, 'listo', 'Roberto1');
CALL insert_pedidos('jamon2', 'Raman10', '01-02-2020', 155.00, 'listo', 'Roberto2');
CALL insert_pedidos('jamon3', 'Raman11', '01-03-2020', 160.00, 'listo', 'Roberto3');
CALL insert_pedidos('jamon4', 'Raman12', '01-04-2020', 165.00, 'listo', 'Roberto4');
CALL insert_pedidos('jamon5', 'Raman13', '01-05-2020', 170.00, 'listo', 'Roberto5');
CALL insert_pedidos('jamon6', 'Raman14', '01-06-2020', 175.00, 'listo', 'Roberto6');
CALL insert_pedidos('jamon7', 'Raman15', '01-07-2020', 180.00, 'listo', 'Roberto7');
CALL insert_pedidos('jamon8', 'Raman16', '01-08-2020', 185.00, 'listo', 'Roberto8');
CALL insert_pedidos('jamon9', 'Raman17', '01-09-2020', 190.00, 'listo', 'Roberto9');
CALL insert_pedidos('jamon10', 'Raman18', '01-10-2020', 195.00, 'listo', 'Roberto10');
CALL insert_pedidos('jamon11', 'Raman19', '01-11-2020', 200.00, 'listo', 'Roberto11');
CALL insert_pedidos('jamon12', 'Raman20', '01-12-2020', 205.00, 'listo', 'Roberto12');
CALL insert_pedidos('jamon13', 'Raman21', '01-13-2020', 210.00, 'listo', 'Roberto13');
CALL insert_pedidos('jamon14', 'Raman22', '01-14-2020', 215.00, 'listo', 'Roberto14');
CALL insert_pedidos('jamon15', 'Raman23', '01-15-2020', 220.00, 'listo', 'Roberto15');



-- Tabla de detalles_pedido (depende de: pedidos y productos)

DELIMITER |

CREATE PROCEDURE insert_detalles_pedido (
    IN detalle_id VARCHAR(36),
    IN pedido_id VARCHAR(36),
    IN producto_id VARCHAR(36),
    IN cantidad INT,
    IN precio_unitario DECIMAL(10,2),
    IN subtotal DECIMAL(10,2)
)
BEGIN
    INSERT INTO detalles_pedido (detalle_id, pedido_id, producto_id, cantidad, precio_unitario, `subtotal`)
    VALUES(UUID(), pedido_id, producto_id, cantidad, precio_unitario, subtotal);
END

DELIMITER ;


-- Insertar datos básicos

INSERT INTO pais (nombre) VALUES ('Chile');
INSERT INTO region (id_pais, nombre) VALUES (1, 'Metropolitana');
INSERT INTO comuna (id_region, nombre) VALUES (1, 'Santiago');

INSERT INTO clientes (nombre, email, telefono) 
VALUES ('Juan Pérez', 'juan@mail.com', '912345678');

INSERT INTO productos (nombre, descripcion, precio, stock)
VALUES ('Teclado Mecánico', 'Teclado retroiluminado RGB', 39990, 100);

-- Insertar pedido
INSERT INTO pedidos (id_cliente, fecha_pedido, total, estado_pedido)
VALUES (1, CURDATE(), 39990, 'Pendiente');

INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad, precio_unitario)
VALUES (1, 1, 1, 39990);

INSERT INTO direcciones_envio (id_cliente, direccion_calle, id_comuna, direccion_codigo_postal)
VALUES (1, 'Av. Siempre Viva 123', 1, '8320000');

INSERT INTO envios (id_pedido, id_direccion_envio, fecha_envio, estado_envio)
VALUES (1, 1, CURDATE(), 'En camino');

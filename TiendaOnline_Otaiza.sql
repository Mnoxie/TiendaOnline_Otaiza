
-- Crear base de datos
DROP DATABASE IF EXISTS TiendaOnline_Otaiza;
CREATE DATABASE TiendaOnline_Otaiza;
USE TiendaOnline_Otaiza;

-- Tabla: pais
CREATE TABLE pais (
  id_pais INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) UNIQUE
);

-- Tabla: region
CREATE TABLE region (
  id_region INT AUTO_INCREMENT PRIMARY KEY,
  id_pais INT NOT NULL,
  nombre VARCHAR(100),
  FOREIGN KEY (id_pais) REFERENCES pais(id_pais)
);

-- Tabla: comuna
CREATE TABLE comuna (
  id_comuna INT AUTO_INCREMENT PRIMARY KEY,
  id_region INT NOT NULL,
  nombre VARCHAR(100),
  FOREIGN KEY (id_region) REFERENCES region(id_region)
);

-- Tabla: clientes
CREATE TABLE clientes (
  id_cliente INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100),
  email VARCHAR(100) UNIQUE,
  telefono VARCHAR(20)
);

-- Tabla: productos
CREATE TABLE productos (
  id_producto INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100),
  descripcion TEXT,
  precio DECIMAL(10,2),
  stock INT
);

-- Tabla: pedidos
CREATE TABLE pedidos (
  id_pedido INT AUTO_INCREMENT PRIMARY KEY,
  id_cliente INT NOT NULL,
  fecha_pedido DATE,
  total DECIMAL(10,2),
  estado_pedido VARCHAR(50),
  FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

-- Tabla: detalle_pedido
CREATE TABLE detalle_pedido (
  id_detalle INT AUTO_INCREMENT PRIMARY KEY,
  id_pedido INT NOT NULL,
  id_producto INT NOT NULL,
  cantidad INT,
  precio_unitario DECIMAL(10,2),
  FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
  FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- Tabla: pagos
CREATE TABLE pagos (
  id_pago INT AUTO_INCREMENT PRIMARY KEY,
  id_pedido INT NOT NULL,
  fecha_pago DATE,
  metodo_pago VARCHAR(50),
  estado_pago VARCHAR(50),
  FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido)
);

-- Tabla: direcciones_envio
CREATE TABLE direcciones_envio (
  id_direccion INT AUTO_INCREMENT PRIMARY KEY,
  id_cliente INT NOT NULL,
  direccion_calle VARCHAR(255),
  id_comuna INT NOT NULL,
  direccion_codigo_postal VARCHAR(20),
  FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
  FOREIGN KEY (id_comuna) REFERENCES comuna(id_comuna)
);

-- Tabla: envios
CREATE TABLE envios (
  id_envio INT AUTO_INCREMENT PRIMARY KEY,
  id_pedido INT NOT NULL,
  id_direccion_envio INT NOT NULL,
  fecha_envio DATE,
  estado_envio VARCHAR(50),
  FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
  FOREIGN KEY (id_direccion_envio) REFERENCES direcciones_envio(id_direccion)
);

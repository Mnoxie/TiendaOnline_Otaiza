
-- Vistas

CREATE VIEW vista_pedidos_clientes AS
SELECT 
    p.id_pedido,
    c.nombre AS cliente,
    p.fecha_pedido,
    p.total,
    p.estado_pedido
FROM pedidos p
JOIN clientes c ON p.id_cliente = c.id_cliente;

CREATE VIEW vista_detalle_pedido AS
SELECT 
    dp.id_pedido,
    pr.nombre AS producto,
    dp.cantidad,
    dp.precio_unitario
FROM detalle_pedido dp
JOIN productos pr ON dp.id_producto = pr.id_producto;

CREATE VIEW vista_envios_estado AS
SELECT 
    e.id_envio,
    p.id_pedido,
    e.fecha_envio,
    e.estado_envio
FROM envios e
JOIN pedidos p ON e.id_pedido = p.id_pedido;

-- Función

DELIMITER //

CREATE FUNCTION obtener_total_pedido(pedido_id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
  DECLARE total DECIMAL(10,2);
  SELECT SUM(cantidad * precio_unitario)
  INTO total
  FROM detalle_pedido
  WHERE id_pedido = pedido_id;
  RETURN total;
END;
//

DELIMITER ;

-- Stored Procedure

DELIMITER //

CREATE PROCEDURE registrar_pago (
    IN pedido_id INT,
    IN metodo VARCHAR(50),
    IN estado VARCHAR(50)
)
BEGIN
    INSERT INTO pagos (id_pedido, fecha_pago, metodo_pago, estado_pago)
    VALUES (pedido_id, CURDATE(), metodo, estado);

    UPDATE pedidos
    SET estado_pedido = 'Pagado'
    WHERE id_pedido = pedido_id;
END;
//

DELIMITER ;

-- Trigger

DELIMITER //

CREATE TRIGGER trg_actualizar_stock
AFTER INSERT ON detalle_pedido
FOR EACH ROW
BEGIN
    UPDATE productos
    SET stock = stock - NEW.cantidad
    WHERE id_producto = NEW.id_producto;
END;
//

DELIMITER ;

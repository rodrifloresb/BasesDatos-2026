-- Parcial 1 | 2026

-- 1

SELECT prestamos.id_prestamo, concat(clientes.apellido, ", ",clientes.nombre) AS apellidoNombre,
    clientes.provincia, prestamos.monto_solicitado, prestamos.estado,
    prestamos.fecha_otorgamiento
FROM prestamos
JOIN clientes ON prestamos.id_cliente = clientes.id_cliente
WHERE prestamos.estado = "vigente" OR prestamos.estado = "en_mora"
    AND prestamos.monto_solicitado > 200000
    AND prestamos.monto_solicitado < 600000
ORDER BY prestamos.monto_solicitado DESC, clientes.apellido ASC;

-- 2

SELECT concat(clientes.apellido, ", ",clientes.nombre) AS NombreCompleto,
    clientes.provincia, res.CantidadPrestamos, res.CapitalTotal,
    res.FechaUltimoPrestamo
FROM clientes
JOIN (
    SELECT id_cliente, COUNT(id_cliente) AS CantidadPrestamos,
        SUM(monto_solicitado) AS CapitalTotal,
        MAX(fecha_otorgamiento) AS FechaUltimoPrestamo
    FROM prestamos
    GROUP BY id_cliente
    ORDER BY id_cliente ASC
) AS res ON res.id_cliente = clientes.id_cliente
WHERE res.CantidadPrestamos > 1;

-- 3.1 

CREATE TABLE log_cobranzas (
    id_log INT UNSIGNED NOT NULL AUTO_INCREMENT,
    id_pago INT UNSIGNED NOT NULL,
    id_prestamo INT UNSIGNED NOT NULL,
    fecha_pago DATE NOT NULL,
    monto_pagado DECIMAL(12,2) NOT NULL,
    medio_pago VARCHAR(30) NOT NULL,
    registrado_el DATETIME NOT NULL,
    PRIMARY KEY (id_log)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 3.2

-- No funciona.

/*
DELIMITER $$
CREATE TRIGGER log_nuevo_pago 
AFTER INSERT ON pagos
FOR EACH ROW
BEGIN 
    INSERT INTO log_cobranzas(id_pago, id_prestamo fecha_pago, monto_pagado, medio_pago)
    VALUES (NEW.id_pago, tempPrestamo, NEW.fecha_pago, NEW.monto_pagado, NEW.medio_pago);
    SELECT id_prestamo FROM cuotas WHERE id_cuota = NEW.id_cuota; AS tempPrestamo
END; $$

*/
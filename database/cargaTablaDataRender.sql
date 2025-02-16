SELECT * FROM roles;

SELECT * FROM usuarios;

	
/*INSERT INTO usuarios (usu_nombre, usu_email, usu_contrasena, usu_direccion, usu_telefono, rol_id) VALUES
('Alice Flores', 'alice@example.com', 'hashedpassword123', 'Av. Jardines 123, Ciudad Verde', '123456789', 2), --cliente
('Bob Jardinero', 'bob@example.com', 'hashedpassword456', 'Calle Plantas 456, Ciudad Verde', '987654321', 3),
('Admin Plantas', 'admin@example.com', 'hashedpassword789', 'Av. Central 789, Ciudad Verde', '111222333', 1);*/

/*CREATE TABLE categorias (
    cat_id SERIAL PRIMARY KEY,
    cat_nombre VARCHAR(100) UNIQUE NOT NULL
);
INSERT INTO categorias (cat_nombre) VALUES
('Plantas'),
('Herramientas'),
('Fertilizantes'),
('Macetas');*/

SELECT * FROM categorias;

-- PRODUCTOS

/*CREATE TABLE productos (
    pro_id SERIAL PRIMARY KEY,
    pro_descripcion VARCHAR(255) NOT NULL, 	--cambia a descripcion
    pro_caracteristica TEXT,									--cambia a caracteristicas
    pro_precio DECIMAL(10,2) NOT NULL,
    pro_stock INT NOT NULL,
    pro_imagen_url TEXT,
    cat_id INT REFERENCES categorias(cat_id)
);*/
/*INSERT INTO productos (pro_descripcion, pro_caracteristica, pro_precio, pro_stock, pro_imagen_url, cat_id)
VALUES
('Rosa del Desierto', 'Planta decorativa resistente al sol'		, 1000, 1000, 'url-imagen-rosa', 1),
('Palas de Jardinería', 'Pala multiusos para jardinería'		, 2000, 1000, 'url-imagen-palas', 2),
('Compost Orgánico', 'Compost natural para mejorar el suelo'	, 3000, 1000, 'url-imagen-compost', 3);*/

SELECT * FROM productos;

--5 Carrito de Compras (carrito)
--Relaciona los productos que un usuario ha añadido a su carrito.
/*CREATE TABLE carro_compra (
    car_id SERIAL PRIMARY KEY,
    usu_id INT REFERENCES usuarios(usu_id) ON DELETE CASCADE,
    pro_id INT REFERENCES productos(pro_id) ON DELETE CASCADE,
    car_cantidad INT NOT NULL CHECK (car_cantidad > 0)
);*/
/*INSERT INTO carro_compra (usu_id, pro_id, car_cantidad) VALUES
(1, 1, 10), 
(2, 2, 20), 
(1, 3, 30); */

SELECT * FROM carro_compra;

--6. estado_pedidos
--Almacena los estados de cada pedido realizado
/*CREATE TABLE estado_pedidos (
    esp_id Int PRIMARY KEY,
	esp_descripcion VARCHAR(50) NOT NULL);*/
/*INSERT INTO estado_pedidos (esp_id,esp_descripcion) VALUES
(1,'pendiente'),
(2, 'pagado'),
(3, 'enviado'),
(4, 'entregado');*/

SELECT * FROM estado_pedidos;

--7 Pedidos (pedidos) 
--Guarda los pedidos que realiza un usuario.
/*CREATE TABLE pedidos (
    ped_id SERIAL PRIMARY KEY,
    usu_id INT REFERENCES usuarios(usu_id) ON DELETE CASCADE,
    ped_total DECIMAL(10,2) NOT NULL,
    esp_id int REFERENCES estado_pedidos(esp_id),
    ped_fecha_pedido DATE DEFAULT CURRENT_DATE
);*/
/*INSERT INTO pedidos (usu_id, ped_total, esp_id, ped_fecha_pedido) VALUES
(1, 100000, 2, '2025-01-10'),
(2, 400000, 2, '2025-01-11'),
(1, 900000, 2, '2025-01-12');*/

SELECT * FROM pedidos;


--8 Detalle de Pedido (pedido_detalle)
--Registra los productos comprados en cada pedido.
/*CREATE TABLE pedido_detalle (
    det_id SERIAL PRIMARY KEY,
    ped_id INT REFERENCES pedidos(ped_id) ON DELETE CASCADE,
    pro_id INT REFERENCES productos(pro_id) ON DELETE CASCADE,
    det_cantidad INT NOT NULL CHECK (det_cantidad > 0),
    det_precio_unitario DECIMAL(10,2) NOT NULL
);*/
/*INSERT INTO pedido_detalle (ped_id, pro_id, det_cantidad, det_precio_unitario) VALUES
(1, 1, 10, 1000), 
(2, 2, 20, 2000),
(1, 3, 30, 3000); */

SELECT * FROM pedido_detalle;

--9. Estado_Pagos
--Almacena los estados de cada Pago realizado
/*CREATE TABLE estado_pagos (
    est_id Int PRIMARY KEY,
    est_descripcion VARCHAR(50)  --Puede ser pendiente o completado
);*/
/*INSERT INTO estado_pagos(est_id,est_descripcion) values
(1, 'Pendiente'),
(2, 'Completado');*/

SELECT * FROM estado_pagos;

--10. Metodo_Pagos
--Almacena los distintos metodos de Pago realizado
/*CREATE TABLE metodo_pagos (
    met_id int PRIMARY KEY,
    met_descripcion VARCHAR(50) --Puede ser Tarjeta de cred/PayPal/Transferencia Bancaria
);
INSERT INTO metodo_pagos(met_id,met_descripcion) values
(1, 'Tarjeta de Credito'),
(2, 'Paypal'),
(3, 'Transferencia Bancaria');*/

SELECT * FROM metodo_pagos;

--11. Pagos (pagos)
--Registra la información de los pagos realizados.
/*CREATE TABLE pagos (
    pag_id SERIAL PRIMARY KEY,
    ped_id INT REFERENCES pedidos(ped_id) ON DELETE CASCADE,
    met_id int NOT NULL, -- tarjeta, PayPal, transferencia, etc.
    est_id int,
    pag_fecha DATE DEFAULT CURRENT_DATE
);
INSERT INTO pagos (ped_id, met_id, est_id, pag_fecha) VALUES
(1, 1, 1, NULL), -- Pendiente de pago
(2, 2, 2, '2025-01-11'),
(3, 3, 2, '2025-01-12');*/

SELECT * FROM pagos;

--12. Resenas (reseñas)
--Permite que los clientes dejen reseñas sobre los productos.
/*CREATE TABLE resenas (
    res_id SERIAL PRIMARY KEY,
    usu_id INT REFERENCES usuarios(usu_id) ON DELETE CASCADE,
    pro_id INT REFERENCES productos(pro_id) ON DELETE CASCADE,
    res_calificacion INT CHECK (res_calificacion BETWEEN 1 AND 5),
    res_comentario TEXT,
    res_fecha DATE DEFAULT CURRENT_DATE
);
INSERT INTO resenas (usu_id, pro_id, res_calificacion, res_comentario, res_fecha) VALUES
(1, 1, 5, 'Excelente planta muy decorativa.', '2025-01-15'),
(2, 2, 4, 'Buena calidad, resistente y versátil.', '2025-01-16'),
(1, 3, 5, 'Muy útil, facil de aplicar en plantas y arbustos.', '2025-01-17');*/

SELECT * FROM resenas;

--13. Favoritos (favoritos)
--Permite a los usuarios marcar productos como favoritos.
/*CREATE TABLE favoritos (
    fav_id SERIAL PRIMARY KEY,
    usu_id INT REFERENCES usuarios(usu_id) ON DELETE CASCADE,
    pro_id INT REFERENCES productos(pro_id) ON DELETE CASCADE,
    fecha DATE DEFAULT CURRENT_DATE
);
INSERT INTO favoritos (usu_id, pro_id, fecha) VALUES
(1, 3, '2025-01-10 14:23:00'), -- Juan marcó como favorito tipo de Compost Orgánico
(2, 2, '2025-01-11 16:45:30'), -- María marcó la pala como favorita
(1, 1, '2025-01-12 09:12:15'); -- Juan marcó planta*/

SELECT * FROM favoritos;



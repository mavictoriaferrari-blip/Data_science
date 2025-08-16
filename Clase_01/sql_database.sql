CREATE TABLE IF NOT EXISTS ventas (
    id_venta INTEGER PRIMARY KEY,
    fecha_venta TEXT,
    id_producto INTEGER,
    nombre_producto TEXT,
    categoria_producto TEXT,
    cantidad INTEGER,
    precio_unitario REAL,
    total_venta REAL,
    id_cliente INTEGER,
    nombre_cliente TEXT
);


.mode csv
.import ./csv/ventas_tienda.csv ventas

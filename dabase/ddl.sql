-- Tabla para Usuarios (Clientes)
CREATE TABLE Usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    contraseña_hashed VARCHAR(255),
    direccion VARCHAR(255),
    telefono VARCHAR(20)
);

-- Tabla para Direcciones de Envío
CREATE TABLE Direcciones (
    id_direccion INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    direccion VARCHAR(255),
    ciudad VARCHAR(100),
    codigo_postal VARCHAR(20),
    pais VARCHAR(100),
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
);

-- Tabla para Productos
CREATE TABLE Productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    sku VARCHAR(50) UNIQUE,
    nombre VARCHAR(100),
    descripcion TEXT,
    precio DECIMAL(10, 2),
    stock INT,
    id_categoria INT,
    FOREIGN KEY (id_categoria) REFERENCES Categorias_Productos(id_categoria)
);

-- Tabla para Categorías de Productos
CREATE TABLE Categorias_Productos (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre_categoria VARCHAR(100)
);

-- Tabla para Pedidos
CREATE TABLE Pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    fecha_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    estado VARCHAR(20),
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
);

-- Tabla para Detalles de Pedidos
CREATE TABLE Detalles_Pedido (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT,
    id_producto INT,
    cantidad INT,
    precio_unitario DECIMAL(10, 2),
    FOREIGN KEY (id_pedido) REFERENCES Pedidos(id_pedido),
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto)
);

-- Tabla para Pagos
CREATE TABLE Pagos (
    id_pago INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT,
    metodo_pago VARCHAR(50),
    monto DECIMAL(10, 2),
    fecha_pago TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    estado_pago VARCHAR(20),
    FOREIGN KEY (id_pedido) REFERENCES Pedidos(id_pedido)
);

-- Tabla para Transacciones (opcional)
CREATE TABLE Transacciones (
    id_transaccion INT AUTO_INCREMENT PRIMARY KEY,
    id_pago INT,
    tipo_transaccion VARCHAR(50),
    descripcion TEXT,
    monto_transaccion DECIMAL(10, 2),
    fecha_transaccion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_pago) REFERENCES Pagos(id_pago)
);

-- Ejemplo de cómo agregar una tabla para Valoraciones de Productos opcionalmente:

CREATE TABLE Valoraciones_Productos (
    id_valoracion INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    id_producto INT,
    puntuacion INT,
    comentario TEXT,
    fecha_valoracion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario),
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto)
);

/*Relación con la tabla Productos:
Para establecer la relación entre la tabla Productos y Categorias_Productos, se utiliza una técnica común en bases de datos relacionales: la relación muchos a muchos a través de una tabla intermedia. Sin embargo, en este caso, como un producto puede pertenecer a una sola categoría, utilizaremos una relación directa uno a muchos, donde cada producto puede estar asociado a una única categoría.
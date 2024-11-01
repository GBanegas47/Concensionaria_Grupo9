-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 01-11-2024 a las 00:25:06
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `concensionaria`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarAgenda` (IN `p_id_cliente` INT, IN `p_id_empleado` INT, IN `p_fecha_hora_cita` DATETIME, IN `p_tipo_cita` ENUM('venta','servicio'), IN `p_estado_cita` ENUM('confirmada','pendiente','cancelada'))   BEGIN
    INSERT INTO Agenda (id_cliente, id_empleado, fecha_hora_cita, tipo_cita, estado_cita)
    VALUES (p_id_cliente, p_id_empleado, p_fecha_hora_cita, p_tipo_cita, p_estado_cita);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarCliente` (IN `p_cliente` INT, IN `p_nombre` VARCHAR(50), IN `p_apellidos` VARCHAR(50), IN `p_fecha_nacimiento` DATE, IN `p_telefono` VARCHAR(20), IN `p_correo_electronico` VARCHAR(100), IN `p_direccion` VARCHAR(255), IN `p_tipo_cliente` ENUM('física','jurídica'))   BEGIN
    INSERT INTO Cliente (id_cliente, nombre, apellidos, fecha_nacimiento, telefono, correo_electronico, direccion, tipo_cliente, fecha_registro)
    VALUES (p_cliente,p_nombre, p_apellidos, p_fecha_nacimiento, p_telefono, p_correo_electronico, p_direccion, p_tipo_cliente, CURDATE());
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarCompra` (IN `p_fecha_compra` DATE, IN `p_id_proveedor` INT)   BEGIN
    INSERT INTO Compra (fecha_compra, id_proveedor)
    VALUES (p_fecha_compra, p_id_proveedor);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarCompraDetalle` (IN `p_id_compra` INT, IN `p_id_vehiculo` INT, IN `p_id_pieza` INT, IN `p_precio` DECIMAL(8,2), IN `p_cantidad` INT)   BEGIN
    INSERT INTO CompraDetalle (id_compra, id_vehiculo, id_pieza, precio, cantidad)
    VALUES (p_id_compra, p_id_vehiculo, p_id_pieza, p_precio, p_cantidad);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarCotizacion` (IN `p_id_cliente` INT, IN `p_id_vehiculo` INT, IN `p_fecha_solicitud` DATE, IN `p_precio_cotizado` DECIMAL(10,2), IN `p_vendedor_asignado` INT, IN `p_estado` ENUM('pendiente','aceptada','rechazada'), IN `p_fecha_expiracion` DATE)   BEGIN
    INSERT INTO Cotizacion (id_cliente, id_vehiculo, fecha_solicitud, precio_cotizado, vendedor_asignado, estado, fecha_expiracion)
    VALUES (p_id_cliente, p_id_vehiculo, p_fecha_solicitud, p_precio_cotizado, p_vendedor_asignado, p_estado, p_fecha_expiracion);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarEmpleado` (IN `p_nombre` VARCHAR(50), IN `p_apellidos` VARCHAR(50), IN `p_cargo` ENUM('vendedor','servicio','administracion'), IN `p_fecha_contratacion` DATE, IN `p_correo_electronico` VARCHAR(100), IN `p_telefono` VARCHAR(20), IN `p_comision_ventas` DECIMAL(5,2), IN `p_nivel_acceso` ENUM('bajo','medio','alto'))   BEGIN
    INSERT INTO Empleado (nombre, apellidos, cargo, fecha_contratacion, correo_electronico, telefono, comision_ventas, nivel_acceso)
    VALUES (p_nombre, p_apellidos, p_cargo, p_fecha_contratacion, p_correo_electronico, p_telefono, p_comision_ventas, p_nivel_acceso);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarFactura` (IN `p_id_venta` INT, IN `p_id_servicio` INT, IN `p_fecha_emision` DATE, IN `p_monto_total` DECIMAL(10,2), IN `p_impuestos_aplicados` DECIMAL(10,2), IN `p_detalles_pago` ENUM('efectivo','transferencia','tarjeta'))   BEGIN
    INSERT INTO Factura (id_venta, id_servicio, fecha_emision, monto_total, impuestos_aplicados, detalles_pago)
    VALUES (p_id_venta, p_id_servicio, p_fecha_emision, p_monto_total, p_impuestos_aplicados, p_detalles_pago);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarFinanciamiento` (IN `p_id_venta` INT, IN `p_entidad_financiera` VARCHAR(100), IN `p_monto_financiado` DECIMAL(10,2), IN `p_tasa_interes` DECIMAL(5,2), IN `p_plazo` INT, IN `p_cuotas_mensuales` DECIMAL(10,2), IN `p_fecha_inicio` DATE, IN `p_fecha_finalizacion` DATE, IN `p_estado_pagos` ENUM('al dia','atrasado'))   BEGIN
    INSERT INTO Financiamiento (id_venta, entidad_financiera, monto_financiado, tasa_interes, plazo, cuotas_mensuales, fecha_inicio, fecha_finalizacion, estado_pagos)
    VALUES (p_id_venta, p_entidad_financiera, p_monto_financiado, p_tasa_interes, p_plazo, p_cuotas_mensuales, p_fecha_inicio, p_fecha_finalizacion, p_estado_pagos);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarGarantia` (IN `p_id_vehiculo` INT, IN `p_duracion` INT, IN `p_cobertura` TEXT, IN `p_fecha_inicio` DATE, IN `p_fecha_expiracion` DATE, IN `p_estado` ENUM('activa','expirada'))   BEGIN
    INSERT INTO Garantia (id_vehiculo, duracion, cobertura, fecha_inicio, fecha_expiracion, estado)
    VALUES (p_id_vehiculo, p_duracion, p_cobertura, p_fecha_inicio, p_fecha_expiracion, p_estado);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarHistorialCompra` (IN `p_id_historial` INT, IN `p_id_cliente` INT, IN `p_id_venta` INT, IN `p_fecha_compra` DATETIME, IN `p_id_proveedor` INT)   BEGIN 
INSERT INTO HistotialCompra ( id_historial, id_cliente, id_venta, fecha_compra, id_proveedor)
VALUES (p_id_historial, p_id_cliente, p_id_venta, p_fecha_compra, p_id_proveedor);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarMecanico` (IN `p_id_mecanico` INT, IN `p_nombre` VARCHAR(50), IN `p_apellido` VARCHAR(50), IN `p_especialiacion` ENUM('Mecanica','electricidad','carroceria'), IN `p_fecha_contratacion` DATETIME, IN `p_historial_servicios` TEXT, IN `p_telefono` VARCHAR(20), IN `p_correo_electrinico` VARCHAR(100))   BEGIN 
INSERT INTO Mecanico (id_mecanico, nombre, apellido, especializacion, fecha_contratacion, historial_servicios, telefono, correo_electronico)
VALUES (p_id_mecanico, p_nombre, p_apellido, p_especializacion, p_fecha_contratacion, p_historial_servicios, p_telefono, p_correo_electronico);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarPieza` (IN `p_nombre_pieza` VARCHAR(100), IN `p_numero_parte` VARCHAR(50), IN `p_marca` VARCHAR(50), IN `p_modelo_compatible` VARCHAR(50), IN `p_precio` DECIMAL(10,2), IN `p_cantidad_disponible` INT, IN `p_id_proveedor` INT)   BEGIN
    INSERT INTO Pieza (nombre_pieza, numero_parte, marca, modelo_compatible, precio, cantidad_disponible, id_proveedor)
    VALUES (p_nombre_pieza, p_numero_parte, p_marca, p_modelo_compatible, p_precio, p_cantidad_disponible, p_id_proveedor);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarProveedor` (IN `p_nombre_proveedor` VARCHAR(100), IN `p_direccion` VARCHAR(255), IN `p_telefono` VARCHAR(20), IN `p_correo_electronico` VARCHAR(100), IN `p_tipo_productos` ENUM('vehiculos','piezas'))   BEGIN
    INSERT INTO Proveedor (nombre_proveedor, direccion, telefono, correo_electronico, tipo_productos)
    VALUES (p_nombre_proveedor, p_direccion, p_telefono, p_correo_electronico, p_tipo_productos);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarServicio` (IN `p_id_cliente` INT, IN `p_id_vehiculo` INT, IN `p_tipo_servicio` ENUM('mantenimiento','reparacion','revision'), IN `p_descripcion_servicio` TEXT, IN `p_fecha_ingreso` DATE, IN `p_fecha_estimada_finalizacion` DATE, IN `p_costo_estimado` DECIMAL(10,2), IN `p_mecanico_asignado` INT, IN `p_estado` ENUM('pendiente','en proceso','finalizado'))   BEGIN
    INSERT INTO Servicio (id_cliente, id_vehiculo, tipo_servicio, descripcion_servicio, fecha_ingreso, fecha_estimada_finalizacion, costo_estimado, mecanico_asignado, estado)
    VALUES (p_id_cliente, p_id_vehiculo, p_tipo_servicio, p_descripcion_servicio, p_fecha_ingreso, p_fecha_estimada_finalizacion, p_costo_estimado, p_mecanico_asignado, p_estado);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarVehiculo` (IN `p_vehiculo` INT, IN `p_marca` VARCHAR(50), IN `p_modelo` VARCHAR(50), IN `p_ano` YEAR, IN `p_color` VARCHAR(30), IN `p_numero_serie` VARCHAR(50), IN `p_tipo_combustible` VARCHAR(30), IN `p_tipo_transmision` VARCHAR(30), IN `p_precio_venta` DECIMAL(10,2), IN `p_estado` ENUM('disponible','vendido','reservado'), IN `p_fecha_ingreso` DATE, IN `p_kilometraje` INT, IN `p_fecha_fabricacion` DATE)   BEGIN
    INSERT INTO Vehiculo (id_vehiculo,marca, modelo, ano, color, numero_serie, tipo_combustible, tipo_transmision, precio_venta, estado, fecha_ingreso, kilometraje, fecha_fabricacion)
    VALUES (p_vehiculo, p_marca, p_modelo, p_ano, p_color, p_numero_serie, p_tipo_combustible, p_tipo_transmision, p_precio_venta, p_estado, p_fecha_ingreso, p_kilometraje, p_fecha_fabricacion);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarVenta` (IN `p_id_cliente` INT, IN `p_id_vehiculo` INT, IN `p_fecha_venta` DATE, IN `p_monto_total` DECIMAL(10,2), IN `p_metodo_pago` ENUM('contado','financiamiento','leasing'), IN `p_vendedor_asignado` INT, IN `p_estado_transaccion` ENUM('pagada','pendiente'), IN `p_fecha_entrega` DATE)   BEGIN
    INSERT INTO Venta (id_cliente, id_vehiculo, fecha_venta, monto_total, metodo_pago, vendedor_asignado, estado_transaccion, fecha_entrega)
    VALUES (p_id_cliente, p_id_vehiculo, p_fecha_venta, p_monto_total, p_metodo_pago, p_vendedor_asignado, p_estado_transaccion, p_fecha_entrega);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarVentaEmpleado` (IN `p_id_venta_empleado` INT, IN `p_id_empleado` INT, IN `p_id_venta` INT)   BEGIN 
INSERT INTO VentaEmpleado (id_venta_empleado, id_empleado, id_venta)
VALUES (p_id_venta_empleado, p_id_empleado, p_id_venta);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `agenda`
--

CREATE TABLE `agenda` (
  `id_cita` int(11) NOT NULL,
  `id_cliente` int(11) DEFAULT NULL,
  `id_empleado` int(11) DEFAULT NULL,
  `fecha_hora_cita` datetime DEFAULT NULL,
  `tipo_cita` enum('venta','servicio') DEFAULT NULL,
  `estado_cita` enum('confirmada','pendiente','cancelada') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `id_cliente` int(11) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `apellidos` varchar(50) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `correo_electronico` varchar(100) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `tipo_cliente` enum('física','jurídica') DEFAULT NULL,
  `fecha_registro` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compra`
--

CREATE TABLE `compra` (
  `id_compra` int(11) NOT NULL,
  `fecha_compra` date DEFAULT NULL,
  `id_proveedor` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compradetalle`
--

CREATE TABLE `compradetalle` (
  `id_compra_detalle` int(11) NOT NULL,
  `id_compra` int(11) DEFAULT NULL,
  `id_vehiculo` int(11) DEFAULT NULL,
  `id_pieza` int(11) DEFAULT NULL,
  `precio` decimal(8,2) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cotizacion`
--

CREATE TABLE `cotizacion` (
  `id_cotizacion` int(11) NOT NULL,
  `id_cliente` int(11) DEFAULT NULL,
  `id_vehiculo` int(11) DEFAULT NULL,
  `fecha_solicitud` date DEFAULT NULL,
  `precio_cotizado` decimal(10,2) DEFAULT NULL,
  `vendedor_asignado` int(11) DEFAULT NULL,
  `estado` enum('pendiente','aceptada','rechazada') DEFAULT NULL,
  `fecha_expiracion` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado`
--

CREATE TABLE `empleado` (
  `id_empleado` int(11) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `apellidos` varchar(50) DEFAULT NULL,
  `cargo` enum('vendedor','servicio','administracion') DEFAULT NULL,
  `fecha_contratacion` date DEFAULT NULL,
  `correo_electronico` varchar(100) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `comision_ventas` decimal(5,2) DEFAULT NULL,
  `nivel_acceso` enum('bajo','medio','alto') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `empleado`
--

INSERT INTO `empleado` (`id_empleado`, `nombre`, `apellidos`, `cargo`, `fecha_contratacion`, `correo_electronico`, `telefono`, `comision_ventas`, `nivel_acceso`) VALUES
(1, 'Ana', 'Gómez', 'vendedor', '2022-01-15', 'ana.gomez@example.com', '555-5678', 5.00, 'medio');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factura`
--

CREATE TABLE `factura` (
  `id_factura` int(11) NOT NULL,
  `id_venta` int(11) DEFAULT NULL,
  `id_servicio` int(11) DEFAULT NULL,
  `fecha_emision` date DEFAULT NULL,
  `monto_total` decimal(10,2) DEFAULT NULL,
  `impuestos_aplicados` decimal(10,2) DEFAULT NULL,
  `detalles_pago` enum('efectivo','transferencia','tarjeta') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `financiamiento`
--

CREATE TABLE `financiamiento` (
  `id_financiamiento` int(11) NOT NULL,
  `id_venta` int(11) DEFAULT NULL,
  `entidad_financiera` varchar(100) DEFAULT NULL,
  `monto_financiado` decimal(10,2) DEFAULT NULL,
  `tasa_interes` decimal(5,2) DEFAULT NULL,
  `plazo` int(11) DEFAULT NULL,
  `cuotas_mensuales` decimal(10,2) DEFAULT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_finalizacion` date DEFAULT NULL,
  `estado_pagos` enum('al dia','atrasado') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `garantia`
--

CREATE TABLE `garantia` (
  `id_garantia` int(11) NOT NULL,
  `id_vehiculo` int(11) DEFAULT NULL,
  `duracion` int(11) DEFAULT NULL,
  `cobertura` text DEFAULT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_expiracion` date DEFAULT NULL,
  `estado` enum('activa','expirada') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historialcompras`
--

CREATE TABLE `historialcompras` (
  `id_historial` int(11) NOT NULL,
  `id_cliente` int(11) DEFAULT NULL,
  `id_venta` int(11) DEFAULT NULL,
  `fecha_compra` date DEFAULT NULL,
  `id_proveedor` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario`
--

CREATE TABLE `inventario` (
  `id_inventario` int(11) NOT NULL,
  `id_vehiculo` int(11) DEFAULT NULL,
  `fecha_entrada` date DEFAULT NULL,
  `estado_vehiculo` enum('nuevo','usado','vendido') DEFAULT NULL,
  `ubicacion` varchar(100) DEFAULT NULL,
  `cantidad_disponible` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mecanico`
--

CREATE TABLE `mecanico` (
  `id_mecanico` int(11) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `apellidos` varchar(50) DEFAULT NULL,
  `especializacion` enum('mecanica','electricidad','carroceria') DEFAULT NULL,
  `fecha_contratacion` date DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `correo_electronico` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pieza`
--

CREATE TABLE `pieza` (
  `id_pieza` int(11) NOT NULL,
  `nombre_pieza` varchar(100) DEFAULT NULL,
  `numero_parte` varchar(50) DEFAULT NULL,
  `marca` varchar(50) DEFAULT NULL,
  `modelo_compatible` varchar(50) DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `cantidad_disponible` int(11) DEFAULT NULL,
  `id_proveedor` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pieza`
--

INSERT INTO `pieza` (`id_pieza`, `nombre_pieza`, `numero_parte`, `marca`, `modelo_compatible`, `precio`, `cantidad_disponible`, `id_proveedor`) VALUES
(1, 'Frenos', '12345', 'MarcaX', 'ModeloY', 150.00, 10, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedor`
--

CREATE TABLE `proveedor` (
  `id_proveedor` int(11) NOT NULL,
  `nombre_proveedor` varchar(100) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `correo_electronico` varchar(100) DEFAULT NULL,
  `tipo_productos` enum('vehiculos','piezas') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `proveedor`
--

INSERT INTO `proveedor` (`id_proveedor`, `nombre_proveedor`, `direccion`, `telefono`, `correo_electronico`, `tipo_productos`) VALUES
(1, 'Proveedor S.A.', 'Av. Siempre Viva 742', '9990-7788', 'contacto@proveedorsa.com', 'vehiculos');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicio`
--

CREATE TABLE `servicio` (
  `id_servicio` int(11) NOT NULL,
  `id_cliente` int(11) DEFAULT NULL,
  `id_vehiculo` int(11) DEFAULT NULL,
  `tipo_servicio` enum('mantenimiento','reparacion','revision') DEFAULT NULL,
  `descripcion_servicio` text DEFAULT NULL,
  `fecha_ingreso` date DEFAULT NULL,
  `fecha_estimada_finalizacion` date DEFAULT NULL,
  `costo_estimado` decimal(10,2) DEFAULT NULL,
  `mecanico_asignado` int(11) DEFAULT NULL,
  `estado` enum('pendiente','en proceso','finalizado') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vehiculo`
--

CREATE TABLE `vehiculo` (
  `id_vehiculo` int(11) NOT NULL,
  `marca` varchar(50) DEFAULT NULL,
  `modelo` varchar(50) DEFAULT NULL,
  `ano` year(4) DEFAULT NULL,
  `color` varchar(30) DEFAULT NULL,
  `numero_serie` varchar(50) DEFAULT NULL,
  `tipo_combustible` varchar(30) DEFAULT NULL,
  `tipo_transmision` varchar(30) DEFAULT NULL,
  `precio_venta` decimal(10,2) DEFAULT NULL,
  `estado` enum('disponible','vendido','reservado') DEFAULT NULL,
  `fecha_ingreso` date DEFAULT NULL,
  `kilometraje` int(11) DEFAULT NULL,
  `fecha_fabricacion` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta`
--

CREATE TABLE `venta` (
  `id_venta` int(11) NOT NULL,
  `id_cliente` int(11) DEFAULT NULL,
  `id_vehiculo` int(11) DEFAULT NULL,
  `fecha_venta` date DEFAULT NULL,
  `monto_total` decimal(10,2) DEFAULT NULL,
  `metodo_pago` enum('contado','financiamiento','leasing') DEFAULT NULL,
  `vendedor_asignado` int(11) DEFAULT NULL,
  `estado_transaccion` enum('pagada','pendiente') DEFAULT NULL,
  `fecha_entrega` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventasempleado`
--

CREATE TABLE `ventasempleado` (
  `id_venta_empleado` int(11) NOT NULL,
  `id_empleado` int(11) DEFAULT NULL,
  `id_venta` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `agenda`
--
ALTER TABLE `agenda`
  ADD PRIMARY KEY (`id_cita`),
  ADD KEY `id_cliente` (`id_cliente`),
  ADD KEY `id_empleado` (`id_empleado`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id_cliente`);

--
-- Indices de la tabla `compra`
--
ALTER TABLE `compra`
  ADD PRIMARY KEY (`id_compra`),
  ADD KEY `id_proveedor` (`id_proveedor`);

--
-- Indices de la tabla `compradetalle`
--
ALTER TABLE `compradetalle`
  ADD PRIMARY KEY (`id_compra_detalle`),
  ADD KEY `id_compra` (`id_compra`),
  ADD KEY `id_pieza` (`id_pieza`),
  ADD KEY `id_vehiculo` (`id_vehiculo`);

--
-- Indices de la tabla `cotizacion`
--
ALTER TABLE `cotizacion`
  ADD PRIMARY KEY (`id_cotizacion`),
  ADD KEY `id_cliente` (`id_cliente`),
  ADD KEY `id_vehiculo` (`id_vehiculo`),
  ADD KEY `vendedor_asignado` (`vendedor_asignado`);

--
-- Indices de la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD PRIMARY KEY (`id_empleado`);

--
-- Indices de la tabla `factura`
--
ALTER TABLE `factura`
  ADD PRIMARY KEY (`id_factura`),
  ADD KEY `id_venta` (`id_venta`),
  ADD KEY `id_servicio` (`id_servicio`);

--
-- Indices de la tabla `financiamiento`
--
ALTER TABLE `financiamiento`
  ADD PRIMARY KEY (`id_financiamiento`),
  ADD KEY `id_venta` (`id_venta`);

--
-- Indices de la tabla `garantia`
--
ALTER TABLE `garantia`
  ADD PRIMARY KEY (`id_garantia`),
  ADD KEY `id_vehiculo` (`id_vehiculo`);

--
-- Indices de la tabla `historialcompras`
--
ALTER TABLE `historialcompras`
  ADD PRIMARY KEY (`id_historial`),
  ADD KEY `id_cliente` (`id_cliente`),
  ADD KEY `id_venta` (`id_venta`);

--
-- Indices de la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD PRIMARY KEY (`id_inventario`),
  ADD KEY `id_vehiculo` (`id_vehiculo`);

--
-- Indices de la tabla `mecanico`
--
ALTER TABLE `mecanico`
  ADD PRIMARY KEY (`id_mecanico`);

--
-- Indices de la tabla `pieza`
--
ALTER TABLE `pieza`
  ADD PRIMARY KEY (`id_pieza`),
  ADD KEY `id_proveedor` (`id_proveedor`);

--
-- Indices de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  ADD PRIMARY KEY (`id_proveedor`);

--
-- Indices de la tabla `servicio`
--
ALTER TABLE `servicio`
  ADD PRIMARY KEY (`id_servicio`),
  ADD KEY `id_cliente` (`id_cliente`),
  ADD KEY `id_vehiculo` (`id_vehiculo`),
  ADD KEY `mecanico_asignado` (`mecanico_asignado`);

--
-- Indices de la tabla `vehiculo`
--
ALTER TABLE `vehiculo`
  ADD PRIMARY KEY (`id_vehiculo`);

--
-- Indices de la tabla `venta`
--
ALTER TABLE `venta`
  ADD PRIMARY KEY (`id_venta`),
  ADD KEY `id_cliente` (`id_cliente`),
  ADD KEY `id_vehiculo` (`id_vehiculo`),
  ADD KEY `vendedor_asignado` (`vendedor_asignado`);

--
-- Indices de la tabla `ventasempleado`
--
ALTER TABLE `ventasempleado`
  ADD PRIMARY KEY (`id_venta_empleado`),
  ADD KEY `id_venta` (`id_venta`),
  ADD KEY `id_empleado` (`id_empleado`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `agenda`
--
ALTER TABLE `agenda`
  MODIFY `id_cita` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `compra`
--
ALTER TABLE `compra`
  MODIFY `id_compra` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `compradetalle`
--
ALTER TABLE `compradetalle`
  MODIFY `id_compra_detalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `cotizacion`
--
ALTER TABLE `cotizacion`
  MODIFY `id_cotizacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `empleado`
--
ALTER TABLE `empleado`
  MODIFY `id_empleado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `factura`
--
ALTER TABLE `factura`
  MODIFY `id_factura` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `financiamiento`
--
ALTER TABLE `financiamiento`
  MODIFY `id_financiamiento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `garantia`
--
ALTER TABLE `garantia`
  MODIFY `id_garantia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `historialcompras`
--
ALTER TABLE `historialcompras`
  MODIFY `id_historial` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `inventario`
--
ALTER TABLE `inventario`
  MODIFY `id_inventario` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `mecanico`
--
ALTER TABLE `mecanico`
  MODIFY `id_mecanico` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pieza`
--
ALTER TABLE `pieza`
  MODIFY `id_pieza` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  MODIFY `id_proveedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `servicio`
--
ALTER TABLE `servicio`
  MODIFY `id_servicio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `vehiculo`
--
ALTER TABLE `vehiculo`
  MODIFY `id_vehiculo` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `venta`
--
ALTER TABLE `venta`
  MODIFY `id_venta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `ventasempleado`
--
ALTER TABLE `ventasempleado`
  MODIFY `id_venta_empleado` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `agenda`
--
ALTER TABLE `agenda`
  ADD CONSTRAINT `agenda_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`),
  ADD CONSTRAINT `agenda_ibfk_2` FOREIGN KEY (`id_empleado`) REFERENCES `empleado` (`id_empleado`);

--
-- Filtros para la tabla `compra`
--
ALTER TABLE `compra`
  ADD CONSTRAINT `compra_ibfk_1` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedor` (`id_proveedor`);

--
-- Filtros para la tabla `compradetalle`
--
ALTER TABLE `compradetalle`
  ADD CONSTRAINT `compradetalle_ibfk_1` FOREIGN KEY (`id_compra`) REFERENCES `compra` (`id_compra`),
  ADD CONSTRAINT `compradetalle_ibfk_2` FOREIGN KEY (`id_pieza`) REFERENCES `pieza` (`id_pieza`),
  ADD CONSTRAINT `compradetalle_ibfk_3` FOREIGN KEY (`id_vehiculo`) REFERENCES `vehiculo` (`id_vehiculo`);

--
-- Filtros para la tabla `cotizacion`
--
ALTER TABLE `cotizacion`
  ADD CONSTRAINT `cotizacion_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`),
  ADD CONSTRAINT `cotizacion_ibfk_2` FOREIGN KEY (`id_vehiculo`) REFERENCES `vehiculo` (`id_vehiculo`),
  ADD CONSTRAINT `cotizacion_ibfk_3` FOREIGN KEY (`vendedor_asignado`) REFERENCES `empleado` (`id_empleado`);

--
-- Filtros para la tabla `factura`
--
ALTER TABLE `factura`
  ADD CONSTRAINT `factura_ibfk_1` FOREIGN KEY (`id_venta`) REFERENCES `venta` (`id_venta`),
  ADD CONSTRAINT `factura_ibfk_2` FOREIGN KEY (`id_servicio`) REFERENCES `servicio` (`id_servicio`);

--
-- Filtros para la tabla `financiamiento`
--
ALTER TABLE `financiamiento`
  ADD CONSTRAINT `financiamiento_ibfk_1` FOREIGN KEY (`id_venta`) REFERENCES `venta` (`id_venta`);

--
-- Filtros para la tabla `garantia`
--
ALTER TABLE `garantia`
  ADD CONSTRAINT `garantia_ibfk_1` FOREIGN KEY (`id_vehiculo`) REFERENCES `vehiculo` (`id_vehiculo`);

--
-- Filtros para la tabla `historialcompras`
--
ALTER TABLE `historialcompras`
  ADD CONSTRAINT `historialcompras_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`),
  ADD CONSTRAINT `historialcompras_ibfk_2` FOREIGN KEY (`id_venta`) REFERENCES `venta` (`id_venta`);

--
-- Filtros para la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD CONSTRAINT `inventario_ibfk_1` FOREIGN KEY (`id_vehiculo`) REFERENCES `vehiculo` (`id_vehiculo`);

--
-- Filtros para la tabla `pieza`
--
ALTER TABLE `pieza`
  ADD CONSTRAINT `pieza_ibfk_1` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedor` (`id_proveedor`);

--
-- Filtros para la tabla `servicio`
--
ALTER TABLE `servicio`
  ADD CONSTRAINT `servicio_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`),
  ADD CONSTRAINT `servicio_ibfk_2` FOREIGN KEY (`id_vehiculo`) REFERENCES `vehiculo` (`id_vehiculo`),
  ADD CONSTRAINT `servicio_ibfk_3` FOREIGN KEY (`mecanico_asignado`) REFERENCES `mecanico` (`id_mecanico`);

--
-- Filtros para la tabla `venta`
--
ALTER TABLE `venta`
  ADD CONSTRAINT `venta_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`),
  ADD CONSTRAINT `venta_ibfk_2` FOREIGN KEY (`id_vehiculo`) REFERENCES `vehiculo` (`id_vehiculo`),
  ADD CONSTRAINT `venta_ibfk_3` FOREIGN KEY (`vendedor_asignado`) REFERENCES `empleado` (`id_empleado`);

--
-- Filtros para la tabla `ventasempleado`
--
ALTER TABLE `ventasempleado`
  ADD CONSTRAINT `ventasempleado_ibfk_1` FOREIGN KEY (`id_venta`) REFERENCES `venta` (`id_venta`),
  ADD CONSTRAINT `ventasempleado_ibfk_2` FOREIGN KEY (`id_empleado`) REFERENCES `empleado` (`id_empleado`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 18-10-2021 a las 18:39:58
-- Versión del servidor: 10.5.12-MariaDB-0+deb11u1
-- Versión de PHP: 7.4.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `tarjetaplaza`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `id` int(11) NOT NULL,
  `ci` varchar(255) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `apellido` varchar(255) NOT NULL,
  `fechanac` date DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `celular` varchar(255) NOT NULL,
  `foto` varchar(255) DEFAULT NULL,
  `saldo` double NOT NULL,
  `codigo` varchar(255) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`id`, `ci`, `nombre`, `apellido`, `fechanac`, `direccion`, `celular`, `foto`, `saldo`, `codigo`, `fecha`) VALUES
(11, '3520226', 'Eddy Carlos ', 'Plaza Garcia', '1975-05-23', 'oruro', '78610570', NULL, 0, 'ecpg-6220253-10-ANIV21', '2022-10-11 00:00:00'),
(12, '7277735', 'Carlos Javier ', 'Espinoza Mamani ', '1989-11-03', 'oruro', '72483447', NULL, 100, 'cjem-5377727-1-ANIV21', '2022-10-13 00:00:00'),
(13, '65430762', 'Dennilzón Adrián', 'Choque Chanez', '1996-10-25', 'oruro', '65430762', NULL, 100, 'dacc-26703456-2-ANIV21', '2022-10-12 00:00:00'),
(14, '7398770', 'Jacquelin Tatiana', 'Colque Aro', '1969-12-31', 'oruro', '69600260', NULL, 100, 'jtca-0778937-4-ANIV21', '2022-10-12 00:00:00'),
(15, '7336001', 'Roberto Kevin', 'Martinez Villegas', '1997-04-17', 'oruro', '65415389', NULL, 100, 'rkmv-1006337-5-ANIV21', '2022-10-12 00:00:00'),
(16, '7277736', 'Andree Enrique', 'Espinoza mamani', '1969-12-31', 'oruro', '65408201', NULL, 100, 'aeem-6377727-3-ANIV21', '2022-10-12 00:00:00'),
(17, '5721136', 'Roberto Jaime', 'Zubieta Orihuela', '1985-02-16', 'oruro', '76142243', NULL, 80, 'rjzo-6311275-7-ANIV21', '2022-10-12 00:00:00'),
(18, '7359532', 'Karol Silvana', 'Vera Ruiz', '1969-12-31', 'oruro', '60423382', NULL, 100, 'ksvr-2359537-6-ANIV21', '2022-10-12 00:00:00'),
(19, '7347276', 'Álvaro Cristhian ', 'Pereira Soto ', '1993-11-22', 'oruro', '71107629', NULL, 100, 'cps-6727437-29-ANIV21', '2022-10-12 00:00:00'),
(20, '5068681', 'Marcelo Jorge', 'Gonzáles Del Castillo', '1985-03-12', 'oruro', '78611101', NULL, 100, 'mjgdc-1868605-34-ANIV21', '2022-10-12 00:00:00'),
(21, '7372995', 'Reyna Alejandra', 'Quisbert Morales', '1996-10-28', 'oruro', '61826080', NULL, 100, 'raqm-5992737-33-ANIV21', '2022-10-12 00:00:00'),
(22, '7362901', 'Milenka Jacqueline', 'Meave Parra', '1994-09-22', 'oruro', '79405225', NULL, 72, 'mjmp-1092637-31-ANIV21', '2022-10-12 00:00:00'),
(23, '5065381 or', 'Kevin Raúl ', 'Rodríguez Villacorta', '1995-04-19', 'oruro', '70434750', NULL, 100, 'krrv-ro 1835605-8-ANIV21', '2022-10-12 00:00:00'),
(24, '3053241 or', 'Albina ', 'Villacorta Ojeda', '1965-06-03', 'ORURO', '77146882', NULL, 100, 'avo-ro 1423503-9-ANIV21', '2022-10-12 00:00:00'),
(25, '7407201', 'Alex Alejandro ', 'Crispin contreras', '1998-09-13', 'ORURO', '65828328', NULL, 100, 'aacc-1027047-11-ANIV21', '2022-10-12 00:00:00'),
(26, '12549368', 'José Alfredo', 'Flores Troncoso', '2002-12-26', 'ORURO', '77145799', NULL, 100, 'jaft-86394521-10-ANIV21', '2022-10-12 00:00:00'),
(27, '7311222', 'William Mucio', 'Achabal Villalpando', '1969-12-31', 'ORURO', '75402638', NULL, 100, 'wmav-2221137-12-ANIV21', '2022-10-12 00:00:00'),
(28, '12549352', 'Paola Jazmin ', 'Atora Muñoz', '1999-12-19', 'ORURO', '72460534', NULL, 100, 'pjam-43506427-13-ANIV21', '2022-10-12 00:00:00'),
(29, '9972519lp', 'Yulian mario', 'Williams Ramírez', '1997-12-02', 'ORURO', '65407662', NULL, 62.4, 'ymwr-pl9152799-15-ANIV21', '2022-10-12 00:00:00'),
(30, '7285329', 'Luis Diego', 'Condarco Navarro', '1969-12-31', 'ORURO', '67222944', NULL, 8, 'ldcn-9235827-14-ANIV21', '2022-10-12 00:00:00'),
(31, '7377084', 'KAREN', 'ROSALES VILLARROEL', '1992-03-30', 'ORURO', '77150045', NULL, 100, 'krv-4807737-30-ANIV21', '2022-10-12 00:00:00'),
(32, '7342865 ', 'Pablo Sebastian ', 'Vega Bellot ', '1969-12-31', 'ORURO', '72431973', NULL, 100, 'psvb- 5682437-16-ANIV21', '2022-10-12 00:00:00'),
(33, '7418071 ', 'Joel Armando ', 'Ojeda Hurtado ', '2000-07-29', 'ORURO', '76145308', NULL, 76, 'jaoh- 1708147-17-ANIV21', '2022-10-12 00:00:00'),
(34, '7422244', 'José Manuel', 'Zenteno Espinoza ', '1996-04-02', 'ORURO', '77144609', NULL, 100, 'jmze-4422247-20-ANIV21', '2022-10-12 00:00:00'),
(35, '7367544', 'Diego Dalecio ', 'Ortega Morales ', '2000-03-11', 'ORURO', '68283174', NULL, 100, 'ddom-4457637-19-ANIV21', '2022-10-12 00:00:00'),
(36, '7392328', 'Adelaida ', 'Choquetupa Huanca', '2001-01-18', 'ORURO', '75709919', NULL, 100, 'asft-6801237-21-ANIV21', '2022-10-12 00:00:00'),
(37, '12551996', 'Lucero', 'Vargas anavi', '1969-12-31', 'ORURO', '77861638', NULL, 100, 'lva-69915521-177-ANIV21', '2022-10-14 00:00:00'),
(38, '7321086', 'Ariel Simón ', 'Flores Troncoso', '1997-08-12', 'ORURO', '75429805', NULL, 100, 'asft-6801237-21-ANIV21', '2022-10-12 00:00:00'),
(39, '7410039', 'Katherine ', 'Crispin Colque ', '2000-02-17', 'ORURO', '76159675', NULL, 100, 'kcc-9300147-22-ANIV21', '2022-10-12 00:00:00'),
(40, '7423494', 'Rodrigo Alberto', 'Corrales Ortiz', '2002-11-07', 'ORURO', '68322800', NULL, 100, 'raco-4943247-23-ANIV21', '2022-10-12 00:00:00'),
(41, '7328319', 'SILVIA', 'MARCA DIAZ', '1999-02-19', 'ORURO', '77148571', NULL, 100, 'smd-9138237-24-ANIV21', '2022-10-12 00:00:00'),
(42, '7391118', 'Paulo Andres', 'Paco Torrico', '1999-07-31', 'ORURO', '65407525', NULL, 100, 'papt-8111937-32-ANIV21', '2022-10-12 00:00:00'),
(43, '5067630', 'Gonzalo', 'Copa Pastor', '1996-12-29', 'ORURO', '72342784', NULL, 100, 'gcp-0367605-27-ANIV21', '2022-10-12 00:00:00'),
(44, '3552551', 'Gonzalo ', 'Copa Barrios', '1975-03-14', 'ORURO', '71859988', NULL, 100, 'gcb-1552553-28-ANIV21', '2022-10-12 00:00:00'),
(45, '4306168 LP', 'Tito', 'Ticona  Olivera', '1973-06-28', 'ORURO', '78610573', NULL, 100, 'tto-37501687-25-ANIV21', '2022-10-12 00:00:00'),
(46, '3546122', 'Mery Ruth', 'Pastor Velasco ', '1975-07-10', 'ORURO', '72468404', NULL, 100, 'mrpv-2216453-26-ANIV21', '2022-10-12 00:00:00'),
(47, '4056766 Or', 'Juan Carlos', 'García Siles', '1982-07-14', 'ORURO', '70421618', NULL, 100, 'jcgs-rO 6676504-183-ANIV21', '2022-10-14 00:00:00'),
(48, '3548921', 'Rosalba Marlene ', 'Hidalgo Peñafiel ', '1978-02-20', 'ORURO', '71889665', NULL, 16, 'rmhp-1298453-35-ANIV21', '2022-10-12 00:00:00'),
(49, '5738420', 'Rodrigo Tomás', 'Escalante Arias ', '1988-05-13', 'ORURO', '72342037', NULL, 36, 'rtea-0248375-36-ANIV21', '2022-10-12 00:00:00'),
(50, '15302867', 'Daniela mishell', 'Peñaylillo Tapia', '2000-06-22', 'ORURO', '76152380', NULL, 100, 'dmpt-76820351-37-ANIV21', '2022-10-12 00:00:00'),
(51, '7419827', 'LIZBETH HEIDI', 'CHOQUE SOLIZ', '2000-09-24', 'ORURO', '69576899', NULL, 100, 'lhcs-7289147-39-ANIV21', '2022-10-12 00:00:00'),
(52, '7381267', 'Alvaro Leonel ', 'Choque Achacollo ', '1994-01-21', 'ORURO', '72355654', NULL, 80, 'alca-7621837-38-ANIV21', '2022-10-12 00:00:00'),
(53, '7311074', 'Javier', 'Canaviri Espinoza', '1999-12-02', 'ORURO', '76150552', NULL, 100, 'jce-4701137-40-ANIV21', '2022-10-12 00:00:00'),
(54, '4075322', 'Elvia Wendy', 'Jacinto Coca ', '1987-06-20', 'ORURO', '68282013', NULL, 100, 'ewjc-2235704-43-ANIV21', '2022-10-12 00:00:00'),
(55, '4068322 Or', 'Cecilia', 'Blacut Condori ', '1983-01-25', 'ORURO', '70437136', NULL, 100, 'cbc-rO 2238604-41-ANIV21', '2022-10-12 00:00:00'),
(56, '13189129', 'Axel Rodrigo ', 'Pita Jacinto ', '2006-11-20', 'ORURO', '71180037', NULL, 100, 'arpj-92198131-44-ANIV21', '2022-10-12 00:00:00'),
(57, '7338602', 'Juan Abel', 'Calizaya Tarqui', '2002-10-29', 'ORURO', '71888855', NULL, 100, 'jact-2068337-42-ANIV21', '2022-10-12 00:00:00'),
(58, '5742064', 'Ronald ', 'Quispe Flores', '1985-08-26', 'ORURO', '60410135', NULL, 100, 'rqf-4602475-45-ANIV21', '2022-10-12 00:00:00'),
(59, '7319559', 'Kelly Mercedez', 'Atanacio Torrez', '1995-09-17', 'ORURO', '72343985', NULL, 100, 'kmat-9559137-46-ANIV21', '2022-10-12 00:00:00'),
(60, '7356321', 'Melany Andrea', 'Rivera Ojeda', '1996-12-15', 'ORURO', '75701235', NULL, 100, 'maro-1236537-48-ANIV21', '2022-10-12 00:00:00'),
(61, '7345330', 'Jheymi', 'Choque Pacheco ', '1992-04-16', 'ORURO', '73841623', NULL, 84, 'jcp-0335437-47-ANIV21', '2022-10-12 00:00:00'),
(62, '7347396', 'Mauricio Jesús', 'Llanque Colque', '1995-09-22', 'ORURO', '75707202', NULL, 100, 'mjlc-6937437-49-ANIV21', '2022-10-12 00:00:00'),
(63, '7364389', 'Josue', 'Cadena Choque ', '1994-03-05', 'ORURO', '75414663', NULL, 100, 'jcc-9834637-50-ANIV21', '2022-10-12 00:00:00'),
(64, '7374504', 'Marcelo ', 'Rodriguez Suarez ', '1994-06-20', 'ORURO', '79406520', NULL, 100, 'mrs-4054737-51-ANIV21', '2022-10-12 00:00:00'),
(65, '5758203', 'Elizangela', 'Avilez Morales', '1984-10-21', 'ORURO', '70434305', NULL, 100, 'em-3028575-52-ANIV21', '2022-10-12 00:00:00'),
(66, '7367321', 'Selena', 'Lopez Dorado', '2001-09-24', 'ORURO', '65415235', NULL, 100, 'sld-1237637-54-ANIV21', '2022-10-12 00:00:00'),
(67, '7289858', 'Mayra Alejandra ', 'Ochoa Flores ', '1998-07-24', 'ORURO', '61838638', NULL, 58.4, 'maof-8589827-53-ANIV21', '2022-10-12 00:00:00'),
(68, '4054646', 'Arnold Miguel', 'Rios Pacheco', '1985-09-20', 'ORURO', '68304503', NULL, 100, 'amrp-6464504-55-ANIV21', '2022-10-12 00:00:00'),
(69, '7344209', 'Samuel Josué', 'Salvatierra Caro', '1998-03-30', 'ORURO', '60402547', NULL, 100, 'sjsc-9024437-58-ANVI21', '2022-10-12 00:00:00'),
(70, '7387611', 'Paul Douglas', 'Soliz Julián', '1999-10-03', 'ORURO', '74461320', NULL, 66.4, 'pdsj-1167837-57-ANIV21', '2022-10-12 00:00:00'),
(71, '7351138', 'Alvaro Hector', 'Simón Mollo', '2002-04-05', 'ORURO', '72451562', NULL, 100, 'ahsm-8311537-56-ANIV21', '2022-10-12 00:00:00'),
(72, '7334547', 'Edwin Cristian', 'Velasquez Gutiérrez', '1999-09-02', 'ORURO', '68291585', NULL, 100, 'ecvg-7454337-60-ANIV21', '2022-10-12 00:00:00'),
(73, '5764079', 'Cindy Michelle', 'Sejas Ascarraga', '1987-06-20', 'ORURO', '75410028', NULL, 52, 'cmsa-9704675-61-ANIV21', '2022-10-12 00:00:00'),
(74, '5741048', 'Cristian Edwin ', 'Beltrán Ríos ', '1986-02-09', 'ORURO', '70433335', NULL, 100, 'cebr-8401475-63-ANIV21', '2022-10-12 00:00:00'),
(75, '5773293 ', 'Paul Guillermo ', 'Sejas Ascarraga', '1988-11-29', 'ORURO', '67203947', NULL, 100, 'pgsa- 3923775-62-ANIV21', '2022-10-12 00:00:00'),
(76, '5770348', 'INTI MARCELO', 'PEÑARANDA COCA', '1997-05-14', 'ORURO', '72476914', NULL, 100, 'impc-8430775-111-ANIV21', '2022-10-12 00:00:00'),
(77, '9341687', 'Daniela Adriana', 'Córdova Choque', '2001-06-24', 'ORURO', '60405333', NULL, 100, 'dacc-7861439-109-ANIV21', '2022-10-12 00:00:00'),
(78, '7362892', 'Joselin Marcia', 'Velasquez lopez', '1996-06-23', 'ORURO', '70435933', NULL, 100, 'jmvl-2982637-59-ANIV21', '2022-10-12 00:00:00'),
(79, '7367513 ', 'HENRY MANUEL ', 'MAMANI HUARACHI ', '2003-07-19', 'ORURO', '73818845', NULL, 100, 'hmmh- 3157637-64-ANIV21', '2022-10-12 00:00:00'),
(80, '7298082', 'Fidel Alexander', 'Vasquez Huanca', '1997-06-03', 'ORURO', '75418705', NULL, 100, 'favh-2808927-100-ANIV21', '2022-10-12 00:00:00'),
(81, '13464307', 'Brayan Alvert', 'Poma Villca', '1998-03-09', 'ORURO', '61832411', NULL, 12, 'bapv-70346431-66-ANIV21', '2022-10-12 00:00:00'),
(82, '3520195', 'Roxana ', 'Huarachi Villa', '1974-05-20', 'ORURO', '75700461', NULL, 100, 'rhv-5910253-65-ANIV21', '2022-10-12 00:00:00'),
(83, '7405795', 'Ezequiel Felipe ', 'Vázquez Huanca ', '2004-09-22', 'ORURO', '72318631', NULL, 100, 'efvh-5975047-101-ANIV21', '2022-10-12 00:00:00'),
(84, '7323417', 'Daysi Jeovana ', 'Colque Cruz', '2000-10-09', 'ORURO', '65409615', NULL, 100, 'djcc-7143237-67-ANIV21', '2022-10-12 00:00:00'),
(85, '7375944', 'ADDA BELÉN', 'ACHO RIVERA', '2000-06-28', 'ORURO', '75711979', NULL, 100, 'abar-4495737-68-ANIV21', '2022-10-12 00:00:00'),
(87, '7422801', 'Jose Fernando', 'Pinaya', '1997-04-18', 'ORURO', '76156159', NULL, 100, 'jfp-95165167-69-ANIV21', '2022-10-12 00:00:00'),
(88, '7371055', 'Luisa Karen', 'Ramirez Llampa', '1996-03-29', 'ORURO', '72316231', NULL, 100, 'lkrl-5501737-72-ANIV21', '2022-10-12 00:00:00'),
(89, '7367629 ', 'Andrés  Jhonny', 'Manzaneda Adrian', '1996-07-05', 'ORURO', '75707714', NULL, 100, 'ajma- 9267637-71-ANIV21', '2022-10-12 00:00:00'),
(90, '12741850', 'Graciela Génesis', 'Carpio Iturricha', '1996-12-13', 'ORURO', '77149148', NULL, 100, 'ggci-05814721-70-ANIV21', '2022-10-12 00:00:00'),
(91, '13156784', 'Mathias Alejandro', 'Delgado Sanchez', '2007-09-01', 'ORURO', '70415725', NULL, 100, 'mads-48765131-169-ANIV21', '2022-10-14 00:00:00'),
(92, '7270560', 'Jhovany Alvaro ', 'Paco Pacolla', '1995-11-28', 'ORURO', '65413602', NULL, 100, 'japp-0650727-102-ANIV21', '2022-10-12 00:00:00'),
(93, '7270162', 'Susana', 'Garnica Fernández ', '1990-09-20', 'ORURO', '72472858', NULL, 100, 'sgf-2610727-73-ANIV21', '2022-10-12 00:00:00'),
(94, '7388599', 'Alexander', 'Villegas Chambi', '1994-09-21', 'ORURO', '75425088', NULL, 100, 'avc-9958837-74-ANIV21', '2022-10-12 00:00:00'),
(95, '7282032 ', 'Gersom Adalid ', 'Bricher Lainez', '1989-07-01', 'ORURO', '78603077', NULL, 100, 'gabl- 2302827-75-ANIV21', '2022-10-12 00:00:00'),
(96, '13156783', 'Andrés Arturo', 'Delgado Sánchez', '1969-12-31', 'ORURO', '70423333', NULL, 100, 'aads-38765131-170-ANIV21', '2022-10-14 00:00:00'),
(97, '5758986 ', 'Alan Beymar', 'Mendoza Yucra', '2002-11-21', 'ORURO', '75411386', NULL, 100, 'abmy- 6898575-76-ANIV21', '2022-10-12 00:00:00'),
(98, '3521152', 'Melania Jackeline', 'Ortiz Huayta', '1975-05-15', 'ORURO', '72470704', NULL, 100, 'mjoh-2511253-79-ANIV21', '2022-10-12 00:00:00'),
(99, '3515598', 'ALBERTO FRANCISCO', 'Corrales Villanueva', '1974-07-09', 'ORURO', '71185939', NULL, 52, 'afcv-8955153-81-ANIV21', '2022-10-12 00:00:00'),
(100, '7329671', 'Patricia', 'Guzman Patiño', '2000-07-25', 'ORURO', '65402456', NULL, 100, 'pgp-1769237-83-ANIV21', '2022-10-12 00:00:00'),
(101, '7333917', 'SAMUEL', 'ROSEL MUÑOZ', '2000-09-08', 'ORURO', '62808933', NULL, 4, 'srm-7193337-77-ANIV21', '2022-10-12 00:00:00'),
(102, '5773851', 'María Claudia', 'Delgadillo Corrales', '1995-07-10', 'ORURO', '72488277', NULL, 100, 'mcdc-77288427-80-ANIV21', '2022-10-12 00:00:00'),
(103, '7394457', 'Rosario Vanessa', 'Ticona Flores', '1992-10-29', 'ORURO', '75704569', NULL, 100, 'rvtf-7544937-78-ANIV21', '2022-10-12 00:00:00'),
(104, '7379324', 'Carlos Franz', 'Arequipa Salas', '1993-03-09', 'ORURO', '74102094', NULL, 100, 'cfas-4239737-82-ANIV21', '2022-10-12 00:00:00'),
(105, '3060609', 'Marina ', 'Fernández Irahola', '1966-06-18', 'ORURO', '73839400', NULL, 100, 'mfi-9060603-85-ANIV21', '2022-10-12 00:00:00'),
(106, '5769852', 'ALEJANDRA ', 'VIÑOLA FERNÁNDEZ', '1988-03-08', 'ORURO', '70417237', NULL, 100, 'avf-2589675-86-ANIV21', '2022-10-12 00:00:00'),
(107, '7294175', 'Romeo Alejandro', 'Calizaya Oczachoque', '1993-03-18', 'ORURO', '79409933', NULL, 100, 'raco-5714927-84-ANIV21', '2022-10-12 00:00:00'),
(108, '7313439', 'Percy Alberto', 'Yavé Fernández', '2001-11-13', 'ORURO', '67221965', NULL, 100, 'payf-9343137-87-ANIV21', '2022-10-12 00:00:00'),
(109, '7370530', 'Kevin Luis', 'Ramirez Choque', '2001-10-04', 'ORURO', '74460655', NULL, 100, 'klrc-0350737-88-ANIV21', '2022-10-12 00:00:00'),
(110, '5762653', 'Rodrigo', 'Aramayo Mercado', '1988-03-12', 'ORURO', '60411101', NULL, 100, 'ram-3562675-93-ANIV21', '2022-10-12 00:00:00'),
(111, '7356813', 'Ronald', 'Morochi Paredez', '2002-09-12', 'ORURO', '72304498', NULL, 76, 'rmp-3186537-90-ANIV21', '2022-10-12 00:00:00'),
(112, '5064533', 'Velka Brita', 'Navarro Claros', '1986-12-16', 'ORURO', '72005303', NULL, 100, 'vbnc-3354605-92-ANIV21', '2022-10-12 00:00:00'),
(113, '7302632', 'Claudia Mabel ', 'Jimenez Irahola', '1989-04-06', 'ORURO', '78607538', NULL, 100, 'cmji-2362037-89-ANIV21', '2022-10-12 00:00:00'),
(114, '7294469', 'Marialy Jhaziel', 'Cossio Riveros', '2003-08-21', 'ORURO', '70430260', NULL, 100, 'mjcr-9644927-91-ANIV21', '2022-10-12 00:00:00'),
(115, '7290827', 'Gary', 'Quezada Mendez', '1993-11-22', 'ORURO', '70422556', NULL, 100, 'gqm-7280927-94-ANIV21', '2022-10-12 00:00:00'),
(116, '5728755', 'ROLANDO ', 'YUCRA MAMANI ', '1984-06-04', 'ORURO', '79427725', NULL, 100, 'rym-5578275-105-ANIV21', '2022-10-12 00:00:00'),
(117, '7293332', ' Miguel Alexander ', 'Muñoz Arratia', '1996-12-16', 'ORURO', '61814656', NULL, 100, 'mama-2333927-95-ANIV21', '2022-10-12 00:00:00'),
(118, '5767953', 'Erick Gualberto ', 'Rivera Ramirez', '1989-10-20', 'ORURO', '69601932', NULL, 87.2, 'egrr-3597675-96-ANIV21', '2022-10-12 00:00:00'),
(119, '5741967', 'Jhosemar Miguel', 'Condori Andia', '1987-08-07', 'ORURO', '72491711', NULL, 100, 'jmca-7691475-98-ANIV21', '2022-10-12 00:00:00'),
(120, '7264796', 'Liz Gabriela', 'Quispe Benítez', '1988-08-10', 'ORURO', '72454667', NULL, 34.400000000000006, 'lgqb-6974627-99-ANIV21', '2022-10-12 00:00:00'),
(121, '6634181', 'Maricela Magdaly', 'Yucra Paredes', '1987-07-06', 'ORURO', '79404978', NULL, 100, 'mmyp-1814366-97-ANIV21', '2022-10-12 00:00:00'),
(122, '7367698', 'Estefani Michel ', 'Chungara Valencia ', '1995-03-10', 'ORURO', '74479258', NULL, 100, 'emcv-8967637-104-ANIV21', '2022-10-12 00:00:00'),
(123, '5739508', 'Roger Alan', 'Medina Chambi', '1989-03-07', 'ORURO', '79427662', NULL, 100, 'ramc-8059375-103-ANIV21', '2022-10-12 00:00:00'),
(124, '7360804', 'Marvin Adhemar', 'Choque Mamani', '1997-08-27', 'ORURO', '72838566', NULL, 100, 'macm-4080637-110-ANIV21', '2022-10-12 00:00:00'),
(125, '10542283', 'Benjamin', 'Ramos Calizaya', '1998-10-25', 'ORURO', '74225242', NULL, 100, 'brc-38224501-106-ANIV21', '2022-10-12 00:00:00'),
(126, '7998868', 'Stefany Sharon ', 'Colodro Huerta ', '2000-06-10', 'ORURO', '73830506', NULL, 100, 'ssch-8688997-108-ANIV21', '2022-10-12 00:00:00'),
(127, '7277027', 'Ivi Aida', 'Romero Cama', '1994-03-12', 'ORURO', '72471764', NULL, 100, 'iarc-7207727-107-ANIV21', '2022-10-12 00:00:00'),
(128, '5765693', 'Lilian', 'Apata Mamani', '1985-11-27', 'ORURO', '71849713', NULL, 100, 'lam-3965675-112-ANIV21', '2022-10-12 00:00:00'),
(129, '5755961', 'Rolando', 'Aquino Gutierrez', '1986-05-31', 'ORURO', '61825444', NULL, 100, 'rag-1695675-113-ANIV21', '2022-10-12 00:00:00'),
(130, '7425790', 'franz pablo', 'mamani encinas', '1994-03-03', 'ORURO', '71857668', NULL, 100, 'fpme-0975247-114-ANIV21', '2022-10-12 00:00:00'),
(131, '7359469', 'Valquiria Judith ', 'Martínez Ayala ', '1994-01-03', 'ORURO', '73820296', NULL, 100, 'vjma-9649537-115-ANIV21', '2022-10-12 00:00:00'),
(132, '7355212', 'Monica Andrea', 'Rodriguez Coca', '1995-10-11', 'ORURO', '71108840', NULL, 100, 'marc-2125537-116-ANIV21', '2022-10-12 00:00:00'),
(133, '8551455', 'Osmar ', 'Porcel', '1990-08-21', 'ORURO', '70419539', NULL, 100, 'op-5541558-118-ANIV21', '2022-10-12 00:00:00'),
(134, '5723192', 'Favio Daniel', 'Yugar Caceres', '1983-08-18', 'ORURO', '75428090', NULL, 100, 'fdyc-2913275-117-ANIV21', '2022-10-12 00:00:00'),
(135, '7374887', 'Isabel', 'Choque Gutiérrez', '1992-05-11', 'ORURO', '76157671', NULL, 100, 'icg-7884737-119-ANIV21', '2022-10-12 00:00:00'),
(136, '7338018', 'Marcos antonio', 'Mallcu garcia', '1993-10-28', 'ORURO', '68306869', NULL, 28, 'mamg-8108337-123-ANIV21', '2022-10-12 00:00:00'),
(137, '14670927', 'Katia Olga', 'Bernuy Malla', '1990-05-26', 'ORURO', '70426192', NULL, 72, 'kobm-72907641-120-ANIV21', '2022-10-12 00:00:00'),
(138, '3522197', 'Lady Lorena', 'Mareño Mamani', '1984-04-14', 'ORURO', '72481500', NULL, 28, 'llmm-7912253-122-ANIV21', '2022-10-12 00:00:00'),
(139, '8995032', 'Ernesto Norman', 'Choque López', '2001-05-03', 'ORURO', '62787806', NULL, 100, 'encl-2305998-121-ANIV21', '2022-10-12 00:00:00'),
(140, '7338018', 'Marcos antonio', 'Mallcu garcia', '1993-10-28', 'ORURO', '68306869', NULL, 100, 'shg-2880547-125-ANIV21', '2022-10-12 00:00:00'),
(141, '12644893', 'CESAR ANDRES ', 'CHAMBI MORALES ', '1998-09-13', 'ORURO', '77146668', NULL, 100, 'cacm-39844621-124-ANIV21', '2022-10-12 00:00:00'),
(142, '7450882', 'Sandra', 'Huanca Guarachi', '1995-11-25', 'ORURO', '60422053', NULL, 100, 'shg-2880547-125-ANIV21', '2022-10-12 00:00:00'),
(143, '7331953', 'Ronald', 'Rodríguez Ayma ', '1993-01-20', 'ORURO', '60423282', NULL, 100, 'rra-3591337-126-ANIV21', '2022-10-12 00:00:00'),
(144, '7269940', 'Mireya Celeste', 'Velásquez Pantoja', '1997-04-16', 'ORURO', '76142086', NULL, 100, 'mcvp-0499627-127-ANIV21', '2022-10-12 00:00:00'),
(145, '7399965', 'Ronald', 'Apaza chile', '1999-09-12', 'ORURO', '68338903', NULL, 100, 'rac-5699937-128-ANIV21', '2022-10-12 00:00:00'),
(146, '5745841', 'GLADYS VARINIA', 'VALDEZ FERNÁNDEZ', '1986-03-20', 'ORURO', '69600155', NULL, 100, 'gvvf-1485475-130-ANIV21', '2022-10-12 00:00:00'),
(147, '7346004', 'Lilian Cecilia', 'Mamani Choque', '1996-07-31', 'ORURO', '75405203', NULL, 100, 'lcmc-4006437-131-ANIV21', '2022-10-12 00:00:00'),
(148, '9396648', 'Herbert Giovanni ', 'Mamani Bernabe ', '1994-05-27', 'ORURO', '68335925', NULL, 100, 'hgmb-8466939-129-ANIV21', '2022-10-12 00:00:00'),
(149, '4042971 ', 'Jimena', 'Salazar Mendoza ', '1986-06-19', 'ORURO', '77440154', NULL, 100, 'jsm- 1792404-133-ANIV21', '2022-10-12 00:00:00'),
(150, '5065438', 'Yamil Jorge', 'Gomez Antezana', '1983-09-01', 'ORURO', '79409818', NULL, 100, 'yjga-8345605-132-ANIV21', '2022-10-12 00:00:00'),
(151, '7389828', 'Junior Ariel', 'Mendoza Andrade', '1993-09-18', 'ORURO', '69604178', NULL, 100, 'jama-8289837-134-ANIV21', '2022-10-12 00:00:00'),
(152, '7403684', 'Neyza ', 'López Chila', '1998-03-22', 'ORURO', '62846249', NULL, 100, 'nlc-4863047-135-ANIV21', '2022-10-12 00:00:00'),
(153, '7389829', 'Alison', 'Mendoza Andrade', '2007-08-11', 'ORURO', '69593555', NULL, 100, 'ama-9289837-136-ANIV21', '2022-10-12 00:00:00'),
(154, '7272555', 'Paola Andrea ', 'Navarro Rojas ', '1993-04-20', 'ORURO', '68319995', NULL, 100, 'panr-5552727-137-ANIV21', '2022-10-12 00:00:00'),
(155, '5774528', 'Mauricio Ariel ', 'Ugarte Deheza ', '1989-06-04', 'ORURO', '69588890', NULL, 100, 'maud-09888596-138-ANIV21', '2022-10-12 00:00:00'),
(156, '4079010', 'Ricardo Sergio', 'Soto Bernal', '1984-09-16', 'ORURO', '72499884', NULL, 100, 'rssb-0109704-184-ANIV21', '2022-10-14 00:00:00'),
(157, '7363616', 'Nelson Rolando ', 'Mamani Choque', '1995-12-15', 'ORURO', '60419875', NULL, 100, 'nrmc-6163637-139-ANIV21', '2022-10-12 00:00:00'),
(158, '10463504', 'KEVIN JONATHAN', 'COPA RICALDI', '1996-07-20', 'ORURO', '68341749', NULL, 100, 'kjcr-40536401-140-ANIV21', '2022-10-12 00:00:00'),
(159, '4076140', 'BRAYAN JIMMY', 'RUFINO ARROYO', '1997-04-26', 'ORURO', '68305977', NULL, 100, 'bjra-0416704-142-ANIV21', '2022-10-12 00:00:00'),
(160, '7398676', 'Jhoselin', 'Mamani Choque', '1999-07-22', 'ORURO', '70436052', NULL, 100, 'jmc-6768937-141-ANIV21', '2022-10-12 00:00:00'),
(161, '4060586', 'Richard', 'Achabal Villalpando', '1985-10-02', 'ORURO', '71884710', NULL, 100, 'rav-6850604-143-ANIV21', '2022-10-12 00:00:00'),
(162, '3558204', 'RONALD JAIME', 'VARGAS OBLITAS', '1980-11-07', 'ORURO', '75413303', NULL, 100, 'rjvo-4028553-187-ANIV21', '2022-10-14 00:00:00'),
(163, '7418853', 'José Alexander ', 'Marce Flores', '1996-11-15', 'ORURO', '68322331', NULL, 26.4, 'jamf-3588147-144-ANIV21', '2022-10-12 00:00:00'),
(164, '6593853', 'Boris Elmer', 'Chambi Ricaldi', '1988-10-12', 'ORURO', '72435224', NULL, 100, 'becr-3583956-145-ANIV21', '2022-10-12 00:00:00'),
(165, '7291087', 'Dayana Arelis', 'Villalobos Benito', '1996-02-07', 'ORURO', '75403881', NULL, 100, 'davb-7801927-146-ANIV21', '2022-10-12 00:00:00'),
(166, '7289566', 'Grace Pamela ', 'Villalobos Benito', '1993-09-09', 'ORURO', '69591130', NULL, 100, 'gpvb-6659827-147-ANIV21', '2022-10-12 00:00:00'),
(167, '12869769', 'Patricia Allison ', 'Loría Frias ', '2006-03-30', 'ORURO', '76144902', NULL, 100, 'palf-96796821-148-ANIV21', '2022-10-12 00:00:00'),
(169, '3559649', 'Enilsen Lizett ', 'Patiño Arce', '1979-03-20', 'ORURO', '72488088', NULL, 100, 'elpa-9469553-149-ANIV21', '2022-10-12 00:00:00'),
(170, '7346366', 'Diego Manuel', 'Conde Estupiñon', '1993-08-15', 'ORURO', '75420335', NULL, 100, 'dmce- 6636437-150-ANIV21', '2022-10-12 00:00:00'),
(171, '4051850', 'Jacqueline', 'Patiño Arce ', '1980-09-28', 'ORURO', '71108919', NULL, 100, 'jpa-0581504-151-ANIV21', '2022-10-12 00:00:00'),
(172, '3544856', 'Oscar Rodrigo', 'Gutierrez Torrico ', '1978-01-22', 'ORURO', '67235240', NULL, 36, 'orgt-6584453-152-ANIV21', '2022-10-12 00:00:00'),
(173, '7336632', 'Marcelo de Jesus ', 'Aima Gutiérrez ', '1999-11-29', 'ORURO', '72335531', NULL, 100, 'mdjag-2366337-153-ANIV21', '2022-10-12 00:00:00'),
(174, '5726211', 'Oscar', 'Cuentas Sandy', '2000-04-30', 'ORURO', '72485985', NULL, 100, 'ocs-1126275-155-ANIV21', '2022-10-12 00:00:00'),
(175, '5065528', 'Lezly Britha', 'Patiño Arce ', '1982-04-26', 'ORURO', '79403504', NULL, 144, 'lbpa-8255605-156-ANIV21', '2022-10-12 00:00:00'),
(176, '7404972', 'Alvaro ', 'Sanchez Vargas ', '2003-04-28', 'ORURO', '76142753', NULL, 100, 'asv-2794047-154-ANIV21', '2022-10-12 00:00:00'),
(178, '7424962', 'Luis Alejandro', 'García herbas', '1993-12-02', 'ORURO', '68368185', NULL, 100, 'lagh-2694247-157-ANIV21', '2022-10-12 00:00:00'),
(179, '7392329', 'Edgar', 'Choquetupa Huanca ', '1969-12-31', 'ORURO', '67252521', NULL, 44, 'ech-9232937-158-ANIV21', '2022-10-12 00:00:00'),
(180, '5737850', 'Mauricio', 'Chambi Vergara ', '1991-04-16', 'ORURO', '69336046', NULL, 100, 'mcv-0587375-159-ANIV21', '2022-10-12 00:00:00'),
(181, '7275255', 'JHESSIKA HELEN', 'ROCHA AJHUACHO', '1996-07-01', 'ORURO', '69580685', NULL, 100, 'jhra-5525727-185-ANIV21', '2022-10-14 00:00:00'),
(182, '5736563', 'OSEL JUAN', 'CRISPIN FAJARDO', '1990-09-07', 'ORURO', '75700129', NULL, 100, 'ojcf-3656375-186-ANIV21', '2022-10-14 00:00:00'),
(183, '7314984 ', 'Gilmer', 'Garcia Huayllani', '2002-05-24', 'ORURO', '67231680', NULL, 100, 'ggh- 4894137-163-ANIV21', '2022-10-12 00:00:00'),
(184, '7405995', 'Conny Sofia', 'Macedo Cussi', '2002-09-30', 'ORURO', '63692126', NULL, 100, 'csmc-5995047-162-ANIV21', '2022-10-12 00:00:00'),
(185, '7316415', 'Abdeel Miguel', 'Escobar Vargas ', '1969-12-31', 'ORURO', '76132552', NULL, 100, 'amev-5146137-160-ANIV21', '2022-10-12 00:00:00'),
(186, '3547554', 'Omar Saúl', 'Frías Enríquez', '1977-09-15', 'ORURO', '77148000', NULL, 36, 'osfe-00084177-161-ANIV21', '2022-10-12 00:00:00'),
(187, '7333755', 'Jessica Evelyn ', 'Mamani Nina', '2000-05-06', 'ORURO', '71856031', NULL, 100, 'jemn-5573337-164-ANIV21', '2022-10-12 00:00:00'),
(188, '7336199', 'adimer', 'chambi', '2021-10-15', NULL, '69603027', '', 560.4, 'sjsc-9024437-58-ANIV21', '2021-10-15 00:00:00'),
(190, '5740424', 'Gustavo Pablo', 'Vásquez Llorenty', '1984-09-14', 'ORURO', '77158449', NULL, 100, 'gpvl-4240475-181-ANIV21', '2022-10-14 00:00:00'),
(191, '5062436', 'LIZETH', 'PLAZA GARCIA', '1987-04-29', 'ORURO', '74158178', NULL, 100, 'lpg-6342605-182-ANIV21', '2022-10-14 00:00:00'),
(193, '2759855', 'Martha Laura', 'Sánchez Espinoza', '1968-09-14', 'ORURO', '71889868', NULL, 100, 'mlse-5589572-180-ANIV21', '2022-10-14 00:00:00'),
(194, '6553738', 'Andrea Valentina', 'Alcócer Sánchez', '1994-08-11', 'ORURO', '75413200', NULL, 100, 'avas-8373556-179-ANIV21', '2022-10-14 00:00:00'),
(195, '6553724', 'Gabriela Erika', 'Alcócer Sánchez', '1992-12-17', 'ORURO', '70436681', NULL, 100, 'geas-4273556-178-ANIV21', '2022-10-14 00:00:00'),
(196, '5741863', 'Henrry', 'Frias Tito', '1986-05-14', 'ORURO', '70553876', NULL, 100, 'hft- 3681475-165-ANIV21', '2022-10-14 00:00:00'),
(197, '5741279', 'Sandra Marcela', 'Alvarez Colque', '1988-05-21', 'ORURO', '72003174', NULL, 100, 'smac-9721475-166-ANIV21', '2022-10-14 00:00:00'),
(198, '7282363', 'Santos', 'Soliz Guzman', '1988-12-23', 'ORURO', '68303555', NULL, 100, 'ssg-3632827-167-ANIV21', '2022-10-14 00:00:00'),
(199, '7409962', 'Juan pablo', 'Cerrogrande Acuña', '2000-09-05', 'ORURO', '67208613', NULL, 39.6, 'jpca-2699047-171-ANIV21', '2022-10-14 00:00:00'),
(200, '7270080', 'Miguel A.', 'Humerez Mamani', '1989-02-02', 'ORURO', '69336339', NULL, 100, 'mahm-0800727-168-ANIV21', '2022-10-14 00:00:00'),
(201, '7330878', 'Ronald', 'Mamani Choque', '1989-12-21', 'ORURO', '72456452', NULL, 4, 'rmc-8780337-172-ANIV21', '2022-10-14 00:00:00'),
(202, '7413644', 'María Renée', 'Morante Condori', '1998-09-05', 'ORURO', '79410198', NULL, 65.6, 'mrmc-4463147-173-ANIV21', '2022-10-14 00:00:00'),
(203, '4057959', 'Soledad', 'Condori Flores', '1980-12-19', 'ORURO', '60430963', NULL, 52, 'scf-9597504-174-ANIV21', '2022-10-14 00:00:00'),
(204, '7261025', 'Ritha Jazmine', 'Aima Gutierrez', '1988-02-12', 'ORURO', '75415540', NULL, 100, 'rjag-5201627-175-ANIV21', '2022-10-14 00:00:00'),
(205, '7275151', 'Andrea Silvana', 'Gutierrez Rodriguez', '1988-07-22', 'ORURO', '79404475', NULL, 100, 'asgr-1515727-176-ANIV21', '2022-10-14 00:00:00'),
(206, '13857944', 'Matías charly', 'Córdova Aguilar', '2009-06-10', 'ORURO', '79413104', NULL, 100, 'mcca-44975831-188-ANIV21', '2022-10-14 00:00:00'),
(207, '5908775', 'Jose luis', 'Magne escobar', '1984-02-02', 'ORURO', '70344117', NULL, 100, 'jlme-5778095-189-ANIV21', '2022-10-14 00:00:00'),
(208, '4832494', 'Milenka Ana', 'Vega Garcia', '1986-01-07', 'ORURO', '70417579', NULL, 100, 'mavg-4942384-190-ANIV21', '2022-10-14 00:00:00'),
(209, '3395650', 'GREGORIO FERNANDO', 'UREÑA MERIDA', '1973-01-12', 'ORURO', '69572229', NULL, 100, 'gfum-0565933-191-ANIV21', '2022-10-14 00:00:00'),
(210, '7364378', 'Marcelo Edgar', 'Huarachi Chila', '1993-06-28', 'ORURO', '78616459', NULL, 100, 'mehc-8734637-192-ANIV21', '2022-10-14 00:00:00'),
(211, '4075892', 'Carlos', 'Córdova reynaga', '1985-12-19', 'ORURO', '79413104', NULL, 100, 'ccr- 2985704-195-ANIV21', '2022-10-14 00:00:00'),
(212, '4077923', 'Junior jairo', 'Viza moya', '2000-07-14', 'ORURO', '72336906', NULL, 100, 'jjvm-3297704-193-ANIV21', '2022-10-14 00:00:00'),
(213, '7275669', 'Jhoselin Andrea', 'Soria Vallejos', '1996-05-07', 'ORURO', '72302779', NULL, 100, 'jasv- 9665727-194-ANIV21', '2022-10-14 00:00:00'),
(214, '7358978-Or.', 'Lilian Nicol', 'Arevalo Guachalla', '1996-02-09', 'ORURO', '70431187', NULL, 100, 'lnag-.rO-8798537-196-ANIV21', '2022-10-15 00:00:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial`
--

CREATE TABLE `historial` (
  `id` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `lugar` varchar(255) NOT NULL,
  `monto` double NOT NULL,
  `numero` int(11) NOT NULL,
  `cliente_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `historial`
--

INSERT INTO `historial` (`id`, `fecha`, `lugar`, `monto`, `numero`, `cliente_id`) VALUES
(1, '2021-10-09', 'SABOR PERU', 80, 4, 1),
(2, '2021-10-09', 'CANDY BAR', 40, 29, 1),
(3, '2021-10-09', 'CANDY BAR', 23.200000000000003, 30, 1),
(4, '2021-10-09', 'CANDY BAR', 7.2, 34, 1),
(5, '2021-10-09', 'BOLETERIA', 72, 72, 1),
(6, '2021-10-09', 'BOLETERIA', 32, 73, 1),
(7, '2021-10-09', 'BOLETERIA', 80, 74, 1),
(8, '2021-10-09', 'BOLETERIA', 64, 75, 1),
(9, '2021-10-09', 'BOLETERIA', 64, 76, 1),
(10, '2021-10-09', 'CANDY BAR', 23.2, 35, 1),
(11, '2021-10-09', 'BOLETERIA', 32, 77, 1),
(12, '2021-10-10', 'CAFE ITALIA', 80, 1, 1),
(13, '2021-10-10', 'CAFE ITALIA', 16, 2, 1),
(14, '2021-10-10', 'CANDY BAR', 8, 11, 1),
(15, '2021-10-10', 'CANDY BAR', 8, 12, 1),
(16, '2021-10-10', 'BOLETERIA', 80, 70, 1),
(17, '2021-10-10', 'BOLETERIA', 160, 71, 1),
(18, '2021-10-10', 'CANDY BAR', 80, 13, 1),
(19, '2021-10-10', 'CANDY BAR', 120, 14, 1),
(20, '2021-10-10', 'CANDY BAR', 80, 15, 1),
(21, '2021-10-10', 'CANDY BAR', 8, 16, 1),
(22, '2021-10-10', 'CANDY BAR', 120, 17, 1),
(23, '2021-10-10', 'BOLETERIA', 80, 72, 1),
(24, '2021-10-13', 'CANDY BAR', 28, 114373, 48),
(25, '2021-10-13', 'CAFE ITALIA', 40, 1593, 29),
(26, '2021-10-13', 'CANDY BAR', 24, 114678, 111),
(27, '2021-10-14', 'CANDY BAR', 16, 114703, 61),
(28, '2021-10-14', 'SABOR PERU', 20, 2483, 29),
(29, '2021-10-14', 'SABOR PERU', 24, 2484, 29),
(30, '2021-10-14', 'SABOR PERU', 28, 2485, 163),
(31, '2021-10-14', 'SABOR PERU', 24, 2486, 29),
(32, '2021-10-14', 'CAFE ITALIA', 21.6, 1600, 163),
(33, '2021-10-15', 'SABOR PERU', 20, 2497, 17),
(34, '2021-10-15', 'SABOR PERU', 30, 2499, 199),
(35, '2021-10-15', 'SABOR PERU', 24, 2500, 199),
(36, '2021-10-15', 'BOLETERIA', 48, 89188, 73),
(38, '2021-10-15', 'CANDY BAR', 80, 20, 188),
(39, '2021-10-15', 'CANDY BAR', 8, 24, 188),
(40, '2021-10-15', 'BOLETERIA', 64, 89205, 30),
(41, '2021-10-15', 'CANDY BAR', 28, 114822, 30),
(43, '2021-10-15', 'CAFE ITALIA', 30.4, 1613, 202),
(44, '2021-10-15', 'CANDY BAR', 80, 27, 188),
(45, '2021-10-15', 'SABOR PERU', 20, 2503, 163),
(46, '2021-10-15', 'CANDY BAR', 40, 28, 188),
(47, '2021-10-15', 'CANDY BAR', 80, 29, 188),
(48, '2021-10-15', 'BOLETERIA', 80, 73, 188),
(49, '2021-10-15', 'BOLETERIA', 72, 89218, 136),
(50, '2021-10-15', 'BOLETERIA', 160, 75, 188),
(51, '2021-10-15', 'CAFE ITALIA', 8, 1, 188),
(52, '2021-10-15', 'CAFE ITALIA', 12.8, 2, 188),
(53, '2021-10-15', 'CAFE ITALIA', 4, 1617, 202),
(54, '2021-10-15', 'CAFE ITALIA', 6.4, 3, 188),
(55, '2021-10-15', 'CANDY BAR', 80, 30, 188),
(57, '2021-10-15', 'CANDY BAR', 72, 114871, 138),
(58, '2021-10-15', 'BOLETERIA', 80, 77, 188),
(59, '2021-10-15', 'BOLETERIA', 40, 78, 188),
(60, '2021-10-15', 'SABOR PERU', 56, 1, 188),
(61, '2021-10-15', 'BOLETERIA', 80, 79, 188),
(62, '2021-10-15', 'BOLETERIA', 80, 80, 188),
(63, '2021-10-15', 'BOLETERIA', 80, 81, 188),
(64, '2021-10-15', 'BOLETERIA', 40, 82, 188),
(65, '2021-10-15', 'BOLETERIA', 40, 83, 188),
(66, '2021-10-15', 'BOLETERIA', 80, 84, 188),
(67, '2021-10-15', 'BOLETERIA', 80, 88, 188),
(68, '2021-10-15', 'BOLETERIA', 40, 89, 188),
(69, '2021-10-15', 'BOLETERIA', 80, 90, 188),
(70, '2021-10-15', 'BOLETERIA', 40, 92, 188),
(71, '2021-10-15', 'BOLETERIA', 100, 93, 188),
(72, '2021-10-15', 'BOLETERIA', 50, 94, 188),
(73, '2021-10-15', 'BOLETERIA', 80, 95, 188),
(74, '2021-10-15', 'BOLETERIA', 40, 97, 188),
(75, '2021-10-15', 'SABOR PERU', 28, 3, 188),
(76, '2021-10-15', 'SABOR PERU', 80, 4, 188),
(77, '2021-10-15', 'SABOR PERU', 80, 5, 188),
(78, '2021-10-15', 'SABOR PERU', 28, 2511, 137),
(79, '2021-10-16', 'CAFE ITALIA', 8, 3, 188),
(80, '2021-10-16', 'CAFE ITALIA', 8, 4, 188),
(81, '2021-10-16', 'CAFE ITALIA', 9.6, 5, 188),
(82, '2021-10-16', 'SABOR PERU', 28, 9, 188),
(83, '2021-10-16', 'SABOR PERU', 60, 10, 188),
(84, '2021-10-16', 'SABOR PERU', 24, 11, 188),
(85, '2021-10-16', 'CANDY BAR', 40, 38, 188),
(86, '2021-10-16', 'CANDY BAR', 40, 39, 188),
(87, '2021-10-16', 'CANDY BAR', 40, 40, 188),
(88, '2021-10-16', 'BOLETERIA', 64, 80, 188),
(89, '2021-10-16', 'BOLETERIA', 64, 81, 188),
(90, '2021-10-16', 'BOLETERIA', 64, 89266, 186),
(91, '2021-10-16', 'BOLETERIA', 96, 89301, 101),
(92, '2021-10-16', 'BOLETERIA', 32, 89303, 81),
(93, '2021-10-16', 'BOLETERIA', 64, 89306, 49),
(94, '2021-10-16', 'CANDY BAR', 65.6, 114983, 120),
(95, '2021-10-16', 'CANDY BAR', 16, 115002, 81),
(97, '2021-10-16', 'BOLETERIA', 96, 89326, 201),
(98, '2021-10-16', 'BOLETERIA', 24, 89377, 81),
(99, '2021-10-16', 'CANDY BAR', 16, 115096, 81),
(100, '2021-10-16', 'SABOR PERU', 24, 2543, 163),
(101, '2021-10-16', 'BOLETERIA', 192, 89442, 175),
(102, '2021-10-16', 'CANDY BAR', 64, 115162, 175),
(103, '2021-10-16', 'BOLETERIA', 48, 89465, 118),
(104, '2021-10-16', 'CANDY BAR', 64.8, 115186, 118),
(105, '2021-10-16', 'CANDY BAR', 6.4, 115245, 199),
(106, '2021-10-16', 'BOLETERIA', 32, 89506, 203),
(107, '2021-10-16', 'BOLETERIA', 32, 89507, 179),
(108, '2021-10-16', 'CANDY BAR', 16, 115247, 203),
(109, '2021-10-16', 'CANDY BAR', 24, 115249, 179),
(110, '2021-10-17', 'CANDY BAR', 28, 115276, 22),
(111, '2021-10-17', 'CANDY BAR', 56, 115449, 48),
(112, '2021-10-17', 'CANDY BAR', 20, 115581, 52),
(113, '2021-10-17', 'CAFE ITALIA', 13.6, 1647, 29),
(114, '2021-10-18', 'CANDY BAR', 64, 115773, 172),
(115, '2021-10-18', 'CANDY BAR', 41.6, 115775, 67),
(116, '2021-10-18', 'BOLETERIA', 24, 89813, 33),
(117, '2021-10-18', 'SABOR PERU', 33.6, 2609, 70),
(118, '2021-10-18', 'SABOR PERU', 20, 2610, 188),
(119, '2021-10-18', 'CANDY BAR', 16, 115777, 188),
(120, '2021-10-18', 'BOLETERIA', 48, 89825, 99);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2021_10_11_152142_create_permisos_table', 1),
(6, '2021_10_11_152502_create_permiso_user_table', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permisos`
--

CREATE TABLE `permisos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `permisos`
--

INSERT INTO `permisos` (`id`, `nombre`, `created_at`, `updated_at`) VALUES
(1, 'Control de usuarios', NULL, NULL),
(2, 'Realizar recarga', NULL, NULL),
(3, 'Historial recarga', NULL, NULL),
(4, 'Historial gasto', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permiso_user`
--

CREATE TABLE `permiso_user` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `permiso_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `permiso_user`
--

INSERT INTO `permiso_user` (`id`, `user_id`, `permiso_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, NULL, NULL),
(2, 1, 2, NULL, NULL),
(3, 1, 3, NULL, NULL),
(4, 1, 4, NULL, NULL),
(5, 2, 2, NULL, NULL),
(6, 2, 3, NULL, NULL),
(7, 2, 4, NULL, NULL),
(12, 5, 1, NULL, NULL),
(13, 5, 2, NULL, NULL),
(14, 5, 4, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `created_at`, `updated_at`) VALUES
(2, 'App\\Models\\User', 1, 'auth_token', '9a81b40f2d92a26091b8b7be1469ad9f6424fe2914eee8baa9c46165cb3d3a57', '[\"*\"]', '2021-10-15 03:50:19', '2021-10-15 00:32:58', '2021-10-15 03:50:19'),
(3, 'App\\Models\\User', 1, 'auth_token', '212f16ab10288b998bf27b7f9b5125106b132d48a7949c09de9edb9c197e514b', '[\"*\"]', NULL, '2021-10-15 00:46:04', '2021-10-15 00:46:04'),
(6, 'App\\Models\\User', 1, 'auth_token', 'b5d906363b893d78ca259b47e29af213752c27e9a9b36a45266ba5cafb67676c', '[\"*\"]', '2021-10-15 01:25:27', '2021-10-15 01:25:18', '2021-10-15 01:25:27'),
(8, 'App\\Models\\User', 1, 'auth_token', '9c9b9488690b0af3e99a45f67119828f61fbd5ab6feb62aa3ed5d8436fb71784', '[\"*\"]', '2021-10-17 13:50:50', '2021-10-15 07:05:09', '2021-10-17 13:50:50'),
(9, 'App\\Models\\User', 1, 'auth_token', '8e5195ee030d303299fa8ffac59a61e225486bc4293ee7ca62489bf6e2095847', '[\"*\"]', '2021-10-15 18:18:18', '2021-10-15 18:14:08', '2021-10-15 18:18:18'),
(12, 'App\\Models\\User', 1, 'auth_token', 'bd328f78b4c679f16cec3bc99d9a5785d5909cbda5e36ed1e16f1c242dde3ebe', '[\"*\"]', '2021-10-16 19:38:44', '2021-10-16 19:13:53', '2021-10-16 19:38:44');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recarga`
--

CREATE TABLE `recarga` (
  `id` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `monto` double NOT NULL,
  `cliente_id` int(11) NOT NULL,
  `hora` time NOT NULL DEFAULT current_timestamp(),
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `recarga`
--

INSERT INTO `recarga` (`id`, `fecha`, `monto`, `cliente_id`, `hora`, `user_id`) VALUES
(1, '2021-10-15', 10, 188, '00:55:33', 1),
(2, '2021-10-15', 5, 188, '20:11:07', 1),
(3, '2021-10-15', 1, 188, '20:11:59', 1),
(4, '2021-10-15', 1000, 188, '20:14:49', 1),
(5, '2021-10-15', 1000, 188, '20:15:20', 1),
(6, '2021-10-15', -50, 188, '20:17:17', 1),
(7, '2021-10-15', -2290, 188, '20:18:30', 1),
(8, '2021-10-16', 300, 188, '18:58:13', 1),
(9, '2021-10-16', 100, 188, '19:37:52', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `carnet` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `fechalimite` date NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `name`, `carnet`, `email`, `email_verified_at`, `fechalimite`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'ADMINISTRADOR', '1010', 'admin@test.com', NULL, '9999-01-01', '$2y$10$77J59q2ynyMjW/vUNzYEOuko.VqDrMhlpwrkK7SbxtJTyxaAYSsSK', NULL, NULL, NULL),
(2, 'ADIMER PAUL CHAMBI AJATA', '7336199', 'adimer101@gmail.com', NULL, '9999-01-01', '$2y$10$nFPawsrduh4SuI2V2FG7i.6.VvRjK.u5VueAS1/HgnkaSZfoXz2K.', NULL, NULL, NULL),
(3, 'ALEJANDRO LOPEZ', '2020', 'aler@gmail.com', NULL, '9999-01-01', '$2y$10$5sYiF3HM2.RJsMxxC3wF2eIDBLcl38BTQ2rNSXL4i1wCAn.iQ1Cge', NULL, NULL, NULL),
(5, 'MARIA CALLE', '3030', 'maria@gmail.com', NULL, '2021-10-21', '$2y$10$Dn57c1g6eYj8JdaJDrrAMeZMJavGXLq6NxV8ij6hbpL0qDv0p7qYW', NULL, '2021-10-14 22:38:20', '2021-10-14 22:38:55');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indices de la tabla `historial`
--
ALTER TABLE `historial`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indices de la tabla `permisos`
--
ALTER TABLE `permisos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `permiso_user`
--
ALTER TABLE `permiso_user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `permiso_user_user_id_foreign` (`user_id`),
  ADD KEY `permiso_user_permiso_id_foreign` (`permiso_id`);

--
-- Indices de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indices de la tabla `recarga`
--
ALTER TABLE `recarga`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_carnet_unique` (`carnet`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=215;

--
-- AUTO_INCREMENT de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `historial`
--
ALTER TABLE `historial`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=121;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `permisos`
--
ALTER TABLE `permisos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `permiso_user`
--
ALTER TABLE `permiso_user`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `recarga`
--
ALTER TABLE `recarga`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `permiso_user`
--
ALTER TABLE `permiso_user`
  ADD CONSTRAINT `permiso_user_permiso_id_foreign` FOREIGN KEY (`permiso_id`) REFERENCES `permisos` (`id`),
  ADD CONSTRAINT `permiso_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

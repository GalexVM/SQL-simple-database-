create table hoteles (
id_hotel INT not null auto_increment,
 nombre_hotel varchar(100) not null,
 direccion varchar(100) not null,
 constraint pk_id_hotel primary key(id_hotel));

create table tipo_habitacion (
id_tipo_hab INT not null auto_increment,
 nombre_tipo varchar(15) not null,
 costo_hab decimal(5,2) not null,
 descripcion varchar(100),
 capacidad integer not null,
 constraint pk_tipo_hab primary key(id_tipo_hab));

create table huespedes (
id_huesped varchar(12) not null,
 nombre_huesped varchar(25) not null,
 apellido_huesped varchar(25) not null,
 telefono_huesped varchar(25) not null,
 email_huesped varchar(35) not null,
 tipo int not null,
 pais_origen varchar(25),
 constraint pk_id_huesped primary key(id_huesped));

create table agencias(
id_agencia INT not null auto_increment,
nombre_agencia varchar(25) not null,
telefono varchar(25) not null,
nombre_contacto varchar(25) not null,
apellido_contacto varchar(25) not null,
pctje_comision decimal(2,2) not null,
primary key(id_agencia)); 

create table reservas (
id_reserva INT not null auto_increment, 
nro_habitaciones integer not null, 
fecha_entrada date not null, 
fecha_salida date not null, 
id_agencia INT not null, 
constraint pk_id_reserva primary key(id_reserva),
 foreign key (id_agencia) references agencias(id_agencia)
);

create table habitaciones (
id_habitacion INT not null auto_increment, 
id_tipo_hab int not null, 
id_hotel INT not null, 
id_reserva_actual INT null, 
constraint pk_id_habitacion primary key(id_habitacion),
foreign key(id_tipo_hab) references tipo_habitacion(id_tipo_hab),
foreign key(id_reserva_actual) references reservas(id_reserva),
foreign key(id_hotel) references hoteles(id_hotel)
);

create table gerentes_generales (
dni varchar(8) not null , 
id_hotel int not null, 
nombre varchar(25) not null, 
apellido varchar(25) not null, 
telefono varchar(25) not null, 
email varchar(100) not null, 
constraint pk_gerentes_dni primary key(dni),
foreign key(id_hotel) references hoteles(id_hotel));

create table tipo_servicio (
id_tipo_servicio INT not null auto_increment, 
nombre_servicio varchar(25) not null, 
constraint pk_tipo_servicio primary key(id_tipo_servicio));

create table cargos_personal (
id_cargo INT not null auto_increment, 
nombre_cargo varchar(25) not null, constraint pk_cargo primary key(id_cargo));

create table personal(
id_personal varchar(8) not null,
nombre_personal varchar(25) not null,
apellido_personal varchar(25) not null,
id_cargo int not null,
telefono varchar(25) not null,
id_tipo_personal varchar(25) not null,
estudios varchar(25),
area varchar(25),
constraint pk_personal primary key(id_personal),
constraint fk_cargo_prsnal foreign key(id_cargo) references cargos_personal(id_cargo));

create table cargos_extra (
id_cargo INT not null auto_increment,
id_reserva INT not null, constraint pk_cargos primary key(id_cargo));

create table servicios (
id_servicio INT not null auto_increment,
id_tipo_servicio INT not null, 
costo decimal(5,2) not null,
horario varchar(20) not null,
detalles varchar(250),
costos_extra decimal(4,2),
id_subtipo varchar(15),
fecha date,
modo_entrega varchar(8),
constraint pk_servicio primary key(id_servicio),
constraint fk_tipo_servicio foreign key(id_tipo_servicio) references tipo_servicio(id_tipo_servicio));

create table solicitudes_srvcios (
id_solicitud INT not null auto_increment,
id_cargo INT not null,
id_servicio INT not null,
cantidad integer not null default 1,
constraint pk_solicitud primary key(id_solicitud),
constraint fk_cargo foreign key(id_cargo) references cargos_extra(id_cargo),
constraint fk_servicio_slctud foreign key(id_servicio) references servicios(id_servicio));

create table lista_prsnal_srvcio (
id_lista_personal INT not null auto_increment,
id_personal varchar(8) not null,
id_servicio INT not null,
constraint fk_personal foreign key(id_personal) references personal(id_personal),
constraint fk_servicio foreign key(id_servicio) references servicios(id_servicio),
constraint pk_lista_prsnal primary key(id_lista_personal));

create table reservas_vinculadas (
id_lista_reservas INT not null auto_increment,
id_habitacion INT not null,
id_reserva INT not null,
constraint fk_id_hab foreign key(id_habitacion) references habitaciones(id_habitacion),
constraint fk_id_reserva_v foreign key(id_reserva) references reservas(id_reserva),
constraint pk_lista_reservas primary key(id_lista_reservas));

create table reserva_huespedes (
id_reserva_huespedes INT not null auto_increment,
id_reserva INT not null,
id_huesped varchar(12) not null,
constraint pk_acompanantes primary key(id_reserva_huespedes),
constraint fk_id_acomp foreign key(id_huesped) references huespedes(id_huesped),
constraint fk_id_reserva_ac foreign key(id_reserva) references reservas(id_reserva));
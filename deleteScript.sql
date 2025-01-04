/*
id_reserva_actual de la(s) habitacion a NULL
borrar de reservas_vinculadas
borrar de solicitudes_servicio
borrar de cargos extra
borrar de reserva_huespedes
borrar reserva

*/

update habitaciones h
set habitaciones.id_reserva_actual = null
where habitaciones.id_reserva_actual = ?;

delete from reservas_vinculadas
where reservas_vinculadas.id_reserva = ?;

delete from solicitudes_srvcios
where  solicitudes_srvcios.id_cargo = (
	select ce.id_cargo
    from reservas r
    join cargos_extra ce on ce.id_reserva = r.id_reserva
    where r.id_reserva = ?
    );
    
delete from cargos_extra
where id_reserva = ?;

delete from reserva_huespedes
where id_reserva = ?;

delete from reservas
where id_reserva = ?

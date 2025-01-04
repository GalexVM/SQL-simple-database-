/*principal*/
select r.id_reserva as 'Reserva', concat(hs.nombre_huesped,' ', hs.apellido_huesped) as 'Nombre',
		r.fecha_entrada as 'Entrada', r.fecha_salida as 'Salida', sum(th.costo_hab + s.costo) as 'Total'
from reservas r
join habitaciones h on r.id_reserva = h.id_reserva_actual
join tipo_habitacion th on h.id_tipo_hab = th.id_tipo_hab

join reserva_huespedes rh on r.id_reserva = rh.id_reserva
join huespedes hs on rh.id_huesped = hs.id_huesped

join cargos_extra ce on r.id_reserva = ce.id_reserva
join solicitudes_srvcios ss on ce.id_cargo = ss.id_cargo
join servicios s on ss.id_servicio = s.id_servicio
where hs.tipo = 1
group by r.id_reserva
;
/*boton1*/
select concat(hs.nombre_huesped ,' ', hs.apellido_huesped) 'Nombre', hs.telefono_huesped 'Teléfono',
			hs.email_huesped 'Email', hs.pais_origen 'Pais'
from huespedes hs
where id_huesped = ?;
/*boton2*/
select concat(hs.nombre_huesped,' ', hs.apellido_huesped) as 'Nombre',
		hs.telefono_huesped as 'Telefono', hs.email_huesped as 'Email',
        hs.pais_origen as 'Pais'
from huespedes hs
left join reserva_huespedes rs on hs.id_huesped = rs.id_huesped
left join reservas r on rs.id_reserva = r.id_reserva
where hs.tipo = 0 and r.id_reserva = ?
group by  hs.id_huesped
;
/*boton3*/
select th.nombre_tipo 'Tipo', th.costo_hab 'Costo', th.capacidad 'Capacidad', th.descripcion 'Datos adicionales'
from habitaciones h
left join tipo_habitacion th on th.id_tipo_hab = h.id_tipo_hab
left join reservas r on r.id_reserva = h.id_reserva_actual
where r.id_reserva = ?
group by h.id_habitacion;
/*boton4*/
select th.nombre_tipo 'Tipo', th.costo_hab 'Costo'
from habitaciones h
left join tipo_habitacion th on th.id_tipo_hab = h.id_tipo_hab
left join reservas r on r.id_reserva = h.id_reserva_actual
where r.id_reserva = ?
group by h.id_habitacion;

select ts.nombre_servicio 'Tipo servicio', s.detalles 'Descripción', s.costo 'Costo', s.costos_extra 'Extra' 
from servicios s
join solicitudes_srvcios ss on s.id_servicio = ss.id_servicio
join cargos_extra ce on ss.id_cargo = ce.id_cargo
join reservas r on ce.id_reserva = r.id_reserva
join tipo_servicio ts on s.id_tipo_servicio = ts.id_tipo_servicio
where r.id_reserva = ?
group by s.id_servicio;

/*verificar admin*/


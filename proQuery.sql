select datos_reserva.Reserva, Nombre, Habitaciones, Entrada, Salida, suma_hab.s, suma_costos.s
        from (select r.id_reserva as 'Reserva', concat(hs.nombre_huesped,' ', hs.apellido_huesped) as 'Nombre',
        r.nro_habitaciones as 'Habitaciones', r.fecha_entrada as 'Entrada', r.fecha_salida as 'Salida'
        from huespedes hs
		join reserva_huespedes rs on rs.id_huesped = hs.id_huesped
		join reservas r on r.id_reserva = rs.id_reserva
		where hs.tipo = 1 ) as datos_reserva 
        join
        (select h.id_reserva_actual reserva, sum(th.costo_hab) s from huespedes hs 
		join reserva_huespedes rs on rs.id_huesped = hs.id_huesped
		join reservas r on r.id_reserva = rs.id_reserva
		join habitaciones h on r.id_reserva = h.id_reserva_actual
		left join tipo_habitacion th on h.id_tipo_hab = th.id_tipo_hab
		where hs.tipo = 1 group by h.id_reserva_actual) as suma_hab
        on datos_reserva.Reserva = suma_hab.reserva
        join
        (select r.id_reserva reserva, sum(s.costo) s from huespedes hs 
		join reserva_huespedes rs on rs.id_huesped = hs.id_huesped
		join reservas r on r.id_reserva = rs.id_reserva
		left join cargos_extra ce on r.id_reserva = ce.id_reserva
		left join solicitudes_srvcios ss on ce.id_cargo = ss.id_cargo
		left join servicios s on ss.id_servicio = s.id_servicio
		where hs.tipo = 1 group by r.id_reserva) as suma_costos
		on  suma_hab.reserva = suma_costos.reserva
order by Reserva
;
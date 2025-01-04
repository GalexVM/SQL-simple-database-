/*
huéspedes
	titular
    acomapañante
reservas
reserva-huespedes
mostrar habitaciones disponibles
reserva-vinculada

*/

insert into huespedes
values('x','','','','',1,'');

insert into huespedes
values('i','','','','',0,'');

insert into reservas(id_agencia, nro_habitaciones, fecha_entrada, fecha_salida)
values(1,2,'01/01/2001','');

insert into reserva_huespedes(id_huesped, id_reserva)
values('x', (select r.id_reserva
			from reservas r
			left join reserva_huespedes  rh on rh.id_reserva = r.id_reserva
			where rh.id_reserva_huespedes is null
			group by r.id_reserva
			) );

insert into reserva_huespedes(id_huesped, id_reserva)
values('i',(select r.id_reserva
			from reservas r
            left join reserva_huespedes rh on rh.id_reserva = r.id_reserva
            where rh.id_huesped = 'x' and r.fecha_entrada = '01/01/2001'
			));

select h.id_habitacion
from habitaciones h
left join tipo_habitacion th on h.id_tipo_hab = th.id_tipo_hab
where th.id_tipo_hab = 1 and h.id_reserva_actual is null
group by h.id_habitacion; /*esta decision tendra que ser a mano*/

insert into reservas_vinculadas(id_habitacion, id_reserva)
values(?,(select r.id_reserva
			from reservas r
            left join reserva_huespedes rh on rh.id_reserva = r.id_reserva
            where rh.id_huesped = 'x' and r.fecha_entrada = '01/01/2001'
			));




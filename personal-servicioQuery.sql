select p.id_personal 'DNI',  concat(p.nombre_personal, ' ', p.apellido_personal) 'Nombres y Apellidos',
		cp.nombre_cargo 'Tipo', p.telefono 'Teléfono'
from servicios s
join lista_prsnal_srvcio lps on s.id_servicio = lps.id_servicio
join personal p on lps.id_personal = p.id_personal
join tipo_servicio ts on s.id_tipo_servicio = ts.id_tipo_servicio
join cargos_personal cp on p.id_cargo = cp.id_cargo

where s.id_servicio = ?
group by p.id_personal
order by p.id_cargo;

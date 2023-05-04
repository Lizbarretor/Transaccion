
Create table venta(
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
idproducto INT NOT NULL,
NombreProducto VARCHAR(50),
Cantidad INT UNSIGNED,
FOREIGN KEY (idproducto)
REFERENCES productos (idProducto)
);


INSERT INTO venta VALUES (0,100,"Bandeja de carne de cerdo",3);
INSERT INTO venta VALUES (0,111,"Bandeja Chorizo",2);
INSERT INTO venta VALUES (0,101,"Manzana",1);

delimiter //
create procedure VentaProductos(
    in idProductoV int,
    in nombreProducto varchar (50),
    in cantidadVendida int
)
begin
	declare exit handler for 1690
    begin
		select 'no queda producto';
        rollback;
    end; 
    start transaction;
   	update inventario set cantidad = cantidad - cantidadVendida where idProducto = idProductoV;
    set nombreProducto = (Select productos.nombreProducto from productos where idProducto = idProductoV) ;
	insert into venta (id,  idProducto, NombreProducto, cantidad) 
	values (0,  idProductoV, nombreProducto, cantidadVendida);
    commit;
end 
//

call sumerca.VentaProductos(100, 'Bandeja de carne de cerdo', 4);
call sumerca.VentaProductos(101, 'manzana', 51);
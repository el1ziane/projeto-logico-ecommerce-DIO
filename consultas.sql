SELECT Fname, Address FROM client;

SELECT * FROM product 
WHERE category = 'Eletrônico';

SELECT * FROM client
ORDER BY Fname ASC;

SELECT o.idOrder, c.Fname, o.orderStatus, d.deliveryStatus, d.trackingCode
FROM orders o
INNER JOIN client c ON o.idOrderClient = c.idClient
INNER JOIN delivery d ON o.idOrder = d.idOrder;

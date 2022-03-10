SELECT
   ...>      Id
   ...>      , OrderDate
   ...>      , PrevOrderDate
   ...>      , ROUND(julianday(OrderDate) - julianday(PrevOrderDate), 2)
   ...> FROM (
   ...>      SELECT Id
   ...>           , OrderDate
   ...>           , LAG(OrderDate, 1, OrderDate) OVER (ORDER BY OrderDate ASC) AS PrevOrderDate
   ...>      FROM 'Order'
   ...>      WHERE CustomerId = 'BLONP'
   ...>      ORDER BY OrderDate ASC
   ...>      LIMIT 10
   ...> );
16766|2012-07-22 23:11:15|2012-07-22 23:11:15|0.0
10265|2012-07-25|2012-07-22 23:11:15|2.03
12594|2012-08-16 12:35:15|2012-07-25|22.52
20249|2012-08-16 16:52:23|2012-08-16 12:35:15|0.18
20882|2012-08-18 19:11:48|2012-08-16 16:52:23|2.1
18443|2012-08-28 05:34:03|2012-08-18 19:11:48|9.43
10297|2012-09-04|2012-08-28 05:34:03|6.77
11694|2012-09-17 00:27:14|2012-09-04|13.02
25613|2012-09-18 22:37:15|2012-09-17 00:27:14|1.92
17361|2012-09-19 12:13:21|2012-09-18 22:37:15|0.57
sqlite> WITH expenditures AS (
   ...>     SELECT
   ...>         IFNULL(c.CompanyName, 'MISSING_NAME') AS CompanyName,
   ...>         o.CustomerId,
   ...>         ROUND(SUM(od.Quantity * od.UnitPrice), 2) AS TotalCost
   ...>     FROM 'Order' AS o
   ...>     INNER JOIN OrderDetail od on od.OrderId = o.Id
   ...>     LEFT JOIN Customer c on c.Id = o.CustomerId
   ...>     GROUP BY o.CustomerId
   ...> ),
   ...> quartiles AS (
   ...>     SELECT *, NTILE(4) OVER (ORDER BY TotalCost ASC) AS ExpenditureQuartile
   ...>     FROM expenditures
   ...> )
   ...> SELECT CompanyName, CustomerId, TotalCost
   ...> FROM quartiles
   ...> WHERE ExpenditureQuartile = 1
   ...> ORDER BY TotalCost ASC;
MISSING_NAME|DUMO|1615.9
MISSING_NAME|OCEA|3460.2
MISSING_NAME|ANTO|7515.35
MISSING_NAME|QUEE|30226.1
Trail's Head Gourmet Provisioners|TRAIH|3874502.02
Blondesddsl père et fils|BLONP|3879728.69
Around the Horn|AROUT|4395636.28
Hungry Owl All-Night Grocers|HUNGO|4431457.1
Bon app|BONAP|4485708.49
Bólido Comidas preparadas|BOLID|4520121.88
Galería del gastrónomo|GALED|4533089.9
FISSA Fabrica Inter. Salchichas S.A.|FISSA|4554591.02
Maison Dewey|MAISD|4555931.37
Cactus Comidas para llevar|CACTU|4559046.87
Spécialités du monde|SPECD|4571764.89
Magazzini Alimentari Riuniti|MAGAA|4572382.35
Toms Spezialitäten|TOMSP|4628403.36
Split Rail Beer & Ale|SPLIR|4641383.53
Santé Gourmet|SANTG|4647668.15
Morgenstern Gesundkost|MORGK|4676234.2
White Clover Markets|WHITC|4681531.74
La corne d'abondance|LACOR|4724494.22
Victuailles en stock|VICTE|4726476.33
Lonesome Pine Restaurant|LONEP|4735780.66
SELECT DISTINCT ShipName, substr(ShipName, 0, instr(ShipName, '-')) as PreHyphen
   ...> FROM 'Order'
   ...> WHERE ShipName LIKE '%-%'
   ...> ORDER BY ShipName ASC;
Bottom-Dollar Markets|Bottom
Chop-suey Chinese|Chop
GROSELLA-Restaurante|GROSELLA
HILARION-Abastos|HILARION
Hungry Owl All-Night Grocers|Hungry Owl All
LILA-Supermercado|LILA
LINO-Delicateses|LINO
QUICK-Stop|QUICK
Save-a-lot Markets|Save
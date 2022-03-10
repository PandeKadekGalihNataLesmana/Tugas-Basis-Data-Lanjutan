with p as (
   ...> select Product.Id, Product.ProductName as name
   ...> from Product
   ...>         inner join OrderDetail on Product.id = OrderDetail.ProductId
   ...>         inner join 'Order' on 'Order'.Id = OrderDetail.OrderId
   ...>         inner join Customer on CustomerId = Customer.Id
   ...> where DATE(OrderDate) = '2014-12-25' and CompanyName = 'Queen Cozinha'
   ...> group by Product.id
   ...> ),
   ...> c as (
   ...>         select row_number() over (order by p.id asc) as seqnum, p.name as name
   ...>         from p
   ...> ),
   ...> flattened as (
   ...>         select seqnum, name as name
   ...>         from c
   ...>         where seqnum = 1
   ...>         union all
   ...>         select c.seqnum, f.name || ', ' || c.name
   ...>         from c join
   ...>                 flattened f
   ...>                 on c.seqnum = f.seqnum + 1
   ...> )
   ...> select name from flattened
   ...> order by seqnum desc limit 1;
Mishi Kobe Niku, NuNuCa Nuß-Nougat-Creme, Schoggi Schokolade, Mascarpone Fabioli, Sasquatch Ale, Boston Crab Meat, Manjimup Dried Apples, Longlife Tofu, Lakkalikööri
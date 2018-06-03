select *
from   (values (1, 2, 3)
              ,(1, 2, 3)
              ,(1, 4, 3)
              ,(1, 4, 3)
              ,(2, 4, 3)
              ,(2, 4, 3)) as t(a,b,c)
order  by ROW_NUMBER() over (partition by a,b order by c)
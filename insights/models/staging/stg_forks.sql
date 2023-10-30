
select * 
from {{ source('raw', 'activities') }} a
where a.type = 'fork'
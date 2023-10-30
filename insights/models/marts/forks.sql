{{config(
    materialized = 'materialized_view',
    on_configuration_change = 'apply',
    indexes=[{'columns': ['id'],'unique': True},{'columns': ['channel'],'unique': False}]

)}}

select * from {{ ref('stg_forks') }} a 
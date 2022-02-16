view: der_supplier {
   derived_table: {
    sql: SELECT
        s_suppkey as supplier_id
        ,s_name as supplier_name
        ,sum(l_totalprice)/ (select sum(l_totalprice) from f_lineitems where l_orderstatus = 'F') * 100 revenue_percentage
      FROM f_lineitems
      JOIN d_supplier on s_suppkey = l_suppkey
      where l_orderstatus = 'F'
      GROUP BY s_suppkey, s_name
      ORDER BY s_name;;
  }

  # Define your dimensions and measures here, like this:
  dimension: s_suppkey {
    hidden: yes
    label: "Key"
    primary_key: yes
    type: number
    sql: ${TABLE}.s_suppkey ;;
  }

  dimension: s_name {
    label: "Name"
    type: string
    sql: ${TABLE}.s_name ;;
  }

  dimension: revenue_percentage {
    label: "Revenue percent"
    type: number
    sql: ${TABLE}.revenue_percentage ;;
    value_format_name: "percent_2"
  }

}

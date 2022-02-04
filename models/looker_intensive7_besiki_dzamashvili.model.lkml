connection: "tpchlooker"

# include all the views
include: "/views/**/*.view"

datagroup: looker7_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: looker7_default_datagroup

# explore: d_customer {}

# explore: d_dates {}

# explore: d_part {}

# explore: d_supplier {}

explore: f_lineitems {
  join: d_customer {
    type: left_outer
    sql_on: ${f_lineitems.l_custkey} = ${d_customer.c_custkey} ;;
    relationship: many_to_one
  }

  join: d_dates {
    type: left_outer
    sql_on: ${f_lineitems.l_orderdatekey} = ${d_dates.datekey} ;;
    relationship: many_to_one
  }

  join: d_part {
    type: left_outer
    sql_on: ${f_lineitems.l_partkey} = ${d_part.p_partkey} ;;
    relationship: many_to_one
  }

  join: d_supplier {
    type: left_outer
    sql_on: ${f_lineitems.l_suppkey} = ${d_supplier.s_suppkey} ;;
    relationship: many_to_one
  }
}

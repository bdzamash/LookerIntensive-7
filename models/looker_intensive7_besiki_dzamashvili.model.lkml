connection: "tpchlooker"

# include all the views
include: "/views/**/*.view"

datagroup: looker7_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: looker7_default_datagroup

explore: d_customer {
  view_label: "Customers"
  group_label: "Dimensions"
}

explore: d_dates {
  view_label: "Dates"
  group_label: "Dimensions"
}

explore: d_part {
  view_label: "Parts"
  group_label: "Dimensions"
}

explore: d_supplier {
  view_label: "Suppliers"
  group_label: "Dimensions"
}

explore: f_lineitems {
  view_label: "Order Items"
  group_label: "Fact"
  join: d_customer {
    view_label: "Customers"
    type: left_outer
    relationship: many_to_one
    sql_on: ${d_customer.c_custkey} = ${f_lineitems.l_custkey} ;;
  }

  join: d_dates {
    view_label: "Dates"
    type: left_outer
    sql_on: ${f_lineitems.l_orderdatekey} = ${d_dates.datekey} ;;
    relationship: many_to_one
  }

  join: d_part {
    view_label: "Parts"
    type: left_outer
    sql_on: ${f_lineitems.l_partkey} = ${d_part.p_partkey} ;;
    relationship: many_to_one
  }

  join: d_supplier {
    view_label: "Suppliers"
    type: left_outer
    sql_on: ${f_lineitems.l_suppkey} = ${d_supplier.s_suppkey} ;;
    relationship: many_to_one
  }

  join: der_supplier {
    view_label: "Derived Suppliers"
    type: left_outer
    sql_on: ${d_supplier.s_suppkey} = ${der_supplier.s_suppkey} ;;
    relationship: many_to_one
  }
}

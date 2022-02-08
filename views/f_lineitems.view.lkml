view: f_lineitems {
  sql_table_name: "DATA_MART"."F_LINEITEMS"
    ;;

  dimension: l_availqty {
    label: "available quantity"
    type: number
    sql: ${TABLE}."L_AVAILQTY" ;;
  }

  dimension: l_clerk {
    label: "clerk"
    type: string
    sql: ${TABLE}."L_CLERK" ;;
  }

  dimension: l_commitdatekey {
    hidden: yes
    type: number
    sql: ${TABLE}."L_COMMITDATEKEY" ;;
  }

  dimension: l_custkey {
    hidden: yes
    type: number
    sql: ${TABLE}."L_CUSTKEY" ;;
  }

  dimension: l_discount {
    label: "discount"
    type: number
    sql: ${TABLE}."L_DISCOUNT" ;;
  }

  dimension: l_extendedprice {
    label: "extended price"
    type: number
    sql: ${TABLE}."L_EXTENDEDPRICE" ;;
  }

  dimension: l_linenumber {
    label: "line number"
    type: number
    sql: ${TABLE}."L_LINENUMBER" ;;
  }

  dimension: l_orderdatekey {
    hidden: yes
    type: number
    sql: ${TABLE}."L_ORDERDATEKEY" ;;
  }

  dimension: l_orderkey {
    hidden: yes
    type: number
    primary_key: yes
    sql: ${TABLE}."L_ORDERKEY" ;;
  }

  dimension: l_orderpriority {
    label: "priority"
    type: string
    sql: ${TABLE}."L_ORDERPRIORITY" ;;
  }

  dimension: l_orderstatus {
    label: "status"
    type: string
    sql: ${TABLE}."L_ORDERSTATUS" ;;
  }

  dimension: l_partkey {
    hidden: yes
    type: number
    sql: ${TABLE}."L_PARTKEY" ;;
  }

  dimension: l_quantity {
    label: "quantity"
    type: number
    sql: ${TABLE}."L_QUANTITY" ;;
  }

  dimension: l_receiptdatekey {
    hidden: yes
    type: number
    sql: ${TABLE}."L_RECEIPTDATEKEY" ;;
  }

  dimension: l_returnflag {
    label: "return flag"
    type: string
    sql: ${TABLE}."L_RETURNFLAG" ;;
  }

  dimension: l_shipdatekey {
    hidden: yes
    type: number
    sql: ${TABLE}."L_SHIPDATEKEY" ;;
  }

  dimension: l_shipinstruct {
    label: "ship instruction"
    type: string
    sql: ${TABLE}."L_SHIPINSTRUCT" ;;
  }

  dimension: l_shipmode {
  label: "ship mode"
    type: string
    sql: ${TABLE}."L_SHIPMODE" ;;
  }

  dimension: l_shippriority {
    label: "ship priority"
    type: number
    sql: ${TABLE}."L_SHIPPRIORITY" ;;
  }

  dimension: l_suppkey {
    hidden: yes
    type: number
    sql: ${TABLE}."L_SUPPKEY" ;;
  }

  dimension: l_supplycost {
    label: "supply cost"
    type: number
    sql: ${TABLE}."L_SUPPLYCOST" ;;
  }

  dimension: l_tax {
    label: "tax"
    type: number
    sql: ${TABLE}."L_TAX" ;;
  }

  dimension: l_totalprice {
    label: "total price"
    hidden: yes
    type: number
    sql: ${TABLE}."L_TOTALPRICE" ;;
  }

  dimension: Is_Russia {
    type: yesno
    sql: d_customer.c_nation : "RUSSIA";;
    group_label: "Dimension filters"
  }

  dimension: Is_Returned {
    type: yesno
    sql: ${l_returnflag} : 'R' ;;
    group_label: "Dimension filters"
  }

  dimension: Is_Completed {
    type: yesno
    sql: ${l_orderstatus} : 'F' ;;
    group_label: "Dimension filters"
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: Total_Sale_Price {
    description: "Total sales from items sold"
    type: sum
    sql: ${l_totalprice} ;;
    value_format_name: usd
  }

  measure: Average_Sale_Price {
    description: "Average sale price of items sold"
    type: average
    sql: ${l_totalprice} ;;
    value_format_name: usd
  }

  measure: Cumulative_Total_Sales {
    description: "Cumulative total sales from items sold (also known as a running total)"
    type: running_total
    sql: ${Total_Sale_Price} ;;
    value_format_name: usd
  }

  measure: Total_Russia_Sales {
    description: "Total sales by customers from Russia"
    type: sum
    sql: ${l_totalprice} ;;
    filters: [Is_Russia: "yes"]
    value_format_name: usd
  }

  measure: Total_Gross_Revenue {
    description: "Total price of completed sales"
    type: sum
    sql: ${l_totalprice} ;;
    filters: [Is_Completed: "yes"]
    value_format_name: usd
  }

  measure: Total_Cost {
    description: "Total cost of items sold from inventory"
    type: sum
    sql: ${l_supplycost} ;;
    value_format_name: usd
  }

  measure: Total_Gross_Margin_Amount {
    description: "Total Gross Revenue – Total Cost"
    type: number
    sql: ${Total_Gross_Revenue} - ${Total_Cost} ;;
    value_format_name: usd
  }

  measure: Goss_Margin_Percentage {
    description: "Total Gross Margin Amount / Total Gross Revenue"
    type: number
    sql: ${Total_Gross_Margin_Amount} / NULLIF(${Total_Gross_Revenue},0) ;;
    value_format: "0.00\%"
  }

  measure: Number_of_Items_Returned {
    description: "Number of items that were returned by dissatisfied customers"
    type: sum
    sql: ${l_quantity} ;;
    filters: [Is_Returned: "yes"]
  }

  measure: Total_Number_of_Items_Sold {
    type: sum
    sql: ${l_quantity} ;;
  }

  measure: Item_Return_Rate {
    description: "Number Of Items Returned / Total Number Of Items Sold"
    type: number
    sql: ${Number_of_Items_Returned} / NULLIF(${Total_Number_of_Items_Sold},0) ;;
    value_format: "0.00\%"
  }

  # measure: Total_Number_of_Customers {
  #   description: "Total number of customers"
  #   type: count_distinct
  #   sql:  ${l_custkey};;
  # }

  measure: Average_Spend_Per_Customer {
    description: "Total Sale Price / Total Number of Customers"
    type: average_distinct
    sql_distinct_key: ${l_custkey}
    sql: ${l_totalprice};;
    value_format: "$0.00"
  }
}

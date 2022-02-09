view: d_customer {
  sql_table_name: "DATA_MART"."D_CUSTOMER"
    ;;

  dimension: c_address {
    type: string
    sql: ${TABLE}."C_ADDRESS" ;;
  }

  dimension: c_custkey {
    hidden: yes
    type: number
    primary_key: yes
    sql: ${TABLE}."C_CUSTKEY" ;;
  }

  dimension: c_mktsegment {
    type: number
    sql: ${TABLE}."C_MKTSEGMENT" ;;
  }

  dimension: c_name {
    type: string
    sql: ${TABLE}."C_NAME" ;;
  }

  dimension: c_nation {
    type: string
    sql: ${TABLE}."C_NATION" ;;
  }

  dimension: c_phone {
    type: string
    sql: ${TABLE}."C_PHONE" ;;
  }

  dimension: c_region {
    type: string
    sql: ${TABLE}."C_REGION" ;;
  }

  dimension: Is_Russia {
    type: yesno
    sql: ${c_nation} = "RUSSIA";;
    group_label: "Dimension filters"
  }

  measure: count {
    type: count
    drill_fields: [c_name]
  }

  measure: Total_Russia_Sales {
    description: "Total sales by customers from Russia"
    type: sum
    sql: ${f_lineitems.l_totalprice} ;;
    filters: [Is_Russia: "yes"]
    value_format_name: usd
  }
}

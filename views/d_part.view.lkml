view: d_part {
  sql_table_name: "DATA_MART"."D_PART"
    ;;

  dimension: p_brand {
    label: "brand"
    type: string
    sql: ${TABLE}."P_BRAND" ;;
  }

  dimension: p_mfgr {
    label: "mfgr"
    type: string
    sql: ${TABLE}."P_MFGR" ;;
  }

  dimension: p_name {
    label: "name"
    type: string
    sql: ${TABLE}."P_NAME" ;;
  }

  dimension: p_partkey {
    hidden: yes
    type: number
    primary_key: yes
    sql: ${TABLE}."P_PARTKEY" ;;
  }

  dimension: p_size {
    label: "size"
    type: number
    sql: ${TABLE}."P_SIZE" ;;
  }

  dimension: p_type {
    label: "type"
    type: string
    sql: ${TABLE}."P_TYPE" ;;
  }

  measure: count {
    type: count
    drill_fields: [p_name]
  }
}

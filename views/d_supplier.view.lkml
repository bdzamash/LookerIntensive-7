view: d_supplier {
  sql_table_name: "DATA_MART"."D_SUPPLIER"
    ;;

  dimension: s_acctbal {
    type: number
    sql: ${TABLE}."S_ACCTBAL" ;;
  }

  dimension: s_address {
    type: string
    sql: ${TABLE}."S_ADDRESS" ;;
  }

  dimension: s_name {
    type: string
    sql: ${TABLE}."S_NAME" ;;
  }

  dimension: s_nation {
    type: string
    sql: ${TABLE}."S_NATION" ;;
  }

  dimension: s_phone {
    type: string
    sql: ${TABLE}."S_PHONE" ;;
  }

  dimension: s_region {
    type: string
    sql: ${TABLE}."S_REGION" ;;
  }

  dimension: s_suppkey {
    hidden: yes
    type: number
    primary_key: yes
    sql: ${TABLE}."S_SUPPKEY" ;;
  }

  dimension: Cohort_of_suppliers_according_to_Account_Balance {
    description: "Cohort of suppliers according to Account Balance:
      • <= 0
      • 1—300
      • 3001—5000
      • 5001—7000
      • 7000 <
      "
    type: tier
    tiers: [0, 1, 300, 3000, 5000, 7000]
    style: integer
    sql: ${s_acctbal} ;;
  }

  measure: count {
    type: count
    drill_fields: [s_name]
  }
}

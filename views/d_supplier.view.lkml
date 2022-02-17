view: d_supplier {
  sql_table_name: "DATA_MART"."D_SUPPLIER"
    ;;

  dimension: s_acctbal {
    label: "account balance"
    type: number
    sql: ${TABLE}."S_ACCTBAL" ;;
  }

  dimension: s_address {
    label: "address"
    type: string
    sql: ${TABLE}."S_ADDRESS" ;;
  }

  dimension: s_name {
    label: "name"
    type: string
    sql: ${TABLE}."S_NAME" ;;
    link: {
      label: "Supplier's website"
      url: "http://www.google.com/search?q={{ value | url_encode }}"
      icon_url: "http://google.com/favicon.ico"
    }
  }

  dimension: s_nation {
    label: "nation"
    type: string
    sql: ${TABLE}."S_NATION" ;;
  }

  dimension: s_phone {
    label: "phone"
    type: string
    sql: ${TABLE}."S_PHONE" ;;
  }

  dimension: s_region {
    label: "region"
    type: string
    sql: ${TABLE}."S_REGION" ;;
  }

  dimension: s_suppkey {
    hidden: yes
    type: number
    primary_key: yes
    sql: ${TABLE}."S_SUPPKEY" ;;
  }

  dimension: Suppliers_Account_Balance_Cohort {
    description: "Cohort of suppliers according to Account Balance:
      • <= 0
      • 1—300
      • 3001—5000
      • 5001—7000
      • 7000 <
      "
    type: tier
    tiers: [1,301, 3001, 5001, 7001]
    style: integer
    sql: ${s_acctbal} ;;
  }

  measure: count {
    type: count
    drill_fields: [s_name]
  }
}

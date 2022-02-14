view: d_dates {
  sql_table_name: "DATA_MART"."D_DATES"
    ;;

  dimension_group: date_val {
    label: "Dates"
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}."DATE_VAL" ;;
  }

  dimension: datekey {
    hidden: yes
    type: number
    primary_key: yes
    sql: ${TABLE}."DATEKEY" ;;
  }

  dimension: day_of_week {
    type: number
    sql: ${TABLE}."DAY_OF_WEEK" ;;
  }

  dimension: dayname_of_week {
    type: string
    sql: ${TABLE}."DAYNAME_OF_WEEK" ;;
  }

  dimension: month_name {
    type: string
    sql: ${TABLE}."MONTH_NAME" ;;
  }

  dimension: month_num {
    type: number
    sql: ${TABLE}."MONTH_NUM" ;;
  }

  dimension: quarter {
    type: number
    sql: ${TABLE}."QUARTER" ;;
  }

  dimension: year {
    type: number
    sql: ${TABLE}."YEAR" ;;
  }

  dimension: month_year {
    type: string
    sql: CONCAT(${month_name}, ' ', ${year}) ;;
  }

  dimension: is_before_mtd {
    type: yesno
    sql:
    DAY(${date_val_raw}) < DAY(CURRENT_TIMESTAMP())
      OR
      DAY(${date_val_raw}) = DAY(CURRENT_TIMESTAMP()) AND
      HOUR(${date_val_raw}) < HOUR(CURRENT_TIMESTAMP())
      OR
      DAY(${date_val_raw}) = DAY(CURRENT_TIMESTAMP()) AND
      HOUR(${date_val_raw}) <= HOUR(CURRENT_TIMESTAMP()) AND
      MINUTE(${date_val_raw}) < MINUTE(CURRENT_TIMESTAMP())  ;;
    }

  measure: count {
    type: count
    drill_fields: [month_name]
  }
}

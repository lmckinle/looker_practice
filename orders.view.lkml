view: orders {
  sql_table_name: demo_db.orders ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  dimension: order_income {
    type: number
    value_format_name: usd
    sql: (SELECT SUM(order_items.sale_price)
      FROM order_items
      WHERE order_items.order_id = orders.id)
       ;;
  }

  dimension: order_cost{
    type: number
    value_format_name: usd
    sql: (SELECT SUM(inventory_items.cost)
      FROM order_items
      LEFT JOIN inventory_items ON order_items.inventory_item_id = inventory_items.id
      WHERE order_items.order_id = orders.id) ;;
  }

  dimension: order_profit {
    type:  number
    value_format_name: usd
    sql: ${order_income} - ${order_cost};;
  }

  dimension: order_sequence {
    type: number
    sql: (SELECT COUNT(*)
          FROM orders o
          WHERE o.id < ${TABLE}.id
          AND o.user_id = ${TABLE}.user_id) + 1 ;;
  }

  dimension: is_first_order {
    type: yesno
    sql: ${order_sequence} = 1 ;;
  }


  ## MEASURES ##

  measure: count {
    type: count
    drill_fields: [id, users.first_name, users.last_name, users.id, order_items.count]
  }

  measure: total_order_profit {
    type: sum
    value_format_name: usd
    sql: ${order_profit};;
  }

  measure: average_order_profit {
    type: average
    value_format_name: usd
    sql: ${order_profit} ;;
  }
}

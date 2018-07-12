view: orders {
  sql_table_name: demo_db.orders ;;

  dimension: id {
    hidden:  yes
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

  dimension: amount_of_order {
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
    value_format_name: decimal_2
    sql: ${amount_of_order} - ${order_cost};;
  }

  measure: count {
    type: count
    drill_fields: [id, users.first_name, users.last_name, users.id, order_items.count]
  }

  measure: total_order_profit {
    type: sum
    sql: ${TABLE}.order_profit ;;
  }

  measure: average_order_profit {
    type: average
    sql: ${TABLE}.order_profit ;;
  }
}

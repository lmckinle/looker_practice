view: order_items {
  sql_table_name: demo_db.order_items ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: returned {
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
    sql: ${TABLE}.returned_at ;;
  }

  dimension: is_expensive {
    description: "Returns 'Yes' if product has a sale price above $25"
    type: yesno
    sql:  ${sale_price} > 25 ;;
  }

  dimension: sale_price {
    type: number
    value_format_name: usd
    sql: ${TABLE}.sale_price ;;
  }

  dimension: line_item_profit {
    type:  number
    value_format_name: usd
    sql:  ${sale_price} - ${inventory_items.cost};;
  }

  measure: count {
    type: count
    drill_fields: [id, inventory_items.id, orders.id]
  }

  measure: total_item_profit {
    description: "The profit summed across all line items within an order"
    type: sum
    value_format_name: usd
    sql:  ${line_item_profit} ;;
  }

  measure: average_item_profit {
    description: "The profit averaged across all line items within an order"
    type: average
    value_format_name: usd
    sql:  ${line_item_profit} ;;
  }

  measure: total_sale_price {
    type: sum
    value_format_name: usd
    sql: ${sale_price} ;;
  }

  measure: total_orders {
    type:  count_distinct
    sql:  ${order_id} ;;
  }
}

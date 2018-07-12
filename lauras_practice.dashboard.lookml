- dashboard: lauras_practice
#----------------------------------
  title: Lauras Practice
  layout: tile
  tile_size: 100
#----------------------------------
  filters:

#----------------------------------
  elements:

  - title: Total Orders
    name: Total Orders
    model: lauras_project
    explore: order_items
    type: single_value
    fields:
    - orders.count
    filters:
      orders.created_date: 90 days
    sorts:
    - orders.count desc
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    row: 0
    col: 0
    width: 8
    height: 6

  - title: Average Order Profit
    name: Average Order Profit
    model: lauras_project
    explore: order_items
    type: single_value
    fields:
    - orders.average_order_profit
    filters:
      orders.created_date: 90 days
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    series_types: {}
    row: 0
    col: 8
    width: 8
    height: 6

  - title: First Time Purchasers
    name: First Time Purchasers
    model: lauras_project
    explore: orders
    type: single_value
    fields:
    - orders.count
    filters:
      orders.is_first_order: 'Yes'
      orders.created_date: 90 days
    sorts:
    - orders.count desc
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    row: 0
    col: 16
    width: 8
    height: 6

- dashboard: lauras_practice
#----------------------------------
  title: "Laura's Practice Dashboard"
  layout: tile
  tile_size: 100
#----------------------------------
  filters:
  - name: date
    title: "Date"
    type: date_filter
    default_value: Last 90 Days

  - name: state
    title: 'State / Region'
    type: field_filter
    explore: users
    field: users.state

#----------------------------------
  elements:

  - title: "Total Orders"
    name: Total Orders
    model: lauras_project
    explore: order_items
    type: single_value
    fields:
    - orders.count
    sorts:
    - orders.count desc
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    row: 0
    col: 0
    width: 8
    height: 6

  - title: "Average Order Profit"
    name: Average Order Profit
    model: lauras_project
    explore: order_items
    type: single_value
    fields:
    - orders.average_order_profit
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

  - title: "First Time Purchasers"
    name: First Time Purchasers
    model: lauras_project
    explore: orders
    type: single_value
    fields:
    - orders.count
    filters:
      orders.is_first_order: 'Yes'
    sorts:
    - orders.count desc
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    row: 0
    col: 16
    width: 8
    height: 6

- dashboard: lauras_practice
#----------------------------------
  title: "Laura's Practice Dashboard"
  layout: newspaper
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
    listen:
      date: orders.created_date
      state: users.state
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
    listen:
      date: orders.created_date
      state: users.state
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
    listen:
      date: orders.created_date
      state: users.state
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

  - title: "Orders by Day and Category"
    name: Orders by Day and Category
    model: lauras_project
    explore: order_items
    type: looker_area
    fields: [orders.created_date, products.category, products.count]
    pivots: [products.category]
    fill_fields: [orders.created_date]
    filters:
      products.category: Blazers & Jackets,Sweaters,Pants,Shorts,Fashion Hoodies & Sweatshirts,Accessories
    listen:
      date: orders.created_date
      state: users.state
    sorts: [orders.created_date desc, products.category]
    query_timezone: America/Los_Angeles
    stacking: normal
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: none
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_ticks: true
    x_axis_scale: time
    y_axis_scale_mode: linear
    show_null_points: true
    interpolation: linear
    totals_color: "#808080"
    value_labels: legend
    label_type: labPer
    show_row_numbers: true
    table_theme: editable
    series_types: {}
    hidden_series: []
    colors: ['palette: Looker Classic']
    series_colors: {}
    x_axis_label: '"#"'
    hide_legend: true
    y_axes: [{label: "#", orientation: left, series: [{id: Accessories - products.count,
            name: Accessories, axisId: products.count}, {id: Blazers & Jackets - products.count,
            name: Blazers &amp; Jackets, axisId: products.count}, {id: Fashion Hoodies
              & Sweatshirts - products.count, name: Fashion Hoodies &amp; Sweatshirts,
            axisId: products.count}, {id: Pants - products.count, name: Pants, axisId: products.count},
          {id: Shorts - products.count, name: Shorts, axisId: products.count}, {id: Sweaters
              - products.count, name: Sweaters, axisId: products.count}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 0,
        type: linear}]
    x_axis_datetime_label: "%B"
    x_axis_datetime_tick_count: 3
    trend_lines: []
    reference_lines: []

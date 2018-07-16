- dashboard: lauras_practice
#----------------------------------
  title: "Laura's Practice Dashboard"
  layout: grid
  rows:
    - elements: [Total_Orders, Avg_Order_Profit, First_Time_Purchasers]
      height: 220
    - elements: [Orders_by_Day_and_Category, Sales_by_Date]
      height: 400
    - elements: [Top_Zips]
      height: 400
    #- elements: [sales_by_date_and_category, top_10_brands]
      #height: 400
    #- elements: [layer_cake_cohort]
      #height: 400
    #- elements: [customer_cohort]
      #height: 400
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

  - name: Total_Orders
    title: "Total Orders"
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

  - name: Avg_Order_Profit
    title: "Average Order Profit"
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

  - name: First_Time_Purchasers
    title: "First Time Purchasers"
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

  - name: Orders_by_Day_and_Category
    title: "Orders by Day and Category"
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
    x_axis_label: ''
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

  - name: Sales_by_Date
    title: "Sales $ by Date"
    model: lauras_project
    explore: order_items
    type: looker_column
    fields: [orders.created_date, order_items.total_sale_price]
    fill_fields: [orders.created_date]
    listen:
      date: orders.created_date
      state: users.state
    sorts: [orders.created_date desc]
    query_timezone: America/Los_Angeles
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    totals_color: "#808080"
    show_null_points: true
    interpolation: linear
    series_types: {}
    colors: ['palette: Looker Classic']
    series_colors: {}
    x_axis_datetime_label: "%B %d"
    x_axis_datetime_tick_count: 8
    y_axes: [{label: Total Sales $, orientation: left, series: [{id: order_items.total_sale_price,
            name: Order Items Total Sale Price, axisId: order_items.total_sale_price}],
        showLabels: true, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    reference_lines: [{reference_type: range, line_value: mean, range_start: max, range_end: mean,
        margin_top: deviation, margin_value: mean, margin_bottom: deviation, label_position: right,
        color: "#e37612", label: Above Average Sales}, {reference_type: line, line_value: median,
        range_start: max, range_end: min, margin_top: deviation, margin_value: mean,
        margin_bottom: deviation, label_position: right, color: "#e37612", label: Median}]

  - name: Top_Zips
    title: "Top Zip Codes by Items Ordered"
    model: lauras_project
    explore: order_items
    type: looker_geo_coordinates
    fields: [order_items.count, users.zip]
    listen:
      date: orders.created_date
      state: users.state
    sorts: [order_items.count desc]
    query_timezone: America/Los_Angeles
    map: usa
    map_plot_mode: points
    heatmap_opacity: 0.5
    map_pannable: true
    map_zoomable: true
    series_types: {}
    point_color: "#651F81"
    point_radius: 3

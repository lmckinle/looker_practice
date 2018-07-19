- dashboard: lauras_practice
#----------------------------------
  title: "Laura's Practice Dashboard"
  layout: grid
  rows:
    - elements: [Total_Orders, Avg_Order_Profit, First_Time_Purchasers]
      height: 220
    - elements: [Orders_by_Day_and_Category, Sales_by_Date]
      height: 400
    - elements: [Top_Zips, Top_States]
      height: 400
    - elements: [Top_15_Brands]
      height: 400
    - elements: [user_signup_cohort_orders]
      height: 400
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
    label_density: 25
    legend_position: center
    y_axis_gridlines: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_ticks: true
    x_axis_scale: time
    y_axis_scale_mode: linear
    show_null_points: true
    colors: ['palette: Looker Classic']
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
    label_density: 25
    legend_position: center
    y_axis_gridlines: true
    show_view_names: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density_custom: 5
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    totals_color: "#808080"
    show_null_points: true
    interpolation: linear
    colors: ['palette: Looker Classic']
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

  - name: Top_States
    title: "Sales by State"
    model: lauras_project
    explore: order_items
    type: looker_geo_choropleth
    fields: [order_items.count, users.state]
    sorts: [order_items.count desc]
    listen:
      date: orders.created_date
      state: users.state
    limit: 500
    map: usa
    colors: ["#651F81"]

  - name: Top_15_Brands
    title: "Top 15 Brands"
    model: lauras_project
    explore: order_items
    type: table
    fields: [products.brand, order_items.count, orders.count, order_items.total_sale_price, orders.average_order_profit]
    sorts: [order_items.count desc]
    limit: 15
    listen:
      date: orders.created_date
      state: users.state
    query_timezone: America/Los_Angeles
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false

  - name: user_signup_cohort_orders
    title: "Cohort - Orders by User Signup Month"
    model: lauras_project
    explore: order_items
    type: looker_area
    fields: [orders.created_month, users.created_month, orders.count]
    pivots: [users.created_month]
    fill_fields: [orders.created_month, users.created_month]
    filters:
      orders.created_date: 12 months ago for 12 months
      users.created_month: 12 months ago for 12 months
    listen:
      state: users.state
    sorts: [orders.created_month, users.created_month 0]
    limit: 15
    column_limit: 50
    query_timezone: America/Los_Angeles
    stacking: normal
    colors: ['palette: Fuchsia to Green']

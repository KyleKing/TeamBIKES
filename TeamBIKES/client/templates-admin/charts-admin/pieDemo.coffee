###
# Call the function to built the chart when the template is rendered
###

###
# Function to draw the pie chart
###

builtPie = ->
  # 'external' data
  data = new Array
  data.push
    name: 'In Use'
    y: _.random(10, 100)
    color: '#113F8C'
  data.push
    name: 'Unused'
    y: _.random(1, 40)
    color: '#01A4A4'
  data.push
    name: 'Broken'
    y: _.random(1, 20)
    color: '#00A1CB'
  $('#container-pie').highcharts
    chart:
      plotBackgroundColor: null
      plotBorderWidth: null
      plotShadow: false
    title: text: 'Bikes by Condition'
    credits: enabled: false
    tooltip: pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
    plotOptions: pie:
      allowPointSelect: true
      cursor: 'pointer'
      dataLabels: enabled: false
      showInLegend: true
    series: [ {
      type: 'pie'
      name: 'Bikes'
      data: data
    } ]
  return

Template.pieDemo.rendered = ->
  builtPie()
  return

# ---
# generated by js2coffee 2.0.4
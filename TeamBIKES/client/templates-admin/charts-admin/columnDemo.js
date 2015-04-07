/*
 * Function to draw the column chart
 */
function builtColumn(BarData) {

    $('#container-column').highcharts({

        chart: {
            type: 'column'
        },

        title: {
            text: 'Monthly Red Bars Bike Rides'
        },

        colors: [
            '#00A9E0', '#3B3B3D', '#67CDDC', '#98C73D', '#D0DD2B'
        ],

        subtitle: {
            text: 'Source: Math.random()'
        },

        credits: {
            enabled: false
        },

        xAxis: {
            categories: [
                'Jan',
                'Feb',
                'Mar',
                'Apr',
                'May',
                'Jun',
                'Jul',
                'Aug',
                'Sep',
                'Oct',
                'Nov',
                'Dec'
            ]
        },

        yAxis: {
            min: 0,
            title: {
                text: 'Bikes Ridden'
            }
        },

        tooltip: {
            headerFormat: '<h4>{point.key}</h4>',
            // This styling is really screwy
            // headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
            // pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
            //     '<td style="padding:0"><b>{point.y:.1f} mm</b></td></tr>',
            // footerFormat: '</table>',
            shared: true,
            useHTML: true
        },

        plotOptions: {
            column: {
                pointPadding: 0.2,
                borderWidth: 0
            }
        },

        series: BarData
        // [{
        //     name: '< 10 Minute Rides',
        //     data: [49.9, 71.5, 106.4, 129.2, 144.0, 176.0, 135.6, 148.5, 216.4, 194.1, 95.6, 54.4]

        // }, {
        //     name: '10+ Minute Rides',
        //     data: [83.6, 78.8, 98.5, 93.4, 106.0, 84.5, 105.0, 104.3, 91.2, 83.5, 106.6, 92.3]

        // }, {
        //     name: 'Off Campus Rides',
        //     data: [42.4, 33.2, 34.5, 39.7, 52.6, 75.5, 57.4, 60.4, 47.6, 39.1, 46.8, 51.1]

        // }]
    });
}

/*
 * Call the function to built the chart when the template is rendered
 */
Template.columnDemo.rendered = function() {
    return Meteor.subscribe("AdminBarChartData", function() {
        if (Meteor.isClient) {
            BarData = AdminBarChart.find().fetch();
            // console.log(BarData);
            builtColumn(BarData);
        }
    });
};
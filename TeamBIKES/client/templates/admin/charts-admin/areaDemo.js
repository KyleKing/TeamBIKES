/*
 * Function to draw the area chart
 */
function builtArea(randArray1, randArray2) {

    $('#container-area').highcharts({

        chart: {
            type: 'area',
            animation: Highcharts.svg, // don't animate in old IE
            // events: {
            //         load: function () {

            //             // set up the updating of the chart each second
            //             var series = this.series[0];
            //             setInterval(function () {
            //                 var x = (new Date()).getTime(), // current time
            //                     y = Math.random();
            //                 series.addPoint([x, y], true, true);
            //             }, 1000);
            //         }
            //     }
        },

        title: {
            text: 'Bike Quantities'
        },

        credits: {
            enabled: false
        },

        colors: [
            '#98C73D','#3B3B3D', '#00A9E0'
        ],

        // subtitle: {
        //     text: 'Source: <a href="http://thebulletin.metapress.com/content/c4120650912x74k7/fulltext.pdf">' +
        //         'thebulletin.metapress.com</a>'
        // },

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

        // xAxis: {
        //     allowDecimals: false,
        //     labels: {
        //         formatter: function () {
        //             return this.value; // clean, unformatted number for year
        //         }
        //     }
        // },

        yAxis: {
            title: {
                text: 'Milieage (miles)'
            }
        },

        // yAxis: {
        //     title: {
        //         text: 'Milieage'
        //     },
        //     labels: {
        //         formatter: function () {
        //             return this.value / 1000 + 'k';
        //         }
        //     }
        // },

        tooltip: {
            pointFormat: '{series.name} <b>{point.y:,.0f}</b> miles'
        },

        // plotOptions: {
        //     area: {
        //         pointStart: 2013,
        //         marker: {
        //             enabled: false,
        //             symbol: 'circle',
        //             radius: 2,
        //             states: {
        //                 hover: {
        //                     enabled: true
        //                 }
        //             }
        //         }
        //     }
        // },

        // series: BarData
        series: [{
            name: 'Bikes Ridden',
            data: randArray1
        }, {
            name: 'Miles Redistributed',
            data: randArray2
        }]
    });
}

/*
 * Call the function to built the chart when the template is rendered
 */
//  if(Meteor.isClient) {
//     Meteor.subscribe("AdminAreaChartData");
// }

// if(Meteor.isClient) {
//     Session.set("current_channel", "cool_people_channel");

//     Meteor.autorun(function() {
//         Meteor.subscribe("messages", Session.get("current_channel"));
//     });
// }

Template.areaDemo.created = function() {
    return Meteor.subscribe("AdminAreaChartData", function() {
        if (Meteor.isClient) {
            // console.log(BarData);
            var randArray1 = [];
            _.times(12, function(){ randArray1.push(_.random(100, 800)); });

            var randArray2 = [];
            _.times(12, function(){ randArray2.push(_.random(1, 200)); });
            builtArea(randArray1, randArray2);
        }
    });
};
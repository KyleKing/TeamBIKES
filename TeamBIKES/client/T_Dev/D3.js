Template.D3.onRendered(function () {
  var width = 960,
      height = 500;

  var color = d3.scale.category20();

  var force = d3.layout.force()
      .charge(-120)
      .linkDistance(30)
      .size([width, height]);

  var svg = d3.select("svg")
      .attr("width", width)
      .attr("height", height);

  d3.json("miserables.json", function(error, graph) {
    if (error) throw error;

    force
        .nodes(graph.nodes)
        .links(graph.links)
        .start();

    var link = svg.selectAll(".link")
        .data(graph.links)
      .enter().append("line")
        .attr("class", "link")
        .style("stroke-width", function(d) { return Math.sqrt(d.value); });

    var node = svg.selectAll(".node")
        .data(graph.nodes)
      .enter().append("circle")
        .attr("class", "node")
        .attr("r", 5)
        .style("fill", function(d) { return color(d.group); })
        .call(force.drag);

    node.append("title")
        .text(function(d) { return d.name; });

    force.on("tick", function() {
      link.attr("x1", function(d) { return d.source.x; })
          .attr("y1", function(d) { return d.source.y; })
          .attr("x2", function(d) { return d.target.x; })
          .attr("y2", function(d) { return d.target.y; });

      node.attr("cx", function(d) { return d.x; })
          .attr("cy", function(d) { return d.y; });
    });
  });

});


// Template.D3.onRendered(function () {
//   var margin = {top: 20, right: 20, bottom: 30, left: 40},
//       width = 960 - margin.left - margin.right,
//       height = 600 - margin.top - margin.bottom;

//   var x = d3.scale.ordinal()
//       .rangeRoundBands([0, width], .1);

//   var y = d3.scale.linear()
//       .range([height, 0]);

//   var xAxis = d3.svg.axis()
//       .scale(x)
//       .orient("bottom");

//   var yAxis = d3.svg.axis()
//       .scale(y)
//       .orient("left")
//       .ticks(10, "%");

//   // var svg = d3.select("body").append("svg")
//   var svg = d3.select("svg")
//       .attr("width", width + margin.left + margin.right)
//       .attr("height", height + margin.top + margin.bottom)
//     .append("g")
//       .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

//   d3.tsv("data.tsv", type, function(error, data) {
//     if (error) throw error;
//     // console.log(data);

//     x.domain(data.map(function(d) { return d.letter; }));
//     y.domain([0, d3.max(data, function(d) { return d.frequency; })]);

//     svg.append("g")
//         .attr("class", "x axis")
//         .attr("transform", "translate(0," + height + ")")
//         .call(xAxis);

//     svg.append("g")
//         .attr("class", "y axis")
//         .call(yAxis)
//       .append("text")
//         .attr("transform", "rotate(-90)")
//         .attr("y", 6)
//         .attr("dy", ".71em")
//         .style("text-anchor", "end")
//         .text("Frequency");

//     svg.selectAll(".bar")
//         .data(data)
//       .enter().append("rect")
//         .attr("class", "bar")
//         .attr("x", function(d) { return x(d.letter); })
//         .attr("width", x.rangeBand())
//         .attr("y", function(d) { return y(d.frequency); })
//         .attr("height", function(d) { return height - y(d.frequency); });
//   });

//   function type(d) {
//     d.frequency = +d.frequency;
//     return d;
//   }
// });
Template.About.onRendered(function () {

  var width = 960,
      height = 400;

  var foci = [{x: 150, y: 150}, {x: 50, y: 250}, {x: width-50, y: 100}];

  var color = d3.scale.category20();

  var svg = d3.select('svg')
      .attr('width', width)
      .attr('height', height);

  // Get external data
  d3.json("bikes.json", function(error, graph) {
    // Extract the nodes and links from the data.
    console.log(graph);
    var nodes = graph.nodes,
        links = graph.links;

    // Now we create a force layout object and define its properties.
    // Those include the dimensions of the visualization and the arrays
    // of nodes and links.

    var force = d3.layout.force()
        .charge(-120)
        .linkDistance(30)
        .size([width, height])
        .nodes(nodes)
        .links(links);

    force.linkDistance(width/10);

    // Next we'll add the nodes and links to the visualization.
    // Note that we're just sticking them into the SVG container

    var link = svg.selectAll(".link")
        .data(links)
      .enter().append("line")
        .attr("class", "link")
        .style("stroke-width", 2);
    var node = svg.selectAll(".node")
        .data(nodes)
      .enter().append("circle")
        .attr("class", "node")
        .attr("r", 10)
        .style("fill", function(d) { return color(d.group); })
        .call(force.drag);

    force.on('tick', function() {
      node.attr('cx', function(d) { return d.x; })
          .attr('cy', function(d) { return d.y; });

      link.attr('x1', function(d) { return d.source.x; })
          .attr('y1', function(d) { return d.source.y; })
          .attr('x2', function(d) { return d.target.x; })
          .attr('y2', function(d) { return d.target.y; });

      nodes.forEach(function(o, i) {
        o.y += (foci[o.group].y - o.y) * 0.01;
        o.x += (foci[o.group].x - o.x) * 0.01;
      });
      node
          .attr("cx", function(d) { return d.x; })
          .attr("cy", function(d) { return d.y; });
    });

    force.start();
  });

});

// Template.About.onRendered(function () {
//   //Constants for the SVG
//   var width = 500,
//       height = 500;

//   //Set up the colour scale
//   var color = d3.scale.category20();

//   //Set up the force layout
//   var force = d3.layout.force()
//       .charge(-120)
//       .linkDistance(30)
//       .size([width, height]);

//   //---Insert-------
//   var node_drag = d3.behavior.drag()
//           .on("dragstart", dragstart)
//           .on("drag", dragmove)
//           .on("dragend", dragend);

//       function dragstart(d, i) {
//           force.stop() // stops the force auto positioning before you start dragging
//       }

//       function dragmove(d, i) {
//           d.px += d3.event.dx;
//           d.py += d3.event.dy;
//           d.x += d3.event.dx;
//           d.y += d3.event.dy;
//       }

//       function dragend(d, i) {
//           d.fixed = true; // of course set the node to fixed so the force doesn't include the node in its auto positioning stuff
//           force.resume();
//       }

//       function releasenode(d) {
//           d.fixed = false; // of course set the node to fixed so the force doesn't include the node in its auto positioning stuff
//           //force.resume();
//       }


//   //---End Insert------

//   //Append a SVG to the body of the html page. Assign this SVG as an object to svg
//   var svg = d3.select("svg")
//       .attr("width", width)
//       .attr("height", height);

//   //Read the data from the mis element
//   // var mis = document.getElementById('mis').innerHTML;
//   // graph = JSON.parse(mis);

//   d3.json("bikes.json", function(error, graph) {
//     if (error) throw error;

//     //Creates the graph data structure out of the json data
//     force.nodes(graph.nodes)
//         .links(graph.links)
//         .start();

//     // Create all the line svgs but without locations yet
//     var link = svg.selectAll(".link")
//         .data(graph.links)
//         .enter().append("line")
//         .attr("class", "link")
//         .style("stroke-width", function (d) {
//         return Math.sqrt(d.value);
//     });

//     // Do the same with the circles for the nodes - no
//     var node = svg.selectAll(".node")
//         .data(graph.nodes)
//         .enter().append("circle")
//         .attr("class", "node")
//         .attr("r", 8)
//         .style("fill", function (d) {
//         return color(d.group);
//     })
//     .on('dblclick', releasenode)
//     .call(node_drag); // Added

//     // Now we are giving the SVGs co-ordinates - the force layout is generating the co-ordinates which this code is using to update the attributes of the SVG elements
//     force.on("tick", function () {
//         link.attr("x1", function (d) {
//             return d.source.x;
//         })
//             .attr("y1", function (d) {
//             return d.source.y;
//         })
//             .attr("x2", function (d) {
//             return d.target.x;
//         })
//             .attr("y2", function (d) {
//             return d.target.y;
//         });

//         node.attr("cx", function (d) {
//             return d.x;
//         })
//             .attr("cy", function (d) {
//             return d.y;
//         });
//     });

//   }); // Graph, error

// });



// Template.About.onRendered(function () {
//   // Define the dimensions of the visualization. We're using
//   // a size that's convenient for displaying the graphic on
//   // http://jsDataV.is

//   var width = 640,
//       height = 480;

//   // Here's were the code begins. We start off by creating an SVG
//   // container to hold the visualization. We only need to specify
//   // the dimensions for this container.

//   var svg = d3.select('svg')
//       .attr('width', width)
//       .attr('height', height);

//   // Before we do anything else, let's define the data for the visualization.

//   var graph = {
//       "nodes": [  { "x": 208.992345, "y": 273.053211 },
//                   { "x": 595.98896,  "y":  56.377057 },
//                   { "x": 319.568434, "y": 278.523637 },
//                   { "x": 214.494264, "y": 214.893585 },
//                   { "x": 482.664139, "y": 340.386773 },
//                   { "x":  84.078465, "y": 192.021902 },
//                   { "x": 196.952261, "y": 370.798667 },
//                   { "x": 107.358165, "y": 435.15643  },
//                   { "x": 401.168523, "y": 443.407779 },
//                   { "x": 508.368779, "y": 386.665811 },
//                   { "x": 355.93773,  "y": 460.158711 },
//                   { "x": 283.630624, "y":  87.898162 },
//                   { "x": 194.771218, "y": 436.366028 },
//                   { "x": 477.520013, "y": 337.547331 },
//                   { "x": 572.98129,  "y": 453.668459 },
//                   { "x": 106.717817, "y": 235.990363 },
//                   { "x": 265.064649, "y": 396.904945 },
//                   { "x": 452.719997, "y": 137.886092 }
//               ],
//       "links": [  { "target": 11, "source":  0 },
//                   { "target":  3, "source":  0 },
//                   { "target": 10, "source":  0 },
//                   { "target": 16, "source":  0 },
//                   { "target":  1, "source":  0 },
//                   { "target":  3, "source":  0 },
//                   { "target":  9, "source":  0 },
//                   { "target":  5, "source":  0 },
//                   { "target": 11, "source":  0 },
//                   { "target": 13, "source":  0 },
//                   { "target": 16, "source":  0 },
//                   { "target":  3, "source":  1 },
//                   { "target":  9, "source":  1 },
//                   { "target": 12, "source":  1 }
//               ]
//       };


//   // Extract the nodes and links from the data.
//   var nodes = graph.nodes,
//       links = graph.links;

//   // Now we create a force layout object and define its properties.
//   // Those include the dimensions of the visualization and the arrays
//   // of nodes and links.

//   var force = d3.layout.force()
//       .size([width, height])
//       .nodes(nodes)
//       .links(links);

//   // There's one more property of the layout we need to define,
//   // its `linkDistance`. That's generally a configurable value and,
//   // for a simple example, we'd normally leave it at its default.
//   // Unfortunately, the default value results in a visualization
//   // that's not especially clear. This parameter defines the
//   // distance (normally in pixels) that we'd like to have between
//   // nodes that are connected. (It is, thus, the length we'd
//   // like our links to have.)

//   force.linkDistance(width/3.05);

//   // Next we'll add the nodes and links to the visualization.
//   // Note that we're just sticking them into the SVG container
//   // at this point. We start with the links. The order here is
//   // important because we want the nodes to appear "on top of"
//   // the links. SVG doesn't really have a convenient equivalent
//   // to HTML's `z-index`; instead it relies on the order of the
//   // elements in the markup. By adding the nodes _after_ the
//   // links we ensure that nodes appear on top of links.

//   // Links are pretty simple. They're just SVG lines, and
//   // we're not even going to specify their coordinates. (We'll
//   // let the force layout take care of that.) Without any
//   // coordinates, the lines won't even be visible, but the
//   // markup will be sitting inside the SVG container ready
//   // and waiting for the force layout.

//   var link = svg.selectAll('.link')
//       .data(links)
//       .enter().append('line')
//       .attr('class', 'link');

//   // Now it's the nodes turn. Each node is drawn as a circle.

//   var node = svg.selectAll('.node')
//       .data(nodes)
//       .enter().append('circle')
//       .attr('class', 'node');

//   // We're about to tell the force layout to start its
//   // calculations. We do, however, want to know when those
//   // calculations are complete, so before we kick things off
//   // we'll define a function that we want the layout to call
//   // once the calculations are done.

//   force.on('end', function() {

//       // When this function executes, the force layout
//       // calculations have concluded. The layout will
//       // have set various properties in our nodes and
//       // links objects that we can use to position them
//       // within the SVG container.

//       // First let's reposition the nodes. As the force
//       // layout runs it updates the `x` and `y` properties
//       // that define where the node should be centered.
//       // To move the node, we set the appropriate SVG
//       // attributes to their new values. Also give the
//       // nodes a non-zero radius so they're visible.

//       node.attr('r', width/100)
//           .attr('cx', function(d) { return d.x; })
//           .attr('cy', function(d) { return d.y; });

//       // We also need to update positions of the links.
//       // For those elements, the force layout sets the
//       // `source` and `target` properties, specifying
//       // `x` and `y` values in each case.

//       link.attr('x1', function(d) { return d.source.x; })
//           .attr('y1', function(d) { return d.source.y; })
//           .attr('x2', function(d) { return d.target.x; })
//           .attr('y2', function(d) { return d.target.y; });

//   });

//   // Okay, everything is set up now so it's time to turn
//   // things over to the force layout. Here we go.

//   force.start();

//   // By the time you've read this far in the code, the force
//   // layout has probably finished its work.

// });
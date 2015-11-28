Template.About.onRendered ->
  width = 960
  height = 400
  foci = [{x: 150, y: 150}, {x: 50, y: 250}, {x: width-50, y: 100}, {x: width, y: 300}];
  color = d3.scale.category20()

  svg = d3.select('svg').attr('width', width).attr('height', height)

  # Get external data
  d3.json 'bikes.json', (error, graph) ->
    # Extract the nodes and links from the data.
    console.log graph
    nodes = graph.nodes
    links = graph.links

    # Now we create a force layout object and define its properties.
    # Those include the dimensions of the visualization and the arrays
    # of nodes and links.
    force = d3.layout.force().charge(-200).linkDistance(width / 10).size([
      width
      height
    ]).nodes(nodes).links(links)

    # Next we'll add the nodes and links to the visualization.
    # Note that we're just sticking them into the SVG container
    link = svg.selectAll('.link').data(links).enter().append('line').attr('class', 'link').style('stroke-width', 2)
    node = svg.selectAll('.node').data(nodes).enter().append('circle').attr('class', 'node').attr('r', 10).style('fill', (d) ->
      color d.group
    ).call(force.drag)

    force.on 'tick', ->
      # Place Nodes and Links
      node.attr('cx', (d) ->
        d.x
      ).attr 'cy', (d) ->
        d.y
      link.attr('x1', (d) ->
        d.source.x
      ).attr('y1', (d) ->
        d.source.y
      ).attr('x2', (d) ->
        d.target.x
      ).attr 'y2', (d) ->
        d.target.y

      # Move to foci
      nodes.forEach (o, i) ->
        o.y += (foci[o.group].y - (o.y)) * 0.01
        o.x += (foci[o.group].x - (o.x)) * 0.01
      node.attr('cx', (d) ->
        d.x
      ).attr 'cy', (d) ->
        d.y
      return

    force.start()

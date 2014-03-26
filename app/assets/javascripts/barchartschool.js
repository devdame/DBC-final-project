function barChartSchool(data) {

    var width = 600,                     //bar length
        barHeight = 40;

    var w = 600,                        //viewport width
        h = 600,                       //viewport height
        color = d3.scale.category20c(); //builtin range of colors

    var scaler = d3.scale.linear()
          .range([0, w/2]);



    var chart = d3.select("#bar-chart-school")
        .append("svg:svg")              //create the SVG element inside the <body>
        .data([data])                   //associate our data with the document
            .attr("width", w)           //set the width and height of our visualization (these will
                                        // be attributes of the <svg> tag
            .attr("height", h)
        .append("svg:g")                //make a group to hold our bar

    // calculating max range
    maxPosRange = d3.max(data, function(d) { return d.positive_count });
    maxNegRange = d3.max(data, function(d) { return d.negative_count });
    totalRange = maxPosRange + maxNegRange;

    var bar = chart.selectAll("g")
        .data(data)
        .enter().append("g")
        .attr("transform", function(d, i) { return "translate(0," + i * barHeight + ")"; });

    // posivibe bars
    bar.append("rect")
      .attr("width", 0)
      .attr("opacity", 0.5)
      .attr("x", 0)
      .transition()
      .duration(1000)
      .attr("width", function(d) { return scaler(d.positive_count/totalRange); })
      // .attr("x", scaler(maxNegRange/totalRange))
      .attr("x", (w/2) + 1)
      .attr("height", barHeight - 1)
      .attr("opacity", 1)
      .attr("fill", function(d, i) { return color(i); } );

    // negavibe bars
    bar.append("rect")
      .attr("width", 0)
      .attr("opacity", 0.5)
      .attr("x", 800)       // fix this hard coded coordinate later
      .transition()
      .duration(1000)
      .attr("width", function(d) { return scaler(d.negative_count/totalRange); })
      // .attr("x", function(d) { return scaler((maxNegRange - d.negative_count)/totalRange) - 2; })
      .attr("x", function(d) { return (w/2) - scaler(d.negative_count/totalRange) - 1; })
      .attr("height", barHeight - 1)
      .attr("opacity", 1)
      .attr("fill", function(d, i) { return color(i); } );

    bar.append("text")
    // .attr("x", scaler(maxNegRange/totalRange))
    .attr("x", (w/2))
    .attr("y", barHeight / 2)
    .attr("text-anchor", "middle")
    .attr("dy", ".35em")
    .text(function(d) { return d.name; })
    .attr("fill", "#3D3D3D")
    .attr("font-family", "Sans-Serif");
}

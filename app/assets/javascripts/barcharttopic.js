function barChartTopic(data) {

    var width = 600;                     //bar length
    var barHeight = 20;
    var w = 1200,                        //viewport width
        h = 22*data.length,              //viewport height
        color = d3.scale.category20b();

    var scaler = d3.scale.sqrt()
          .range([0, w/2]);

    var chart = d3.select("#bar-chart-topic")
        .append("svg:svg")              //create the SVG element inside the <body>
        .data([data])                   //associate our data with the document
            .attr("width", w)           //set the width and height of our visualization (these will
                                        // be attributes of the <svg> tag
            .attr("height", h)
        .append("svg:g")                //make a group to hold our bar
        .attr("transform", "translate(0,20)");

    // calculating max range
    maxPosRange = d3.max(data, function(d) { return d.positive_count });
    maxNegRange = d3.max(data, function(d) { return d.negative_count });
    totalRange = maxPosRange + maxNegRange;

    var bar = chart.selectAll("g")
      .data(data)
      .enter().append("g")
      .attr("y", 100)
      .attr("transform", function(d, i) { return "translate(0," + i * barHeight + ")"; });

    // posivibe bars
    bar.append("rect")
      .attr("width", 0)
      .attr("opacity", 0.1)
      .attr("x", 0)
      .transition()
      .duration(1000)
      .attr("width", function(d) { return scaler(d.positive_count/totalRange); })
      .attr("x", (w/2) + 75)
      .attr("height", barHeight - 1)
      .attr("opacity", 1)
      .style("fill", function(d, i) { return d3.rgb(color(i)).brighter(0.5);});

    // negavibe bars
    bar.append("rect")
      .attr("width", 0)
      .attr("opacity", 0.1)
      .attr("x", w)
      .transition()
      .duration(1000)
      .attr("width", function(d) { return scaler(d.negative_count/totalRange); })
      .attr("x", function(d) { return (w/2) - scaler(d.negative_count/totalRange) - 75; })
      .attr("height", barHeight - 1)
      .attr("opacity", 1)
      .style("fill", function(d, i) { return d3.rgb(color(i)).darker(1.3);});

    // background bars for keyword terms
    bar.append("rect")
      .attr("width", 150 - 2)
      .attr("opacity", 1)
      .attr("x", w/2 - 75 + 1)
      .attr("height", barHeight - 1)
      .style("fill", function(d, i) { return color(i); });

    // keyword terms
    bar.append("text")
      .attr("x", (w/2))
      .attr("y", barHeight / 2)
      .attr("text-anchor", "middle")
      .attr("dy", ".30em")
      .text(function(d) { return d.name; })
      .attr("fill", "white")
      .attr("font-family", "Sans-Serif")
      .style("text-shadow", "0 0 2px dimgray");

    // label: more negative
    chart.append("text")
      .attr("x", w*0.3)
      .attr("y", -10)
      .attr("text-anchor", "start")
      .attr("dy", ".30em")
      .text("MORE NEGATIVE ←")
      .attr("fill", "gray")
      .attr("font-family", "Sans-Serif")
      .attr("font-size", "12px");

    // label: more positive
    chart.append("text")
      .attr("x", w*0.7)
      .attr("y", -10)
      .attr("text-anchor", "end")
      .attr("dy", ".30em")
      .text("→ MORE POSITIVE")
      .attr("fill", "gray")
      .attr("font-family", "Sans-Serif")
      .attr("font-size", "12px");

}

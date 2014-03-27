// used by single topic view (topic show)
function barChart(data) {

var width = 800,
    barHeight = 30;

    var w = 800,                        //width
        h = 30*data.length,                       //height
        color = d3.scale.category20c(),     //builtin range of colors
        scaler = d3.scale.linear()
          .range([0, w-250]);



    var chart = d3.select("#bar-chart-topic-school")
        .append("svg:svg")              //create the SVG element inside the <body>
        .data([data])                   //associate our data with the document
            .attr("width", w)           //set the width and height of our visualization (these will
                                        // be attributes of the <svg> tag
            .attr("height", h)
        .append("svg:g")                //make a group to hold our bar

    maxPosRange = d3.max(data, function(d) { return d.count });

    var bar = chart.selectAll("g")
        .data(data)
      .enter().append("g")
        .attr("transform", function(d, i) { return "translate(0," + i * barHeight + ")"; })

    // bar bg
    // bar.append("rect")
    //   .attr("height", 0)
    //   .attr("opacity", 0.2)
    //   .transition()
    //   .duration(800)
    //   // .attr("x", 0)
    //   .attr("opacity", 1)
    //   .attr("width", w)
    //   .attr("height", barHeight - 1)
    //   .attr("fill", "rgba(100,100,100,0.3)" );

    // actual data bars
    bar.append("rect")
      .attr("width", 0)
      .attr("x", 250)
      // .attr("x", 250)
      .transition()
      .duration(2000)
      .attr("width", function(d) { return scaler(d.count/maxPosRange);})
      .attr("height", barHeight - 1)
      .attr("fill", function(d, i) { return color(i); } );


    // text labels
    bar.append("text")
    .attr("x", 240)       // fix this hard code offset in the future
    .attr("y", barHeight / 2)
    .attr("dy", ".35em")
    .text(function(d) { return d.count; })
    .attr("fill", "#606060")
    .attr("font-family", "sans-serif")
    .attr("font-size", "0.9em")
    .attr("font-weight", "bold")
    .attr("text-anchor", "end");

}

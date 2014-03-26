function barChart(data) {

var width = 420,
    barHeight = 30;

    var w = 420,                        //width
        h = 30*data.length,                       //height
        color = d3.scale.category20c(),     //builtin range of colors
        x = d3.scale.sqrt()
          .range([0, width]);

  // var color = d3.scale.ordinal()
  //     .range(["#3399FF", "#5DAEF8", "#86C3FA", "#ADD6FB", "#D6EBFD"]);

    var chart = d3.select("#bar-chart-topic-school")
        .append("svg:svg")              //create the SVG element inside the <body>
        .data([data])                   //associate our data with the document
            .attr("width", w)           //set the width and height of our visualization (these will
                                        // be attributes of the <svg> tag
            .attr("height", h)
        .append("svg:g")                //make a group to hold our bar

    var bar = chart.selectAll("g")
        .data(data)
      .enter().append("g")
        .attr("transform", function(d, i) { return "translate(0," + i * barHeight + ")"; });

    bar.append("rect")
      .attr("width", 0)
      .transition()
      .duration(800)
      .attr("width", function(d) { return (d.count)*1.5;})
      .attr("height", barHeight - 1)
      .attr("fill", function(d, i) { return color(i); } );
    // data = [{"label":"Good", "value": data2.positive_social_ratio},
    //         {"label":"Bad", "value": data2.negative_social_ratio}];

    bar.append("text")
    .attr("x", function(d) { return x(d) - 3; })
    .attr("y", barHeight / 2)
    .attr("dy", ".35em")
    .text(function(d) { return d.name; })
    .attr("fill", "black")
    .attr("font-family", "sans-serif");
}

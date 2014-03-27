function pieChart(data, targetId) {
  // console.log("pieChart invoked");
  // console.log(data);
  // console.log(targetId);


  var w = 500,                        //width
    h = 500,                            //height
    r = 200,                            //radius
    color = d3.scale.category20c();     //builtin range of colors

    // data = [{"label":"Good", "value":60},
    //         {"label":"Bad", "value":30},
    //         {"label":"Other", "value":10}];



    data = [{"label":"Positive", "value": data.positive_social_ratio},
            {"label":"Negative", "value": data.negative_social_ratio},
            {"label":"Neutral", "value": data.neutral_social_ratio}];

    var vis = d3.select(targetId)
        .append("svg:svg")              //create the SVG element inside the <body>
        .data([data])                   //associate our data with the document
            .attr("width", w)           //set the width and height of our visualization (these will be attributes of the <svg> tag
            .attr("height", h)
        .append("svg:g")                //make a group to hold our pie chart
            .attr("transform", "translate(" + w/2 + "," + h/2 + ")")    //move the center of the pie chart from 0, 0 to radius, radius

    var arc = d3.svg.arc()              //this will create <path> elements for us using arc data
        .outerRadius(r);

    var pie = d3.layout.pie()           //this will create arc data for us given a list of values
        .startAngle(1.1*Math.PI)
        .endAngle(3.1*Math.PI)
        .value(function(d) { return d.value; });    //we must tell it out to access the value of each element in our data array

    var arcs = vis.selectAll("g.slice")     //this selects all <g> elements with class slice (there aren't any yet)
        .data(pie)                          //associate the generated pie data (an array of arcs, each having startAngle, endAngle and value properties)
        .enter()                            //this will create <g> elements for every "extra" data element that should be associated with a selection. The result is creating a <g> for every object in the data array

        .append("svg:g")                //create a group to hold each slice (we will have a <path> and a <text> element associated with each slice)
                .attr("class", "slice");    //allow us to style things in the slices (like text)


        arcs.append("svg:path")
                .attr("fill", function(d, i) { return color(i); } ) //set the color for each slice to be chosen from the color function defined above
                .transition().delay(function(d, i) { return i * 500; }).duration(500)
                // return i * 100 is delay between sector animations
                //.duration(2000) is animation speed
                // .transition()
                // .delay(800)
                .attrTween('d', function(d) {
                 var i = d3.interpolate(d.startAngle+0.1, d.endAngle);
                 return function(t) {
                    d.endAngle = i(t);
                    return arc(d);
                  }
                 });                                   //this creates the actual SVG path using the associated data (pie) with the arc drawing function

        arcs.append("svg:text")                                     //add a label to each slice
                .attr("transform", function(d) {                    //set the label's origin to the center of the arc
                //we have to make sure to set these before calling arc.centroid
                d.innerRadius = 120;
                d.outerRadius = r;
                return "translate(" + arc.centroid(d) + ")";        //this gives us a pair of coordinates like [50, 50]
            })
            .attr("text-anchor", "middle")                          //center the text on it's origin
            .text(function(d, i) { return data[i].label; })           //get the label from our original data array
            .attr("fill", "white")  // text
            .attr("font-family", "Sans-Serif")
}


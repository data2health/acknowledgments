<!DOCTYPE html>
<meta charset="utf-8">
<style> 
    
.node circle {
  fill: #fff;
  stroke: steelblue;
  stroke-width: 3px;
}

.node text { font: 12px sans-serif; }

.node--internal text {
  text-shadow: 0 1px 0 #fff, 0 -1px 0 #fff, 1px 0 0 #fff, -1px 0 0 #fff;
}

.link {
  fill: none;
  stroke: #ccc;
  stroke-width: 2px;
}

</style>

<body>
   	
<script src="//d3js.org/d3.v4.min.js"></script>
<script>
	
var treeData =
  {
    "name": "NP",
    "children": [
      { 
		"name": "NP:Person",
        "children": [
          { "name": "NNP:FirstName" },
          { "name": "NNP:LastName" }
        ]
      },
      { "name": "PP",
          "children": [
                       { "name": "IN" },
                       { "name": "NNP:location" }
                     ]
     }
    ]
  };


var margin = {top: 40, right: 90, bottom: 50, left: 90},
	width = 660 - margin.left - margin.right,
	height = 250 - margin.top - margin.bottom;


var treemap = d3.tree()
    .size([width, height]);

var root = d3.hierarchy(treeData);
//var root = d3.hierarchy(treeData, function(d) {
//    return d.children;
//  });

var nodes = treemap(root);

console.log(nodes)
// dslkjafdlkasjfdlkasdflkajsdflkjsadlfj

var svg = d3.select("body").append("svg")
      .attr("width", width + margin.left + margin.right)
      .attr("height", height + margin.top + margin.bottom),
    g = svg.append("g")
      .attr("transform",
            "translate(" + margin.left + "," + margin.top + ")");

var link = g.selectAll(".link")
    .data( nodes.descendants().slice(1))
  .enter().append("path")
    .attr("class", "link")
   .attr("d", function(d) {
       return "M" + d.x + "," + d.y
         + "C" + d.x + "," + (d.y + d.parent.y) / 2
         + " " + d.parent.x + "," +  (d.y + d.parent.y) / 2
         + " " + d.parent.x + "," + d.parent.y;
       });

var node = g.selectAll(".node")
    .data(nodes.descendants())
  .enter().append("g")
    .attr("class", function(d) { 
      return "node" + 
        (d.children ? " node--internal" : " node--leaf"); })
    .on("click", click)
    .attr("transform", function(d) { 
      return "translate(" + d.x + "," + d.y + ")"; });

node.append("circle")
  .attr("r", 10);

node.append("text")
  .attr("dy", ".35em")
  .attr("x", function(d) { return d.children ? -13 : 13; })
  .style("text-anchor", function(d) { 
    return d.children ? "end" : "start"; })
  .text(function(d) { return d.data.name; });
 
var output=
	g.append("text")
	.attr("x", width/2)        
	.attr("y", height+30)
	.attr("text-anchor", "middle")  
	.style("font-size", "16px")  
	.text("here should be some stuff");

function changetext(d){
	output
	.transition()
	.duration(200)
	.text(d.toString()); 
}


	function click(d) {
		var selected = d
		while (d.parent) {
			var parent = d.parent
			var child = d
			d3.selectAll(".node").filter(
					function(e) {
						return (e == parent && !parent.selected == "1")
								|| (e == child && !child.selected == "1");
					}).select("circle").style("fill", "pink")
			d.tagged = '1'
			d.parent.tagged = '1'
			d = d.parent;
		}
		d3.selectAll(".node").filter(function(e) {
			return e == selected;
		}).select("circle").style("fill", "red")
		selected.selected = 1
		test = ""
		check(nodes)
		changetext(test)
	}

	var test = ""

	function check(d) {
		console.log(d.data.name + " " + d.selected + " " + d.tagged);
		if (d.selected) {
			test += "(" + d.data.name + ")";
		}
		if (d.tagged && !d.selected) {
			test += d.data.name;
		}
		if (!d.parent) {
			test += " ^";
		}
		if (d.children)
			for (var i = 0; i < d.children.length; i++) {
				if (d.children[i].selected) {
					test += " <" + (i + 1);
					check(d.children[i]);
				} else if (d.children[i].tagged) {
					test += " <" + (i + 1) + "[";
					check(d.children[i]);
					test += "]";
				}
			}
	}
</script>
</body>

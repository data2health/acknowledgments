<!DOCTYPE html>
<meta charset="utf-8">
<style> 
    
/* changed node stroke color  */
.node circle {
  fill: #fff;
  stroke: #037C93;
  stroke-width: 2px;
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

<!-- added a reset button that calls reset (at very bottom of script) -->
<div id="option">
    <input name="updateButton" 
           type="button" 
           value="Reset" 
           onclick="reset()" />
</div>

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

// this has been changed 
var treemap = d3.tree()
    .size([width, height])
    .separation(function(a,b){			// added to have even seperation of nodes in levels
        return a.parrent==b.parrent?1:1
    });

var root = d3.hierarchy(treeData);

var nodes = treemap(root);


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

// this is edited to have the text in the middle and then above or below the nodes
node.append("text")
  .attr("dy", ".35em")
  .style("text-anchor", "middle")
  .attr("y", function(d) {return d.children ? -20 : 20;  })
  .text(function(d) { return d.data.name; });
 
var output=
	g.append("text")
	.attr("x", width/2)        
	.attr("y", height+45)
	.attr("text-anchor", "middle")  
	.style("font-size", "16px")  
	.text("Extraction Pattern");

function changetext(d){
	output
	.transition()
	.duration(200)
	.text(d.toString()); 
}

// changed node colors in this function 
	function click(d) {
		var selected = d
		while (d.parent) {
			var parent = d.parent
			var child = d
			d3.selectAll(".node").filter(
					function(e) {
						return (e == parent && !parent.selected == "1")
								|| (e == child && !child.selected == "1");
					}).select("circle").style("fill", "#FFBDA5") //changed parent colors 
			d.tagged = '1'
			d.parent.tagged = '1'
			d = d.parent;
		}
		d3.selectAll(".node").filter(function(e) {
			return e == selected;
		}).select("circle").style("fill", "#FF5313") // changed child color 
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
	
	// these two functions were added to reset node color and remove data tags 
	function reset(){
		d3.selectAll(".node")
			.select("circle").style("fill", "white");
		deletedata(root); //starts at root then calls again for each child 
		changetext('Extraction Pattern');
	}
	
	function deletedata(d){
		delete d.tagged;
		delete d.selected;
		if (d.children){
			for (var i = 0; i < d.children.length; i++){
				deletedata(d.children[i]);
			}
		}
	}
</script>
</body>
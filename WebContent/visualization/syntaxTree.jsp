<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<div id="tree" style=" float:left; width:100px">
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

<script src="//d3js.org/d3.v4.min.js"></script>
<script>
	
var tokens = "${param.tgrep}".match(/[\[]|[^ \[\]]+|[\]]/g);

var fence = 0;
var treeData = parse_tokens();

	function parse_tokens() {
		var current = {};
		if (tokens[fence] == "[") {
			fence++;
			current.name = tokens[fence].match(/[A-Z$]+|[^A-Z$]/g)[0];
			fence++;
		}
		while (tokens[fence] != "]") {
			if (current.children == null)
				current.children = [];
			if (tokens[fence] == "[") {
				current.children.push(parse_tokens());
				fence++;
			} else {
				var node = {};
				node.name = tokens[fence].match(/[A-Z$]+|[^A-Z$]+/g)[0];
				current.children.push(node);
				fence++;
			}
		}
		return current;
	}

	var margin = {
		top : 40,
		right : 90,
		bottom : 50,
		left : 90
	}, width = 660 - margin.left - margin.right, height = 200 - margin.top
			- margin.bottom;

	var treemap = d3.tree().size([ width, height ]);

	var root = d3.hierarchy(treeData);
	var nodes = treemap(root);

	console.log(nodes)

	var svg = d3.select("#tree").append("svg").attr("width",
			width + margin.left + margin.right).attr("height",
			height + margin.top + margin.bottom), g = svg.append("g").attr(
			"transform", "translate(" + margin.left + "," + margin.top + ")");

	var link = g.selectAll(".link").data(nodes.descendants().slice(1)).enter()
			.append("path").attr("class", "link").attr(
					"d",
					function(d) {
						return "M" + d.x + "," + d.y + "C" + d.x + ","
								+ (d.y + d.parent.y) / 2 + " " + d.parent.x
								+ "," + (d.y + d.parent.y) / 2 + " "
								+ d.parent.x + "," + d.parent.y;
					});

	var node = g.selectAll(".node").data(nodes.descendants()).enter().append(
			"g").attr("class", function(d) {
		return "node" + (d.children ? " node--internal" : " node--leaf");
	}).on("click", click).attr("transform", function(d) {
		return "translate(" + d.x + "," + d.y + ")";
	});

	node.append("circle").attr("r", 10);

	node.append("text").attr("dy", ".35em").attr("x", function(d) {
		return d.children ? -13 : 13;
	}).style("text-anchor", function(d) {
		return d.children ? "end" : "start";
	}).text(function(d) {
		return d.data.name;
	});

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
		tgrep = ""
		check(nodes)
		document.getElementById("tgrep").value = tgrep
	}

	var tgrep = ""

	function check(d) {
		console.log(d.data.name + " " + d.selected + " " + d.tagged);
		if (d.selected) {
			tgrep += "(" + d.data.name + ")";
		}
		if (d.tagged && !d.selected) {
			tgrep += d.data.name;
		}
		if (!d.parent) {
			tgrep += " ^";
		}
		if (d.children)
			for (var i = 0; i < d.children.length; i++) {
				if (d.children[i].selected) {
					tgrep += " <" + (i + 1);
					check(d.children[i]);
				} else if (d.children[i].tagged) {
					tgrep += " <" + (i + 1) + "[";
					check(d.children[i]);
					tgrep += "]";
				}
			}
	}
</script>
</div>
$(document).ready(function(){

var placeid = "";
var koreaMapWidth = 0;
var koreaMapHeight = 0;
var initialScale = 4500,
    initialX = 0,
    initialY = 0,
    centered,
    labels;
koreaMapWidth  = initialScale / 6;
koreaMapHeight = initialScale / 6;
initialX = initialScale * -2.15 - 80;
initialY = initialScale * 0.75 - 80;
var mapSvg = d3.select("#mapShow").append("svg")
    .attr("width", koreaMapWidth)
    .attr("height", koreaMapHeight)
    .attr('id', 'koreaMap');
//    .call(zoom);
var koreaProjection, koreaPath, koreaMap,
    placeProjection, placePath, placeMap,
    roadProjection, roadPath, roadMap,
    elecrailProjection, elecrailPath, elecrailMap;
var zoom;

function displayKoreaMap(){
koreaProjection    = d3.geo.mercator().scale(initialScale).translate([initialX, initialY]);
placeProjection    = d3.geo.mercator().scale(initialScale).translate([initialX, initialY]);
roadProjection     = d3.geo.mercator().scale(initialScale).translate([initialX, initialY]);
elecrailProjection = d3.geo.mercator().scale(initialScale).translate([initialX, initialY]);
koreaPath    = d3.geo.path().projection(koreaProjection);
placePath    = d3.geo.path().projection(placeProjection);
roadPath     = d3.geo.path().projection(roadProjection);
elecrailPath = d3.geo.path().projection(elecrailProjection);
koreaMap    = mapSvg.append("g").attr("id", "maps");
roadMap     = mapSvg.append("g").attr("id", "road");
elecrailMap = mapSvg.append("g").attr("id", "elecrail");
placeMap    = mapSvg.append("g").attr("id", "places");
// zoom and pan //
zoom = d3.behavior.zoom()
	.center(null) /* zoom에서 center를 지정하지 않으면 즉, 값을 null로 하면 마우스가 있는 곳에서 확대, 축소 함 */
    .size([koreaMapWidth, koreaMapHeight])
    .scaleExtent([1, 10]) /* [0.5, 5] 확대 및 축소 범위 지정 */
    .on("zoom", function()
     { koreaMap.attr("transform","translate("+ d3.event.translate + ")scale("+d3.event.scale+")");
       elecrailMap.attr("transform","translate("+ d3.event.translate + ")scale("+d3.event.scale+")");
       roadMap.attr("transform","translate("+ d3.event.translate + ")scale("+d3.event.scale+")");
       placeMap.attr("transform","translate("+ d3.event.translate + ")scale("+d3.event.scale+")");
     });
koreaMap.call(zoom).call(zoom.event);
elecrailMap.call(zoom).call(zoom.event);
roadMap.call(zoom).call(zoom.event);
placeMap.call(zoom).call(zoom.event);
// zoom and pan //
d3.json("../../resources/map/korea.json", function(json)
{ koreaMap.selectAll("path")
          .data(json.features).enter().append("path")
          .attr("d", koreaPath)
          .attr("id", function(d) { return 'path-'+d.properties.code; });
  labels = koreaMap.selectAll("text")
          .data(json.features).enter().append("text")
          .attr("transform", labelsTransform)
          .attr("id", function(d) { return 'label-'+d.properties.code; })
          .attr('text-anchor', 'middle')
          .attr("dy", ".35em")
          .text(function(d) { return d.properties.name; });
});
d3.json("elecrail.geojson", function(json)
{ elecrailMap.selectAll("path")
          .data(json.features).enter().append("path")
          .attr("d", elecrailPath);
});
d3.json("koreaexpresswaylines.geojson", function(json)
{ roadMap.selectAll("path")
          .data(json.features).enter().append("path")
          .attr("d", roadPath);
});
d3.csv("../../resources/map/placekorea.csv", function(data)
{ placeMap.selectAll("circle")
          .data(data).enter().append("circle")
          .attr("cx", function(d) { return placeProjection([d.longi, d.lati])[0]; })
          .attr("cy", function(d) { return placeProjection([d.longi, d.lati])[1]; })
          .attr("r", 3)
          .attr("class", "placeCircle")
          .attr("id", function(d) { return d.seno; });
  placeMap.selectAll("text")
          .data(data).enter().append("text") 
          .attr("x", function(d) { return placeProjection([d.longi, d.lati])[0]; }) 
          .attr("y", function(d) { return placeProjection([d.longi, d.lati])[1] - 5; })
          .attr("class", "placeName")
          .attr("id", function(d) { return d.seno+"name"; })
          .text(function(d) { return d.name; });
});
}
/* ================================================ */

$( document ).on( "click", "#reloadMap", function()
{ mapSvg.selectAll("*").remove();
  displayKoreaMap();
});

displayKoreaMap();

$( document )
 .on( "mouseenter", ".placeCircle", function()
  { placeid = $(this).attr('id')+"name";
    $(this).css({"fill" : "#ff0000"});
    $("#"+placeid).css({"display" : "block"}); 
  })
 .on( "mouseleave", ".placeCircle", function()
  { placeid = $(this).attr('id')+"name";
    $(this).css({"fill" : "#ffff00"});
    $("#"+placeid).css({"display" : "none"}); 
  })
 .on( "mouseenter", "#koreaMap #road path", function()
  { $(this).css({"stroke-width" : "6px"});
  })
 .on( "mouseleave", "#koreaMap #road path", function()
  { $(this).css({"stroke-width" : "3px"});
  });

function labelsTransform(d) {
// 경기도가 서울특별시와 겹쳐서 위치 조정 및 세종특별자치시와 대전광역시 위치 조정
 if (d.properties.code == 31) /* 경기도 */
 { var arr = koreaPath.centroid(d);
   arr[1] += (d3.event && d3.event.scale) ? (d3.event.scale / koreaMapHeight - 40) : (initialScale / koreaMapHeight - 40);
   return "translate(" + arr + ")";
 }
 else if (d.properties.code == 25) /* 대전광역시 */
 { var arr = koreaPath.centroid(d);
   arr[1] += (d3.event && d3.event.scale) ? (d3.event.scale / koreaMapHeight + 5) : (initialScale / koreaMapHeight + 5);
   return "translate(" + arr + ")";
 }
 else if (d.properties.code == 29) /* 세종특별자치시 */
 { var arr = koreaPath.centroid(d);
   arr[1] += (d3.event && d3.event.scale) ? (d3.event.scale / koreaMapHeight + 10) : (initialScale / koreaMapHeight + 10);
   return "translate(" + arr + ")";
 }
 else
 { var arr = koreaPath.centroid(d);
   arr[1] += (d3.event && d3.event.scale) ? (d3.event.scale / koreaMapHeight - 10) : (initialScale / koreaMapHeight - 10);
   return "translate(" + arr + ")";
 }
}

});

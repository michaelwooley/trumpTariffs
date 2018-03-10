var scale = 1,
  bds = {
    max: 10,
    min: 0,
  },
  topofile = '../js/data/us_puma_2016.json',
  datafile = '../js/data/tariff_ind_emp.csv',
  toPlot = 'emp_steel_cty_emp_sh',
  pumaName = 'puma_name',
  stateName = 'state_abbrev',
  logScale = false,
  backgroundColor = 'none';

var colorScheme = [
  'white',
  'rgb(244,242,239)',
  'rgb(220, 213, 229)',
  'rgb(185, 171, 204)',
  'rgb(149,129,178)',
  'rgb(114,87,153)',
  'rgb(79,45,127)',
];

var width = scale * 960,
  height = scale * 500;

var df = d3.map(),
  pumaNames = d3.map(),
  stateNames = d3.map();

// Defines the color mapping
var color = d3
  .scaleThreshold()
  .domain(
    d3.range(
      logScale ? Math.log10(1 + bds.min) : bds.min,
      logScale ? Math.log10(1 + bds.max) : bds.max,
    ),
  )
  .range(colorScheme);

// Set up paths and projections for the map
var projection = d3
  .geoMercator()
  .scale(scale * 890)
  .translate([width * 2.08, height * 1.77]);

var path = d3.geoPath().projection(projection);

var projectionAK = d3
  .geoMercator()
  .scale(scale * 200)
  .translate([width / 1.5, height * 1.4]);

var pathAK = d3.geoPath().projection(projectionAK);

var projectionHA = d3
  .geoMercator()
  .scale(scale * 900)
  .translate([width * 2.85, height * 1.5]);

var pathHA = d3.geoPath().projection(projectionHA);

// var zoom = d3.zoom()
//   // .translate([width / 2, height / 2])
//   // .scale(scale0)
//   // .scaleExtent([scale0, 8 * scale0])
//   .on("zoom", zoomed);

var svg = d3
  .select('svg.basemap')
  .attr('width', width)
  .attr('height', height)
  .style('background-color', backgroundColor); // .call(zoom);
// .call(zoom.event);

d3
  .queue()
  .defer(d3.json, topofile)
  .defer(d3.csv, datafile, function(d) {
    df.set(d.id, +d[toPlot]);
    pumaNames.set(d.id, d[pumaName]);
    stateNames.set(d.id, d[stateName]);
  })
  .await(ready);

function ready(error, us) {
  if (error) throw error;

  svg
    .append('g')
    .attr('class', 'pumas')
    .selectAll('path')
    .data(topojson.feature(us, us.objects.name).features)
    .enter()
    .append('path')
    .attr('d', (d) => {
      d[toPlot] = df.get(d.id) || 0;
      d.puma = pumaNames.get(d.id);
      d.state = stateNames.get(d.id);

      if (!['02', '15', '78', '72'].includes(d.properties.STATEFP10)) {
        return path(d);
      } else if (d.properties.STATEFP10 === '02') {
        return pathAK(d);
      } else if (d.properties.STATEFP10 === '15') {
        return pathHA(d);
      } else {
        return null;
      }
    })
    .attr('fill', function(d) {
      return color(logScale ? Math.log10(1 + d[toPlot]) : d[toPlot]);
    })
    .style('stroke', 'white')
    .style('stroke-width', 0.25)
    .append('title')
    .text(function(d) {
      return (
        d.puma +
        '\n' +
        d.state +
        '\n' +
        d[toPlot].toFixed(2).padEnd(2, '0') +
        '%'
      );
    });
}

function zoomed() {
  projection.translate(zoom.translate()).scale(zoom.scale());

  g.selectAll('path').attr('d', path);
}

// d3.json('../js/data/us_puma_2016.json', (error, us) => {
//   if (error) throw error;

//   svg.append("g")
//     .attr("class", "puma")
//     .selectAll("path")
//     .data(topojson.feature(us, us.objects.name).features)
//     .enter().append("path")
//     .attr("d", (d) => {
//       if (!['02', '15', '78', '72'].includes(d.properties.STATEFP10)) {
//         return path(d)
//       } else if (d.properties.STATEFP10 === '02') {
//         return pathAK(d)
//       } else if (d.properties.STATEFP10 === '15') {
//         return pathHA(d)
//       } else {
//         return null;
//       }
//     })
//     .style("fill", function(d) {
//       return fill(path.area(d));
//     });
// })

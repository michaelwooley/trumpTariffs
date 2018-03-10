const mainBaseMap = () => {
  var mapTitle = 'County Steel and Aluminum Employment Shares';
  var mapNotes = `Map plots the estimated percent of workers employed in either the "Iron and steel mills and steel products" or "  Aluminum production and processing" industries in 2012-16. Shares computed at PUMA level then aggregated to county level. See Data Appendix for further information. Source: IPUMS/American Community Survey 2012-2016 5-Year Sample.`;

  var datafile = '../data/int/county_emp_tariffs_data.csv';

  var colorScheme = [
    'white',
    'rgb(244,242,239)',
    'rgb(220, 213, 229)',
    'rgb(185, 171, 204)',
    'rgb(149,129,178)',
    'rgb(114,87,153)',
    'rgb(79,45,127)',
  ];

  var scaling = 1;

  var width = scaling * 960,
    height = scaling * 635,
    centered,
    stateOutlines,
    titleElement;

  var svg = d3
    .select('svg.basemap-v2')
    .attr('width', width)
    .attr('height', height);

  var df = d3.map();

  var path = d3.geo.path().projection(null);

  var x = d3.scale
    .linear()
    .domain([0, 10])
    .rangeRound([scaling * 600, scaling * 860]);

  var color = d3.scale
    .threshold()
    .domain([0, 1, 2, 4, 6, 10])
    .range(colorScheme);

  svg
    .append('rect')
    .attr('class', 'background')
    .attr('width', width)
    .attr('height', height)
    .on('click', clicked);

  var g = svg
    .append('g')
    .attr('class', 'key')
    .attr('transform', 'translate(0, 15) scale(' + scaling + ')');

  // The title
  titleElement = svg
    .append('text')
    .attr('class', 'caption')
    .attr('dy', 13)
    .attr('x', 0)
    .attr('text-anchor', 'start')
    .style('user-select', 'none')
    .text(mapTitle);

  notesY = scaling * 610;
  svg
    .append('foreignObject')
    .attr('x', 0)
    .attr('y', notesY)
    .attr('width', width)
    .attr('height', height - notesY)
    .attr('class', 'fig-notes')
    .attr('text-anchor', 'start')
    .style('user-select', 'none')
    .text(mapNotes);

  var gAxis = g.append('g').attr('transform', 'translate(250,575) scale(0.5)');

  gAxis
    .selectAll('rect')
    .data(
      color.range().map(function(d) {
        d = color.invertExtent(d);
        if (d[0] == null) d[0] = x.domain()[0];
        if (d[1] == null) d[1] = x.domain()[1];
        return d;
      }),
    )
    .enter()
    .append('rect')
    .attr('height', 8)
    .attr('x', function(d) {
      return x(d[0]);
    })
    .attr('width', function(d) {
      if (d[1] == 10) {
        return x(d[1]) - x(d[0]);
      } else {
        return (x(d[1]) - x(d[0])) * 2;
      }
    })
    .attr('fill', function(d) {
      return color(d[0]);
    });

  gAxis
    .call(
      d3.svg
        .axis()
        .scale(x)
        .orient('bottom')
        .tickSize(10)
        .tickFormat(function(x, i) {
          if (x !== 10) {
            return i ? (i !== 4 ? x : x + '+') : x + '%';
          }
        })
        .tickValues(color.domain()),
    )
    .select('.domain')
    .remove();

  // Async loading of files
  queue()
    .defer(d3.json, 'https://d3js.org/us-10m.v1.json')
    .defer(d3.csv, datafile, function(d) {
      df.set(d.id, {
        value: +d.emp_tariff,
        state: d.state_name,
        county_state: d.county_state,
      });
    })
    .await(ready);

  function ready(error, us) {
    if (error) throw error;

    g
      .append('g')
      .attr('class', 'counties')
      .selectAll('path')
      .data(topojson.feature(us, us.objects.counties).features)
      .enter()
      .append('path')
      .attr('fill', function(d) {
        var dd = df.get(d.id);
        if (dd != null) {
          d.value = dd.value;
          d.state = dd.state;
          d.county_state = dd.county_state;
          return color(d.value);
        }
      })
      .attr('d', path)
      .style('stroke', 'white')
      .style('stroke-width', 0.25)
      .on('click', clicked)
      .append('title')
      .text(function(d) {
        return d.value == null
          ? 'N/A'
          : d.county_state + '\n' + d.value.toFixed(3) + '%';
      });

    stateOutlines = g
      .append('path')
      .datum(topojson.mesh(us, us.objects.states, (a, b) => a !== b))
      .attr('class', 'states')
      .attr('d', path)
      .style('stroke-width', 1);
  }

  function clicked(d) {
    var x, y, k;

    if (d && centered !== d) {
      var centroid = path.centroid(d);
      x = centroid[0];
      y = centroid[1];
      k = 4;
      centered = d;
    } else {
      x = width / 2;
      y = height / 2;
      k = 1;
      centered = null;
    }

    g.selectAll('path').classed(
      'active',
      centered &&
        function(d) {
          return d === centered;
        },
    );

    g
      .transition()
      .duration(750)
      .attr(
        'transform',
        'translate(' +
          width / 2 +
          ',' +
          height / 2 +
          ')scale(' +
          k +
          ')translate(' +
          -x +
          ',' +
          -y +
          ')',
      )
      .style('stroke-width', 1.5 / k + 'px');

    stateOutlines.selectAll('path').style('stroke-width', centered ? 2 : 1);

    console.log(d);

    titleElement.text(centered ? mapTitle + ' (' + d.state + ')' : mapTitle);
  }
};

window.onload = () => {
  mainBaseMap();
  DownstreamMap();
};

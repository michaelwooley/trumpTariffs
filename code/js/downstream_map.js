const DownstreamMap = () => {
  var mapTitle = 'Downstream Input Exposure to Steel and Aluminum Industries';
  var mapNotes = `Map plots the mean input exposure of each county. For details on how this is computed see the main text. See Data Appendix for further information on construction. Source: IPUMS/American Community Survey 2012-2016 5-Year Sample and 2007 BEA Detailed Input-Output Tables`;

  var datafile = '../data/int/county_emp_tariffs_data.csv';

  var downstreamOrder = [
      'tariff_exp_1',
      'tariff_exp_2',
      'tariff_exp_5',
      'tariff_exp_10',
      'tariff_exp_Infinite',
    ],
    downstreamName = ['Order 1', 'Order 2', 'Order 5', 'Order 10', 'Infinite'],
    downstreamIdx = 0,
    downstreamMaxIdx = 4,
    runAnimation = true;

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
    titleElement,
    subtitleElement;

  var svg = d3
    .select('svg.downstream-map')
    .attr('width', width)
    .attr('height', height);

  var df = d3.map();

  var path = d3.geo.path().projection(null);

  var x = d3.scale
    .linear()
    .domain([0, 0.008396, 0.010105, 0.013106, 0.017256, 0.022068, 0.086])
    .rangeRound([scaling * 600, scaling * 675]);

  var color = d3.scale
    .threshold()
    .domain([0, 0.008396, 0.010105, 0.013106, 0.017256, 0.022068, 0.086])
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
    .attr('transform', 'translate(0, 14) scale(' + scaling + ')');

  // The title
  titleElement = svg
    .append('text')
    .attr('class', 'caption')
    .attr('dy', 13)
    .attr('x', 0)
    .attr('text-anchor', 'start')
    .style('user-select', 'none')
    .text(mapTitle);

  subtitleElement = svg
    .append('text')
    .attr('class', 'subtitle')
    .attr('dy', 13)
    .attr('dx', 860)
    .attr('text-anchor', 'middle')
    .style('user-select', 'none')
    .text(downstreamName[downstreamIdx]);

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
      return 500 + x(d[0]) * 0.25;
    })
    .attr('width', function(d) {
      return (x(d[1]) - x(d[0])) * 0.25;
    })
    .attr('fill', function(d) {
      return color(d[0]);
    });

  gAxis
    .append('text')
    .attr('class', 'axis-tick')
    .attr('x', x(0.0015))
    .attr('dy', 25)
    .text('$0.00');
  gAxis
    .append('text')
    .attr('class', 'axis-tick')
    .attr('x', x(0.025))
    .attr('dy', 25)
    .text('$0.09');

  // Add link to pause animation
  gAxis
    .append('text')
    .attr('class', 'pause-button')
    .attr('x', scaling * x(0.0015))
    .attr('dy', -10)
    // .attr('dx', scaling * 2.5)
    // .attr('dy', scaling * 7)
    .on('click', () => {
      runAnimation = !runAnimation;
    })
    .text('Toggle Animation');

  // Async loading of files
  queue()
    .defer(d3.json, 'https://d3js.org/us-10m.v1.json')
    .defer(d3.csv, datafile, function(d) {
      let vv = downstreamOrder.map((oo) => +d[oo]);
      if (vv == null) {
        return null;
      }
      df.set(d.id, {
        values: vv,
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
      .attr('fill', (d) => {
        var dd = df.get(d.id);
        if (dd != null) {
          d.values = dd.values;
          d.state = dd.state;
          d.county_state = dd.county_state;
          return color(d.values[downstreamIdx]);
        }
      })
      .attr('d', path)
      .style('stroke', 'white')
      .style('stroke-width', 0.25)
      .on('click', clicked)
      .append('title')
      .text(function(d) {
        return d.values == null
          ? 'N/A'
          : d.county_state + '\n' + d.values[downstreamIdx].toFixed(3) + '%';
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

    titleElement.style('visibility', centered ? 'hidden' : 'visible');
  }

  setInterval(() => {
    if (runAnimation) {
      downstreamIdx =
        downstreamIdx === downstreamMaxIdx ? 0 : downstreamIdx + 1;

      g
        .selectAll('g.counties path')
        .transition()
        .attr('fill', (d) => {
          if (d.values) {
            return color(d.values[downstreamIdx]);
          }
        })
        .duration(500);

      g.selectAll('g.counties path title').text(function(d) {
        return d.values == null
          ? 'N/A'
          : d.county_state + '\n' + d.values[downstreamIdx].toFixed(3) + '%';
      });

      subtitleElement.text(downstreamName[downstreamIdx]);
    }
  }, 1000);
};

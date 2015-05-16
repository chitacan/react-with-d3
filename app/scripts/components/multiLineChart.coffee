React = require 'react'
d3    = require 'd3'

COLORS = ['#eaa54b', '#66a1e2', '#8065e4', '#48cc81']
DATA = [
  [11, 2, 13, 4, 24],
  [5, 4, 19, 10, 18],
  [9, 10, 4, 19, 30],
  [20, 21, 21, 9, 10]
]

M = 30
ANIM_DURATION = 750
ANIM_DELAY    = 300

MultiLineChart = React.createClass
  randomize : (data, min, max) ->
    data.map (d) -> d.map -> Math.floor Math.random() * (max - min) + min

  getInitialState: -> data: []

  componentDidMount: ->
    el = React.findDOMNode @
    oW = @props.width
    oH = @props.height

    W = oW - M - M
    H = oH - M - M

    svg = d3.select el
      .append 'svg'
      .attr 'width', oW
      .attr 'height', oH

    plot = svg.append 'g'
      .attr 'transform', "translate(#{M},#{M})"

    @xScale = d3.scale.linear()
      .range [0, W]
    @yScale = d3.scale.linear()
      .range [H, 0]

    @xAxis = d3.svg.axis()
      .orient 'bottom'

    @yAxis = d3.svg.axis()
      .orient 'left'
      .innerTickSize -W
      .outerTickSize 0
      .tickPadding 8

    @xTick = plot.append 'g'
      .attr 'transform', "translate(0,#{H})"
      .attr 'class', 'axis x'

    @yTick = plot.append 'g'
      .attr 'class', 'axis y'

    @line = d3.svg.line()
      .x (d, i) => @xScale i
      .y (d, i) => @yScale d

    @c = plot.append 'g'
    @setState { data:@randomize DATA, 0, 40 }
    @intervalID = setInterval =>
      @setState { data:@randomize DATA, 0, 40 }
    , 3000

  componentWillUnmount: -> clearInterval @intervalID

  componentDidUpdate: ->
    data = @state.data
    MAX_DATA_LEN = data.reduce (p, c) ->
      Math.max p, c.length
    , 0

    MAX_DATA_VAL = data.reduce (p, c) ->
      Math.max p, d3.max c
    , 0

    @xScale.domain [0, MAX_DATA_LEN - 1]
    @yScale.domain [0, MAX_DATA_VAL]

    @xAxis.scale @xScale
      .ticks MAX_DATA_LEN
    @yAxis.scale @yScale

    @xTick.transition().call @xAxis
    @yTick.transition().call @yAxis

    g = @c.selectAll 'g'
      .data data

    g.enter()
      .append 'g'
      .append 'path'
      .attr 'fill', 'none'
      .attr 'stroke', (d, i) -> COLORS[i]
      .attr 'd', (d) => @line d

    g.select 'path'
      .transition()
      .delay (d, i) -> i * ANIM_DELAY
      .attr 'd', (d) => @line d
      .duration ANIM_DURATION

    g.exit().remove()

    circle = g.selectAll 'circle'
      .data (d) -> d

    circle.enter()
      .append 'circle'
      .attr 'r', 3
      .attr 'cx', (d, i) => @xScale i
      .attr 'cy', (d, i) => @yScale d
      .attr 'fill', (d,i,j) -> COLORS[j]

    circle.transition()
      .delay (d, i, j) -> j * ANIM_DELAY
      .attr 'cx', (d, i) => @xScale i
      .attr 'cy', (d, i) => @yScale d
      .duration ANIM_DURATION

    circle.exit().remove()

  render: -> <div></div>

module.exports = MultiLineChart

React = require 'react'
d3    = require 'd3'

COLORS = ['#eaa54b', '#66a1e2', '#8065e4', '#48cc81']

ANIM_DURATION = 700
ANIM_DELAY    = 200

randomize = (min, max, len) ->
  len  = len || 4
  d3.range(len).map (d) -> Math.floor Math.random() * (max - min) + min

pathTriangle = (cx, cy, h, b) ->
  "#{cx},#{cy - h} #{cx - b},#{cy} #{cx + b},#{cy}"

xScale = d3.scale.linear()
yScale = d3.scale.linear()

style = marginBottom: '-1.5em'

Tri = React.createClass
  componentDidMount: ->
    el = React.findDOMNode @
    @W = @props.width
    @H = @props.height
    @svg = d3.select el
      .append 'svg'
      .attr 'width', @W
      .attr 'height', @H
    @canvas = @svg.append 'g'
    @renderTriangles randomize 5, 40
    @intervalID = setInterval =>
      @renderTriangles randomize 5, 40
    , 2000

  componentWillUnmount: ->
    clearInterval @intervalID
    # clean-up auto update

  renderTriangles: (data)->
    B = (@W / (data.length * 2)) + 5
    dataMax = d3.max data

    xScale.domain [0, data.length - 1]
      .range [0 + B, @W - B]
    yScale.domain [0, dataMax]
      .range [@H, 0]

    triangles = @canvas
      .selectAll 'polygon'
      .data data

    triangles
      .transition()
      .delay (d, i) -> i * ANIM_DELAY
      .duration ANIM_DURATION
      .attr 'points', (d, i) =>
        x = xScale i
        y = @H
        pathTriangle(x, y, @H - yScale(d), B)

    triangles.enter()
      .append 'polygon'
      .style 'fill', (d, i) -> COLORS[i % COLORS.length]
      .style 'fill-opacity', '0.9'
      .attr 'points', (d, i) =>
        x = xScale i
        y = @H
        pathTriangle(x, y, 0, B)
      .transition()
      .delay (d, i) -> i * ANIM_DELAY
      .duration ANIM_DURATION
      .attr 'points', (d, i) =>
        x = xScale i
        y = @H
        pathTriangle(x, y, @H - yScale(d), B)

    triangles.exit().remove()

  render: -> <div className='triangles center' style={style} />

Tri.ID = 'triangles-intro'

module.exports = Tri

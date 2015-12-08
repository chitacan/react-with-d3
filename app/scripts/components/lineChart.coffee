React = require 'react'
d3    = require 'd3'

X_RANGE= [0..30]

LineChart = React.createClass
  displayName: 'LineChart'

  getInitialState: ->
    data = []
    for i in X_RANGE
      data.push Math.random() * (10 + i)
    { data }

  componentDidMount: ->
    setTimeout =>
      return unless @isMounted()
      path = React.findDOMNode(@).querySelector 'path'
      path.style.strokeDashoffset = '0'
    , 500
    @scaler = document.querySelector('.remark-slide-scaler').style.WebkitTransform
    self = @
    d3.select React.findDOMNode @refs.svg
      .on 'mousemove', -> self.handleMouseMove d3.mouse @

  handleMouseMove: (point)->
    x = @x.invert point[0] / @getScaleFactor()
    i = d3.bisect X_RANGE, x
    d0 = X_RANGE[i - 1]
    d1 = X_RANGE[i]
    @setState point: if i - d0 > d1 - i then d1 else d0


  # TODO : this only support in webkit based browser :(
  getScaleFactor: ->
    try
      new WebKitCSSMatrix(@scaler).a
    catch error
      return 1

  render: ->
    { width, height, highlight } = this.props

    xMin = 0
    xMax = width
    yMin = height
    yMax = 0
    @x = d3.scale.linear().domain([0, 30]).range [xMin, xMax]
    @y = d3.scale.linear().domain(d3.extent @state.data ).range [yMin, yMax]

    line = d3.svg.line()
      .interpolate('monotone')
      .x (d, i) => @x(i)
      .y (d)    => @y(d)

    # see http://jakearchibald.com/2013/animated-line-drawing-svg/ about this animation
    pathStyle =
      strokeDasharray: '4000'
      strokeDashoffset: '4000'
      transition: 'stroke-dashoffset 4s linear'
      stroke:'#66a1e2'
      strokeWidth: '4px'
      fill: 'none'
    circleStyle =
      fill: '#e765c3'

    if @state.point? and highlight
      p = @state.point
      circle = <circle cx={@x(p)} cy={@y(@state.data[p])} r={6} style={circleStyle}/>
    <div className='center'>
      <svg ref='svg' width={width} height={height}>
        <path d={line(@state.data)} style={pathStyle} />
        {circle}
      </svg>
    </div>

module.exports = LineChart

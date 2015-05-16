React = require 'react'

module.exports = React.createClass
  render: ->
    axis = this.props.axis
    other           = if this.props.axis is 'x' then 'y' else 'x'
    tickOffsetAxis  = if this.props.axis is 'x' then 0 else 5
    tickOffsetOther = if this.props.axis is 'x' then 24 else -16
    tickLength = if this.props.axis is 'x' then 8 else -8
    scale = this.props.scale
    displayScale = this.props.displayScale || d3.scale.identity()
    tickFormatter = this.props.tickFormatter || d3.scale.identity()
    [min, max] = scale.domain()
    axisLineProps =
      stroke: '#747474'
      strokeWidth: 2

    axisLineProps[axis + '1'] = scale(min) + this.props[axis]
    axisLineProps[axis + '2'] = scale(max) + this.props[axis]
    axisLineProps[other + '1'] = this.props[other]
    axisLineProps[other + '2'] = this.props[other]
    axisLine = React.DOM.line(axisLineProps)

    <g>
      {axisLine}
      {displayScale.ticks(6).map (tick, idx)=>
        lineProps =
          stroke: '#747474'
          strokeWidth: 2

        lineProps[axis + '1'] = scale(displayScale(tick)) + this.props[axis]
        lineProps[axis + '2'] = scale(displayScale(tick)) + this.props[axis]
        lineProps[other + '1'] = this.props[other];
        lineProps[other + '2'] = this.props[other] + tickLength
        line = React.DOM.line(lineProps)
        labelProps =
          fill: '#747474'
          textAnchor: if axis is 'x' then 'middle' else 'end'
        labelProps[axis] = scale(displayScale(tick)) + this.props[axis] + tickOffsetAxis
        labelProps[other] = this.props[other] + tickOffsetOther
        label = React.DOM.text labelProps, tickFormatter(tick)
        <g key={idx}>
          {line}
          {label}
        </g>
      }
    </g>

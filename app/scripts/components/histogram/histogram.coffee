React = require 'react'

Axis = require './axis.coffee'
Bars = require './bars.coffee'
d3   = require 'd3'
M    = require 'moment'

histogram= React.createClass
  render: ->
    data = this.props.data
    values = data.getValues()
    width  = 630
    height = Math.floor width / 2

    if data.domain[0] is 0
      return <div>no data</div>

    scales =
      x: d3.scale.linear().domain([0, data.getDay()]).range([0, width - 10])
      y: d3.scale.linear().domain([0, d3.max values]).range([0, height])

    <div className='histogram'>
      <svg width={width + 100} height={height + 100}>
        <g style={{transform: 'translate(50px,10px)'}}>
          <Axis
            axis='x'
            scale={scales.x}
            displayScale={
              d3.time.scale.utc()
                .domain([ new Date(data.domain[0]), new Date(data.domain[1]) ])
                .range([ 0, data.getDay() ])
            }
            tickFormatter={
              (date) -> M(date).format('YY MMM')
            }
            x={0}
            y={height + 1}
          />
          <Axis
            axis='y'
            scale={scales.y}
            displayScale={
              d3.scale
                .linear()
                .domain([ d3.max(values), 0])
                .range([0, d3.max(values) ])
            }
            tickFormatter={
              (t) -> t.toLocaleString()
            }
            x={0}
            y={0}
          />
          <Bars
            data={data}
            width={width}
            height={height}
            scales={scales}
          />
        </g>
      </svg>
    </div>


module.exports = histogram

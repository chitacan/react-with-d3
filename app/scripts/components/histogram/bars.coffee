React = require 'react'

translate = (x, y) -> "translate(#{x}px,#{y}px)"
toArray = (typed) ->
  arr = new Array typed.length
  arr[i] = typed[i] for d, i in typed

module.exports = React.createClass
  render: ->
    data = this.props.data
    values = toArray data.getValues()
    <g>
      {values.map (value, idx) =>
        click = null
        scaleWidth = (this.props.width/(data.getDay())) + 0.5
        <rect
          fill='#48cc81'
          key={idx}
          x={0}
          y={0}
          width={1}
          height={1}
          style={{
            transition: '0.5s'
            cursor: if click is null then 'auto' else 'pointer'
            transform: translate(this.props.scales.x(idx), this.props.height - this.props.scales.y(value)) + ' scaleY(' + this.props.scales.y(value) + ')' + ' scaleX(' + scaleWidth + ')'
          }}
          onClick={click}
        />
      }
    </g>

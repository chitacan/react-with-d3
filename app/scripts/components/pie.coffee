React = require 'react'

M =
  top   : 15
  right : 15
  bottom: 10
  left  : 15

oH = 250
COLORS = ['#eaa54b', '#66a1e2', '#8065e4', '#48cc81']

Pie = React.createClass

  displayName: 'userCategory'

  getDefaultProps: ->
    users: [
      { type: 'b', data: 1 },
      { type: 'a', data: 9 },
      { type: 'c', data: 1 },
      { type: 'a', data: 1 },
      { type: 'a', data: 1 },
      { type: 'd', data: 7 },
      { type: 'd', data: 1 },
      { type: 'b', data: 1 },
      { type: 'a', data: 1 },
      { type: 'd', data: 3 },
    ]

  componentDidMount: ->
    @el = React.findDOMNode @

    @H = oH - M.top - M.bottom

    @svg = d3.select @el
      .select '.chart'
      .append 'svg'
        .attr width: 0, height: 0

    @container = @svg.append 'g'
      .attr 'transform', "translate(#{M.left}, #{M.top})"

    @pie = @container.append 'g'

    @desc = @container.append 'g'
      .attr 'transform', "translate(0, 5)"

    @desc.append 'text'
      .attr
        'class'         : 'desc'
        'text-anchor'   : 'end'
        'pointer-events': 'none'
        'stroke-width'  : 3
        'stroke'        : '#474747'
      .style 'font-size': '80%'

    @desc.append 'text'
      .attr
        'class'         :'desc'
        'text-anchor'   :'end'
        'pointer-events':'none'
      .style 'font-size': '80%', 'fill': '#aaa'

    @layout = d3.layout.pie()
      .value (d) -> d.values
    @arc = d3.svg.arc()

    setTimeout () =>
      @forceUpdate()
    , 0

  componentDidUpdate: ->
    @oW = @el.clientWidth / 2
    @W  = @oW - M.left - M.right

    groupByType = d3.nest()
      .key (user) -> user.type
      .rollup (values) -> values.length
      .sortKeys d3.ascending
      .entries @props.users

    @svg.attr width: @oW, height: oH

    @arc.innerRadius 0
      .outerRadius @H / 2

    pie = @pie.selectAll 'g'
      .data @layout groupByType

    enter = pie.enter()
      .append 'g'
      .attr 'transform', "translate(#{@W / 2}, #{@H / 2})"

    enter.append 'path'
      .attr 'fill', (d, i) -> COLORS[i]
      .attr 'd', @arc
      .on 'mouseover', @_handleMouseOver
      .on 'mouseout', @_handleMouseOut

    pie.attr 'transform', "translate(#{@W / 2}, #{@H / 2})"

    pie.select 'path'
      .attr 'fill', (d, i) -> COLORS[i]
      .attr 'd', @arc

    @desc.selectAll 'text'
      .attr 'x', @oW - M.left

    @_updateLegend @props.users.length, groupByType

  _updateLegend: (total, groupByType) ->
    ul = d3.select @el
      .select 'ul'

    div = ul.selectAll 'div'
      .data groupByType

    enter = div.enter()
      .append 'div'
      .style 'display', 'inline'

    enter.append 'li'
      .append 'span'
      .attr 'class', 'box'
      .style 'background', (d, i) -> COLORS[i]

    enter.append 'li'
      .style 'font-size', '75%'
      .text (d) -> "#{d.key} #{Math.ceil 100 * d.values / total}%"

    div.select '.box'
      .style 'background', (d, i) -> COLORS[i]

    div.select 'li:nth-child(2)'
      .text (d) -> "#{d.key} #{Math.ceil 100 * d.values / total}%"

    div.exit().remove()

  _handleMouseOver: (d) ->
    @desc.selectAll 'text'
      .text "#{d.data.key} : #{d.data.values} 명"

  _handleMouseOut: (d) ->
    @desc.selectAll 'text'
      .text ""

  render: ->
    <div style={marginBottom: 15}>
      <div className="clearfix">
        <div className="legend">
          <ul>
          </ul>
        </div>
      </div>
      <div className="chart" style={overflow: 'hidden'} />
    </div>

Pie.ID = 'pie-demo'

module.exports = Pie

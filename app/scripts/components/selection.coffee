# selection demo

React = require 'react'
d3    = require 'd3'

COLORS = ['#eaa54b', '#66a1e2', '#8065e4', '#48cc81']
DATA   = d3.range 4
RECT   = 45
LIMIT  = 10

random = (max) -> Math.floor Math.random() * (max - 1) + 1

getArrayItemText = (data, d, i) ->
    if i is 0 and data.length is 1
      "[ #{d} ]"
    else if i is 0
      "[ #{d} ,"
    else if i is data.length - 1
      "#{d} ]"
    else
      "#{d} ,"


Selection = React.createClass
  componentDidMount: ->
    el = React.findDOMNode @
    w  = @props.width
    h  = @props.height
    svg = d3.select el
        .select '#selection_demo'
        .append 'svg'
        .attr
          width : w
          height: h
        .append('g')
        .attr
          id : (d)-> d
          transform: 'translate(10,0)'

    g = svg.append 'g'
    g.selectAll 'rect'
      .data DATA
      .enter()
      .append 'rect'
      .attr
        width : RECT
        height: RECT
        x : (d, i) -> i * (RECT + 1)
        y : 50
        fill: '#747474'

    original = svg.append 'g'
    updated  = svg.append 'g'

    renderOriginal = (data)->
      sel = original.selectAll 'text'
        .data data

      sel.text (d, i) -> getArrayItemText data, d, i

      sel.enter()
        .append 'text'
        .text (d, i) -> getArrayItemText data, d, i
        .attr 'text-anchor', 'middle'
        .attr 'font-size', '0.8em'
        .attr 'x', (d, i) -> (i * (RECT + 1)) + 25
        .attr 'y', 20
        .attr 'fill', 'white'

      sel.exit().remove()

    renderUpdated = (data, color)->
      sel = updated.selectAll 'text'
        .data data

      sel.attr 'fill', color
        .text (d, i) -> getArrayItemText data, d, i

      sel.enter()
        .append 'text'
        .text (d, i) -> getArrayItemText data, d, i
        .attr 'text-anchor', 'middle'
        .attr 'font-size', '0.8em'
        .attr 'x', (d, i) -> (i * (RECT + 1)) + 25
        .attr 'y', 42
        .attr 'fill', color

      sel.exit().remove()

    renderOriginal(DATA)

    d3.select(el).select('#enter').on 'click', ->
      ran = random 4
      return if DATA.length + ran > LIMIT

      renderOriginal(DATA)
      DATA = d3.range DATA.length + ran
      renderUpdated(DATA, '#48cc81')
      g.selectAll 'rect'
        .attr 'fill', '#747474'
        .data DATA
        .enter()
        .append 'rect'
        .attr
          width : RECT
          height: RECT
          x : (d, i) -> i * (RECT + 1)
          y : 50
          fill: '#48cc81'
        .transition().duration 750
        .attr 'fill', '#48cc81'

    d3.select(el).select('#update').on 'click', ->
      renderOriginal(DATA)
      ran = random 4
      data = d3.range ran
      renderUpdated(data, '#66a1e2')
      g.selectAll 'rect'
        .attr 'fill', '#747474'
        .data data
        .transition().duration 350
        .attr 'fill': '#66a1e2'

    d3.select(el).select('#exit').on 'click', ->
      renderOriginal(DATA)
      ran = random 4
      DATA = d3.range DATA.length - ran
      renderUpdated(DATA, '#eaa54b')
      sel = g.selectAll 'rect'
        .attr 'fill', '#747474'
        .data DATA
        .exit()
      sel.transition().duration 350
        .attr 'fill': '#eaa54b'

      setTimeout ->
        sel.transition()
          .duration 350
          .style 'fill-opacity', 0
          .each 'end', -> @remove()
      , 3000

  render: ->
    <div>
      <div id="selection_demo"></div>
      <button id="enter" style={{marginLeft:'20px'}}>enter</button>
      <button id="update" style={{margin:'0px 10px'}}>udpate</button>
      <button id="exit">exit</button>
    </div>

Selection.ID = 'selection-demo'
module.exports = Selection

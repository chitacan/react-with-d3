React = require 'react'
Histogram = require './histogram.coffee'
M = require 'moment'

random = (day, max)->
  n    = Date.now()
  date = [n, M(n).add(day, 'days').valueOf()]
  data = new Uint8Array(1000)
  data[i] = Math.round Math.random() * max for d, i in data

  domain   : date
  getDay   : -> day
  getValues: -> data
  addValues: (_day) ->
    return if data.length < _day + day
    date[1] = M(date[1]).add(_day,'days').valueOf()
    data[i] = Math.round Math.random() * max for i in [day.._day+day]
    day += _day

Chart = React.createClass
  getInitialState: ->
    histogram: random(31, 255)

  componentDidMount: ->
    @setState histogram: random(31, 255)
    @intervalID = setInterval =>
      @state.histogram.addValues(31)
      @setState histogram: @state.histogram
    , 4000

  componentWillUnmount: ->
    clearInterval @intervalID

  render: ->
    <div style={{overflow:'hidden'}}>
      <Histogram data= { @state.histogram } />
    </div>

Chart.ID = 'histogram-demo'

module.exports = Chart

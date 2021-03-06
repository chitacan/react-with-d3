React = require 'react'

window.React = React

Triangles = require './components/triangles.coffee'
Selection = require './components/selection.coffee'
Histogram = require './components/histogram/chart.coffee'
LineChart = require './components/lineChart.coffee'
MultiLine = require './components/multiLineChart.coffee'
Pie       = require './components/pie.coffee'

remark.macros.scale =  (percentage)->
  '<img src="' + @ + '" style="width: ' + percentage + '" />';

slides = remark.create
  navigation:
    scroll : false
  sourceUrl         : 'slide.md'
  highlightStyle    : 'monokai'
  highlightLanguage : 'remark'

getEl = document.getElementById.bind document

slides.on 'beforeShowSlide', (slide)->
  switch slide.getSlideIndex()
    when 0
      React.render <Triangles width={300} height={100}/>,
      getEl Triangles.ID
    when 21
      React.render <Triangles width={400} height={200}/>,
      getEl 'triangles-demo'
    when 24
      React.render <MultiLine width={500} height={300}/>,
      getEl 'multiline-demo'
    when 29
      React.render <Pie/>,
      getEl Pie.ID
    when 31
      React.render <LineChart width={500} height={300} highlight={false}/>,
      getEl 'line-demo-1'
    when 33
      React.render <Histogram />,
      getEl Histogram.ID
    when 35
      React.render <LineChart width={500} height={300} highlight={true} />,
      getEl 'line-demo-2'

slides.on 'hideSlide', (slide)->
  switch slide.getSlideIndex()
    when 0  then React.unmountComponentAtNode getEl Triangles.ID
    when 21 then React.unmountComponentAtNode getEl 'triangles-demo'
    when 24 then React.unmountComponentAtNode getEl 'multiline-demo'
    when 29 then React.unmountComponentAtNode getEl Pie.ID
    when 31 then React.unmountComponentAtNode getEl 'line-demo-1'
    when 33 then React.unmountComponentAtNode getEl Histogram.ID
    when 35 then React.unmountComponentAtNode getEl 'line-demo-2'

React.render <Triangles width={300} height={100}/>, getEl Triangles.ID
React.render <Selection width={500} height={100}/>, getEl Selection.ID

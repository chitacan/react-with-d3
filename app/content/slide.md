class: center, middle

<div id="triangles-intro"></div>

# 리액트와 디3
.degrade[디아블로3 아님 😅]
.footnote.pull-right[🍴  on [github](https://github.com/chitacan/react-with-d3)]

---
.left-column[
  ## # About Me
]

.right-column[
* Software Engineer @Riiid
* [https://github.com/chitacan](https://github.com/chitacan)
* Developing back office & Dashboard
* [D3.js](http://d3js.org/), [React](http://facebook.github.io/react/), [RxJs](https://github.com/Reactive-Extensions/RxJS/)
]

---
.left-column[
  ## # About Me
  ## # Subject
]

.right-column[
* `React` 와 `D3` 를 조합하게된 배경
* 초간단 소개 & 공통점
* `React` 와 `D3` 를 조합하는 2가지 방법
* Riiid 는 어떻게 쓰나요?
]

---
.left-column[
  ## # 시작
]

.right-column[
[`renote`](https://play.google.com/store/apps/details?id=co.riiid.renote) 의 시각화

* 내가 제품을 어떻게 사용하고 있는지 시각적으로 확인할 수 있도록
* 7일안에 `iOS`, `Android` 동시에 😱
* `D3` 를 활용해 차트를 만들고 `html` 파일과 묶어 `webview` 에서 로드
* `D3`, `coffeescript`, `browserify`, `webview` 사용

![:scale 40%](img/screenshot.png)
]

---
.left-column[
  ## # 시작
  ## # 고민
]

.right-column[
하지만,

* 차트의 갯수가 늘어나고, 지원하는 플랫폼이 늘어나도
* 빠르게 차트를 추가하고, 관리할 수 있을까?

<br/>
<br/>
![:scale 90%](img/charts.png)
]

---
.left-column[
  ## # 발단
  ## # 고민
]

.right-column[
`D3` 만으로는 어렵지 않을까?

* `D3` 의 결과물은 CSS, DOM 에 의존성을 가지고 있음
* `D3` 코드를 재사용하기 위해서는 추가적인 작업이 필요함

]

---
.left-column[
  ## # 발단
  ## # 고민
  ## # 개발
]

.right-column[
[`renote`](https://play.google.com/store/apps/details?id=co.riiid.renote) 의 시각화 V2

* 차트를 `React` 컴포넌트로 변환
* amazon s3 의 static hosting 을 활용해 바이너리에 포함되지 않아도 동작할 수 있도록
* 전체 차트를 확인할 수 있는 대시보드
* `D3`, `React`, `coffeescript`, `browserify`, `webview`, `amazon s3` 사용

![:scale 40%](img/screenshot_v2.png)
]

---
class: center, middle

# 오호💡

.degrade[`D3` 로 만든 코드를 `React` 컴포넌트로 만들면,<br> 여러곳에서 활용하기 좋지 않을까?]

---
class: center, middle

# 리액트와 디3

.degrade[초간단 소개 & 공통점]

---
.left-column[
  ## # D3?
]

.right-column[
`Data Driven Document` == `DDD` == `D3`

* 데이터 시각화의 필수 라이브러리
* 데이터 fetching, 변환, DOM과 연결에 필요한 거의 모든 도구 제공
* [http://bl.ocks.org/mbostock](http://bl.ocks.org/mbostock)
]

---
.left-column[
  ## # D3?
  ## # 편견
]

.right-column[
`D3` 는

* 차트 만들때나 쓰는거 아님? 💀
* svg 만 다루는 라이브러리 아님? 💀

`D3` 는

* 데이터와 연결된 `DOM` 을 만들기 위한 라이브러리
* `데이터` 와 `DOM` 을 연결하는 다양한 도구(selection, scale, dynamic properties)를 제공
]

---
.left-column[
  ## # D3?
  ## # 편견
  ## # Selection
]

.right-column[
`데이터` 와 `DOM` 의 연결을 도와주는 `D3` 의 핵심 도구

* `D3` 로 놀기 위해서는 반드시 이해해야 하는 도구지만
* `D3` 를 시작하는 사람들에겐 가장 어려운 부분 😭
* enter, update, exit 패턴

```javascript
selection = d3.selectAll('rect')
  .data([1,2,3,4,5,6]);

// enter
selection.enter().append('rect')
  .x((d, i) => i)
  .attr('height', d => d);

// update
selection.x((d, i) => i)
  .attr('height', d => d)

// exit
selection.exit().remove()
```
]

---
.left-column[
  ## # D3?
  ## # 편견
  ## # Selection
]

.right-column[
<div id="selection-demo"></div>
]

.right-column[
* 추가되는 배열의 아이템 선택 👉 enter
* 삭제되는 배열의 아이템 선택 👉 exit
* 변경된 배열의 아이템 선택 👉 update

```javascript
selection = d3.selectAll('rect')
  .data([1,2,3,4,5,6]);

// enter
selection.enter().append('rect')
  .x((d, i) => i)
  .attr('height', d => d);

// update
selection.x((d, i) => i)
  .attr('height', d => d)

// exit
selection.exit().remove()
```
]

---
.left-column[
  ## # D3?
  ## # 편견
  ## # Selection
]

.right-column[
전달된 데이터만 같다면, `Selection` 을 여러번 수행해도 결과는 항상 같습니다. 즉 항상 같은 `DOM` 을 보여줍니다.

```javascript
d3(data_1) = dom_1
d3(data_2) = dom_2
// later ...
d3(data_1) = dom_1
```
]

---
.left-column[
  ## # React?
]

.right-column[
facebook에서 공개한 UI 전용 라이브러리.
UI 를 작은 컴포넌트로 나누어 개발하고, 이를 조합해서 전체 UI 를 구성

```javascript
// Title.jsx
React.createClass({
  render() {
    return <h1>{this.props.foo}</h1>;
  }
});

// Root.jsx
import Title from './Title.jsx';
import List from './List.jsx';

React.createClass({
  render() {
    return (
    <div>
      <Title foo="hello" />
      <List bar={this.state.list} />
    </div>
    );
  }
});
```
]

---
.left-column[
  ## # React?
  ## # 시작하기
]

.right-column[
`props`, `state`, `render` 이해하기

* `props` : 부모 컴포넌트로 부터 전달된 값 (변경불가)
* `state` : 컴포넌트가 가지는 상태
* `render` : `props` 와 `state` 를 조합해 컴포넌트가 표시할 뷰를 만들어내는 부분

```javascript
function componentName(props) {
  var state = {};
  // mix up with props & state
  return <div attr={this.state.foo}>{this.props.bar}</div>;
}
```
]

---
.left-column[
  ## # React?
  ## # 시작하기
  ## # 공통점
]

.right-column[
전달된 `props` 가 같고, `state` 가 동일하면 `render` 의 리턴값은 항상 동일.
즉, 컴포넌트가 같은 화면을 그린다.

```javascript
ReactComponent(props_1) = dom_1
ReactComponent(props_2) = dom_2
// later ...
ReactComponent(props_1) = dom_1
```

어? 그럼 `D3` 랑 합성하는게 가능하지 않을까요?

```javascript
d3(ReactComponent(props_1)) = dom_1
d3(ReactComponent(props_2)) = dom_2
```
]

---
.left-column[
  ## # React?
  ## # 시작하기
  ## # 공통점
]

.right-column[
`React` 와 `D3` 는 동일한 인자가 주어지면 동일한 DOM 을 보여주는 함수라는 점에서 상당히 유사한 부분이 있으며, 이를 이용해 두 라이브러리를 함께 사용하는 것이 가능합니다.

```javascript
d3(data) = dom
ReactComponent(props) = dom

d3(ReactComponent(props)) = dom
```
]

---
class: center, middle

# 섞어 봅시다.

---
.left-column[
  ## # mix
]

.right-column[
`React` 와 `D3` 를 조합하는 방법은 크가 2가지가 있습니다.

* `D3` 의 enter, update, exit 패턴을 활용하고, `React` 는 컴포넌트의 라이프 사이클만 담당 (`d3(react())`)
* `D3` 의 데이터 변환, scale 등의 유틸리티만 활용하고, `React` 가 렌더링을 담당 (`d3 << react`)
]

---
.left-column[
  ## # mix
  ## # d3(react())
]

.right-column[
별다른 고민없이 `componentDidMount` 에 모든 `D3` 코드를 다 때려 넣어도 됩니다 👻

```javascript
  componentDidMount() {
*   let el = this.findDOMNode(this);
    this.W = this.props.width;
    this.H = this.props.height;
*   this.svg = d3.select(el).append('svg')
      .attr('width',  this.W)
      .attr('height', this.H);
    this.plot= this.svg.append('g');
    this.renderTriangles randomize(5, 40);
    this.intervalID = setInterval(() => {
      this.renderTriangles(randomize(5, 40));
    }, 2000);
  }

  renderTriangles(data) {
    // update, enter, exit
  }

  render() {
    return <div className='triangles' style={style} />;
  }
```
]

---
.left-column[
  ## # mix
  ## # d3(react())
]

.right-column[
별다른 고민없이 `componentDidMount` 에 모든 `D3` 코드를 다 때려 넣어도 됩니다 👻

<div id="triangles-demo" style="margin-top: 3em;"></div>
]

---
.left-column[
  ## # mix
  ## # d3(react())
]

.right-column[
하지만 `props` 업데이트나 `state` 변경에 대응하기 위해서는 `componentDidUpdate` 에 코드를 나누어 작성하는 것이 좋습니다.

* `componentDidMount` : DOM element 와 scale, layout 인스턴스 생성
* `componentDidUpdate` : size 조절, scale 재설정 & enter, update, exit
* `shouldComponentUpdate` : `componentDidUpdate` 호출여부 결정
]

---
.left-column[
  ## # mix
  ## # d3(react())
]

.right-column[
하지만 `props` 업데이트나 `state` 변경에 대응하기 위해서는 `componentDidUpdate` 에 코드를 나누어 작성하는 것이 좋습니다.

```javascript
componentDidMount() {
  let el = React.findDOMNode(this);
  let oW = this.props.width;
  let oH = this.props.height;
  let W  = oW - M - M;
  let H  = oH - M - M;
  let svg = d3.select(el).append('svg')
    .attr('width', oW)
    .attr('height', oH);

  this.plot = svg.append('g')
    .attr('transform', 'translate(' + M + ', ' + M + ')');
},

componentDidUpdate() {
  let data = this.props.data;
  let g = this.plot.selectAll('g');
  g.enter()
    .append('g')
    .append('path')
    .attr('fill', 'none')
    .attr('stroke', (d, i) => COLORS[i])
    .attr('d', (d) => this.line(d));
  g.select('path')
    .transition()
    .delay((d, i) -> i * ANIM_DELAY)
    .attr('d', (d) => this.line(d))
    .duration(ANIM_DURATION);
  g.exit().remove();
},

render() {
  return <div></div>;
}
```
]

---
.left-column[
  ## # mix
  ## # d3(react())
]

.right-column[
하지만 `props` 업데이트나 `state` 변경에 대응하기 위해서는 `componentDidUpdate` 에 코드를 나누어 작성하는 것이 좋습니다.

<div id="multiline-demo" style="margin-top: 3em;"></div>
]

---
.left-column[
  ## # mix
  ## # d3(react())
]

.right-column[
스크린 사이즈에 따라 크기가 변하는 컴포넌트를 만들고 싶다면, `componentDidMount` 코드의 마지막에 `forceUpdate()` 를 호출하는 것도 고려해 볼만합니다.

> componentDidMount 가 호출되는 시점에 컴포넌트의 사이즈가 0 일 수도 있음

```javascript
componentDidMount() {
  let el = React.findDOMNode(this);
  let oW = this.props.width;
  let oH = this.props.height;
  let W  = oW - M - M;
  let H  = oH - M - M;
  let svg = d3.select(el).append('svg')
    .attr('width', oW)
    .attr('height', oH);

  this.plot = svg.append('g')
    .attr('transform', 'translate(' + M + ', ' + M + ')');

* this.forceUpdate();
}
```
]

---
.left-column[
  ## # mix
  ## # d3(react())
]

.right-column[
컴포넌트의 모든 요소를 `D3` 로 렌더링 하는 것을 추천 (특히 legend)

`React` 만으로 legend 를 그리기 위해서는 `state` 를 통해 데이터를 `render` 함수로 전달해야 하는데, `componentDidUpdate` 에서는 불가능하고,
```javascript
componentDidUpdate() {

  // enter(), udpate(), exit() ...

  let groupByType = d3.nest()
  .key(d => d.type)
  .rollup(values => values.length)
  .entries(this.props.users);

  // may cause Maximum call stack size exceeded exception !!
  this.setState({legend: groupByType});
},
```

> 그래도 이렇게 구현하고 싶다면, 부모 컴포넌트에서 groupByType으로 정리해서 넘겨줘도 됩니다.
]

---
.left-column[
  ## # mix
  ## # d3(react())
]

.right-column[
`render` 함수에서 데이터를 정리하면, `render` 함수에서 불필요한 함수 호출이 증가할 수 있습니다.

```javascript
render () {
  // this will call every render()
  let groupByType= d3.nest()
  .key(d => d.type)
  .rollup(values => values.length)
  .entries(this.props.users);

  return (
    <div>
      <ul>
      { this.props.groupByType.map(value => <Legend data={value}/>) }
      </ul>
    </div>
  );
},
```
]

---
.left-column[
  ## # mix
  ## # d3(react())
]

.right-column[
컴포넌트의 모든 요소를 `D3` 로 렌더링 하면, `render` 에서 매번 데이터를 정리하거나, 따로 `props` 로 넘겨주지 않고, `componentDidUpdate` 에서 한번에 처리할 수 있습니다. 🙋

```javascript
componentDidUpdate() {
  this.updateLegend();
},

updateLegend() {
  let groupByType= d3.nest()
  .key(d => d.type)
  .rollup(values => values.length)
  .entries(this.props.users);

  let ul = d3.select(this.el).select('ul');

  let div = ul.selectAll('div')
    .data(groupByType);

  let enter = div.enter()
    .append('div');

  enter.append('li');
    .append('span');
    .attr('class', 'box')
    .style('background', (d, i) => COLOR[i]);

  enter.append('li').text((d) => d.key);

  div.select('.box')
    .style('background', (d, i) => COLOR[i]);

  div.exit().remove()
}
```
]

---
.left-column[
  ## # mix
  ## # d3(react())
]

.right-column[
컴포넌트의 모든 요소를 `D3` 로 렌더링 하면, `render` 에서 매번 데이터를 정리하거나, 따로 `props` 로 넘겨주지 않고, `componentDidUpdate` 에서 한번에 처리할 수 있습니다. 🙋

<div id="pie-demo" style="margin-top: 3em;"></div>
]

---
.left-column[
  ## # mix
  ## # d3(react())
  ## # d3 << react
]

.right-column[
`React`는 `html` 엘리먼트 뿐만 아니라 `svg` 앨리먼트도 지원하기때문에,  렌더링을 모두 `React`에 맡기는 것도 가능합니다.

https://facebook.github.io/react/docs/tags-and-attributes.html#svg-elements

```javascript
render() {
  let x = d3.scale.linear()
    .domain(d3.extent(this.state.data))
    .range([xMin, xMax]);
  let y = d3.scale.linear()
    .domain(d3.extent(this.state.data))
    .range([yMin, yMax]);

  // create line
  let line = d3.svg.line()
    .interpolate('monotone')
    .x((d, i) => x(i))
    .y((d) => y(d))

  return (
  <div>
*   <svg ref='svg' width={width} height={height}>
*     <path d={line(this.state.data)} />
    </svg>
  </div>
  );
}
```

]

---
.left-column[
  ## # mix
  ## # d3(react())
  ## # d3 << react
]

.right-column[
`React`는 `html` 엘리먼트 뿐만 아니라 `svg` 앨리먼트도 지원하기때문에,  렌더링을 모두 `React`에 맡기는 것도 가능합니다.

https://facebook.github.io/react/docs/tags-and-attributes.html#svg-elements

<div id="line-demo-1"></div>
]

---
.left-column[
  ## # mix
  ## # d3(react())
  ## # d3 << react
]

.right-column[
심지어 `D3` 로 그릴 차트의 구성요소를 컴포넌트로 나누어 조합하는 것도 가능합니다.
> from [github](https://github.com/znation/scalable-data-visualization), [youtube](https://www.youtube.com/watch?v=2ii1lEkIv1s&index=15&list=PLb0IAmt7-GS1cbw4qonlQztYV1TAW0sCr)

`D3` 만으로 구현하는 것보다 성능상의 이점이 있을까?

```javascript
render() {
  let data = this.props.data;
  let values = toArray(data.getValues());
  return(
  <g>
    {values.map((value, idx) => {
      scaleWidth = (this.props.width/(data.getDay())) + 0.5;
      <rect
        fill='#48cc81'
        key={idx}
        x={0}
        y={0}
        width={1}
        height={1}
        style={{
          transition: '0.5s',
        }}
      />
      })
    }
  </g>
  );
}
```
]

---
.left-column[
  ## # mix
  ## # d3(react())
  ## # d3 << react
]

.right-column[
심지어 `D3` 로 그릴 차트의 구성요소를 컴포넌트로 나누어 조합하는 것도 가능합니다.

> from [github](https://github.com/znation/scalable-data-visualization), [youtube](https://www.youtube.com/watch?v=2ii1lEkIv1s&index=15&list=PLb0IAmt7-GS1cbw4qonlQztYV1TAW0sCr)

`D3` 만으로 구현하는 것보다 성능상의 이점이 있을까?

<div id="histogram-demo"></div>
]

---
.left-column[
  ## # mix
  ## # d3(react())
  ## # d3 << react
]

.right-column[
이벤트 처리결과를 DOM에 반영하기 위해서 매번 `setState` 를 호출해야 합니다.

```javascript
componentDidMount() {
  d3.select(React.findDOMNode(this.refs.svg))
    .on('mousemove', () => {
      this.handleMouseMove(d3.mouse(this));
    }
},

handleMouseMove(point) {
  let x = this.x.invert(point[0] / this.getScaleFactor());
  let i = d3.bisect(X_RANGE, this.x);
  let d0 = X_RANGE[i - 1];
  let d1 = X_RANGE[i];
  let p = i - d0 > d1 ? d1 : d0;
* this.setState({point: p});
}

render() {
  this.x = d3.scale.linear()
    .domain([0, 30])
    .range([xMin, xMax]);
  this.y = d3.scale.linear()
    .domain(d3.extent(this.state.data))
    .range([yMin, yMax]);

  let circle;
  if (this.state.point && highlight) {
    let p = this.state.point;
    circle = <circle cx={this.x(p)}
                     cy={this.y(this.state.data[p])}
                     r={6}
                     style={circleStyle}/>
  }
  return
  <div className='center'>
    <svg ref='svg' width={width} height={height}>
      <path d={line(this.state.data)} style={pathStyle} />
      {circle}
    </svg>
  </div>
}
```
]

---
.left-column[
  ## # mix
  ## # d3(react())
  ## # d3 << react
]

.right-column[
이벤트 처리결과를 DOM에 반영하기 위해서 매번 `setState` 를 호출해야 합니다.

<div id="line-demo-2"></div>

> 차트에 마우스를 올리면 😏
]

---
.left-column[
  ## # mix
  ## # d3(react())
  ## # d3 << react
  ## # 정리
]

.right-column[
d3(react())

* 우아한 `D3` 의 enter, update, exit 를 그대로 사용
* `D3` 의 애니메이션 활용 가능
* 데이터가 어디에 매핑되었는지 확인 가능
* 자칫 잘못하면 컴포넌트의 코드가 길어질 수도 있음
* `react-native` 등 다른 플랫폼을 지원하는 시리즈에서는 사용 불가능 ...

d3 << react

* 하나의 차트를 여러 컴포넌트로 나눠 재사용성을 극대화
* `react-canvas` 를 타겟으로 렌더링해 성능 향상을 꾀할 수도 있다. (실험해 보고 싶다는)
* `render` 함수가 굉장히 복잡해 질 수 있음
]

---
class: center, middle

# 뤼ㄷ은 어떻게 사용하나요?

.degrade[한나체 ㅂㄷㅂㄷ]

---
.left-column[
  ## # d3(react())
]

.right-column[
륃은 `d3(react())` 방식을 사용합니다.

* 저는 `D3` 빠 이기 때문에 👅
* [codepen](https://codepen.io/chitacan) 에서 작업한 `D3` 코드를 바로 사용하기 위해
* `props` 로는 최소한의 데이터만 전달하고 컴포넌트 안에서 필요한 데이터를 변환하는 방식을 선호합니다.
]

---
.left-column[
  ## # d3(react())
  ## # 사용한 곳?
]

.right-column[
sledge

* renote 2.0 알파테스트
* 웹에서 문제를 풀고, 추천 받을 수 있는 UI + 전체 유저의 성적을 한눈에 확인할 수 있는 대시보드
* mobile / desktop 을 동시에 지원하기 위해 responsive 한 `D3` 맛 `React` 컴포넌트 작성
* `D3`, `React`, `reflux`, `react-bootstrap`, `babel`, `browserify`, `q`, `lodash`, `amazon s3`

![:scale 37%](img/screenshot_sledge_1.png)
![:scale 37%](img/screenshot_sledge_2.png)
]

---
.left-column[
  ## # d3(react())
  ## # 사용한 곳?
]

.right-column[
sledge

* renote 2.0 알파테스트
* 웹에서 문제를 풀고, 추천 받을 수 있는 UI + 전체 유저의 성적을 한눈에 확인할 수 있는 대시보드
* mobile / desktop 을 동시에 지원하기 위해 responsive 한 `D3` 맛 `React` 컴포넌트 작성
* `D3`, `React`, `reflux`, `react-bootstrap`, `babel`, `browserify`, `q`, `lodash`, `amazon s3`

![:scale 90%](img/screenshot_sledge_3.png)
]

---
.left-column[
  ## # d3(react())
  ## # 사용한 곳?
]

.right-column[
lapland

* SANTA! 의 back office
* 문제 분석과 검색, 유저 성적 분석 / 관리
* rxjs 를 활용해 비동기 작업 처리
* `D3`, `React`, `redux`, `react-bootstrap`, `coffeescript`, `browserify`, `rxjs`, `lodash`, `amazon s3`

![:scale 35%](img/screenshot_lapland_1.png)
![:scale 35%](img/screenshot_lapland_2.png)
]

---
.left-column[
  ## # d3(react())
  ## # 사용한 곳?
]

.right-column[
lapland

* SANTA! 의 back office
* 문제 분석과 검색, 유저 성적 분석 / 관리
* rxjs 를 활용해 비동기 작업 처리
* `D3`, `React`, `redux`, `react-bootstrap`, `coffeescript`, `browserify`, `rxjs`, `lodash`, `amazon s3`

![:scale 90%](img/screenshot_lapland_3.png)
]

---
.left-column[
  ## # d3(react())
  ## # 사용한 곳?
  ## # 아!
]

.right-column[
사실 이 슬라이드의 데모도 모두 `D3`로 그려지는 `React` 컴포넌트 🙋

`slide.md`

```html
<div id="triangles"></div>
```

`app.coffee`

```coffeescript
Triangles = require './components/triangles.coffee'

slides.on 'beforeShowSlide', (slide)->
  switch slide.getSlideIndex()
    when 21
*     React.render <Triangles width={400} height={200}/>,
*     getEl 'triangles-demo'

slides.on 'hideSlide', (slide)->
  switch slide.getSlideIndex()
*   when 21 then React.unmountComponentAtNode getEl 'triangles-demo'
```
]

---
class: center, middle

# 끝


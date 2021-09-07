let element = <h1> { React.string("Hello World") } </h1>

let wrapChildren = (children: React.element) => {
  <div>
    <h1> { React.string("Overview") } </h1>
    children
  </div>
}

// wrapChildren(<div> React.string("Let's use React with ReScript") </div>)

let greeting = React.string("Hello ")
let name = React.string("Stranger");

/* element1 의 type은 React.element이다 */
let element1 = <div className="myElement"> greeting name </div>

// 엘리먼트 만들기
// 문자열, 정수, 실수, 배열로부터 엘리먼트 만들기
let str = React.string("Hello") /* "Hello"를 표시하는 새 엘리먼트 */

let number = React.int(1) /* "1"을 표시하는 새 엘리먼트 */

let numberFloat = React.float(1.0) /* "1.0"을 표시하는 새 엘리먼트 */

// 여러 엘리먼트를 단일 요소로 표현하는 React.array 함수를 제공.
let element2 = React.array([
  React.string("element 1"),
  React.string("element 2"),
  React.string("element 3")
])
// list는 런타임 오버 헤드를 포함하기 때문에 React.list 함수는 제공하지 않는다.
// Null 엘리먼트 만들기
// 리스크립트는 강한 타입 특성에서 생기는 제약조건이 있기 때문에 element || null 같은 타입을 허락하지 않는다.
// 값이 렌더링 되거나 렌더링 되지 않을 수 있는 조건을 표현할 때마다 Nothingness를 나타내는 React.null 상수가 필요하다.
let name = Some("Andrea")

let element3 = switch name {
  | Some(name) => <div> {React.string("Hello " ++ name)} </div>
  | None => React.null
}

let result = <div> element3 </div>

// 컴포넌트 함수를 통한 엘리먼트 생성
type props = { "name": string };

let render = (myComp: props => React.element) => {
  <div>
    {React.createElement(myComp, { "name": "Franz" })}
  </div>
}

// 가변 Children 넘기기
// 세 번째 매개 변수로 자식 배열을 받는 React.createElementVariadic 함수가 있다.
type props1 = { "title": string, "children": React.element };

let render1 = (article: props1 => React.element) => {
  let children = [React.string("Introduction"), React.string("Body")];

  let props1 = {"title": "Article #1", "children": React.null};

  {React.createElementVariadic(article, props1, children)}
}
// 이 함수는 주로 JSX 변환에 이용된다. 
// 그래서 일반적으로는 React.createElement를 사용하고 대신 children prop을 넘겨준다.

// DOM 엘리먼트 만들기
// DOM 엘리먼트(<div>, <span>, etc.)를 만들기 위해서는, ReactDOMRe.createDOMElementVariadic 함수를 사용합니다.
let createDom = ReactDOMRe.createDOMElementVariadic(
  "div",
  ~props=ReactDOM.domProps(~className="card", ()),
  [],
);

// 위 함수에는 ReactDOM.domProps 생성 함수가 필요. 그렇기 때문에 리스크립트는 유효한 dom props만 전달하는지 확인할 수 있다.
// https://github.com/reasonml/reason-react/blob/master/src/ReactDOM.re#L61
// 경고: The ReactDOMRe 모듈은 다음 rescript-react 메이저 릴리즈에서 제거될 예정

// 엘리먼트 복제
// 새 인스턴스에 prop 값을 덮어 씌우거나 추가하기 위해 기존 엘리먼트를 복제해야하거나 data-name같은 유효하지 않은 prop 이름 설정이 필요한 경우가 있다.
// 이 때 React.cloneElement를 사용할 수 있다.
let original = <div className="hello"/>

/* className이 "world"로 설정 된 새 React.element 가 반환됩니다. */
let clone = React.cloneElement(original, {"className": "world", "data-name": "some name"});
// 일반적으로 사용되는 props spreading처럼 사용할 수도 있지만 안전하지 않은 특성과 부정확함으로 인해 props spreading 처럼 사용하는 것은 완전 비추. 
// 리스크립트에서는, 필요한 Props 를 컴포넌트에 명시적으로 전달하거나 renderProps을 사용.

// 컴포넌트
@react.component
// 중요 컴포넌트 함수 이름을 항상 make로 지정하고 @react.component 속성을 추가.
let make = () => {
  <div>
    { React.string("Hello ReScripters!") }
  </div>
}

// Props 정의하기
// 리액트에서 props는 주로 단일 props 객체.
// 리스크립트에서 우리는 이름 있는 인자를 사용해 props 매개 변수를 정의한다.
@react.component
let make1 = (~title: string, ~visitorCount: int, ~children: React.element) => {
  let visitorCountMsg = "You are visitor number: " ++ Belt.Int.toString(visitorCount)

  <div>
    <div>
      { React.string(title) }
    </div>
    <div>
      { React.string(visitorCountMsg) }
    </div>
    children
  </div>
}

// 옵셔널 Props
// 이름 있는 인자의 모든 기능을 사용해 옵셔널 Props를 정의할 수도 있다.
@react.component
let make2 = (~name: option<string>=?) => {
  let greeting = switch name {
    | Some(name) => "Hello " ++ name ++ "!"
    | None => "Hello stranger!"
  }
  <div> {React.string(greeting)} </div>
}

// JSX에서 특별한 문법으로 옵셔널 Props를 적용할 수 있다.
// let name = Some("Andrea")

// <Greeting ?name />

// 허용되지 않는 Props 이름 (ex. keyword)
// type같은 Prop 이름은 (<input type="text" /> 처럼) 구문상 유효하지 않다.
// type은 리스크립트에서 예약된 단어. <input type_="text" /> 처럼 _를 붙여 사용.

// Props 와 타입 추론
// 간단한 경우, 범위가 넓은 사용이나 실험적인 경우에는 타입 어노테이션은 생략하는 것이 좋다.
@react.component
let make3 = (~onClick, ~msg, ~children) => {
  <div onClick>
    {React.string(msg)}
    children
  </div>
}
// onClick은 ReactEvent.Mouse.t => unit로 추론되고 msg는 string 그리고 children은 React.element로 추론된다.
// 타입 추론은 값을 더 작은(privately scoped) 함수로 전달할 때 특히 더 잘 동작한다.
// 엄격한 타입 추론으로 많은 키보드 입력이 필요하지 않지만, 우리는 가시성을 높이고 타입 오류를 방지하기 위해 공공 API를 대하는 것처럼 props의 타입을 명시적으로 입력하는 것을 여전히 추천한다.

// JSX에서 컴포넌트 사용
// 모든 리스크립트 컴포넌트는 JSX에서 사용할 수 있다.

// 컴포넌트 직접 작성하기
// JSX 사용되는 컴포넌트를 작성하기위해 @react.component 데코레이터를 꼭 사용할 필요는 없다.
// 대신에 우리는 make와 makeProps 함수로 makeProps: 'a => props와 make: props => React.element 함수를 정의해 이걸 리액트 컴포넌트처럼 동작하게 할 수 있다.
module Link = {
  type props = {"href": string, "children": React.element};
  @obj external makeProps:(
    ~href: string,
    ~children: React.element,
    unit) => props = ""

  let make = (props: props) => {
    <a href={props["href"]}>
     {props["children"]}
    </a>
  }
}

// <Link href="/docs"> {React.string("Docs")} </Link>

// 서브모듈 컴포넌트
// 리액트 컴포넌트를 하위 모듈로 표현할 수 있으므로 합성(Composite) 컴포넌트에 대해 여러 파일을 만들 필요없이 더 복잡한 UI를 빌드할 수 있다.
// (서브 모듈은 어쨌든 부모 컴포넌트에서만 사용됨)
module Label = {
  @react.component
  let make = (~title: string) => {
    <div className="myLabel"> {React.string(title)} </div>
  }
}

@react.component
let make4 = (~children) => {
  <div>
    <Label title="Getting Started" />
    children
  </div>
}

// module Label = Button.Label

// let content = <Label title="Test"/>

// 컴포넌트 네이밍
// 컴포넌트는 실제로 한 쌍의 함수이기 때문에 JSX에서 사용할 모듈에 속해야 한다.
// 각각의 컴포넌트를 식별하는 목적으로도 모듈을 사용하는 것이 좋다.
// @react.component는 우리가 작성한 모듈에 따라 자동으로 이름을 추가한다.

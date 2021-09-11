// ref를 사용하는 상황
// 어떠한 재 렌더링도 발생시키지 않는 상태 관리
// 포커스, 문자열 선택 또는 미디어 재생 관리
// 명령형 애니메이션을 트리거 시킬 때
// 서드 파티 DOM 라이브러리 통합
// 선언적으로 수행할 수 있는 모든 작업에는 refs 를 사용하지 마라

// Refs 생성하기
@react.component
let make = () => {
  let clicks = React.useRef(0)

  let onClick = _ => {
    clicks.current = clicks.current + 1
  }

  <div onClick> {Belt.Int.toString(clicks.current)->React.string} </div>
}

// Refs 접근하기
// ref 속성이 HTML 엘리먼트에 사용되면, ReactDOM.Ref.domRef 통해 전달 된 ref는 기본 DOM 엘리먼트를 current 속성으로 받는다.
// ref 속성을 컴포넌트 함수에 사용할 수 없다. 왜냐면 인스턴스가 없기 때문이다.
// (리스크립트에서는 자바스크립트 클래스를 노출하지 않는다)

// DOM 요소에 Ref 추가하기
@send external focus: Dom.element => unit = "focus"

@react.component
let make1 = () => {
  let textInput = React.useRef(Js.Nullable.null)

  let focusInput = () =>
    switch textInput.current->Js.Nullable.toOption {
    | Some(dom) => dom->focus
    | None => ()
    }

  let onClick = _ => focusInput()

  <div>
    <input type_="text" ref={ReactDOM.Ref.domRef(textInput)} />
    <input type_="button" value="Focus the text input" onClick />
  </div>
}

// Refs와 컴포넌트 함수
// 리액트에서 우리는 ref 속성을 컴포넌트 함수에 인자로 사용할 수 없다.
// module MyComp = {
//   @react.component
//   let make = (~ref) => <input />
// }

// @react.component
// let make = () => {
//   let textInput = React.useRef(Js.Nullable.null)

//   /* 이 코드는 컴파일이 되지 않는다. */
//   <MyComp ref={ReactDOM.Ref.domRef(textInput)} />
// }

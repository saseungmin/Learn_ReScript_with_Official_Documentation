// React.useReducer는 액션/리듀서 패턴으로 상태를 표현하는데 도움을 준다.

// 액션 / 리듀서 패턴은 리스크립트의 불변 레코드, 배리언트 그리고 패턴 매칭 기능을 사용하여 작업 및 상태 변경을 쉽게 표현할 수 있다.
type action = Inc | Dec
type state = {count: int}

let reducer = (state, action) => {
  switch action {
  | Inc => {count: state.count + 1}
  | Dec => {count: state.count - 1}
  }
}

@react.component
let make = () => {
  let (state, dispatch) = React.useReducer(reducer, {count: 0})

  <>
    {React.string("Count:" ++ Belt.Int.toString(state.count))}
    <button onClick={(_) => dispatch(Dec)}> {React.string("-")} </button>
    <button onClick={(_) => dispatch(Inc)}> {React.string("+")} </button>
  </>
}

// 지연 초기화
// initialState 초기 상태를 늦게 생성할 수 있다.
// 이 방법을 사용하려면 React.useReducerWithMapState 훅을 사용하고 init 함수를 세 번째 인수르 전달할 수 있다.
// 초기 상태는 init(initialState)로 설정된다.
// 이 함수는 리듀서 외부의 초기 상태를 만들기 위한 로직을 추출할 수 있게 한다.
// 또한 액션에 대한 응답을 가지고 나중에 상태를 재설정하는 데도 좋다.
type action1 = Inc | Dec | Reset(int)
type state1 = {count: int}

let init = initialCount => {
  {count: initialCount}
}

let reducer = (state, action) => {
  switch action {
  | Inc => {count: state.count + 1}
  | Dec => {count: state.count - 1}
  | Reset(count) => init(count)
  }
}

@react.component
let make1 = (~initialCount: int) => {
  let (state, dispatch) = React.useReducerWithMapState(
    reducer,
    initialCount,
    init,
  )

  <>
    {React.string("Count:" ++ Belt.Int.toString(state.count))}
    <button onClick={_ => dispatch(Dec)}> {React.string("-")} </button>
    <button onClick={_ => dispatch(Inc)}> {React.string("+")} </button>
  </>
}

// 훅은 특정 Props 값을 기반으로 UI를 나타내는 간단한 함수
// 애플리케이션이 유용하지려면 우리는 사용자 입력이나 네트워크 리퀘스트를 서버에 요청을 통해 이러한 Props를 대화식으로 조작하는 방법이 여전히 필요.

// 훅은 리액트 기능에 연결(hook into)할 수 있게 해준다
@react.component
let make = () => {
  let (count, setCount) = React.useState(_ => 0);

  let onClick = (_evt) => {
    setCount(prev => prev + 1)
  };

  let msg = "You clicked" ++ Belt.Int.toString(count) ++  "times"

  <div>
    <p>{React.string(msg)}</p>
    <button onClick> {React.string("Click me")} </button>
  </div>
}

// 리액트는 컴포넌트를 렌더링하거나 다시 렌더링 하는 도중에 이 상태를 보존한다.
// React.useState는 튜플을 반환한다.

// useState: 컴포넌트에 지역 상태를 추가한다.
// useEffect: 컴포넌트 안에서 사이드 이펙트를 발생시키는 부분을 실행한다.
// useContext: 컴포넌트에 리액트 컨텍스트 값을 제공.
// useReducer: useState의 변형. 상태 / 액션 / 리듀스 패턴을 사용할 수 있다.
// useRef: 변형 가능(mutable)한 리액트-Ref 값을 반환.

// 훅은 그저 함수이다. 그러나 훅을 사용할 때는 두가지 규칙을 따라야 한다.
// 리스크립트는 컴파일러에서 이 규칙을 강제하지는 않는다. 
// 때문에 만약 훅 컨벤션 룰을 강제하고 싶다면 자바스크립트로 변환된 결과물에 eslint-plugin를 적용할 수 있다.

// 규칙 1) 가장 상위(at the top level)에서만 훅을 호출해야 한다.
// 반복문, 조건문, 중첩된 함수 내에서 훅을 호출하지 말아라. 대신 리액트 함수 가장 상위 레벨에서 훅을 사용해야 한다.
// 규칙 2) 리액트 함수에서만 훅을 호출할 수 있다.
// 리액트 함수가 아닌 일반 함수에서 훅을 호출하지 말아야한다.


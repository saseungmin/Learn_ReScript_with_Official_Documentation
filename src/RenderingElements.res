// 만든 엘리먼트를 DOM에 렌더링하는 방법

// DOM에 엘리먼트 렌더링하기
// 우리의 리액트 애플리케이션을 root div에 렌더링하기 위해서는 다음 두 스텝을 거치면 된다.
// - ReactDOM.querySelector를 사용하여 DOM 노드 찾기
// - 쿼리로 찾은 Dom.element를 ReactDOM.render 함수를 이용해 리액트 엘리먼트 렌더링하기
// root div 우리 애플리케이션을 렌더링하는 하기
/* Dom 접근은 실패할 가능성이 있다. */
/* ReScript는 엣지 케이스에 대한 명시적인 핸들링을 할 수 있다 */
switch(ReactDOM.querySelector("#root")){
  | Some(root) => ReactDOM.render(<div> { React.string("Hello Andrea") } </div>, root)
  | None => () /* 아무것도 하지 않음 */
}

// 리액트 엘리먼트는 불변적이다. 한 번 엘리먼트를 만들면, 여러분은 그 엘리먼트의 자식 요소나 속성을 변경시킬 수 없다. 
// 엘리먼트는 영화의 단일 프레임과 같다. 엘리먼트는 특정 시점의 UI를 나타낸다.

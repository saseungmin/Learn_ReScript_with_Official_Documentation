// 배열과 키

// 키 그리고 배열 렌더링하기
// 키는 리액트가 각 렌더링 과정에서 변경, 추가 또는 제거된 엘리먼트를 식별하는 데 도움이 된다.
// 엘리먼트에 안정적인 ID를 제공하려면 배열 내부 엘리먼트에 키를 주입해야 한다.
let numbers = [1, 2, 3, 4, 5];

let items = Belt.Array.map(numbers, (number) => {
  <li key={Belt.Int.toString(number)}> {React.int(number)} </li>
})

// 키 값으로 가장 좋은 것은 형제(siblings) 요소 중에서 각각 고유하게 식별할 수 있는 문자열을 사용하는 것.
// 대부분의 경우 데이터의 ID를 키로 사용한다.
type todo = { id: string, text: string }

let todos = [
  {id: "todo1", text: "Todo 1"},
  {id: "todo2", text: "Todo 2"}
]

let items1 = Belt.Array.map(todos, todo => {
  <li key={todo.id}> {React.string(todo.text)} </li>
})

// 만일 렌더링 요소에 안정적인 ID가 없다면 최후의 수단으로 index 값을 키로 사용할 수 있다.

// 키 값은 형제 요소들 사이에서 각각 고유해야한다.
// 배열 내에서 사용되는 키는 형제 요소 사이에서 고유해야한다.
// 하지만 글로벌한 영역에서 고유할 필요는 없다. 두 개의 다른 배열을 생성할 때 고유한 키를 사용할 수 있다.
type post = { id: string, title: string, content: string }

module Blog = {
  @react.component
  let make = (~posts: array<post>) => {
    let sidebar = {
      <ul>
        {
          Belt.Array.map(posts, (post) => {
            <li key={post.id}>
              {React.string(post.title)}
            </li>
          })->React.array
        }
      </ul>
    }

    let content = Belt.Array.map(posts, (post) => {
        <div key={post.id}>
          <h3>{React.string(post.title)}</h3>
          <p>{React.string(post.content)}</p>
        </div>
    });

    <div>
      {sidebar}
      <hr />
      {React.array(content)}
    </div>
  }
}

let posts = [
  {id: "1", title: "Hello World", content: "Welcome to learning ReScript & React!"},
  {id: "2", title: "Installation", content: "You can install reason-react from npm."}
]

let blog = <Blog posts/>

// 리스트 렌더링하기
// 우리는 array<React.element>를 생성하기 전에 Belt.List.toArray를 이용해 list를 array로 변환해야한다.
// list를 사용하면 array로의 추가적 변환 비용이 발생한다.
// 아마 99%의 경우에 배열을(원활한 인터롭, 빠른 자바스크립트 코드) 사용한다. 
// 하지만 경우에 따라 고급 패턴 매칭 기능을 사용하고 싶을 때 list 타입을 사용하기도 한다.

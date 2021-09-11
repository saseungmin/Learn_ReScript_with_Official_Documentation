// Effect 훅은 함수 컴포넌트에서 사이드 이펙트를 다룰 수 있게 해준다.

// 이펙트(Side-Effect)의 일반적인 예는 데이터 페칭이나 서브스크립션 설정 그리고 리액트 컴포넌트에서 DOM을 수동으로 변경하는 것이다.
// 리액트 컴포넌트에는 두가지 종류의 사이드 이펙트가 있다.
// 클린업 과정이 필요하지 않은 것과, 클린업이 필요한 것.

// /* 렌더링이 완료될 때마다 실행 */
// React.useEffect(() => {
//   /* 이펙트 실행 */
//   None /* 또는 Some(() => {}) */
// })

let test = ""

// /* 컴포넌트가 마운트 된 후 단 한번만 실행 */
// React.useEffect0(() => {
//   /* 이펙트 실행 */
//   None // 또는 Some(() => {})
// })

// /* `prop1`이 변경될 때마다 실행 */
// React.useEffect1(() => {
//   /* prop1에 값에 기반한 이펙트 실행 */
//   None
// }, [prop1])

// /* `prop1` 또는 `prop2` 가 변경될 때마다 실행 */
// React.useEffect2(() => {
//   /* prop1 / prop2 값을 기반으로 이펙트 실행 */
//   None
// }, (prop1, prop2))

// React.useEffect3(() => {
//   None
// }, (prop1, prop2, prop3));

// /* 의존성개 따라 useEffect4에서 useEffect7 까지 사용할 수 있습니다. */
// /* useEffect3처럼 튜플로 인자를 받습니다. */

// React.useEffect는 사이드 이펙트성이 강한 명령형 코드를 포함하고 option<unit => unit> 를 값으로 반환.
// 반환하는 값은 잠재적인 클린업 함수이다.

// 의존성 리스트에 React.useEffect1는 배열을 받고 useEffect2와 다른 것들(useEffect3~7)은 왜 튜플 (Ex (prop1, prop2)) 을 받을까?
// 그 이유는 튜플은 여러 값에 서로 다른 타입이 가능하기 때문이다. 
// 반면에 배열은 오직 같은 타입의 값만 받는다. 

// 클린업 없는 이펙트
module Document = {
  type t;
  @val external document: t = "document";
  @set external setTitle: (t, string) => unit = "title"
}

@react.component
let make = () => {
  let (count, setCount) = React.useState(_ => 0);

 React.useEffect1(() => {
    open Document
    document->setTitle(`You clicked ${Belt.Int.toString(count)} times!`)
    None
  }, [count]);

  let onClick = (_evt) => {
    setCount(prev => prev + 1)
  };

  let msg = "You clicked" ++ Belt.Int.toString(count) ++  "times"

  <div>
    <p>{React.string(msg)}</p>
    <button onClick> {React.string("Click me")} </button>
  </div>
}

// 클린업과 이펙트

module ChatAPI = {
  /* Imaginary globally available ChatAPI for demo purposes */
  type status = { isOnline: bool };
  @val external subscribeToFriendStatus: (string, status => unit) => unit = "subscribeToFriendStatus";
  @val external unsubscribeFromFriendStatus: (string, status => unit) => unit = "unsubscribeFromFriendStatus";
}

type state = Offline | Loading | Online;

@react.component
let make1 = (~friendId: string) => {
  let (state, setState) = React.useState(_ => Offline)

  React.useEffect(() => {
    let handleStatusChange = (status) => {
      setState(_ => {
        status.ChatAPI.isOnline ? Online : Offline
      })
    }

    ChatAPI.subscribeToFriendStatus(friendId, handleStatusChange);
    setState(_ => Loading);

    let cleanup = () => {
      ChatAPI.unsubscribeFromFriendStatus(friendId, handleStatusChange)
    }

    Some(cleanup)
  })

  let text = switch(state) {
    | Offline => friendId ++ " is offline"
    | Online => friendId ++ " is online"
    | Loading => "loading..."
  }

  <div>
    {React.string(text)}
  </div>
}

// 이런 최적화를 사용하려면, 컴포넌트 스코프의 모든 값을 의존 배열에 넣어야 한다.
// (props 또는 state 모두) 그렇지 않으면 당신의 코드는 이전 렌더링의 오래된 값을 참조할 수도 있다.

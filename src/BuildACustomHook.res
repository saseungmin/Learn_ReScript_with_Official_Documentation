// 커스텀 훅을 사용하면 기존 컴포넌트 로직을 재사용할 수 있도록 별도의 함수로 추출할 수 있다.
// 우리는 리액트에서 컴포넌트 간 상태를 가진 로직을 공유하는 두가지 인기있는 전통적인 방법을 알고 있다. 
// 그 두가지 방법은 Render-Props 와 Higher-order Components(HoC) 이다.
// 우리는 이제 훅으로 같은 문제를 추가적인 컴포넌트 트리를 작성하지 않고 해결하는 방법이 커스텀 훅이다.

// 커스텀 훅으로 추출하기
// 일반적으로 두 함수간에 로직을 공유하려면, 세번째 함수를 만들어 공통된 부분을 추출하는 방법이 있다. 
// 두 컴포넌트도 함수 훅도 함수이기 때문에 이 방법도 잘 작동한다.
module ChatAPI = {
  /* Imaginary globally available ChatAPI for demo purposes */
  type status = { isOnline: bool };
  @val external subscribeToFriendStatus: (string, status => unit) => unit = "subscribeToFriendStatus";
  @val external unsubscribeFromFriendStatus: (string, status => unit) => unit = "unsubscribeFromFriendStatus";
}

type state = Offline | Loading | Online

let useFriendStatus = (friendId: string): state => {
  let (state, setState) = React.useState(_ => Offline)

  React.useEffect(() => {
    let handleStatusChange = status => {
      setState(_ => {
        status.ChatAPI.isOnline ? Online : Offline
      })
    }

    ChatAPI.subscribeToFriendStatus(friendId, handleStatusChange)
    setState(_ => Loading)

    let cleanup = () => {
      ChatAPI.unsubscribeFromFriendStatus(friendId, handleStatusChange)
    }

    Some(cleanup)
  })

  state
}

// 리액트 컴포넌트와 다르게 커스텀 훅에서는 @react.component와 같은 특정 시그니쳐가 필요하지 않다.
// 우리는 훅이 무엇을 인수로 받고 무엇을 반환하는지 결정할 수 있다.
// 즉, 이건 일반적인 함수와 같다. 훅 규칙이 적용된다는 것을 한눈에 알 수 있도록 이름은 항상 use로 시작해야한다.

// 커스텀 훅 사용하기
type friend = { id: string, name: string };

@react.component
let make = (~friend: friend) => {
  let onlineState = FriendStatusHook.useFriendStatus(friend.id);

  let status = switch(onlineState) {
    | FriendStatusHook.Online => "Online"
    | Loading => "Loading"
    | Offline => "Offline"
  }

  React.string(status);
}

@react.component
let make1 = (~friend: friend) => {
  let onlineState = FriendStatusHook.useFriendStatus(friend.id);

  let color = switch(onlineState) {
    | Offline => "red"
    | Online => "green"
    | Loading => "grey"
  }

  <li style={ReactDOMStyle.make(~color,())}>
      {React.string(friend.name)}
  </li>
}

// 제 커스텀 훅의 이름은 항상 “use”로 시작해야할까요?
// 부탁이에요 그렇게 해주세요. 이 규칙은 매우 중요하거든요.
// 그것 없이는 특정 함수가 내부에 훅에 대한 호출을 포함하는지 아닌지 알 수 없다.
// 때문에 우리는 훅의 규칙(Rules of Hooks) 위반을 자동으로 확인할 수 없다.

// 동일한 훅을 사용하는 두 컴포넌트가 상태를 공유하나요?
// 아닙니다. 커스텀 훅은 상태 저장 로직을 재사용하는 메커니즘(Ex. 구독 설정 및 현재 값 기억)이지만 
// 커스텀 훅을 사용할 때마다 내부의 모든 상태와 이펙트가 완전히 격리됩니다.

// 커스텀 훅은 어떻게 격리 된 상태가 되나요?
// 훅에 대한 각각의 호출은 격리 된 상태를 만듭니다.
// 왜냐하면 우리가 useFriendStatus 훅을 직접 호출하기 때문에 리액트 관점에서 컴포넌트는 useState와 useEffect만 호출합니다.
// 그리고 앞서 배운 것처럼 하나의 컴포넌트에서 useState와 useEffect를 여러 번 호출할 수 있으며 그것은 완전히 독립적입니다..

// 너무 일찍 추상화하지 않도록 하세요. 
// 충분한 상태 저장 로직 처리가 관련되어 있을 때 컴포넌트가 상당히 커지는 것은 매우 일반적입니다. 이것은 정상적인 현상입니다.
// 바로 훅을 만들어 분할할 필요는 없습니다. 그러나 커스텀 훅이 간단한 인터페이스 뒤에 복잡한 논리를 숨기거나 복잡한 컴포넌트를 풀어볼 수 있는 케이스를 발견하는 것도 좋습니다.

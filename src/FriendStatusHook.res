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

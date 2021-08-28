// 예외는 예외 케이스일 때 던지는 특별한 종류의 배리언트. (남용하지 x!)
let getItem = (items) =>
  if false {
    /* 찾은 값을 반환 */
    1
  } else {
    raise(Not_found)
  }
let result =
  try {
    getItem([1, 2, 3])
  } catch {
  | Not_found => 0 /* getItem 에서 예외가 던져졌다면 기본값 설정 */
  }

let myItems = list{1, 2, 3}
let theItem = 4

switch List.find(i => i === theItem, myItems) {
| item => Js.log(item)
| exception Not_found => Js.log("No such item found!")
}

// JS 예외 받기
// 자바스크립트 예외와 리스크립트 예외를 구별하기 위해 리스크립트는 Js.Exn.Error(payload) 배리언트를 JS 예외용 네임 스페이스로 지정해 사용해야한다.
let someJSFunctionThatThrows = () => {
  Js.Exn.raiseError("someJSFunctionThatThrows!")
}

try {
  someJSFunctionThatThrows()
} catch {
| Js.Exn.Error(obj) =>
  switch Js.Exn.message(obj) {
  | Some(m) => Js.log("Caught a JS exception! Message: " ++ m)
  | None => ()
  }
}

// JS 예외를 발생하기
// raise(MyException)는 리스크립트 예외를 발생한다. 
// (목적이 무엇이든) 자바스크립트 예외를 발생하려면 Js.Exn.raiseError를 사용한다.
let myTest = () => {
  Js.Exn.raiseError("Hello!")
}

// JS에서 리스크립트 예외 받기
exception BadArgument({myMessage: string})

let myTest1 = () => {
  raise(BadArgument({myMessage: "Oops!"}))
}
// RE_EXN_ID 는 내부 기록용 필드로. 
// 이 필드는 JS에서 절대 사용하지 말아야한다. 다른 필드를 사용.
// 인라인 레코드 타입을 사용하면 리스크립트는 예외를 { RE_EXN_ID, myMessage, Error }와 같이 특수한 케이스로 컴파일한다.

// Tips & Tricks
// 배리언트를 사용하면 예외가 필요하지 않는 경우가 많다. 
// 예를 들어 item 을 콜렉션에서 못찾았다면 예외를 던지는 대신 option<item>(이 경우 None)을 반환해봐라.

// 구조분해
// 데이터 형태에 따른 switch 구문
// 완전성 검사

// 구조분해
let coordinates = (10, 20, 30)
let (x, _, _) = coordinates
Js.log(x) // 10

/* 레코드 */
type student = {
  name: string, 
  age: int
}

let student1 = {
  name: "John",
  age: 10
}

let {name} = student1
/* 배리언트 */
type result =
  | Success(string)
let myResult = Success("You did it!")
let Success(message) = myResult /* "You did it!" 값을 `message` 으로 할당 */

// 일반적으로 바인딩을 배치하는 모든 곳에서 구조분해를 사용할 수 있다.
let displayMessage = (Success(m)) => {
  /* 매개 변수를 구조분해해 Success 메시지 문자열을 직접 추출 */
  Js.log(m)
}

displayMessage(Success("You did it!"))

// 레코드는 구조분해시 필드 이름도 바꿀 수 있다.
let {name: n} = student1 /* "John" 값을 `n` 으로 할당 */

// 최상위 수준에서 배열, 리스트를 구조분해할 수 있다.
let myArray = [1, 2, 3]
let [item1, item2, _] = myArray
/* 1은 `item1`에 할당, 2는 `item2`에 할당, 3번째 요소는 무시 */

let myList = list{1, 2, 3}
// let list{head, ...tail} = myList 오류 발생
/* 1은 `head`, `list{2, 3}` 은 tail에 할당 */

// 위 경우 강하게 비추
// 배열과 리스트을 올바르게 구조분해하는 방법은 switch를 사용하는 것이다.

// 데이터 형태에 따른 switch 구문
type payload =
  | BadResult(int)
  | GoodResult(string)
  | NoResult

// if-else 대신 초강력한 switch 패턴 매칭으로 구조 분해를 하고, 
// 각각 분해된 결과의 오른편에 작성된 코드가 실행되도록 한다.
let data = GoodResult("Product shipped!")
switch data {
| GoodResult(theMessage) =>
  Js.log("Success! " ++ theMessage)
| BadResult(errorCode) =>
  Js.log("Something's wrong. The error code is: " ++ Js.Int.toString(errorCode))
| NoResult =>
  Js.log("Bah.")
}

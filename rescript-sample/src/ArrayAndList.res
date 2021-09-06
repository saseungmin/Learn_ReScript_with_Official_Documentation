// Array
// 리스크립트의 배열에 있는 항목들은 꼭 같은(homogeneous) 타입이어야 한다.
let myArray = ["hello", "world", "how are you"]

// 다음과 같이 배열의 항목에 접근하거나 수정 할 수 있다.
let array = ["hello", "world", "how are you"]

let firstItem = array[0]

array[0] = "hey"

// List
// 불변이고, 선두의 항목을 가져오는 것이 빠르다.
// 꼬리(마지막) 항목을 가져오는 것이 빠르다.
// 나머지 다른 것들은 느리다.
// 모든 항목을 같은 타입이어야 한다.

let myList = list{ 1, 2, 3 }

// 리스트는 불변하고, 효율적인 기능(크기의 가변성, 빠른 속도로 선두 항목 추가, 항목 분해)을 사용하고자 하는 경우에 적합.
// 만약 어느 항목에 무작위로 접근하거나 선두가 아닌 위치에 항목을 추가해야한다면 리스트를 사용하면 안된다. (코드가 답답하고 느려질것이다)
// anotherList 마지막 3 항목은 myList에서 공유받는다.
let anotherList = list{ 0, ...myList }

// list{a, ...b, ...c}는 문법오류가 발생한다는 것을 강조드린다.
// 리스크립트는 여러 리스트를 하나의 리스트로 전개하는 것을 지원하지 않는다.
// 이를 위해 List.concat을 사용 할 수 있으나 권장하지 않는다.
// 목록 중간에 있는 임의의 항목을 업데이트하는 것도 권장하지 않는다. 
// 성능 및 할당 오버헤드의 시간복잡도가 선형(O(n))이기 때문이다.

// Access
// switch는 보통 리스트의 항목에 접근하기 위해 사용된다.
let message =
  switch myList {
  | list{} => "This list is empty"
  | list{ a, ...rest } => "The head of the list is the string" ++ Js.Int.toString(a)
  }

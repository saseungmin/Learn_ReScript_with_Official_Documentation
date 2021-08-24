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

// 일부 값을 무시
type status = Vacations(int) | Sabbatical(int) | Sick | Present
type reportCard = {passing: bool, gpa: float}
type person =
  | Teacher({
    name: string,
    age: int,
  })
  | Student({
    name: string,
    status: status,
    reportCard: reportCard,
  })

let person1 = Teacher({name: "Jane", age: 35})

// payload를 완전히 무시하려는 경우, 다음과 같이 _ 와일드 카드를 사용할 수 있다.
switch person1 {
| Teacher(_) => Js.log("Hi teacher")
| Student(_) => Js.log("Hey student")
}

// _ 는 switch의 최상위 수준에서도 작동하며 포괄 조건으로 사용된다.
// switch myStatus {
// | Vacations(_) => Js.log("Have fun!")
// | _ => Js.log("Ok.")
// }
// 최상위에서 포괄 조건을 남용하면 안된다. 가급적 모든 케이스를 작성하는 것이 좋다.

// When 절
let person2 = Teacher({name: "Jane", age: 35})

switch person2 {
| Teacher(_) => () // 아무것도 안함
| Student({reportCard: {gpa}}) =>
  if gpa < 0.5 {
    Js.log("What's happening")
  } else {
    Js.log("Heyo")
  }
}

// switch는 패턴을 선형으로 유지하기 위해 if 조건을 같이 사용할 수 있는 기능을 지원.
switch person2 {
| Teacher(_) => () // 아무것도 안함
| Student({reportCard: {gpa}}) when gpa < 0.5 =>
  Js.log("What's happening")
| Student(_) =>
  /* fall-through, 모든 값 케이스 */
  Js.log("Heyo")
}

// 예외 매칭
let theItem = 5
let myItems = list{1, 2, 3, 4, 5}

switch List.find(i => i === theItem, myItems) {
| item => Js.log(item)
| exception Not_found => Js.log("No such item found!")
}

// 배열 매칭
let students = ["Jane", "Harvey", "Patrick"]
switch students {
| [] => Js.log("There are no students")
| [student1] =>
  Js.log("There's a single student here: " ++ student1)
| manyStudents =>
  /* 배열에 있는 이름들 출력 */
  Js.log2("The students are: ", manyStudents)
}

// 리스트 매칭
// 리스트 패턴 매칭은 배열과 유사하지만 리스트의 꼬리(tail)를 추출하는 추가 기능이 있다. 
// (tail은 첫 번째 요소를 제외한 모든 요소.)
let rec printStudents = (students) => {
  switch students {
  | list{} => () // 끝
  | list{student} => Js.log("Last student: " ++ student)
  | list{student1, ...otherStudents} =>
    Js.log(student1)
    printStudents(otherStudents)
  }
}

let result = printStudents(list{"Jane", "Harvey", "Patrick"})

// 완전성 검사
// 리스크립트는 가장 중요한 패턴 매칭 기능으로 누락된 패턴이 있는지 컴파일 시점에 검사하는 기능을 제공.
let message = switch person1 {
| Teacher({name: "Mary" | "Joe"}) =>
  `Hey, still going to the party on Saturday?`
| Student({name, reportCard: {passing: true, gpa}}) =>
  `Congrats ${name}, nice GPA of ${Js.Float.toString(gpa)} you got there!`
| Student({
    reportCard: {gpa: 0.0},
    status: Vacations(daysLeft) | Sabbatical(daysLeft)
  }) =>
  `Come back in ${Js.Int.toString(daysLeft)} days!`
| Student({status: Sick}) =>
  `How are you feeling?`
| Student({name}) =>
  `Good luck next semester ${name}!`
}
// 위 코드는 person1의 Teacher({name})이 Mary 또는 Joe 가 아닐때 나머지 경우를 처리하는 부분을 생략했다.
// 값이 가질 수 있는 모든 시나리오를 처리하지 못할 때 대부분의 프로그램 버그가 발생. 다행히 리스크립트는 컴파일러에서 다음과 같이 알려준다.
// 다음은 대부분의 nullable 값이 처리되는 방식.
let myNullableValue = Some(5)

switch myNullableValue {
| Some(v) => Js.log("value is present")
| None => Js.log("value is absent")
}
// None 케이스를 처리하지 않으면 컴파일러가 경고한다. 더 이상 코드에 undefined 버그가 없다!
// 결론과 팁
// 와일드카드 _ 를 너무 남용하지 마라. 이렇게하면 컴파일러가 더 나은 완전성 검사를 제공하지 못한다.
// when 절을 아껴서 사용. 가능하면 패턴 매칭를 평평하게(flatten) 만들어라. 이게 진짜 버그를 제거하는 좋은 방법이다.
let optionBoolToBool = opt => {
  switch opt {
  | Some(trueOrFalse) => trueOrFalse
  | None => false
  }
}

// 분기가 많은 if-else를 사용할 때마다 패턴 매칭을 고려해봐라. 더 간결하고 성능도 더 뛰어나다.

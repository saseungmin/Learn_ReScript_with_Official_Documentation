// 리스크립트 객체는 타입 선언이 필요없다.
// 레코드와 다르게 구조적(structural)이고 더 다형성하다.
// 객체가 JS로부터 전달된 것이 아니면 변경할 수 없다.
// 패턴패칭을 지원하지 않는다.

// 물론 리스크립트 레코드가 자바스크립트 객체로 깔끔하게 컴파일되긴 하지만,
// 자바스크립트 객체를 흉내내거나 바인딩할 때에는 리스크립트의 객체가 더 나은 선택일 수 있다.

// 타입 선언
// 레코드와는 다르게 선택적이다. 객체의 타입은 값으로부터 추론된다. 그래서 타입 선언을 굳이 적을 필요가 없다.
type person = {
  "age": int,
  "name": string, // 필드 이름이 따옴표
}

// Creation
// 레코드와 다르게 여기서 me는 "age", "name" 필드가 있는 타입 선언을 찾아서 비교하려하지 않는다.
let me = {
  "age": 5,
  "name": "Big ReScript"
}

// me가 {"age": int, "name": string}로 추론된다.
let me1 = {
  "age": "hello!", // age가 문자열임에도 에러가 나지 않습니다.
  "name": "Big ReScript",
}

// 이는 타입 검사기가 me를 person과 매칭하려 시도하지 않기 때문이다.
// 만약 어떤 객체가 기존에 선언된 객체 타입과 정확히 일치하기를 원한다면 아래와 같이 어노테이션을 주면 된다.
// let me2: person = {
//   "age": "hello!"  타입 에러
// }

// 접근
let age = me["age"]

// 변경
// 객체가 자바스크립트 바인딩으로부터 온 것이 아니라면 수정은 되지 않는다. 
// 만약 수정이 되는 상황이라면 =를 쓰면 된다.
type student = {
  @bs.set "age": int,
  @bs.set "name": string,
}
@bs.module("MyJSFile") external student1: student = "student1"

student1["name"] = "Mary"

// Combine Types
// 하나의 객체 유형 정의를 다른 객체 유형 정의를 사용하여 전개 할 수 있다.
// 이것은 객체의 값이 아닌 객체 타입에서만 작동한다.
type point2d = {
  "x": float,
  "y": float,
}

type point3d = {
  ...point2d,
  "z": float,
}

let myPoint: point3d = {
  "x": 1.0,
  "y": 2.0,
  "z": 3.0,
}
// Tips & Tricks
// 객체가 타입 선언을 필요로 하지 않는데다 리스크립트가 알아서 어떤 타입으로든 추론을 해주기 때문에, 
// 자바스크립트 API 바인딩이 필요하다면 매우 쉽고 빠르게 만들 수 있다. (물론 안전하지는 않다)

// document의 타입을 구체적으로 명시하지 않고 아무 타입 'a라고 했습니다.
@bs.val external document: 'a = "document"

// 메서드 호출
document["addEventListener"]("mouseup", _event => {
  Js.log("Clicked!")
})

// 프로퍼티 읽기
let loc = document["location"]

// 프로퍼티 쓰기
document["location"]["href"] = "rescript-lang.org"

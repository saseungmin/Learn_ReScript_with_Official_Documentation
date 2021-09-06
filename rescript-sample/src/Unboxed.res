type name = Name(string)
let studentName = Name("Joe")

type greeting = {message: string}
let hi = {message: "hello!"}

// 성능이 중요하거나 간혹 특수한 자바스크립트 인터롭이 필요한 상황에서는 리스크립트가 제공하는 언랩(혹은 언박스) 기능을 사용할 수 있다.
// 언랩은 단일 필드 레코드 혹은 단일 페이로드-단일 생성자 배리언트가 JS로 변환될 때, 해당 객체의 래퍼를 벗겨낸다.
// 타입 선언 위에 @unboxed라고 달면 된다.
@unboxed
type name1 = Name(string)
let studentName1 = Name("Joe")

@unboxed
type greeting1 = {message: string}
let hi1 = {message: "hello!"}

// 사용하기
// 왜 싱글 페이로드를 가진 배리언트 또는 레코드가 필요한가? 왜 그냥 페이로드를 넘기지 않나?
// type coordinates = {x: float, y: float}

// let renderDot = (coordinates) => {
//   Js.log3("Pretend to draw at:", coordinates.x, coordinates.y)
// }

// let toWorldCoordinates = (localCoordinates) => {
//   {
//     x: localCoordinates.x +. 10.,
//     y: localCoordinates.x +. 20.,
//   }
// }

// let playerLocalCoordinates = {x: 20.5, y: 30.5}

// renderDot(playerLocalCoordinates)

// 이런, 뭔가 잘못되었습니다. renderDot은 전역 좌표를 기준으로 렌더링하는데 인자로 로컬 좌표가 전달됐습니다.
// 이제 코드를 수정해서 잘못된 좌표 타입이 전달되지 못하게 막아봅시다.
type coordinates = {x: float, y: float}
@unboxed type localCoordinates = Local(coordinates)
@unboxed type worldCoordinates = World(coordinates)

let renderDot = (World(coordinates)) => {
  Js.log3("Pretend to draw at:", coordinates.x, coordinates.y)
}

let toWorldCoordinates = (Local(coordinates)) => {
  World({
    x: coordinates.x +. 10.,
    y: coordinates.x +. 20.,
  })
}

let playerLocalCoordinates = Local({x: 20.5, y: 30.5})

/* 이제 이렇게 호출하면 오류가 발생합니다! */
/* renderDot(playerLocalCoordinates) */
/* 대신 이렇게 사용하도록 강제합니다. */
renderDot(playerLocalCoordinates -> toWorldCoordinates)
// 이제 renderDot은 worldCoordinates만을 입력으로 받는다.
// 배리언트 타입으로 구분 + 인자 구조분해를 써서 더 안전한 코드를 만들었다.
// 성능 저하는 없다.
// unboxed 속성 덕분에 배리언트 래퍼 없이 깔끔하게 JS 코드로 컴파일됐다.

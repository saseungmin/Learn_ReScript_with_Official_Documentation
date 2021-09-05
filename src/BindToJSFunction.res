// 자바스크립트 함수를 바인딩 하는 것은 다른 어떤 값을 바인딩하는 것과 같다
/* nodejs의 path.dirname 을 가져옵니다. */
@bs.module("path") external dirname: string => string = "dirname"
let root = dirname("/User/github") // returns "User"

// 이름이 있는 인자
// 자바스크립트 함수의 명확하지 않은 사용법을 수정하는데 사용.
// MyGame.js

// function draw(x, y, border) {
//   // `border` 는 옵셔널이고 기본값은 false 라고 가정합니다.
// }
// draw(10, 20);
// draw(20, 20, true);

@module("MyGame")
external draw: (~x: int, ~y: int, ~border: bool=?, unit) => unit = "draw"

draw(~x=10, ~y=20, ~border=true, ())
draw(~x=10, ~y=20, ())
// 참고: 마지막 인자가 옵셔널인 border 와 같은 특수한 경우에는 바로 뒤에 유닛(unit) () 이 필요하다.
// 함수가 완료되었음을 알려주는 유닛이 없다면 경고를 낸다.

// 객체 메소드
// 자바스크립트 모듈을 제외한 자바스크립트 객체는 send를 사용하는 특별한 바인딩 방법이 필요.
type document // document 객체를 위한 추상 타입
@send external getElementById: (document, string) => Dom.element = "getElementById"
@val external doc: document = "document"

let el = getElementById(doc, "myId")

// 가변 함수 인자
// 임의의 한개 이상의 인자를 가진 자바스크립트 함수가 있다고 가정할 수 있다.
// ReScript는 임의의 인자들 모두가 같은 타입이라는 전제하에 이러한 모델링을 지원한다.
// 필요한 경우에 variadic 키워드를 external 에 추가하라
@module("path") @variadic
external join: array<string> => string = "join"

let v = join(["a", "b"])

// 폴리모픽 함수 모델링
// 트릭 1: 여러개의 external을 사용
// 오버로드된 자바스크립트 함수가 취할 수 있는 많은 경우의 수를 철저히 열거할 수 있다면, 간단한 방법으로는 모두 각각 다르게 바인딩하라
@module("MyGame") external drawCat: unit => unit = "draw"
@module("MyGame") external drawDog: (~giveName: string) => unit = "draw"
@module("MyGame") external draw: (string, ~useRandomAnimal: bool) => unit = "draw"
drawCat()
drawDog(~giveName="Dog")
draw("test", ~useRandomAnimal=true)

// 트릭 2: 폴리모픽 배리언트 + unwrap을 사용
// "만약 자바스크립트의 함수 인자가 비공식적으로 string 또는 int 가 아닌 배리언트였다면" 이라고 말하고 싶은 충동이 들었다면
// 우리는 인자에 주석을 달아 이러한 external 기능을 제공한다. 이를 폴리모픽 배리언트라고 한다.
// function padLeft(value, padding) {
//   if (typeof padding === 'number') {
//     return Array(padding + 1).join(' ') + value;
//   }
//   if (typeof padding === 'string') {
//     return padding + value;
//   }
//   throw new Error(`Expected string or number, got '${padding}'.`);
// }
@val
external padLeft: (
  string,
  @unwrap [
    | #Str(string)
    | #Int(int)
  ])
  => string = "padLeft"
let pad1 = padLeft("Hello World", #Int(4))
let pad2 = padLeft("Hello World", #Str("Message from ReScript: "))
// 명백하게, 자바스크립트는 폴리모픽 배리언트를 가질 수 없다!
// 우리는 이제 폴리모픽 배리언트의 타입 체크와 문법을 얻었다.
// 이것의 비밀은 @unwrap 어노테이션 때문이다.
// 컴파일 타임에 배리언트 생성자를 제거하고 페이로드의 값만 출력한다.
@val
external testIntType: (
  @int [
    | #onClosed
    | @as(20) #onOpen
    | #inBinary
  ])
  => int = "testIntType"

let test1 = testIntType(#onClosed)
let test2 = testIntType(#onOpen)
let test3 = testIntType(#inBinary)

// onClosed는 0 으로 컴파일되고, onOpen 은 20으로, 그리고 inBinary는 21로 컴파일된다.
// 특수한 경우: 이벤트 리스너
type readline

@send
external on: (
    readline,
    @string [
      | #close(unit => unit)
      | #line(string => unit)
    ]
  )
  => readline = "on"

let register = rl =>
  rl
  ->on(#close(event => Js.log(event)))
  ->on(#line(line => Js.log(line)));

// 고정된 인자
// 때때로 인자의 기본값을 자바스크립트 함수에 전달하면서 external을 사용하면 편리하다.
@val
external processOnExit: (
  @as("exit") _,
  int => unit
) => unit = "process.on"

processOnExit(exitCode =>
  Js.log("error code: " ++ Js.Int.toString(exitCode))
);
// @as("exit") 그리고 플레이스홀더 _ 인자는 첫번째 인자가 컴파일되면 "exit" 로 컴파일 되기를 원한다는 것을 나타낸다.
// 그리고 as: @as(json`true`), @as(json`{"name": "John"}`), 등 과 같은 모든 JSON 리터럴을 사용할 수 있다.

// 커리 & 언커리
// 보장된 언커링을 사용
// 언커리드 함수 어노테이션은 external을 사용하는 경우에서도 작동한다:
type timerId
@val external setTimeout: ((. unit) => unit, int) => timerId = "setTimeout"

let id = setTimeout((.) => Js.log("hello"), 1000)
// 위에서 제시한 해결책은 안전하고 보장되며 성능이 좋다. 그러나 때로는 시각적으로 부담스럽다.
// external 을 사용하고 있습니다.
// external 함수가 다른 함수를 인자로 받습니다.
// 사용자가 호출하는 곳에서 점(dot)과 함께 호출하는 것을 원하지 않습니다.
// 이런 상황일 경우 아래와 같이 사용 @uncurry
@send external map: (array<'a>, @uncurry ('a => 'b)) => array<'b> = "map"
let arr = map([1, 2, 3], x => x + 1)
// 일반적으로 uncurry는 추천된다.
// 컴파일러는 컴파일 타임에 커링을 언커링으로 바꾸기 위한 많은 최적화를 한다.
// 그러나 일부 경우에는 최적화를 할 수 없는 경우가 있다. 이러한 경우에는 런타임에 확인하는 방식으로 변경된다.

// this 기반 콜백 모델링
// 많은 자바스크립트 라이브러리는 this에 의존하는 콜백이 있다.
// x.onload = function(v) {
//   console.log(this.response + v);
// };
type x
@val external x: x = "x"
@set external setOnload: (x, @this ((x, int) => unit)) => unit = "onload"
@get external resp: x => int = "response"
setOnload(x, @this ((o, v) => Js.log(resp(o) + v)))
// this는 첫 번째 인자로 항상 this를 가지며, 인자가 없는 함수일 경우 unit 타입을 표시할 필요는 없다.

// 함수의 Nullable 반환 값 래핑
// undefined 또는 null을 반환하는 자바스크립트 함수를 위해 @return(...) 을 제공한다.
// 해당 값을 option 타입으로 자동으로 변환하려면 (ReScript option 타입의 None 값은 null이 아닌 undefined 로만 컴파일된다.)
type element
type dom

@send @return(nullable)
external getElementById: (dom, string) => option<element> = "getElementById"

let test = dom => {
  let elem = dom->(getElementById("haha"))

  switch (elem) {
  | None => 1
  | Some(_ui) => 2
  }
}
// return(nullable) 속성은 자동으로 null과 undefined를 option 타입으로 바꾸어준다..
// 현재 4개의 지시문을 제공합니다. null_to_opt, undefined_to_opt, nullable 그리고 identity.

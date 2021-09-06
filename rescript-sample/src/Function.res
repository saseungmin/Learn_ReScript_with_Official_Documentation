// 함수는 화살표와 반환 표현식으로 선언할 수 있다.
let greet = (name) => "Hello " ++ name

let result = greet("World!")

// 함수가 여러 인자를 받는 경우 콤마(,)를 구분자로 선언.
let add = (x, y, z) => x + y + z
let sum = add(1, 2, 3)

// 긴 함수를 작성하려면 내용을 블록으로 감싼다.
let greetMore = (name) => {
  let part1 = "Hello"
  part1 ++ " " ++ name
}

// 이름이 있는 인자
// 여러 인자를 받는 함수, 특히 인자가 동일한 타입인 함수는 호출할 때 혼동 될 수 있다.
// 이런 경우 인자 이름 앞에 ~ 기호를 붙여 인자에 이름을 붙일 수 있다.
let addCoordinates = (~x, ~y) => {
  x + y
}

// 순서에 관계없이 전달할 수 있다
let add = addCoordinates(~y=6, ~x=5)

// 간결하게 작성하기 위해 함수 내부에서 다른 이름으로 인자를 참조 할 수도 있다.
let drawCircle = (~radius as r: int, ~color as c: string) => {
  Js.log("color: " ++ c)

  r * r
}

let circle = drawCircle(~radius = 10, ~color = "red")

// 이름이 있는 선택 인자
// 이름이 있는 인자는 선언시 선택 사항으로 만들 수 있고, 함수를 호출 할 때 생략 할 수 있다.
let startAt = (r1, r2) => r1 * r2

let drawCircle2 = (~color, ~radius = ?, ()) => {
  Js.log("color: " ++ color)

  switch radius {
  | None => startAt(1, 1)
  | Some(r_) => startAt(r_, r_)
  }
}

// 시그니쳐 및 타입 어노테이션
// 인자에 시그니쳐와 타입 어노테이션을 모두 추가하면 다음과 같은 결과를 얻을 수 있다.
type color = string

// 첫 번째 줄은 함수의 시그니처
// 함수의 시그니처는 외부와 상호 작용하는 타입을 설명합니다.
let drawCircle3 : (~color: color, ~radius: int=?, unit) => int =
  // 두 번째 줄에서는 함수 내부에서 인자를 사용할 때
  // 인자 타입을 기억할 수 있도록 인자에 어노테이션을 추가합니다.
  (~color: color, ~radius: option<int>=?, ()) => {
    Js.log("color: " ++ color)
  
    switch radius {
    | None => startAt(1, 1)
    | Some(r_) => startAt(r_, r_)
    }
  }

// 명시적으로 전달되는 선택 인자
// 아래와 같이 값이 None인지 Some(a)인지 모르는 상태에서 값을 함수에 전달하고 싶을 때가 있다.
// let result =
//   switch payloadRadius {
//   | None => drawCircle(~color, ())
//   | Some(r) => drawCircle(~color, ~radius=r, ())
//   }
// 이렇게 쓸 수 있다.
// 설명하자면 "radius가 선택 인자고 int 값을 전달해야 한다는 것을 알지만, 
// 전달하려는 값이 None인지 Some(val) 모른다. 그래서 option 그대로 전달하겠다."
// let result = drawCircle(~color, ~radius=?payloadRadius, ())

// 기본값이 있는 선택 인자
// 이 경우 option 타입으로 래핑되지 않는다.
let drawCircle4 = (~radius = 0, ~color, ()) => {
  Js.log("color: " ++ color)

  radius * radius
}

// 재귀함수
// 함수를 재귀적으로 호출하는 것은 성능과 호출 스택에 좋지 않다.
// 그러나 리스크립트는 지능적으로 꼬리 재귀을 사용해 빠른 자바스크립트 루프로 컴파일한다.
// 리스크립트에서 기본적으로 재귀적 호출을 방지한다. 재귀함수를 만들려면 let 뒤에 rec 키워드를 추가한다.
let rec neverTerminate = () => neverTerminate()

/* 리스트 중 하나가 `item`과 같을때까지 모든 항목을 재귀적으로 확인합니다. */
/* 일치하는 항목이 있으면 'true'를 반환하고, 그렇지 않으면 'false'를 반환합니다. */
let rec listHas = (list, item) =>
  switch list {
  | list{} => false
  | list{a, ...rest} => a === item || listHas(rest, item)
  }

// 상호 재귀 함수
// 상호 재귀 함수는 rec 키워드를 사용해 단일 재귀 함수처럼 시작된 다음 and 와 함께 연결한다.
let rec callSecond = () => callFirst()
and callFirst = () => callSecond()

// Uncurried(언커리드) 함수
// 리스크립트의 함수는 기본적으로 커리드 함수며, 컴파일 된 JS 결과물에서 우리가 지불하는 몇 가지 성능 패널티 중 하나이다.
// 컴파일러는 가능한 한 이러한 커링을 제거하기 위해 최선을 다한다.
// 그러나 특정 상황에서는 언커링을 보장 할 수 있다. 이 경우 함수의 매개 변수 목록에 점을 넣으면된다.
// 언커리드 함수의 타입을 선언할 때에도 마찬가지로 괄호 앞에 .을 붙여야 합니다.
let add1 = (. x, y) => x + y

let re = add1(. 1, 2)

// 단일 단위 () 인자로 커리드 함수를 호출해야하는 경우 ignore() 함수를 사용할 수 있다.
let echo = (. a) => a

echo(. ignore())
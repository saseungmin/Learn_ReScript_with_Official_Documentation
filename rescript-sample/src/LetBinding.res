// "let 바인딩"을 하면 이후 코드에서 바인딩 된 변수를 참조.
// 바인딩은 불변
let greeting = "hello!"

let score = 10
let newScore = 10 + score

// 블록 스코프
// 스코프는 {}을 사용해 지정
let message = {
  let part1 = "hello"
  let part2 = "word"
  // 암시적으로 스코프의 마지막 줄에 있는 값이 반환.
  part1 ++ " " ++ part2
}

// part1, part2 밖에서 접근 불가

// 디자인 결정
// 리스크립트 if, while 구문과 함수도 같은 블록 스코프 방식.
let displayGreeting = true

if displayGreeting {
  let message = "Enjoying the docs so far?"
  Js.log(message)
}
/* `message`는 여기서 접근 X */

// 쉐도잉
// 여기서 참조하는 바인딩은 위에서 가장 가까운 바인딩. 값의 변경은 일어나지 않는다!
let result = "hello"
Js.log(result) /* prints "hello" */
let result = 1
Js.log(result) /* prints 1 */

// Private let bindings
module A: {
  // public 필드로 타입을 선언하며 모듈 A의 a는 접근 불가능 하고, b만 접근 가능
  let b: int
} = {
  let a = 3 // 외부에서 a는 접근 불가
  let b = 4
}
// 직접 %%private 키워드로 private 필드를 직접 만들 수 있다
module B = {
  %%private(let a = 3)
  let b = 4
}

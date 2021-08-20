// If-Else & 삼항 표현(Ternary)
// 자바스크립트에서와 달리, 리스크립트의 if는 표현(expression)이다. 즉, 바디(body)의 내용을 평가한다.
let isMorning = true

let message = if isMorning {
  "Good morning!"
} else {
  "Hello!"
}

// if-else 표현에서 else 브랜치가 없는 경우, 암시적으로 ()를 제공한다 (unit 타입으라고 부른다).
let calls = () => Js.log("Wow! morning")

if isMorning {
  calls()
}

// 위는 다음과 같다.
if isMorning {
  calls()
} else {
  ()
}

// 리스크립트는 삼항 축약 표현(ternary sugar)도 제공하지만, 가능하면 if-else를 사용 할 것을 장려한다.
let message1 = isMorning ? "Good morning" : "Hello!"

// 리스크립트에서는 다른 언어에서보다 if-else와 삼항 표현(ternary)을 극히 드물게 사용한다

// For 루프(loop)
// For 루프(loop)는 시작 값부터 끝 값까지(끝 값도 포함) 반복.

let one = 1
let ten = 10

for i in one to ten {
  Js.log(i)
}

// for 루프 카운트에 downto를 이용하면 반대방향으로 반복할 수 있다.
for i in ten downto one {
  Js.log(i)
}

// While 루프(loop)
// 리스크립트는 루프를 탈출하는 break 키워드가 없다. (함수에서 빠른 탈출을 위한 return 키워드도 없다.)
// 그러나 가변 바인딩을 이용해 while 루프를 쉽게 탈출할 수 있다.
let break = ref(false)

while !break.contents {
  if Js.Math.random() > 0.3 {
    break := true
  } else {
    Js.log("Still running")
  }
}

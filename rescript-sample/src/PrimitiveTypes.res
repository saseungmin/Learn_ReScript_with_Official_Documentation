// 문자열
// 리스크립트에서 string 타입은 겹 따옴표를 사용해 구분.
let greeting = "Hello world!"
let multilineGreeting = "Hello
  Hi World!"

// ++ 문자열 이어 붙이기
let greetings = "Hello " ++ "earth!"

// 문자열 보간
let name = "Joe"
let greeting1 = `Hello
World
👍
${name}
`

// 문자열 보간을 하려면 바인딩을(name) 문자열로 변환해야 한다. 
// 보간을 통해 바인딩을 암시적으로 문자열로 변환하려면 앞에 j를 추가.
let age = 10
let message = j`Today I am $age years old.`

// char 리스크립트는 단일 문자 타입을 가지고 있다.
let firstLetterOfAlphabet = 'a' // 하지만, char 타입은 유니코드 또는 UTF-8을 지원하지 않기 때문에 추천하지 않는다.

// 정규 표현식 https://rescript-lang.org/docs/manual/latest/api/js/re
let r = %re("/b/g")

// Integers https://rescript-lang.org/docs/manual/latest/api/js/int
// 32비트 범위를 가지고 만일 넘어가는 경우에 잘린다.

// Float https://rescript-lang.org/docs/manual/latest/api/js/float
// 실수 연산은 +. 처럼 사용.
let floatCal = 0.5 +. 0.6

// 유닛(unit)
// unit 타입은 ()라는 단일 값을 가진다. unit 타입은 자바스크립트의 undefined으로 컴파일 된다.
let test = ()

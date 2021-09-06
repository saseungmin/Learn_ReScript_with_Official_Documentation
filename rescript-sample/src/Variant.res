// 배리언트

// myResponse 배리언트 타입은 Yes, No, PrettyMuch 를 가지고 있다.
// 배리언트 생성자"(또는 "배리언트 태그") 라고 한다. |(바)로 각 생성자를 구분한다.
// 배리언트 생성자는 대문자로 시작해야한다.
type myResponse =
  | Yes
  | No
  | PrettyMuch

let areYouCrushingIt = Yes

// 배리언트는 명시적으로 정의해야한다.
// 사용하려는 배리언트가 다른 파일에 있는 경우 레코드처럼 명시적으로 기재해야한다.
let pet: Zoo.animal = Dog // 선호
// or
let pet2 = Zoo.Dog

// 생성자 인자
// 배리언트 생성자는 추가 값을 가질 수 있다. 쉼표로 구분해 선언
// Instagram 은 string 을, Facebook 은 string와 int를 가진다.
type account =
  | None
  | Instagram(string)
  | Facebook(string, int)

let myAccount = Facebook("Josh", 26)
let friendAccount = Instagram("Jenny")

// 이름이 있는 배리언트 페이로드(인라인 레코드)
// 배리언트 생성자가 여러 값을 가질때 가독성을 높이기 위해 필드 이름을 지정할 수 있다.
// 이를 "인라인 레코드" 라고하며 배리언트 생성자 내에서만 허용됩니다.
// 리스크립트의 다른 곳에서는 인라인으로 레코드 타입 선언을 할 수 없습니다.
type user =
  | Number(int)
  | Id({
    name: string,
    password: string,
  })

let me = Id({
  name: "Joe",
  password: "123",
})

// 일반 레코드 타입도 배리언트에 넣을 수 있다.
type u = {
  name: string,
  password: string,
}

// 다만 결과물은 인라인 레코드보다 약간 지저분하고 성능이 떨어진다
type user2 =
  | Number(int)
  | Ids(u)

let me2 = Ids({
  name: "Joe",
  password: "123",
})

// 자바스크립트 결과물
// 컴파일 된 배리언트 값은 타입 선언에 따라 세가지 자바스크립트 결과물로 컴파일된다.
// - 페이로드가 없는 생성자인 경우 숫자로 컴파일
type greeting = Hello | Goodbye
let g1 = Hello
let g2 = Goodbye

// - 페리로드가 있는 생성자인 경우, TAG 필드와 함께 첫 번째 페이로드는 _0 필드, 두 번째 페이로드는 _1 ...와 같이 순서가 적용된 객체로 컴파일 된다.
// - 예외로 배리언트 타입 선언에 페이로드가 있는 생성자가 하나만 있는 경우, 생성자는 TAG 필드가 없는 객체로 컴파일된다.
type outcome = Good | Error(string)
let o1 = Good
let o2 = Error("oops!")

type family = Child | Mom(int, string) | Dad (int)
let f1 = Child
let f2 = Mom(30, "Jane")
let f3 = Dad(32)

// - 이름이 있는 배리언트 페이로드(=인라인 레코드)는 _0, _1,... 대신 필드 이름을 사용한 객체로 컴파일된다. 객체는 이전 규칙에 따라 TAG 필드가 있을 수도 있고 없을 수도 있다.
type person = Teacher | Student({ gpa: float })
let p1 = Teacher
let p2 = Student({ gpa: 99.5 })

type s = { score: float }
type adventurer = Warrior(s) | Wizard(string)
let a1 = Warrior({ score: 10.5 })
let a2 = Wizard("Joe")

// Tips & Tricks
// 주의 인자 2개를 전달하는 생성자와 인자로 단일 튜플을 전달하는 생성자를 혼동하지 말라.
type account3 =
  | Facebook(string, int) // 인자 2개
type account4 =
  | Instagram((string, int)) // 인자 1개 - 요소가 2개인 튜플

// 배리언트는 반드시 생성자가 있어야 함
type myType = Int(int) | String(string)

// 잠재적으로 성능 측면에서 배리언트는 프로그램 로직 속도를 엄청나게 높일 수 있다.
type animal = Dog | Cat | Bird

let data = Dog

switch data {
  | Dog => Js.log("Wof")
  | Cat => Js.log("Meow")
  | Bird => Js.log("Kashiiin")
}

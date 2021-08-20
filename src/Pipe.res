// 리스크립트는 파이프 연산자(->)를 지원한다.
// 파이프를 이용하면 a(b)를 b -> a와 같이 작성할 수 있다.
// 파이프는 단순히 방향을 바꿔주는 문법일 뿐이어서 사용할 때 별도의 성능 저하는 없다.
type person = {age: int, name: string}

let me: person = {
  age: 27,
  name: "seungmin"
}

let validateAge = (age) => age === 0 ? "Nothing Info" : "Match age" ++ Js.Int.toString(age)
let getAge = (age) => age 
let parseData = (who: person) => {
  if who.name === "seungmin" {
    who.age
  } else {
    0
  }
}

// validateAge(getAge(parseData(person)))
let result = validateAge(getAge((parseData(me))))
// 위 코드는 읽기 어렵다. 가장 안쪽 코드를 찾은 뒤 그 곳에서부터 읽어야 한다.
// 파이프를 사용하면 다음과 같이 바꿀 수 있다.
let pipeResult = me
  -> parseData
  -> getAge
  -> validateAge

// 파이프는 함수가 인자를 한개 이상 넘겨받을 때도 동작한다.
// a(one, two, three)
// one -> a(two, three)


// 파이프는 이름이 있는 인자에서도 동작한다
// 파이프를 남용하지 말아라. 파이프는 목적이 아니라 수단일 뿐이다. 
// 때때로 경험이 없는 개발자들은 파이프를 사용할 것이라 생각하고 API의 모양을 설계하는데, 좋지 않은 접근이다.

// 자바스크립트 메소드 체이닝
@bs.send external map: (array<'a>, 'a => 'b) => array<'b> = "map"
@bs.send external filter: (array<'a>, 'a => bool) => array<'a> = "filter"

type request
@bs.val external asyncRequest: unit => request = "asyncRequest"
@bs.send external setWaitDuration: (request, int) => request = "setWaitDuration"
@bs.send external send: request => unit = "send"

let result1 = Js.Array2.filter(
  Js.Array2.map([1, 2, 3], a => a + 1),
  a => mod(a, 2) == 0
)

send(setWaitDuration(asyncRequest(), 4000))

// 바인딩 함수를 호출하면서 가독성이 안좋아졌는데, 파이프를 사용하면 자바스크립트 메소드 체이닝과 동일한 모양새로 바꿀 수 있다
let result2 = [1, 2, 3]
  -> map(a => a + 1)
  -> filter(a => mod(a, 2) == 0)

asyncRequest() -> setWaitDuration(4000) -> send

// 배리언트와 파이프
// 배리언트 생성자도 파이프와 함께 사용할 수 있다
// let result3 = name -> preprocess -> Some
// let result = Some(preprocess(name))

// 파이프 플레이스홀더
// 플레이스홀더는 언더스코어(_)를 이용해 작성할 수 있다. 이것은 해당 인자를 나중에 채우겠다는 의미이다.
let add3 = (a, b, c) => a + b + c
// 아래 두 함수는 의미가 같다.
let addTo7 = (x) => add3(3, x, 4)
let addTo7_ = add3(3, _, 4)

// 때때로, 파이프가 인자의 첫번째 위치하는 값을 가리키게 하고 싶지 않을 수 있다.
// 이럴 때, 파이프로 전달하고자 하는 위치에 플레이스홀더를 두면 된다.

let getName = (me: person) => me.name
let namePerson = (age, name) => name ++ Js.Int.toString(age)

let result3 = getName(me)
  -> namePerson(me.age, _)

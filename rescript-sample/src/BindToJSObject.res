// 레코드처럼 사용하는 자바스크립트 객체를 바인딩 하기
// 리스크립트 레코드를 사용해 바인딩하기
// 자바스크립트 객체가 고정된 필드들을 가지고 있다면, 리스크립트의 레코드에 해당한다.
// 리스크립트 레코드는 자바스크립트 객체로 깔끔하게 컴파일되므로, 명확하게 자바스크립트 객체를 리스크립트 레코드로 타입정의를 할 수 있다.
type person = {
  name: string,
  friends: array<string>,
  age: int,
}

@bs.module("MySchool") external john: person = "john"

let johnName = john.name

// 리스크립트 객체를 사용하여 바인딩하기
type person1 = {
  "name": string,
  "friends": array<string>,
  "age": int,
}

@bs.module("MySchool") external john1: person1 = "john1"

let johnName1 = john1["name"]

// @bs 게터/세터를 이용한 바인딩
// 자바스크립트 객체의 개별 필드들을 bs.get과 bs.set을 이용해 바인딩할 수 있다.
type textarea

@bs.set external setName: (textarea, string) => unit = "name"
@bs.get external getName: textarea => string = "name"

// bs.get_index와 bs.set_index를 사용해 인덱스 또는 동적 속성에 접근할 수 있다.
type t

@bs.new external create: int => t = "Int32Array"
@bs.get_index external get: (t, int) => int = ""
@bs.set_index external set: (t, int, int) => unit = ""

let i32arr = create(3)
i32arr->set(0, 42)
Js.log(i32arr->get(0))

// 해시 맵처럼 사용하는 자바스크립트 객체를 바인딩하기
// 자바스크립트 객체가 다음과 같이 쓰이는 경우가 있다.
// 1. 키들이 추가되거나 삭제
// 2. 모든 값이 같은 타입을 가진다.
// 이건 객체보다 해쉬 맵에 가깝다. get 및 set 연산이 포함된 Js.Dict(https://rescript-lang.org/docs/manual/latest/api/js/dict)
// 를 사용하면 자바스크립트 객체로 깔끔하게 컴파일된다.

// 클래스인 자바스크립트 객체를 바인딩하기
// new Date()를 에뮬레이션하려면 bs.new를 사용한다
type d

@bs.new external createDate: unit => d = "Date"

let date = createDate();

// 자바스크립트 클래스 자체를 모듈로 가져와서 객체를 생성하고 싶으면 bs.new와 bs.module을 함께 쓰면 된다.
type b
@bs.new @bs.module external book: unit => b = "Book"
let myBook = book();

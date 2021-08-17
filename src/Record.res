// 레코드(Record)는 자바스크립트 객체(Object)와 유사
// 기본적으로 불변이고 고정된 필드를 가지고 있다(확장 불가)

// 타입 선언 (레코드는 반드시 타입 선언을 해야한다)
type person = {
  age: int,
  name: string,
}

// 생성 (타입 추론 가능)
// 새 레코드 값을 생성할 때 리스크립트는 값의 형태가 맞는 레코드 타입 선언을 찾으려 한다.
// 그래서 me는 person 타입으로 추론된다.
let me = {
  age: 5,
  name: "Big ReScript",
}

// 다만, 타입 선언이 다른 파일이나 모듈에 있는 경우 어떤 파일이나 모듈인지 명시적으로 기재해야 한다.
let you: School.person = {
  age: 20, 
  name: "Big ReScript"
}

// Access
// 익숙한 .(dot) 어노테이션을 사용합니다.

let name = me.name

// Immutable Update
// spread 연산자를 사용해 이전 레코드로에서 새 레코드를 만들 수 있다. 원본 레코드는 변경되지 않는다.
let meNextYear = {
  ...me,
  age: me.age + 1,
}

// Mutable Update
// 레코드 필드는 선택적으로 변경 가능(mutable)할 수 있다.
// 이렇게하면 = 연산자를 사용해 해당 필드를 효율적으로 업데이트 할 수 있다.
type person1 = {
  name: string,
  mutable age: int,
}

let baby: person1 = {
  name: "Baby ReScript",
  age: 5,
}

baby.age = baby.age + 1

// JavaScript Output
// 리스크립트 레코드는 자바스크립트 객체로 컴파일 된다.
// getAge는 인자 entity가 age 필드와 가장 가까운 레코드 타입인 monster 타입이어야한다고 추론할 것이다.
type monster = {
  age: int, 
  hasTentacles: bool,
}

let getAge = (entity) => entity.age

let kraken = {
  age: 9999, 
  hasTentacles: true,
}
let me1 = {age: 5, name: "Baby ReScript"}

let kar = getAge(kraken)
// getAge(me1): 타입 오류!

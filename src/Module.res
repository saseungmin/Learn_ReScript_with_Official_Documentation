// 모듈은 작은 파일들 같은 것. 타입 정의와 let 바인딩, 자식 모듈 포함 등을 할 수 있다.

// 모듈을 만들려면 module 키워드를 사용. 모듈 이름은 반드시 대문자.
module School = {
  type profession = Teacher | Director

  let person1 = Teacher
  let getProfession = (person) =>
    switch person {
    | Teacher => "A teacher"
    | Director => "A director"
    }
}

// 모듈의 내용은 타입을 포함해 레코드와 동일한 표현인 . 표현을 사용해 접근할 수 있다.
// 네임스페이스처럼 사용할 수 있다.
let anotherPerson: School.profession = School.Teacher
Js.log(School.getProfession(anotherPerson)) // A teacher

// 모듈안에 모듈을 포함해도 작동한다
module MyModule = {
  module NestedModule = {
    let message = "hello"
  }
}

let message = MyModule.NestedModule.message

// 모듈 열기
// 모듈 안에 있는 타입 또는 값을 사용할 때마다 모듈 이름을 명시하는 것은 매우 귀찮다.
// 그래서 모듈을 열면 ("open")포함하는 모듈 이름을 쓰지 않고 내용만 쓸 수 있다.
// open School
// let p = getProfession(person1)

// School 모듈의 내용은 스코프 내에서 접근할 수 있다.
// Open을 쓰면 편리하지만, 값들이 어디서 왔는지 알기 힘들 수 있기 때문에 open은 주로 지역 범위 내에서만 사용한다.
let t = {
  open School
  getProfession(person1)
}

// 모듈 확장하기 모듈에서 include 키워드를 사용하면 모듈의 모든 내용을 새 모듈에 정적으로 확산한다.
// 상속이나 믹스인에 가깝다.
// 주의: include는 컴파일러 레벨에서 복사-붙여넣기와 같다. 되도록 사용 X, 최후의 수단으로만 사용
module BaseComponent = {
  let defaultGreeting = "Hello"
  let getAudience = (~excited) => excited ? "world!" : "world" 
}

module ActualComponent = {
  // 내용 복사
  include BaseComponent
  // BaseComponent.defaultGreeting을 덮어씌운다.
  let defaultGreeting = "Hey"
  let render = () => defaultGreeting ++ " " ++ getAudience(~excited = true)
}

// open은 매번 모듈 이름을 함께 언급할 필요가 없도록 모듈 내용을 현재 스코프로 가져온다.
// include는 모듈을 정적으로 복사해 현재 모듈에 포함

// 모든 .res파일은 모듈
// 모든 리스크립트 파일은 파일 이름이 모듈 이름으로, 파일 내용은 모듈 내용으로 컴파일 된다.
// 파일/모듈명은 대문자로 시작. React.res는 암시적으로 모듈 React를 구성하며 이 이름으로 다른 소스 파일에서 사용할 수 있다.

// 주의: 리스크립트 파일은 컨벤션에 의해 모듈 이름과 파일 이름의 대/소문자가 일치해야한다.
// 그래서 소문자로 시작하는 파일 이름은 모듈 이름으로 유효하지 않기 때문에, 암묵적으로 대문제로 시작하는 모듈 이름으로 바뀐다.

// 시그니쳐
// 모듈 타입은 시그니쳐로 불리고 명시적으로 쓰인다. 모듈 구현이 확장자가 .res인 파일에 정의되어 있다면, 모듈 타입은 .resi 파일에 정의
// 시그니쳐를 만들기 위해서는 module type 키워드를 사용해야 한다.
// 시그니쳐 이름은 반드시 대문자로 시작해야 한다.
module type EstablishmentType = {
  type profession
  let getProfession: profession => string
}
// EstablishmentType.profession 타입은 구체적인 타입이 아니라 추상화된 타입.
// 이는 "실제 타입이 무엇이든 신경 쓰지 않겠으나, getProfession에 들어갈 입력의 타입으로 쓰인다." 와 같은 말.
// module Company: EstablishmentType = {
//   type profession = CEO | Designer | Engineer | ...

//   let getProfession = (person) => ...
//   let person1 = ...
//   let person2 = ...
// }

// 모듈 시그니처 확장
// 하지만, include는 쓰지않는 것이 좋다.
module type BaseComponent = {
  let defaultGreeting: string
  let getAudience: (~excited: bool) => string
}

module type ActualComponent = {
  include BaseComponent
  let render: unit => string
}

// 모든 .resi 파일은 시그니쳐
// React.res 파일이 React 모듈에 암묵적으로 정의되듯이,
// React.resi 는 암묵적으로 React 시그니쳐를 정의한다.

// 펑터(모듈 함수)
// 모듈은 함수로 넘길 수 있다. 파일을 일급 객체로 전달하는 것과 동등하다.
// 그러나 모듈은 다른 일반적인 컨셉들과는 언어 레이어에서 다르므로 일반 함수로 전달하지는 못한다.
// 대신, 펑터라는 특별한 함수들을 전달한다.
// 펑터와 함수의 차이점
// 펑터는 let 대신 module 키워드 사용
// 펑터는 모듈의 인자값으로 받고 모듈을 반환
// 펑터는 반드시 인자를 어노테이션 해야한다.
// 펑터는 대문자로 시작해야 한다.
module type Comparable = {
  type t
  let equal: (t, t) => bool
}

module MakeSet = (Item: Comparable) => {
  /* 리스트를 자료 구조로 사용합니다. */
  type backingType = list<Item.t>
  let empty = list{}
  let add = (currentSet: backingType, newItem: Item.t): backingType =>
    // 아이템이 존재한다면,
    if List.exists(x => Item.equal(x, newItem), currentSet) {
      currentSet /* 동일한 불변 집합(리스트 타입)을 반환합니다. */
    } else {
      list{
        newItem,
        ...currentSet // 집합 앞에 추가하여 반환합니다.
      }
    }
}

// 펑터는 함수 애플리케이션 문법을 이용하여 적용될 수 있다.
// 이 경우에는 정수값들의 페어로 구성된 집합을 만든다.
module IntPair = {
  type t = (int, int)
  let equal = ((x1: int, y1: int), (x2, y2)) => x1 == x2 && y1 == y2
  let create = (x, y) => (x, y)
}

/* IntPair는 MakeSet이 요구하는 Comparable 시그니쳐를 만족합니다.*/
module SetOfIntPairs = MakeSet(IntPair)

// 모듈들과 펑터들은 언어 나머지 기능(함수, let 바인딩 데이터 구조 등)과는 다른 레이어에 있다.
// 예를 들면, 함수 펑터에 튜플이나 레코드를 전달 할 수 없다.

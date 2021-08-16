// 리스크립트의 타입은 다른 타입으로 바뀌지 않는다.
// 라스크립트의 타입들은 컴파일 후에 사라지고 타입이 필요없는 런타입 단게에서는 그 정보들이 남아있지 않는다.
// 리스크립트는 모든 정보들(특히 모든 타입 오류들)을 컴파일 중에 알려준다.
// 리스크립트의 타입 시스템은 절대 틀리지 않는다.
// 리스크립트의 타입 검사기는 가장 빠른 검사기 중 하나다.
// 타입을 하나하나 쓸 필요가 없다. 리스크립트는 변수의 값에서 타입을 유추할 수 있다.

// 추론(Inference)
// - let 바인딩은 어떠한 타입도 작성하지 않는다
let score = 10 // 10을 토대로 int라는 것을 알고 있다. 추론한다.
let add = (a, b) => a + b // int를 반환할 것이라고 추론한다.

// 타입 어노테이션(Type Annotation)
// 직접 타입을 유동적으로 쓸 수 있다. 이걸 리스크립트에서는 값에 어노테이션(Annotation)을 쓴다라고 한다.
let myScore: int = 10
let myInt = (5: int) + (4: int)

// 타입의 별칭(Type alias)
type scoreType = int
let x: scoreType = 10

// 타입 인자(A.k.a Generic)
// 타입들은 인자를 받을 수 있다. 다른 언어에서는 Generics라고 한다. 매개변수들의 이름은 꼭 '으로 시작해야 한다.
type coordinates<'a> = ('a, 'a, 'a)

let a: coordinates<int> = (10, 20, 20)
let b: coordinates<float> = (10.5, 20.5, 20.5)
let buddy = (10, 20, 20) // 타입 유추

type result<'a, 'b> = 
  | Ok('a)
  | Error('b)

type myPayload = {
  data: string
}

type myPayloadResults<'errorType> = array<result<myPayload, 'errorType>>

let payloadResults: myPayloadResults<string> = [
  Ok({ data: "hi" }),
  Ok({ data: "bye" }),
  Error("Something wrong happened!")
]

// 재귀 타입(Recursive Types)
// 함수와 같이, 타입은 rec을 사용해 자기 자신을 참조 가능.
type rec person = {
  name: string,
  friends: array<person>
}

let seung: person = {
  name: "seungmin",
  friends: [{
    name: "test",
    friends: []
  },
  {
    name: "harang",
    friends: []
  }],
}

// 상호적 재귀 타입(Mutually Recursive Types)
// 타입은 and 를 통해 상호적 재귀가 될 수 있다.
type rec student = {
  taughtBy: teacher
}
and teacher = {
  students: array<student>
}

let myTeacher: student = {
  taughtBy: {
    students: [],
  }
}

// 타입 탈출구(Type Escape Hatch)
// 암시적인 타입 변환과 같은 안전하지 않거나 값의 타입을 마구잡이로 예측하는 등의 위험을 허락하지 않는다.
// 하지만, 실용적인 측면에서 리스크립트는 타입 시스템을 "속일 수"있는 하나의 탈출구를 제공.
// but, 절대 이 기능을 남용하면 안된다. 
// external은 자바스크립트 값을 가져오고 사용하기 위한 리스크립트 주요 기능.
external converToFloat: int => float = "%identity" // int에서 float로 변환
let age = 10
let gpa = 2.1 +. converToFloat(age)

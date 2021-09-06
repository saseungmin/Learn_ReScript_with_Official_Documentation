// 리스크립트 자체는 null 또는 undefined에 대한 개념이 없다.
// 그러나 잠재적으로 존재하지 않는 값의 개념은 여전히 유용하며, 리스크립트에서도 안전하게 존재한다.
// 리스크립트는 option 타입으로 값을 감싸서 존재하는 값과 존재하지 않는 값을 표현한다.
// 즉, "option 타입의 값은 None(존재하지 않음)이거나 Some으로 감싸진 실제 값"을 의미.
// option 타입은 단지 일반적인 배리언트이다.
type option<'a> = None | Some('a)

let personHasACar = true

// "maybe null"의 개념(functional programming의 모나드)을 나타내려면 값을 감싸서 option 타입으로 만들면 된다.
// 이제 licenseNumber는 option 타입이다.
// 나중에 다른 코드가 이 값을 받으면 패턴 매칭을 통해 Some('a)와 None두 값을 모두 처리해야한다.
let licenseNumber = 
  if personHasACar {
    Some(5)
  } else {
    None
  }

// 일반적인 숫자를 option 타입으로 바꾸고 None 케이스에 대한 처리를 강제함으로써 리스크립트는 개념적으로 null값을 잘못 처리하거나 처리를 깜빡 잊을 가능성을 효과적으로 제거했다.
// 순수 리스크립트 프로그램에는 null 에러가 없다.
switch licenseNumber {
  | None => Js.log("The person doesn't have a car")
  | Some(number) => Js.log("The person's license number is " ++ Js.Int.toString(number))
}

// 자바스크립트의 undefined와 null의 Interoperate
// option 에서 undefined의 변환은 완벽하지 않다. 
// 왜냐하면 코드를 작성하는 쪽에서 option 값을 조정할 수 있기 때문입니다.
let x = Some(Some(Some(5)))

// 위 x는 5로 컴파일되지만 다은 문제가 있다.
let x2 = Some(None)

// 아래 x2의 값이 undefined로 컴파일되지 않는다. 이유는 polymorphic(다형성) option 타입('a의 경우 option<'a>)을 다룰 경우,
// 만약 우리가 특별한 어노테이션을 지정하지 않으면 많은 작업이 까다로워진다. 그렇기 때문에 다음 2가지 규칙을 따라야 한다.
// - 절대로 중첩된 option값 (Some(Some(Some(5)))와 같은)을 JS 쪽으로 전달하지 마라.
// - 절대로 JS에서 오는 값을 option<'a>로 표하지마라. 항상 구체적은 non-polymorphic type을 지정하라.

// 만약 option<int> 타입의 변수가 있을 경우 이 option 의 None 처리는 오직 undefined만 체크하고 null에 대해서는 체크하지 않는다.
// 이를 해결하기 위해 우리는 Js.Nullable 모듈을 제공하고 이것을 통해 보다 정교하게 null 및 undefined 접근을 할 수 있다.
// 예를 들어 null 과 undefined 둘 다 될 수 있는 문자열을 받을 경우 다음처럼 타이핑한다.
@bs.module("MyConstant") external myId: Js.Nullable.t<string> = "myId"

// 리스크립트 쪽에서 nullable 문자열을 생성하려면(아마 인터롭을 목적으로 JS 쪽에 전달하는 경우) 다음처럼 해야한다.
@bs.module("MyIdValidator") external validate: Js.Nullable.t<string> => bool = "validate"
// 여기서 Js.Nullable.return 함수는 문자열을 nullable 문자열로 감싸고 타입 시스템에게 값을 전달할 때 
// 이 값이 단순 문자열이 아니라 null 또는 undefined이 될 수 있다고 추적할수 있게 해준다.
let personId: Js.Nullable.t<string> = Js.Nullable.return("abc123")

let result = validate(personId)

// Js.Nullable 과 option 타입간 상호 변환
// Js.Nullable.fromOption는 option 타입에서 Js.Nullable.t 타입으로 변경한다. Js.Nullable.toOption는 그 반대이다.


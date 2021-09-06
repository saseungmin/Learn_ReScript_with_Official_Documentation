// attribute(데코레이터)
// 다른 여러 언어들처럼 리스크립트는 코드 조각을 속성으로 선언해 추가적인 기능을 얻는 것을 허용한다.
// @bs.inline 어노테이션을 사용하면 mode의 값은 인라인으로 사용한다.
@bs.inline
let mode ="dev"

let mode2 = mode

// 이런 어노테이션을 속성(또는 데코레이터)이라고 부른다.
// 속성은 @로 시작하고 사용되는 부분 이전에 선언된다.

// 사용
// 대부분에 속성을 사용할 수 있다. 추가 데이터 또한 함수 호출처럼 시각적으로 사용한다.
// @@warning("-27")는 파일 전체에 적용되는 스탠드 얼론 속성으로 이 속성은 @@구문과 함께 시작한다.
// 여기서 이 속성은 데이터 "-27"을 전달한다.
// https://rescript-lang.org/docs/manual/latest/warning-numbers
@@warning("-27")

// @unboxed는 타입 정의에 사용
@unboxed
type a = Name(string)

// @bs.val는 external 구문과 같이 사용.
@bs.val external message: string = "message"

type student = {
  age: int,
  // @bs.as("aria-label")는 ariaLabel 레코드 필드에 사용.
  @bs.as("aria-label") ariaLabel: string,
}

// @deprecated는 customDouble 표현에 사용된다. 
// 이 속성은 컴파일할 때 사용자에게 deprecated 경고를 보여준다.
@deprecated
let customDouble = foo => foo * 2

// @deprecated("Use SomeOther.customTriple instead")속성은 customTriple deprecation 되는 이유를 문자열로 보여준다.
@deprecated("Use SomeOther.customTriple instead")
let customTriple = foo => foo * 3

// 확장 구문 (Extension Points)
// 속성의 다른 카테고리이다. "확장 구문"이라 불린다. (초기 시스템에서 남은 용어)
%raw("var a = 1")
// 확장 구문은 아이템에 표시되는 어노테이션이 아니다. 확장 구문이 바로 아이템이다.
// 주로 컴파일러가 암시적으로 다른 항목을 대체하는 자리표시자 역할을 한다.
// 확장 구문은 %로 시작한다.
// 단독 확장 구문(@@처럼 독립된 일반 속성 구문과 비슷하다)은 %%로 시작.

// external은 자바스크립트 값을 가져오고 사용하기 위한 리스크립트 주요 기능.
// let 바인딩과 비슷하지만, "="  오른쪽은 값이 아니다. 자바스크립트에서 참조할 값 이름
// 바인딩 타입은 자바스크립트 값의 타입을 알아야하므로 필수이다.
// 파일 또는 모듈의 최상위 수준에만 존재할 수 있다.
// @bs 표기법으로 차별화 또는 확장한다.
@bs.val external setTimeout: (unit => unit, int) => float = "setTimeout"

// 일단 선언하면 let 바인딩처럼 external을 일반 값으로 사용할 수 있다.
/* document의 타입은 지정할 필요가 없는 임의의 타입('a) 이다. */
@bs.val external document: 'a = "document"

document["addEventListener"]("mouseup", _event => {
  Js.log("Clicked!")
})

let loc = document["location"]

document["location"]["href"] = "rescript-lang.org"

// 위 코드조각에서 document의 타입을 폴리모픽 타입인 'a로 지정했다.
// 모든 값이 전달 될 수 있으므로 타입 안전성을 많이 얻지 못한다.
// 그러나 타입 정의 리포지토리없이 리스크립트에서 자바스크립트 라이브러리를 사용해 빠르게 시작하기 좋다.

// 성능 & 결과물 가독성
// external 선언은 컴파일시 호출자에 인라인되어 자바스크립트 결과물에서 완전히 사라진다.
// 즉, 사용할때마다 추가 자바스크립트 <-> 리스크립트간 변환 비용이 발생하지 않는지 확인할 수 있다.
// 또한 결과물 가독성을 위해 더 나은 추가 리스크립트 런타임이 필요하지 않다.

// 디자인 의사결정
// 리스크립트의 인터롭은 직관적일 뿐더러 대부분의 자바스크립트 코드와 잘 호환한다.
// 안전한 타입 시스템과 훌륭한 인터롭의 조합을 통해, 전통적으로 많이 사용되는 점진적 타입시스템의 장점을 누릴 수 있다.

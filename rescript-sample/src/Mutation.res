// 가변 Let 바인딩
// 기본적으로 Let 바인딩은 불변이지만, ref로 값을 감싸면 표준 라이브러리가 하나의 필드로 구성된 레코드를 반환.
// 이 값은 변경할 수 있다.
let myValue = ref(5)

// contents 필드에 접근하면 ref로 감싼 실제값을 얻을 수 있다.
let five = myValue.contents

// 새로운 값 할당
myValue.contents = 6

// 또한 쉽게 사용할 수 있는 문법도 제공
myValue := 6

// 참고로 five 에 바인딩된 값은 여전히 5이다.
// ref 값을 변경한게 아니라 ref로 감싼 값을 변경했기 때문이다.

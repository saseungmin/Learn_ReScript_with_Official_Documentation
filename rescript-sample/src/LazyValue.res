// 지연된 값은 나중에 계산하는 것을 표현
// 자동으로 첫번째 실행결과를 기억해준다. 그리고 어떤 반복된 실행의 결과를 기억한 값을 리턴한다.
// 항상 같은 값을 반환하는 복잡한 함수와 식을 정의하는 데에 유용하다.
// 지연된 값은 Lazy.t('a)타입을 가지고 있다. 'a는 계산된 결과값을 리턴할 값의 타입이다.
// 모든 기능들은 전역으로 사용 가능한 Lazy 모듈에 캡슐화되어있다.

// 지연된 값 만들기
// 리스크립트는 지연된 값을 만드는 문법을 제공한다. lazy 키워드를 사용해 지연된 값을 만들 표현식을 작성할 수 있다.
let getFiles = 
  lazy({
    Js.log("Reading dir")
    Node.Fs.readdirSync("./pages")
  })

// 첫번째 호출시, 계산을 수행
Lazy.force(getFiles) -> Js.log

// 두번째 호출시 이미 계산한 파일들을 반환한다.
Lazy.force(getFiles) -> Js.log

// 아니면 이미 존재하는 함수를 lazy로 래핑할 수 있다.
let getFiles1 = () => {
  Node.Fs.readdirSync("./pages")
}

// 지연된 값으로 함수를 래핑한다
let lazyGetFiles = Lazy.from_fun(getFiles1)

/* 인자가 있는 함수를 래핑하는 예 */
let doesFileExist = name => {
  Node.Fs.readdirSync("./pages") -> Js.Array2.find(s => name === s)
}

/* Lazy 문법을 다시 사용. */
/* 여기서는 Lazy.from_fun을 사용할 수 없다. */
let lazyDoesFileExist = lazy(doesFileExist("blog.res"))

// unit => a와 같이 인자가 없는 함수를 래핑할 때는 Lazy.from_fun을 사용하고, 
// 인자가 1개 이상 있을 때는 lazy(expr) 키워드를 사용.

// 지연된 연산을 강제하기
// 지연된 값들은 값을 리턴할 수 있도록 명시적으로 실행되어야 할 필요가 있다.
// 패턴 매칭을 사용하면 지연된 값을 연산하게 할 수 있다.
// switch를 사용한 패턴 매칭이나 튜플 구조 분해와 같은 문법에서 적용된다.
/* 패턴 매칭으로 지연된 값 추출하기 */
let computation = lazy("computed")

switch computation {
| lazy("computed") => Js.log("ok")
| _ => Js.log("not ok")
}

/* 단일 값을 구조분해 합니다 */
/* 참고: 포매터를 사용하면 `let lazy word = ...` 로 재출력 될겁니다. */
let lazy(word) = lazy("hello")

/* Output: "hello" */
Js.log(word)

/* 튜플 구조분해 */
let lazyValues = (lazy("Hello"), lazy("world"))
let (lazy(word1), lazy(word2)) = lazyValues

Js.log2(word1, word2)

// 예제 핸들링
// 지연된 값이 예외를 발생하면, Lazy.force가 동일한 예외를 발생.
let readFile =
  lazy({
    raise(Not_found)
  })

try {
  Lazy.force(readFile)
} catch {
  | Not_found => Js.log("No file")
}
// try 구문을 사용하고 지연 연산에서 예외가 발생하면 catch 구문 안에서 처리된다.
// 그러나 예외는 자주 쓰이면 안된다!

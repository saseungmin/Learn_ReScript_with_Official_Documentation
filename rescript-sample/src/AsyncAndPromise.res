// 현재 ReScript 에서는 async및 await키워드를 지원하지 않는다.

// 프로미스
// 리스크립트는 자바스크립트 프로미스 지원을 위해 준비한 바인딩이 있다.
// 프로미스를 사용하려면 일반적으로 다음 3개 함수를 사용.
// Js.Promise.resolve: 'a => Js.Promise.t('a)
// Js.Promise.then_: ('a => Js.Promise.t('b), Js.Promise.t('a)) => Js.Promise.t('b)
// Js.Promise.catch: (Js.Promise.error => Js.Promise.t('a), Js.Promise.t('a)) => Js.Promise.t('a)
// 최신 Promise 바인딩은 현재 표준 라이브러리의 일부가 아니다. 지금은 별도로 설치 필요.
// https://github.com/ryyppy/rescript-promise#usage
let p1 = Promise.make((resolve, _reject) => {
  resolve(. "hello world")
})

let p2 = Promise.resolve("some value")

exception MyOwnError(string)

let p3 = Promise.reject(MyOwnError("some rejection"))

open Promise
Promise.resolve("hello world")
-> then(msg => {
  resolve("Message: " ++ msg)
})
-> then(msg => {
  Js.log(msg);
  resolve()
})
-> ignore

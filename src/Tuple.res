// 튜플(Tuple)은 자바스크립트에 존재하지 않는 리스크립트만의 자료구조.
// 불변, 순서가 있음, 생성 시점에 크기가 결정됨, 다른 타입의 값을 포함할 수 있음

let ageAndName = (24, "Lil' ReScript")
let my3dCoordinates = (20.0, 30.5, 100.0)

// 튜플 타입인 타입 어노테이션도 작성할 수 있다. 튜플의 값은 튜플 타입의 타입 어노테이션과 닮아야한다.
let ageAndName1: (int, string) = (24, "Lil' ReScript")
type coord3d = (float, float, float)
let my3dCoordinates1: coord3d = (20.0, 30.5, 100.0)

// 크기가 1인 튜플은 없다. 크기가 1인 튜플은 값으로 사용.
let oneTuple = (24)

// 튜플의 특정 요소를 얻으려면 튜플을 구조분해한다.
// _: 일부 요소를 무시
let (_, y, _) = my3dCoordinates

// 튜플은 구성 요소를 변경 할 수 없다. 구성 요소를 변경하려면 튜플을 구조분해하고 새로운 튜플을 생성한다
let coordinates1 = (10, 20, 30)
let (c1x, _, _) = coordinates1
let coordinates2 = (c1x + 50, 20, 30)

// 여러 값을 전달하려 하는 경우, 큰 작업 없이 손쉽게 이용할 수 있다.
let sum = (x: int, y: int): int => x + y
let divide = (x: int, y: int): int => x / y

let getCalculate = () => {
  let x = sum(5, 1)
  let y = divide(x, 5)
  (x, y)
}

// 튜플은 작은 범위에서 사용하도록 노력. 
// 오래 유지되고 자주 전달될 때 사용할 수 있는 자료구조로 필드 이름이 있는 레코드(Record)가 있다.

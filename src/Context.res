// 컨텍스트는 레벨에서 수동으로 Props 를 전달하지 않고 컴포넌트 트리를 통해 데이터를 전달할 수 있는 방법을 제공.

// 리스크립트에서, Props를 내려주는 것은 JSX prop punning 기능과 강력한 타입 추론을 바탕으로
// 타입스크립트 / 자바스크립트보다 훨씬 간단하므로 단순하게 Props 드릴링이 선호되는 경우가 더 많다.
// 코드에서 Button 컴포넌트의 스타일을 지정하기 위해 “theme” Props를 수동으로 생성해 내려준다.
// type theme = Light | Dark

// module Button = {
//   @react.component
//   let make = (~theme) => {
//     let className = switch theme {
//     | Light => "theme-light"
//     | Dark => "theme-black"
//     }
//     <button className> {React.string("Click me")} </button>
//   }
// }

// module ThemedButton = {
//   @react.component
//   let make = (~theme) => {
//     <Button theme />
//   }
// }

// module Toolbar = {
//   @react.component
//   let make = (~theme) => {
//     <div> <ThemedButton theme /> </div>
//   }
// }

// @react.component
// let make = () => {
//   /* 가장 상위 컴포넌트에서 테마를 정의해 자식 컴포넌트로 내려줍니다 */
//   <Toolbar theme=Dark />
// }

// 컨텍스트를 사용하면 중간 단계를 거치며 Props를 내려주는 것을 피할 수 있다.
module ThemeContext = {
  type theme = Light | Dark
  let context = React.createContext(Light)

  module Provider = {
    let provider = React.Context.provider(context)

    @react.component
    let make = (~value, ~children) => {
      React.createElement(provider, {"value": value, "children": children})
    }
  }
}

module Button = {
  @react.component
  let make = (~theme) => {
    let className = switch theme {
    | ThemeContext.Light => "theme-light"
    | Dark => "theme-black"
    }
    <button className> {React.string("Click me")} </button>
  }
}

module ThemedButton = {
  @react.component
  let make = () => {
    let theme = React.useContext(ThemeContext.context)

    <Button theme />
  }
}

module Toolbar = {
  @react.component
  let make = () => {
    <div> <ThemedButton /> </div>
  }
}

@react.component
let make = () => {
  <ThemeContext.Provider value=ThemeContext.Dark> <div> <Toolbar /> </div> </ThemeContext.Provider>
}

// 텍스트 Input에 useState 사용하기
@react.component
let make = () => {
  let (text, setText) = React.useState(_ => "");

  let onChange = evt => {
    ReactEvent.Form.preventDefault(evt)
    let value = ReactEvent.Form.target(evt)["value"]
    setText(_prev => value);
  }

  <div>
    <input onChange value=text />
  </div>
};

// 자식 컴포넌트로 setState 넘겨주기
module ControlPanel = {
  @react.component
  let make = (~setDarkmode, ~darkmode) => {
    let onClick = evt => {
      ReactEvent.Mouse.preventDefault(evt)
      setDarkmode(prev => !prev)
    }

    let toggleText = "Switch to " ++ ((darkmode ? "light" : "dark") ++ " theme")

    <div> <button onClick> {React.string(toggleText)} </button> </div>
  }
}

@react.component
let make1 = (~content) => {
  let (darkmode, setDarkmode) = React.useState(_ => false)
  // let (darkmode, setDarkmode) = React.Uncurried.useState(_ => false)

  let className = darkmode ? "theme-dark" : "theme-light"

  <div className>
    <section>
      <h1> {React.string("More Infos about ReScript")} </h1> content
    </section>
    <ControlPanel darkmode setDarkmode />
  </div>
}

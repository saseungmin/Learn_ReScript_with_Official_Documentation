module Label = ComponentsAndProps.Label

@react.component
let make = (~name: option<string>=?) => {
  let greeting = switch name {
    | Some(name) => "Hello " ++ name ++ "!"
    | None => "Hello stranger!"
  }
  <div>
    <div>
      {React.string(greeting)} 
    </div>
    <Label title="Test" />
  </div>
}

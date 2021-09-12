type todo = {
  id: int,
  content: string,
  completed: bool,
}

type action =
  | AddTodo(string)
  | RemoveTodo(int)
  | ToggleTodo(int)

type state = {
  todos: array<todo>,
  nextId: int,
}

let reducer = (state, action) =>
  switch action {
  | AddTodo(content) =>
    let todos = Js.Array2.concat(
      state.todos,
      [{id: state.nextId, content: content, completed: false}],
    )
    {todos: todos, nextId: state.nextId + 1}
  | RemoveTodo(id) =>
    let todos = Js.Array2.filter(state.todos, todo => todo.id !== id)
    {...state, todos: todos}
  | ToggleTodo(id) =>
    let todos = Belt.Array.map(state.todos, todo =>
      if todo.id === id {
        {
          ...todo,
          completed: !todo.completed,
        }
      } else {
        todo
      }
    )
    {...state, todos: todos}
  }

let initialTodos = [{id: 1, content: "Try ReScript & React", completed: false}]

@react.component
let make = () => {
  let (state, dispatch) = React.useReducer(
    reducer,
    {todos: initialTodos, nextId: 2},
  )

  let todos = Belt.Array.map(state.todos, todo =>
    <li>
      {React.string(todo.content)}
      <button onClick={_ => dispatch(RemoveTodo(todo.id))}>
        {React.string("Remove")}
      </button>
      <input
        type_="checkbox"
        checked=todo.completed
        onChange={_ => dispatch(ToggleTodo(todo.id))}
      />
    </li>
  )

  <> <h1> {React.string("Todo List:")} </h1> <ul> {React.array(todos)} </ul> </>
}


# Project 01 — Expense Tracker

## Project Description

Build a command-line expense management application using Haskell.

The application allows users to:

- Add expenses with a name and amount.
- Store expenses in memory.
- List recorded expenses.
- Calculate total expenditure.
- Navigate an interactive menu.
- Exit the application.

---

# Module 01 — Programming Fundamentals

**Module Objective:** Build a complete, standalone expense tracker using fundamental Haskell programming concepts.

## Chapter 1 — Haskell Fundamentals

### Topics

- Modules
- Basic data types
- Type aliases
- Functions
- Type signatures
- Function parameters
- Function application
- Tuples

### Task 1 — Define an Expense

#### 1. Concepts / Skills

- Type aliases
- Tuples
- `String`
- `Double`
- Type declarations

#### 2. Assignment

1. Create a Haskell module named `Main`.
2. Define an `Expense` type.
3. Represent each expense as a tuple.
4. Store the expense name as a `String`.
5. Store the expense amount as a `Double`.

#### 3. Code

```haskell
module Main where

type Expense = (String, Double)
```

#### 4. Explanation

- `module Main where` declares the module named `Main`.
- `type` creates an alternative name for an existing type.
- `Expense` is the new type alias.
- `String` represents text.
- `Double` represents floating-point numbers.
- `(String, Double)` is a tuple containing two values.

Example expense:

```haskell
("Food", 25.50)
```

The first element represents the expense name, and the second represents its amount.

---

### Task 2 — Format an Expense

#### 1. Concepts / Skills

- Function declarations
- Type signatures
- Function parameters
- Function application
- Tuple pattern matching
- String concatenation
- Type conversion

#### 2. Assignment

1. Create a function named `formatExpense`.
2. Accept an `Expense` as input.
3. Extract the expense name and amount.
4. Convert the numeric amount into text.
5. Return a formatted string containing the expense name, amount, and currency.

#### 3. Code

Add the following code below the `Expense` type:

```haskell
formatExpense :: Expense -> String
formatExpense (name, amount) =
  name ++ ": " ++ show amount ++ " EUR"
```

#### 4. Explanation

- `formatExpense` is the function name.
- `::` introduces the function's type signature.
- `Expense -> String` means the function accepts an `Expense` and returns a `String`.
- `(name, amount)` extracts both elements from the expense tuple.
- `name` receives the first element.
- `amount` receives the second element.
- `=` separates the function declaration from its implementation.
- `++` concatenates strings.
- `show` converts the numeric amount into a string.

Example:

```haskell
formatExpense ("Food", 25.50)
```

Result:

```text
Food: 25.5 EUR
```

---

## Chapter 2 — Data Structures

### Topics

- Lists
- List construction
- List concatenation
- List traversal
- Higher-order functions
- Function composition

### Task 3 — Display Expenses

#### 1. Concepts / Skills

- Lists
- List type signatures
- Higher-order functions
- `mapM_`
- `putStrLn`
- Function composition
- IO actions

#### 2. Assignment

1. Create a function named `displayExpenses`.
2. Accept a list of expenses.
3. Iterate through the list.
4. Format each expense using `formatExpense`.
5. Print every formatted expense to the terminal.

#### 3. Code

Add the following function:

```haskell
displayExpenses :: [Expense] -> IO ()
displayExpenses expenses =
  mapM_ (putStrLn . formatExpense) expenses
```

#### 4. Explanation

- `[Expense]` represents a list of expenses.
- `IO ()` represents an IO action that returns no meaningful value.
- `expenses` is the function parameter containing the list.
- `mapM_` executes an IO action for each element of a list.
- `putStrLn` prints text to the terminal.
- `.` is the function composition operator.
- `(putStrLn . formatExpense)` first formats an expense and then prints it.

Example list:

```haskell
expenses =
  [ ("Food", 25.50)
  , ("Transport", 12.00)
  ]
```

Calling:

```haskell
displayExpenses expenses
```

prints each expense on a separate line.

---

## Chapter 3 — Functional Programming

### Topics

- Pure functions
- Recursion
- Base cases
- Recursive list processing
- Pattern matching
- Immutable data

### Task 4 — Calculate Total Expenses

#### 1. Concepts / Skills

- Recursive functions
- Base cases
- List pattern matching
- Tuple pattern matching
- Wildcard patterns
- Arithmetic operations
- Pure functions

#### 2. Assignment

1. Create a function named `totalExpenses`.
2. Accept a list of expenses.
3. Return zero when the list is empty.
4. Extract the amount from the first expense.
5. Recursively calculate the total of the remaining expenses.
6. Return the sum of all amounts.

#### 3. Code

Add the following function:

```haskell
totalExpenses :: [Expense] -> Double
totalExpenses [] = 0
totalExpenses ((_, amount):rest) =
  amount + totalExpenses rest
```

#### 4. Explanation

- `totalExpenses` is a recursive function.
- `[Expense] -> Double` means it accepts a list and returns a number.
- `[]` represents an empty list.
- `totalExpenses [] = 0` defines the base case.
- `(_, amount)` extracts an expense tuple.
- `_` ignores the expense name.
- `amount` captures the numeric amount.
- `:` separates the first element from the remaining list.
- `rest` represents the remaining expenses.
- `totalExpenses rest` recursively processes the remaining list.

Example:

```haskell
totalExpenses
  [ ("Food", 25.50)
  , ("Transport", 12.00)
  ]
```

Calculation:

```text
25.50 + 12.00 + 0 = 37.50
```

The function is pure because it calculates a result without performing IO or modifying external state.

---

## Chapter 4 — Input and Output

### Topics

- IO actions
- `IO` type
- `do` notation
- Standard input
- Standard output
- String-to-number conversion

## Chapter 5 — Control Flow

### Topics

- `case` expressions
- Pattern-based branching
- Wildcard patterns
- Recursive application loops
- Immutable application state
- Program entry points

### Task 5 — Build the Interactive Application

#### 1. Concepts / Skills

- `IO`
- `do` notation
- `getLine`
- `putStrLn`
- `read`
- `show`
- `let` bindings
- `case` expressions
- Recursive application loops
- Immutable state management
- `main`

#### 2. Assignment

1. Create a function named `runApp`.
2. Accept the current list of expenses.
3. Display a menu containing four options.
4. Read the user's menu selection.
5. Implement the Add Expense operation.
6. Read the expense name and amount.
7. Convert the entered amount into a `Double`.
8. Add the expense to the list.
9. Implement the List Expenses operation using `displayExpenses`.
10. Implement the Show Total operation using `totalExpenses`.
11. Redisplay the menu after each completed operation.
12. Handle invalid menu selections.
13. Implement the Exit operation.
14. Create `main` to start the application with an empty list.

#### 3. Code

Add the following code below the existing functions:

```haskell
runApp :: [Expense] -> IO ()
runApp expenses = do
  putStrLn "\n1. Add expense"
  putStrLn "2. List expenses"
  putStrLn "3. Show total"
  putStrLn "4. Exit"

  choice <- getLine

  case choice of
    "1" -> do
      putStrLn "Expense name:"
      name <- getLine

      putStrLn "Amount:"
      input <- getLine

      let amount = read input :: Double
      runApp (expenses ++ [(name, amount)])

    "2" -> do
      displayExpenses expenses
      runApp expenses

    "3" -> do
      putStrLn (show (totalExpenses expenses))
      runApp expenses

    "4" -> do
      putStrLn "Goodbye!"

    _ -> do
      putStrLn "Invalid choice"
      runApp expenses

main :: IO ()
main = runApp []
```

#### 4. Explanation

**Function declaration**

```haskell
runApp :: [Expense] -> IO ()
```

- `runApp` accepts a list of expenses.
- `[Expense]` represents the current application data.
- `IO ()` indicates that the function performs IO actions.

**Do notation**

```haskell
runApp expenses = do
```

- `expenses` is the function parameter.
- `=` defines the function implementation.
- `do` allows multiple IO actions to execute sequentially.

**Reading input**

```haskell
choice <- getLine
```

- `getLine` reads a line of text from the terminal.
- `<-` binds the result of an IO action to a variable.
- `choice` contains the user's selection.

**Conditional branching**

```haskell
case choice of
```

- `case` examines the value of `choice`.
- Each branch handles a possible menu selection.
- `->` separates a matching pattern from its action.

**Converting input**

```haskell
let amount = read input :: Double
```

- `let` creates a local binding.
- `read` converts the input string into a numeric value.
- `:: Double` specifies the expected numeric type.

Note: `read` can cause a runtime error if the input is not a valid number. Input validation can be introduced in a later module.

**Adding expenses**

```haskell
runApp (expenses ++ [(name, amount)])
```

- `(name, amount)` creates a new expense tuple.
- `[(name, amount)]` creates a list containing that expense.
- `++` concatenates the existing list with the new list.
- `runApp` receives the updated list.

**Displaying expenses**

```haskell
displayExpenses expenses
runApp expenses
```

- `displayExpenses` prints the current expenses.
- `runApp expenses` displays the menu again.

**Calculating the total**

```haskell
putStrLn (show (totalExpenses expenses))
```

- `totalExpenses expenses` calculates the sum.
- `show` converts the result into a string.
- `putStrLn` prints the string.

**Application loop**

```haskell
runApp expenses
```

Calling `runApp` again creates a recursive application loop.

The current expense list is passed into the next function call.

**Application entry point**

```haskell
main :: IO ()
main = runApp []
```

- `main` is the executable's entry point.
- `IO ()` indicates that the program performs IO actions.
- `runApp []` starts the application with an empty expense list.

---

## Module 01 — Completion Checklist

- [ ] Task 1 — Define an Expense
- [ ] Task 2 — Format an Expense
- [ ] Task 3 — Display Expenses
- [ ] Task 4 — Calculate Total Expenses
- [ ] Task 5 — Build the Interactive Application

## Final Functional Requirements

- [ ] Users can add expenses.
- [ ] Users can list recorded expenses.
- [ ] Users can calculate total expenditure.
- [ ] Users can navigate the interactive menu.
- [ ] Users can exit the application.
- [ ] The application runs independently as a command-line program.

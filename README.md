
# Project 000 — Expense Tracker

## Project Description

Build a command-line expense management application using Haskell.

The application allows users to add expenses, list recorded expenses, calculate total expenditure, and exit through an interactive menu.

## Functional Requirements

- Add an expense with a name and amount.
- Store expenses in memory.
- Display all recorded expenses.
- Calculate total expenses.
- Provide an interactive command-line menu.
- Allow users to exit the application.

## Module 01 — Programming Fundamentals

### Chapter 1 — Haskell Fundamentals

**Topics:**
- Modules
- Basic data types
- Type aliases
- Functions
- Type signatures
- Function parameters
- Function application

**Task 1 — Define an Expense**

- Create an `Expense` type alias.
- Represent each expense as a tuple containing a name and an amount.
- Use `String` for the name and `Double` for the amount.

**Task 2 — Format an Expense**

- Implement `formatExpense`.
- Accept an `Expense` as input.
- Extract the expense name and amount.
- Return a formatted string containing the name, amount, and currency.

### Chapter 2 — Data Structures

**Topics:**
- Tuples
- Lists
- List construction
- List concatenation
- Pattern matching
- List traversal

**Task 3 — Display Expenses**

- Store multiple expenses in a list.
- Implement expense listing.
- Iterate through the list.
- Format and display each expense.

### Chapter 3 — Functional Programming

**Topics:**
- Pure functions
- Recursion
- Base cases
- Recursive list processing
- Function composition
- Immutable data

**Task 4 — Calculate Total Expenses**

- Implement `totalExpenses`.
- Accept a list of expenses.
- Return zero for an empty list.
- Extract each expense amount using pattern matching.
- Recursively calculate the sum of all amounts.

### Chapter 4 — Input and Output

**Topics:**
- IO actions
- `IO` type
- `do` notation
- Standard input
- Standard output
- String-to-number conversion

### Chapter 5 — Control Flow

**Topics:**
- `case` expressions
- Pattern-based branching
- Wildcard patterns
- Recursive application loops
- Application state

**Task 5 — Build the Interactive Application**

- Implement `runApp`.
- Display a menu with four options.
- Read the user's menu selection.
- Implement the Add Expense operation.
- Read the expense name and amount.
- Convert the entered amount into a number.
- Add the new expense to the list.
- Implement the List Expenses operation.
- Implement the Show Total operation.
- Redisplay the menu after each operation.
- Handle invalid menu selections.
- Implement the Exit operation.
- Define `main` to start the application with an empty expense list.

## Module 01 — Completion Criteria

- [ ] Users can add expenses.
- [ ] Users can list expenses.
- [ ] Users can calculate total expenditure.
- [ ] Users can navigate the menu.
- [ ] Users can exit the application.
- [ ] The application runs independently.

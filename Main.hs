
module Main where

-- NEW: Importing modules
-- import makes functionality from another module available.
--
-- Text.Read is a standard Haskell module.
-- (readMaybe) means we import only the readMaybe function.
--
-- readMaybe converts a String into another type safely.
-- Unlike read, it returns Nothing instead of crashing
-- when the input cannot be converted.

import Text.Read (readMaybe)

-- NEW: Data.Fixed and Centi
-- Data.Fixed provides fixed-precision numeric types.
-- Centi represents numbers with two decimal places.
--
-- Example:
-- 25.50 :: Centi
--
-- Centi is useful for a simple expense tracker because
-- Double can introduce binary floating-point errors.
--
-- Note: Centi rounds values to two decimal places.
-- For a financial application, explicit input validation
-- and integer-cent accounting may be preferable.

import Data.Fixed (Centi)


-- TASK #1: Define an expense

-- FIX 1/8: Money precision
--
-- BEFORE:
-- type Expense = (String, Double)
--
-- NEW: Centi replaces Double.
--
-- type creates a type alias.
-- Expense is an alternative name for (String, Centi).
--
-- String represents the expense name.
-- Centi represents the expense amount.
-- (String, Centi) is a tuple containing two values.
--
-- Example:
-- ("Food", 25.50)

type Expense = (String, Centi)


-- TASK #2: Format an expense

-- FIX 2/8: Correct type signature
--
-- BEFORE:
-- formatExpense :: Expense -> Strirng
--
-- PROBLEM:
-- Strirng is not a valid type.
--
-- FIX:
-- Replace Strirng with String.
--
-- :: declares a type signature.
-- -> separates input and output types.
--
-- formatExpense accepts an Expense and returns a String.
--
-- (name, amount) uses tuple pattern matching.
-- Haskell extracts the first value into name
-- and the second value into amount.
--
-- ++ concatenates strings.
-- show converts a value into its String representation.

formatExpense :: Expense -> String
formatExpense (name, amount) =
    name ++ ": " ++ show amount ++ " EUR"


-- TASK #3: Display expenses

-- FIX 3/8: Expense display order
--
-- NEW FUNCTION: displayExpenses
--
-- [Expense] means a list of Expense values.
-- IO () means the function performs an IO action
-- without returning a meaningful result.
--
-- mapM_ applies an IO-producing function
-- to every element of a list, in order.
--
-- putStrLn prints a String followed by a newline.
--
-- NEW OPERATOR: .
-- The dot is the function composition operator.
--
-- (putStrLn . formatExpense) means:
-- 1. Format an expense into a String.
-- 2. Print that String using putStrLn.
--
-- NEW FUNCTION: reverse
-- reverse returns the elements of a list
-- in the opposite order.
--
-- We add new expenses to the beginning of the list.
-- Reversing the list displays the oldest expense first.
--
-- Example:
-- Stored:    [Expense3, Expense2, Expense1]
-- Displayed: [Expense1, Expense2, Expense3]

displayExpenses :: [Expense] -> IO ()
displayExpenses expenses =
    mapM_ (putStrLn . formatExpense) (reverse expenses)


-- TASK #4: Calculate total expenses

-- FIX 4/8: Correct function name and numeric type
--
-- BEFORE:
-- total Expenses ((_, amount):rest) =
--
-- PROBLEM:
-- Function names cannot contain spaces.
--
-- FIX:
-- Use totalExpenses.
--
-- NEW CONCEPT: Recursive functions
-- A recursive function calls itself.
--
-- totalExpenses [] = 0
-- This is the base case.
-- An empty list has a total of zero.
--
-- ((_, amount):rest) uses pattern matching.
--
-- : separates the first element from the remaining list.
-- (_, amount) extracts the two values of an Expense.
-- _ ignores the expense name.
-- amount contains the numeric value.
-- rest contains the remaining expenses.
--
-- Example:
-- [("Food", 20), ("Bus", 5)]
--
-- First recursive call:
-- amount = 20
-- rest = [("Bus", 5)]
--
-- Second recursive call:
-- amount = 5
-- rest = []
--
-- Final result:
-- 20 + 5 + 0 = 25

totalExpenses :: [Expense] -> Centi
totalExpenses [] = 0
totalExpenses ((_, amount):rest) =
    amount + totalExpenses rest


-- TASK #5: Build the interactive application

-- NEW CONCEPT: IO actions
--
-- runApp accepts a list of expenses.
-- It displays a menu, reads input, and performs actions.
--
-- do allows multiple IO actions to be written
-- sequentially.
--
-- <- extracts a result produced by an IO action.
--
-- Example:
-- number_in <- getLine
--
-- getLine reads a line from the keyboard.
-- The entered String is assigned to number_in.
--
-- NEW CONCEPT: Application loop using recursion
--
-- runApp calls itself after completing menu actions.
-- This displays the menu again with the current expenses.
--
-- There is no need for a separate while loop.
--
-- The Exit branch deliberately does not call runApp,
-- allowing the application to terminate.

runApp :: [Expense] -> IO ()
runApp expenses = do

    putStrLn "\n"
    putStrLn "1 - Add an Expense"
    putStrLn "2 - List Expenses"
    putStrLn "3 - Show total"
    putStrLn "4 - Exit"

    number_in <- getLine

    -- NEW CONCEPT: case expressions
    --
    -- case examines a value and selects a matching branch.
    --
    -- "1", "2", "3", and "4" are String patterns.
    --
    -- -> separates a pattern from its corresponding action.
    --
    -- _ is a wildcard pattern matching any other input.

    case number_in of

        "1" -> do

            putStrLn "Please enter the expense name"
            expenseName <- getLine

            putStrLn "Please enter the expense amount"
            expensAmountInString <- getLine


            -- FIX 5/8: Safe input parsing
            --
            -- BEFORE:
            -- let expenseAmount =
            --     read expensAmountInString :: Double
            --
            -- PROBLEM:
            -- read can crash when the user enters invalid input.
            --
            -- NEW FUNCTION: readMaybe
            --
            -- readMaybe attempts to convert a String
            -- into a requested type.
            --
            -- NEW TYPE: Maybe
            --
            -- Maybe represents a result that may or may not exist.
            --
            -- Maybe Centi means:
            -- The conversion may produce a Centi value,
            -- or it may fail.
            --
            -- NEW CONSTRUCTORS: Just and Nothing
            --
            -- Just expenseAmount:
            -- The conversion succeeded.
            -- expenseAmount contains the converted value.
            --
            -- Nothing:
            -- The conversion failed.
            --
            -- Examples:
            -- readMaybe "25.50" :: Maybe Centi
            -- Result: Just 25.50
            --
            -- readMaybe "hello" :: Maybe Centi
            -- Result: Nothing
            --
            -- :: Maybe Centi specifies the expected
            -- result type for readMaybe.
            --
            -- The case expression handles both outcomes.

            case readMaybe expensAmountInString :: Maybe Centi of

                Just expenseAmount -> do

                    -- FIX 6/8: Efficient list insertion
                    --
                    -- BEFORE:
                    -- runApp (expenses ++ [(expenseName, expenseAmount)])
                    --
                    -- PROBLEM:
                    -- ++ appends lists and traverses the
                    -- existing expenses list: O(n).
                    --
                    -- NEW USE OF OPERATOR: :
                    --
                    -- : is the list constructor operator.
                    -- It adds one element to the beginning
                    -- of an existing list: O(1).
                    --
                    -- (expenseName, expenseAmount)
                    -- creates a tuple representing an Expense.
                    --
                    -- Example:
                    -- expenses = [("Food", 20)]
                    --
                    -- ("Bus", 5) : expenses
                    --
                    -- Result:
                    -- [("Bus", 5), ("Food", 20)]
                    --
                    -- NEW CONCEPT: Passing updated state
                    --
                    -- Instead of modifying a global variable,
                    -- we call runApp with a new list.
                    --
                    -- The old list remains unchanged.
                    -- The new recursive call receives
                    -- the updated list of expenses.

                    runApp ((expenseName, expenseAmount) : expenses)

                Nothing -> do

                    putStrLn "Invalid amount. Enter a number like 25.50"

                    -- The input was invalid.
                    -- Continue with the original expenses.

                    runApp expenses


        "2" -> do

            -- Display the existing expenses.
            --
            -- displayExpenses performs the printing.
            -- runApp then displays the menu again.
            --
            -- No expenses are added or removed.

            putStrLn "Here are the expenses:"
            displayExpenses expenses
            runApp expenses


        "3" -> do

            -- FIX 7/8: Correct function application
            --
            -- BEFORE:
            -- show totalExpenses expenses
            --
            -- PROBLEM:
            -- Function application associates to the left.
            --
            -- Haskell interprets the expression as:
            -- (show totalExpenses) expenses
            --
            -- That is incorrect because show expects
            -- a displayable value, not the function itself.
            --
            -- FIX:
            -- show (totalExpenses expenses)
            --
            -- Parentheses force Haskell to calculate
            -- totalExpenses expenses first.
            --
            -- NEW CONCEPT: Pure functions versus IO
            --
            -- totalExpenses calculates a numeric value.
            -- show converts that value into a String.
            -- putStrLn prints the resulting String.
            --
            -- show alone does not print anything.

            putStrLn (
                "Total: "
                ++ show (totalExpenses expenses)
                ++ " EUR"
                )

            -- Return to the menu without changing expenses.

            runApp expenses


        "4" -> do

            -- Exit the application.
            --
            -- There is no recursive runApp call here.
            -- After putStrLn finishes, the IO action ends.

            putStrLn "Thanks for using my program"


        _ -> do

            -- _ matches all remaining inputs.
            --
            -- This branch handles invalid menu commands.
            -- The application then returns to the menu.

            putStrLn "Invalid command / number"
            runApp expenses


-- FIX 8/8: Application entry point
--
-- NEW FUNCTION: main
--
-- main is the entry point of a Haskell executable.
--
-- main :: IO ()
-- declares that main is an IO action.
--
-- main = runApp []
-- starts the application with an empty expense list.
--
-- [] represents an empty list.
--
-- As expenses are added, runApp receives updated lists
-- through its recursive calls.

main :: IO ()
main = runApp []

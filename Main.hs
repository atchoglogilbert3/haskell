
module Main where

import Text.Read (readMaybe)
import Data.Fixed (Centi)


-- FIX 1/8: Money precision
-- BEFORE: type Expense = (String, Double)
-- PROBLEM: Double can introduce floating-point precision errors.
-- FIX: Use Centi for fixed two-decimal-place arithmetic.

type Expense = (String, Centi)


-- FIX 2/8: Type signature
-- BEFORE: formatExpense :: Expense -> Strirng
-- PROBLEM: Strirng is not a valid type.
-- FIX: Use String.

formatExpense :: Expense -> String
formatExpense (name, amount) =
    name ++ ": " ++ show amount ++ " EUR"


-- FIX 3/8: Expense display order
-- BEFORE:
--     mapM_ (putStrLn . formatExpense) expenses
-- PROBLEM:
-- New expenses are now inserted at the beginning.
-- Without reverse, newest expenses appear first.
-- FIX: Reverse the list when displaying expenses.

displayExpenses :: [Expense] -> IO ()
displayExpenses expenses =
    mapM_ (putStrLn . formatExpense) (reverse expenses)


-- TASK #4: Total expenses

-- FIX 4/8: Function declaration
-- BEFORE: total Expenses ((_, amount):rest) =
-- PROBLEM: Function names cannot contain spaces.
-- FIX: Use totalExpenses.
-- ALSO: Return Centi instead of Double.

totalExpenses :: [Expense] -> Centi
totalExpenses [] = 0
totalExpenses ((_, amount):rest) =
    amount + totalExpenses rest


-- TASK #5: Building the final application

runApp :: [Expense] -> IO ()
runApp expenses = do

    putStrLn "\n"
    putStrLn "1 - Add an Expense"
    putStrLn "2 - List Expenses"
    putStrLn "3 - Show total"
    putStrLn "4 - Exit"

    number_in <- getLine

    case number_in of

        "1" -> do

            putStrLn "Please enter the expense name"
            expenseName <- getLine

            putStrLn "Please enter the expense amount"
            expensAmountInString <- getLine


            -- FIX 5/8: Unsafe input parsing
            -- BEFORE:
            -- let expenseAmount =
            --     read expensAmountInString :: Double
            --
            -- PROBLEM:
            -- read crashes when the input is invalid.
            --
            -- FIX:
            -- Use readMaybe, which returns Maybe Centi.
            -- Just amount = successful conversion.
            -- Nothing = invalid input.

            case readMaybe expensAmountInString :: Maybe Centi of

                Just expenseAmount -> do

                    -- FIX 6/8: List insertion efficiency
                    -- BEFORE:
                    -- runApp (expenses ++ [(expenseName, expenseAmount)])
                    --
                    -- PROBLEM:
                    -- ++ traverses the existing list: O(n).
                    --
                    -- FIX:
                    -- Use : to prepend the expense: O(1).
                    -- Display order is restored in FIX 3/8.

                    runApp ((expenseName, expenseAmount) : expenses)

                Nothing -> do
                    putStrLn "Invalid amount. Enter a number like 25.50"
                    runApp expenses


        "2" -> do

            putStrLn "Here are the expenses:"
            displayExpenses expenses
            runApp expenses


        "3" -> do

            -- FIX 7/8: Function application and output
            -- BEFORE:
            -- show totalExpenses expenses
            --
            -- PROBLEM 1:
            -- Haskell interprets this as:
            -- (show totalExpenses) expenses
            -- This is an incorrect application of show.
            --
            -- PROBLEM 2:
            -- show is a pure function returning String.
            -- It does not perform an IO action.
            --
            -- FIX:
            -- First calculate totalExpenses expenses.
            -- Then convert the result using show.
            -- Finally display it using putStrLn.

            putStrLn (
                "Total: "
                ++ show (totalExpenses expenses)
                ++ " EUR"
                )

            runApp expenses


        "4" -> do

            putStrLn "Thanks for using my program"


        _ -> do

            putStrLn "Invalid command / number"
            runApp expenses


-- FIX 8/8: Missing application entry point
-- BEFORE:
-- No main function existed.
--
-- PROBLEM:
-- The executable needs a main IO action.
--
-- FIX:
-- Define main and start runApp with an empty list.

main :: IO ()
main = runApp []

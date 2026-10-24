
module Main where

type Expense = (String, Double)

formatExpense :: Expense -> String
formatExpense (name, amount) =
  name ++ ": " ++ show amount ++ " EUR"

totalExpenses :: [Expense] -> Double
totalExpenses [] = 0
totalExpenses ((_, amount):rest) =
  amount + totalExpenses rest

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
      mapM_ (putStrLn . formatExpense) expenses
      runApp expenses

    "3" -> do
      putStrLn ("Total: " ++ show (totalExpenses expenses) ++ " EUR")
      runApp expenses

    "4" ->
      putStrLn "Goodbye!"

    _ -> do
      putStrLn "Invalid choice"
      runApp expenses

main :: IO ()
main = runApp []

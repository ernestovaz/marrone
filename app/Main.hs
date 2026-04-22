module Main (main) where

import Options.Applicative

data Options = Options
  { verbose :: Bool
  , input   :: String
  }

parser :: Parser Options
parser = Options
  <$> switch
      ( long "verbose"
     <> short 'v'
     <> help "Enable verbose mode" )
  <*> strOption
      ( long "input"
     <> short 'i'
     <> metavar "TEXT"
     <> help "Input text" )

main :: IO ()
main = app =<< execParser opts
  where
    opts = info (parser <**> helper)
      ( fullDesc
     <> progDesc "Scream the input text"
     <> header "scream - a simple command-line tool" )


app :: Options -> IO ()
app opts = do
  let message = if verbose opts
                then "Screaming: " ++ input opts ++ "!!!"
                else input opts ++ "!!!"
  putStrLn message

module Main (main) where

import Options.Applicative
import Network.HTTP.Client
import Network.HTTP.Client.TLS

data Options = Options
  { verbose :: Bool
  , url   :: String
  }

parser :: Parser Options
parser = Options
  <$> switch
      ( long "verbose"
     <> short 'v'
     <> help "Enable verbose mode" )
  <*> strArgument
      ( metavar "URL"
     <> help "url to use" )

main :: IO ()
main = do 
  opts <- execParser parserInfo
  app opts
  where
    parserInfo = info (parser <**> helper)
      ( fullDesc
     <> progDesc "send GET to the provided url"
     <> header "marrone - a simple API tester" )


app :: Options -> IO ()
app args = do
  manager <- newManager tlsManagerSettings
  request <- parseRequest $ url args
  response <- httpLbs request manager

  putStrLn $ "The status code was: " ++ show (responseStatus response)
  print $ responseBody response

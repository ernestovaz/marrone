module Main (main) where

import Network.HTTP.Client
import Network.HTTP.Client.TLS

import qualified CommandlineParser

main :: IO ()
main = do 
  opts <- CommandlineParser.parse
  app opts

app :: CommandlineParser.Arguments -> IO ()
app args = do
  manager <- newManager tlsManagerSettings
  request <- parseRequest $ CommandlineParser.url args
  response <- httpLbs request manager

  putStrLn $ "The status code was: " ++ show (responseStatus response)
  print $ responseBody response

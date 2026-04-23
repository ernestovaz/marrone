module Main (main) where

import Network.HTTP.Client(newManager, parseRequest, httpLbs, responseStatus, responseBody, method)
import Network.HTTP.Client.TLS(tlsManagerSettings)
import qualified Data.ByteString.Char8 as C8

import qualified CommandlineParser

main :: IO ()
main = do 
  opts <- CommandlineParser.parse
  app opts

app :: CommandlineParser.Arguments -> IO ()
app args = do
  manager <- newManager tlsManagerSettings
  baseRequest <- parseRequest $ CommandlineParser.url args
  let request = baseRequest { method = C8.pack "GET" }
  response <- httpLbs request manager

  putStrLn $ "The status code was: " ++ show (responseStatus response)
  print $ responseBody response

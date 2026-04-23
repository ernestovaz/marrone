module CommandlineParser where

import Options.Applicative(Parser, ParserInfo, execParser, fullDesc, header, help, long, progDesc, short, strArgument, helper, info, metavar, switch, (<**>))

data Arguments = Arguments
  { verbose :: Bool
  , url   :: String
  }

parser :: Parser Arguments
parser = Arguments
  <$> switch
      ( long "verbose"
     <> short 'v'
     <> help "Enable verbose mode" )
  <*> strArgument
      ( metavar "URL"
     <> help "url to use" )

parserInfo :: ParserInfo Arguments
parserInfo = info (parser <**> helper)
  ( fullDesc
 <> progDesc "send GET to the provided url"
 <> header "marrone - a simple API tester" )


parse :: IO Arguments
parse = execParser parserInfo

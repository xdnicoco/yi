{-# OPTIONS_HADDOCK show-extensions #-}

-- |
-- Module      :  Yi.Keymap.Vim.Ex.Commands.Make
-- License     :  GPL-2
-- Maintainer  :  yi-devel@googlegroups.com
-- Stability   :  experimental
-- Portability :  portable

module Yi.Keymap.Vim.Ex.Commands.Make (parse) where

import           Control.Applicative
import           Control.Monad
import qualified Data.Text as T
import qualified Text.ParserCombinators.Parsec as P
import           Yi.Command
import           Yi.Keymap
import           Yi.Keymap.Vim.Common
import qualified Yi.Keymap.Vim.Ex.Commands.Common as Common
import           Yi.Keymap.Vim.Ex.Types
import           Yi.MiniBuffer

parse :: EventString -> Maybe ExCommand
parse = Common.parse $ do
    void $ P.string "make"
    args <- map T.pack <$> P.many (P.many1 P.space *> P.many1 P.anyChar)
    return $ Common.impureExCommand {
        cmdShow = T.pack "make"
      , cmdAction = YiA $ makeBuildE $ CommandArguments args
      }

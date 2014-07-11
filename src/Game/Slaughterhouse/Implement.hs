-- |
-- Module       : Game.Slaughterhouse.Implement
-- Description  : Things specific to a particular chess implementation
-- Copyright    : 2014, Peter Harpending.
-- License      : BSD3
-- Maintainer   : Peter Harpending <pharpend2@gmail.com>
-- Stability    : experimental
-- Portability  : archlinux

module Game.Slaughterhouse.Implement where

import           Data.Matrix
import qualified Data.Text as S
import           Game.Slaughterhouse.Agnostic

-- |Make a 'Board' from a 'String'
mkBoard :: String -> Board
mkBoard str = fromList 8 8 [fromSan t | c <- str
                                      , let t = S.singleton c
                                      ]
-- |The slaughter board
slaughterBoard :: Board
slaughterBoard = mkBoard slaughterStr

-- |The slaughter board string
slaughterStr :: String
slaughterStr = "rnbqkbnr\
               \rnbqqbnr\
               \pppppppp\
               \pppppppp\
               \PPPPPPPP\
               \PPPPPPPP\
               \RNBQQBNR\
               \RNBQKBNR"

-- |The kings board
kingsBoard :: Board
kingsBoard = mkBoard kingsStr

-- |The kings board string
kingsStr :: String
kingsStr = "    k   \
           \        \
           \        \
           \        \
           \        \
           \        \
           \        \
           \    K   "

-- |A standard chess board
stdBoard :: Board
stdBoard = mkBoard stdStr

-- |String representation of a standard chess board
stdStr :: String
stdStr = "rnbqkbnr\
         \pppppppp\
         \        \
         \        \
         \        \
         \        \
         \PPPPPPPP\
         \RNBQKBNR"

-- |Bughouse board - two 'stdBoard's next to each other.
bughouse :: Board
bughouse = stdBoard <|> stdBoard

slaughterhouse :: Board
slaughterhouse = slaughterBoard <|> kingsBoard

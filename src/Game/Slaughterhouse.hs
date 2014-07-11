-- |
-- Module       : Game.Slaughterhouse
-- Description  : Things specific to Slaughterhouse
-- Copyright    : 2014, Peter Harpending.
-- License      : BSD3
-- Maintainer   : Peter Harpending <pharpend2@gmail.com>
-- Stability    : experimental
-- Portability  : archlinux

module Game.Slaughterhouse where

import           Data.Matrix
import qualified Data.Text as S
import           Game.Slaughterhouse.Agnostic

-- |The slaughter board
slaughterBoard :: Board
slaughterBoard =  fromList 8 8 [fromSan t | c <- slaughterStr
                                          , let t = S.singleton c ]

-- |The slaughter board string
slaughterStr :: String
slaughterStr = "rnbqkbnr\
               \rnbqkbnr\
               \pppppppp\
               \pppppppp\
               \PPPPPPPP\
               \PPPPPPPP\
               \RNBQKBNR\
               \RNBQKBNR"

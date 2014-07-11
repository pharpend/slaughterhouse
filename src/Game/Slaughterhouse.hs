-- |
-- Module       : Game.Slaughterhouse
-- Description  : A module for Tropical whatever
-- Copyright    : 2014, Peter Harpending.
-- License      : BSD3
-- Maintainer   : Peter Harpending <pharpend2@gmail.com>
-- Stability    : experimental
-- Portability  : archlinux

module Game.Slaughterhouse where

import Data.Matrix
import Data.Ord

-- |The various types of chess pieces
data PieceType = Pawn
               | Knight
               | Bishop
               | Rook
               | Queen
               | King
  deriving (Eq, Read, Show)

-- |Convert each piece type to it's appropriate numerical value, according to
-- <http://en.wikipedia.org/wiki/Chess_piece_relative_value this Wikipedia entry>.
-- 
-- @
-- toInt Pawn   = 1
-- toInt Knight = 3
-- toInt Bishop = 3
-- toInt Rook   = 5
-- toInt Queen  = 9
-- toInt King   = undefined
-- @
-- 
toInt :: PieceType -> Int
toInt Pawn   = 1
toInt Knight = 3
toInt Bishop = 3
toInt Rook   = 5
toInt Queen  = 9
toInt King   = undefined

-- |Order pieces by their integer values, according to 'toInt'
instance Ord PieceType where
  compare = comparing toInt

-- |An actual piece needs a color, too
data ColoredPiece = Black PieceType
                  | White PieceType
  deriving (Eq, Read, Show)

-- |Be kind to the communist spelling as well
type ColouredPiece = ColoredPiece
-- |For those of us who are too lazy to type @Piece@
type Colored  = ColoredPiece
-- |For the lazy communists
type Coloured = ColoredPiece

-- |A square might have a piece on it
type Square = Maybe Coloured

-- |A board is just a 'Matrix' of 'Square's.
type Board = Matrix Square

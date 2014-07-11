{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeSynonymInstances #-}

-- |
-- Module       : Game.Slaughterhouse.Agnostic
-- Description  : Implementation-agnostic chess things.
-- Copyright    : 2014, Peter Harpending.
-- License      : BSD3
-- Maintainer   : Peter Harpending <pharpend2@gmail.com>
-- Stability    : experimental
-- Portability  : archlinux

module Game.Slaughterhouse.Agnostic where

import           Data.Matrix
import           Data.Ord
import qualified Data.Text as T

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


type ColouredPiece = ColoredPiece -- ^Be kind to the communist spelling as well
type Colored  = ColoredPiece      -- ^For those of us who are too lazy to type @Piece@
type Coloured = ColoredPiece      -- ^For the lazy communists
type Square = Maybe Coloured      -- ^A square might have a piece on it
type Board = Matrix Square        -- ^A board is just a 'Matrix' of 'Square's.

-- |Things that can be represented in Standard Algebraic Notation.
class ToSan c where
  toSan :: c -> T.Text

class FromSan c where
  fromSan :: T.Text -> Maybe c

instance ToSan PieceType where
  toSan Pawn   = "p"
  toSan Rook   = "r"
  toSan Knight = "n"
  toSan Bishop = "b"
  toSan Queen  = "q"
  toSan King   = "k"

instance FromSan PieceType where
  fromSan "p" = Just Pawn
  fromSan "r" = Just Rook
  fromSan "n" = Just Knight
  fromSan "b" = Just Bishop
  fromSan "q" = Just Queen
  fromSan "k" = Just King
  fromSan _   = Nothing

instance ToSan Coloured where
  toSan (White ptype) = T.toUpper $ toSan ptype
  toSan (Black ptype) = toSan ptype

instance FromSan Coloured where
  fromSan txt
      | isUpper   = Just . White =<< (fromSan $ T.toLower txt)
      | isLower   = Just . Black =<< fromSan txt
      | otherwise = Nothing
    where
      isUpper :: Bool
      isUpper = firstChar `elem` ['A'..'Z']
      isLower :: Bool
      isLower = firstChar `elem` ['a'..'z']
      firstChar :: Char
      firstChar = head $ T.unpack txt

instance ToSan Square where
  toSan (Just p)  = toSan p
  toSan Nothing   = " "

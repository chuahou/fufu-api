-- SPDX-License-Identifier: MIT
-- Copyright (c) 2021 Chua Hou

module Mahjong.Hand where

-- Tiles --

-- | Types of tiles.
data Tile = Manzu Int
          | Pinzu Int
          | Souzu Int
          | East
          | South
          | West
          | North
          | White
          | Green
          | Red
    deriving (Eq, Ord)

instance Show Tile where
    show (Manzu n) = show n <> "m"
    show (Pinzu n) = show n <> "p"
    show (Souzu n) = show n <> "s"
    show East      = "1z"
    show South     = "2z"
    show West      = "3z"
    show North     = "4z"
    show White     = "5z"
    show Green     = "6z"
    show Red       = "7z"

-- | @maybeNumber f t@ runs @f@ on the suit constructor and number of @t@ if @t@
-- a number tile, returning @Just@ of the result, and returning @Nothing@ for
-- word tiles.
maybeNumber :: ((Int -> Tile) -> Int -> a) -> Tile -> Maybe a
maybeNumber f (Manzu n) = Just $ f Manzu n
maybeNumber f (Pinzu n) = Just $ f Pinzu n
maybeNumber f (Souzu n) = Just $ f Souzu n
maybeNumber _ _         = Nothing

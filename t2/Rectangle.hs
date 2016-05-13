module Rectangle
    ( Point(..)
    , Orientation(..)
    , Rectangle(..)
    , getRectangles
    ) where

type Point = (Int,Int)
data Orientation = Begin | End deriving (Eq, Ord, Show)
data Rectangle = Rectangle {point1 :: Point,orientation :: Orientation, point2 :: Point, r_id :: Int} deriving (Eq, Ord, Show)
    
getRectangles :: [[String]] -> [Rectangle]
getRectangles ([id,x1,x2,y1,y2]:xs) =
    (Rectangle {point1 = ((read x1),(read y1)),
                orientation = Begin,
                point2 = ((read x2),(read y2)),
                r_id = read id})
    : (Rectangle {point1 = ((read x2),(read y2)),
                orientation = End,
                point2 = ((read x1),(read y1)),
                r_id = read id})
    : (getRectangles xs)
getRectangles _ = []

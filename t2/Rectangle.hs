module Rectangle
    ( Point(..)
    , Orientation(..)
    , Rectangle(..)
    , getRectangles
    ) where

-- Point: representacao de um ponto em coordenadas (x,y) similares as
-- coordenadas cartesianas mas com (0,0) no canto superior esquerdo.
type Point = (Int,Int)

-- Orientation: Begin se o ponto superior esquerdo esta andes do inferior
-- direito ou End caso contrario.
data Orientation = Begin | End deriving (Eq, Ord, Show)

-- Rectangle: Representacao de um retangulo pelos pontos inferior direito e
-- superior esquerdo, orientacao (tipo definido acima) e o identificador.
data Rectangle = Rectangle {point1 :: Point,orientation :: Orientation, point2 :: Point, r_id :: Int} deriving (Eq, Ord, Show)

-- getRectangles: recebe uma lista de strings, cada uma contendo a
-- representacao numerica de um retangulo e retorna uma lista dos retangulos
-- na representação definida acima.
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

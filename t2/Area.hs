module Area
    ( findArea
    ) where

import Rectangle
import Data.List
import qualified Data.Map as Map  

type End_value = Int
type Area = Int
type Y = Int

findArea :: [Rectangle] -> String
findArea = show . (process Map.empty Map.empty (0,0)) . sort

process :: Map.Map Int Area -> Map.Map Y Area -> (Area,Y) -> [Rectangle] -> Area
process begin_Map end_Map answer [] = fst answer
process begin_Map end_Map answer ((Rectangle (x1,y1) ori (x2,y2) id):xs) =
  if ori == Begin
     then process new_begin_Map_1 end_Map answer xs
     else process new_begin_Map_2 new_end_Map new_answer xs 
  where
    smalls = fst $ Map.split y1 end_Map
    lower_bound = if smalls == Map.empty then 0 else area + (snd . Map.findMax $ smalls)
    area = abs (x1 - x2) * abs (y1 - y2)
    new_begin_Map_1 = Map.insert id (area + lower_bound) begin_Map
    (Just area', new_begin_Map_2) = (Map.lookup id begin_Map, Map.delete id begin_Map)
    (new_end_Map, new_answer)
      | area' > fst answer = (Map.insertWith max y2 area' end_Map, (area', y2))
      | area' < fst answer && y2 >= snd answer = (Map.insertWith max (snd answer) (fst answer) end_Map, answer)
      | area' < fst answer && y2 < snd answer = (Map.insertWith max y2 area' end_Map, answer)
      | area' == fst answer && y2 >= snd answer = (Map.insertWith max (snd answer) (fst answer) end_Map, answer)
      | area' == fst answer && y2 < snd answer = (Map.insertWith max y2 area' end_Map, (area', y2))

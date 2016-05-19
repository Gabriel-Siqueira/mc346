module Area
    ( findArea
    ) where

import Rectangle
import Data.List
import qualified Data.Map as Map  

type End_value = Int
type Area = Int
type Y = Int
type Id = Int

-- findArea: Recebe uma lista de retangulos e retorna o maior area composta da
-- soma de areas de ratangulos compativeis.
findArea :: [Rectangle] -> String
findArea r = ((show . fst $ ans) ++ ";" ++ (show . snd $ ans))
             where ans = (process Map.empty Map.empty ((0,[]),0)) . (sortBy cmpRet) $ r
                   -- Compara os retangulos primeiro por x, depois pela ordem
                   -- e por fim por y
                   cmpRet (Rectangle (x,y) ori _ _)
                          (Rectangle (x',y') ori' _ _) =
                              if(x /= x')
                              then compare x x'
                              else if(ori /= ori')
                              then compare ori ori'
                              else compare y y'
             
-- process: Realiza o processamento necessario para calcular a area.
process :: Map.Map Id (Area, [Id]) -> Map.Map Y (Area,[Id]) -> ((Area,[Id]),Y) -> [Rectangle] -> (Area, [Id])
process begin_Map end_Map answer [] = fst answer
process begin_Map end_Map answer ((Rectangle (x1,y1) ori (x2,y2) id):xs) =
  if ori == Begin
     then process new_begin_Map_1 end_Map answer xs
     else process new_begin_Map_2 new_end_Map new_answer xs 
  where
    -- smalls: lista dos elementos do end_Map com chaves menores que y1.
    smalls = fst $ Map.split y1 end_Map
    -- lower_bound: elemento de end_Map com a maior chave que é menor que y1.
    lower_bound = if smalls == Map.empty
                  then (0,[])
                  else snd . Map.findMax $ smalls
    -- area: area do retangulo.
    area = abs (x1 - x2) * abs (y1 - y2)
    -- new_begin_Map_1 = novo mapa begin_Map (se ori = Begin).
    new_begin_Map_1 = Map.insert id (area + fst lower_bound,id:(snd lower_bound)) begin_Map
    -- new_begin_Map_2 = novo mapa begin_Map (se ori = End).
    -- value: valor do begin_Map referente ao id do retangulo atual.
    (Just value, new_begin_Map_2) = (Map.lookup id begin_Map, Map.delete id begin_Map)
    -- new_end_Map = novo mapa end_Map (se ori = End).
    -- new_answer = novo valor de answer (se ori = End).
    (new_end_Map, new_answer)
      | fst value > (fst.fst) answer =
          (Map.insertWith max y1 value end_Map, (value, y1))
      | fst value < (fst.fst) answer && y1 >= snd answer =
          (Map.insertWith max (snd answer) (fst answer) end_Map, answer)
      | fst value < (fst.fst) answer && y1 < snd answer =
          (Map.insertWith max y1 value end_Map, answer)
      | fst value == (fst.fst) answer && y1 >= snd answer =
          (Map.insertWith max (snd answer) (fst answer) end_Map, answer)
      | fst value == (fst.fst) answer && y1 < snd answer =
          (Map.insertWith max y1 value end_Map, (value, y1))

import System.IO
import Area
import Rectangle

-- Main: retorna uma acao de io que le a representação numerica dos
-- retangulos e imprime o valor maximo da soma da area de retangulos
-- compativeis.
main :: IO ()
main = do
  interact $ findArea . getRectangles . (map words) . lines
  putStr "\n"

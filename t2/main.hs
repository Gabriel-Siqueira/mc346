import System.IO
import Area
import Rectangle

main :: IO ()
main = do
  interact $ findArea . getRectangles . (map words) . lines
  putStr "\n"


import qualified Experiment.AtomicOps as XA

main :: IO ()
main = do
    putStrLn "-----------------"
    XA.atomicModifyIORef
    XA.atomicModifyIORefCAS
    XA.casIORef
    XA.casArrayElem
    putStrLn "-----------------"


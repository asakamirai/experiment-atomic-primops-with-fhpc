module Experiment.AtomicOps where

import qualified Data.IORef           as Ref
import qualified Data.Atomics         as Atm
import qualified Data.Primitive.Array as Arr

atomicModifyIORef :: IO ()
atomicModifyIORef = do
    ref <- Ref.newIORef (0 :: Int)
    v1 <- Ref.atomicModifyIORef' ref (\ v -> (1, v))
    v2 <- Ref.readIORef ref
    print (v1, v2)

atomicModifyIORefCAS :: IO ()
atomicModifyIORefCAS = do
    ref <- Ref.newIORef (0 :: Int)
    v1 <- Atm.atomicModifyIORefCAS ref (\ v -> (1, v))
    v2 <- Ref.readIORef ref
    print (v1, v2)

casIORef :: IO ()
casIORef = do
    ref <- Ref.newIORef (0 :: Int)
    ticket <- Atm.readForCAS ref
    (suc, next) <- Atm.casIORef ref ticket 1
    let v1 = Atm.peekTicket ticket
        v2 = Atm.peekTicket next
    print (v1, v2, suc)

casArrayElem :: IO ()
casArrayElem = do
    arr <- Arr.newArray 100 (0 :: Int)
    ticket <- Atm.readArrayElem arr 0
    (suc, next) <- Atm.casArrayElem arr 0 ticket 1
    let v1 = Atm.peekTicket ticket
        v2 = Atm.peekTicket next
    print (v1, v2, suc)

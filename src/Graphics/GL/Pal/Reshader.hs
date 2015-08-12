{-# LANGUAGE OverloadedStrings #-}
module Graphics.GL.Pal.Reshader where
import System.FSNotify
import Data.IORef
import Control.Concurrent
import Control.Monad
import Graphics.GL
import System.FilePath

import Graphics.GL.Pal.Shader
import Graphics.GL.Pal.Types

createReshaderProgram :: String -> String -> IO (IO GLProgram)
createReshaderProgram vertexShaderPath fragmentShaderPath = do
    
    let vsName = takeFileName vertexShaderPath
        fsName = takeFileName fragmentShaderPath

    initialShader <- createShaderProgram vertexShaderPath fragmentShaderPath
    shaderRef     <- newIORef initialShader

    let predicate event = case event of
            Modified path _ -> takeFileName path `elem` [vsName, fsName]
            _               -> False
        recompile event = do
            putStrLn $ "Recompiling due to event: " ++ show event
            newShader@(GLProgram prog) <- createShaderProgram vertexShaderPath fragmentShaderPath
            linked <- overPtr (glGetProgramiv prog GL_LINK_STATUS)
            when (linked == GL_TRUE) $ 
                writeIORef shaderRef newShader
    _ <- forkIO $ 
        withManager $ \mgr -> do
            -- start a watching job (in the background)
            _ <- watchTree
              mgr          -- manager
              "."          -- directory to watch
              predicate    -- predicate
              recompile    -- action
            forever $ threadDelay 10000000

    return (readIORef shaderRef)

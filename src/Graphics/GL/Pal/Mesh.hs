module Graphics.GL.Pal.Mesh where
import Graphics.GL
import Control.Monad.Trans
import Foreign

import Graphics.GL.Pal.Types

drawMesh :: MonadIO m => Mesh -> m ()
drawMesh mesh = do
    glBindVertexArray (unVertexArrayObject (meshVAO mesh))

    glDrawElements GL_TRIANGLES (meshIndexCount mesh) GL_UNSIGNED_INT nullPtr

    glBindVertexArray 0



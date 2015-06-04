module Graphics.GL.Pal.Types where
import Graphics.GL
import Control.Monad.Trans
import Foreign

newtype GLProgram         = GLProgram           { unGLProgram           :: GLuint }

newtype AttributeLocation = AttributeLocation   { unAttributeLocation   :: GLint  }
newtype UniformLocation   = UniformLocation     { unUniformLocation     :: GLint  }
newtype TextureID         = TextureID           { unTextureID           :: GLuint }

newtype VertexArrayObject = VertexArrayObject   { unVertexArrayObject   :: GLuint }

newtype TextureObject = TextureObject { unTextureObject :: GLuint }

data ColorSpace = SRGB | Linear

data Mesh = Mesh
        { meshVAO          :: VertexArrayObject
        , meshIndexCount   :: GLsizei
        }

-- | Utility for extracting a value from a pointer-taking function
overPtr :: (MonadIO m, Storable a) => (Ptr a -> IO b) -> m a
overPtr f = liftIO (alloca (\p -> f p >> peek p))
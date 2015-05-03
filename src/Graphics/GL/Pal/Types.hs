module Graphics.GL.Pal.Types where
import Graphics.GL

newtype GLProgram         = GLProgram           { unGLProgram           :: GLuint }

newtype AttributeLocation = AttributeLocation   { unAttributeLocation   :: GLint  }
newtype UniformLocation   = UniformLocation     { unUniformLocation     :: GLint  }
newtype TextureID         = TextureID           { unTextureID           :: GLuint }

newtype VertexArrayObject = VertexArrayObject   { unVertexArrayObject   :: GLuint }

data Mesh = Mesh
        { meshVAO          :: VertexArrayObject
        , meshIndexCount   :: GLsizei
        }
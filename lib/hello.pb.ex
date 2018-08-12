defmodule HelloRequest do
  use Protobuf

  @type t :: %__MODULE__{
          name: String.t()
        }
  defstruct [:name]

  field(:name, 1, optional: true, type: :string)
end

defmodule HelloReply do
  use Protobuf

  @type t :: %__MODULE__{
          message: String.t()
        }
  defstruct [:message]

  field(:message, 1, optional: true, type: :string)
end

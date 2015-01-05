defmodule WsSupervisor do
  @behaviour :supervisor

  @doc """
  启动WsSupervisor
  """
  def start_link do
    :supervisor.start_link({:local, __MODULE__} ,__MODULE__, [])
  end

  @doc """
  :supervisor行为回调函数
  """
  def init([]) do
    procs = []
    {:ok, {{:one_for_one, 10, 10}, procs}}
  end
end
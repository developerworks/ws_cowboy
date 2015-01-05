defmodule WsCowboy do
  @behaviour :application
  def start(_type, _args) do

    # 路由定义
    dispatch = :cowboy_router.compile([
      {:_, [
        {"/", :cowboy_static, {:priv_file, :ws_cowboy, "index.html"}},
        {"/websocket", WsHanlder, []},
        {"/static/[...]", :cowboy_static, {:priv_dir, :ws_cowboy, "static"}}
      ]}
    ])

    # 启动参数
    {:ok, _} = :cowboy.start_http(
      :http,
      100,
      [{:port, 4000}],
      [
        {:env, [
          {:dispatch, dispatch}
        ]}
      ]
    )

    # 启动监控主进程
    WsSupervisor.start_link
  end
  def stop(_state) do
    :ok
  end
end
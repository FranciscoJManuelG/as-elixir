defmodule Ring do
	def start(n, m, msg) do
		ring = create_process([], n)
		link_ring = ring ++ [hd ring]
		send_message(m, msg, link_ring)
		:ok
	end

	def create_process(l_pid,0), do: l_pid
	def create_process(l_pid, count) do
		create_process([spawn(fn -> Ring.loop() end)|l_pid], count-1)
	end

	def send_message(0,_, [next|pid]) do
		send next, {:stop, pid}
	end
	def send_message(m,msg, [next|pid] = l) do
		send next, {{m,pid}, msg}
		send_message(m-1, msg, l)
	end

	def loop() do
		receive do
			{:stop, [next|pid]} ->
				send next, {:stop, pid}
			{{m,[next|pid]}, msg} ->
				send next, {m, msg, pid}
				loop()
		end
	end
end

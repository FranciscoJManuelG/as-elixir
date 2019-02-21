defmodule Echo do
	def start() do
		pid = spawn (fn -> Echo.listen() end) 
		Process.register(pid, :echo)
		:ok
	end

	def listen() do
		receive do
			{:ok, msg} -> IO.puts(msg)
		end
		listen()
	end

	def stop() do
		Process.unregister(:echo)
		:ok
	end

	def print(term) do
    	send :echo, {:ok, term}
    	:ok
  	end
end

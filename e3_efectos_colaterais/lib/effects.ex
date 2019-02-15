defmodule Effects do
	def print(n) do
		print_aux(n,1)
	end
	def print_aux(m,i) when m >= i do
		IO.puts i
		print_aux(m, i+1)
	end
	def print_aux(_,_) do
		"done"
	end


	def even_print(n) do
		even_print_aux(n,1)
	end
	def even_print_aux(m,i) when m < i, do: "done"
	def even_print_aux(m,i) when rem(i,2) == 0 do
		IO.puts i
		even_print_aux(m, i+1)
	end
	def even_print_aux(m,i) when rem(i,2) != 0 do		
		even_print_aux(m, i+1)
	end
end

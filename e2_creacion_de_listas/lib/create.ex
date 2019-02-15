defmodule Create do
	def create(0),do: [] 
	def create(n) do
		create_aux(n,1,[1])
	end 
	def create_aux(m,i,l) when m <= i, do: l
	def create_aux(m,i,l) when m > i do
		lista_aux = l ++ [i+1]
		create_aux(m, i+1, lista_aux)
	end


	def reverse_create(0),do: [] 
	def reverse_create(n) do
		reverse_create_aux(n,[n])
	end 
	def reverse_create_aux(m,l) when m <= 1, do: l
	def reverse_create_aux(m,l) when m > 1 do
		lista_aux = l ++ [m-1]
		reverse_create_aux(m-1,lista_aux)
	end
end

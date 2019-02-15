defmodule Manipulating do
	def filter(l,n) do
		filter_aux(l,n,l)
	end
	def filter_aux(l,_,[]), do: l
	def filter_aux(l,n,[h|t]) when h <= n do
		filter_aux(l,n,t)
	end
	def filter_aux(l,n,[h|t]) do
		lista = l -- [h]
		filter_aux(lista,n,t)
	end


	def reverse(l) do
		reverse_aux(l,[])
	end
	def reverse_aux([],laux), do: laux
	def reverse_aux([h|t],laux) do
		list = [h|laux]
		reverse_aux(t,list)
	end


	def concatenate(l) do
		concatenate_aux(l,[])
	end
	def concatenate_aux([],laux), do: reverse(laux)
	def concatenate_aux([h|t],laux) do
		process_one_list(h,laux,t)
	end
	def process_one_list([],laux,l2) do
		concatenate_aux(l2,laux)
	end
	def process_one_list([h|t],laux,l2) do
		list = [h|laux]
		process_one_list(t,list,l2)
	end


	def flatten(l), do: reverse(flatten_aux(l,[]))
	def flatten_aux([],laux), do: laux
	def flatten_aux([h|t],laux) when is_list(h) do
		flatten_aux(t,flatten_aux(h,laux))
	end
	def flatten_aux([h|t],laux), do: flatten_aux(t,[h|laux])
end

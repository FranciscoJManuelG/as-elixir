defmodule Db do
	def new(), do: []


	def write(deb_ref, key, element) do
		write_aux(deb_ref,key,element,deb_ref)
	end
	def write_aux(l, key, element, []), do: l ++ [{key, element}]  
	def write_aux(l, key, element, [h|_] = laux) do
		{clave,elemento} = h
		update_key(clave, elemento, l, key, element, laux)
	end
	def update_key(clave, elemento, l, key, element, _) when clave == key do
		list = l -- [{clave, elemento}]
		list ++ [{key, element}]
	end
	def update_key(_, _, l, key, element, [_|t]) do
		write_aux(l, key, element, t)
	end


	def delete(db_ref, key) do
		find_key(db_ref,key,db_ref)
	end
	def find_key(l, key, [h|_] = laux) do
		{clave,elemento} = h
		delete_elements(clave, elemento, l, key, laux)
	end
	def delete_elements(clave, elemento, l, key, _) when clave == key do
		l -- [{clave, elemento}]
	end
	def delete_elements(_, _, l, key, [_|t]) do
		find_key(l, key, t)
	end


	def read([], _), do: {:error, :not_found}
	def read([h|t], key) do
		{clave,elemento} = h
		read_aux(clave, elemento, key, t)
	end
	def read_aux(clave, elemento, key, _) when key == clave  do
		{:ok, elemento}
	end
	def read_aux(_,_, key, tail) do
		read(tail, key)
	end


	def match(db_ref, element) do
		match_aux(db_ref, element, [])
	end
	def match_aux([], _, laux), do: laux
	def match_aux([h|t], element, laux) do
		{clave, elemento} = h
		find_element(clave, elemento, element, laux, t)
	end
	def find_element(clave, elemento, element, laux, tail) when elemento == element do
		laux = laux ++ [clave]
		match_aux(tail, element, laux)
	end
	def find_element(_, _, element, laux, tail) do
		match_aux(tail, element, laux)
	end


	def destroy([]), do: :okey
	def destroy([h|t] = l) do
		{clave, elemento} = h
		l -- [{clave, elemento}]
		destroy(t)
	end
end

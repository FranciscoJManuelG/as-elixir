defmodule Mi6 do
	use GenServer

	def init(list), do: {:ok, list}


	def fundar() do
		list = []
		GenServer.start_link(Mi6, list, name: :mi6) 
		:ok
	end


	def recrutar(axente, destino) do 
		GenServer.cast(:mi6, {:recrutar, axente, destino})
	end

	def handle_cast({:recrutar, axente, destino}, list) do
		result = read(list,axente)
		{:noreply, add(axente, destino, result, list)}
	end

	def add(axente, destino, result, list) when result == :not_found do
		l = create(String.length(destino))
		l = Enum.shuffle(l)
		write(list,axente,l)
	end

	def add(_, _, _, list) do
		list
	end


	def asignar_mision(axente, mision) do
		GenServer.cast(:mi6, {:asignar, axente, mision})
	end

	def handle_cast({:asignar, axente, mision}, list) when mision == :espiar do
		result = read(list, axente)
		{:noreply, espiar_agente(list,axente,result)}
	end

	def handle_cast({:asignar, axente, _}, list) do
		result = read(list, axente)
		{:noreply, contrainformar_agente(list,axente,result)}
	end

	def espiar_agente(list, _, result) when result == :not_found do
		list
	end

	def espiar_agente(list, axente, result) do
		{:ok, [h|_] = elemento} = result
		list = list -- [{axente, elemento}]
		lista_filtrada = filter(elemento, h)
		write(list,axente,lista_filtrada)
	end

	def contrainformar_agente(list, _, result) when result == :not_found do
		list
	end

	def contrainformar_agente(list, axente, result) do
		{:ok, elemento} = result
		list = list -- [{axente, elemento}]
		revlist = reverse(elemento)
		write(list,axente,revlist)
	end


	def consultar_estado(axente) do
		GenServer.call(:mi6, {:consultar, axente})
	end

	def handle_call({:consultar, axente}, _from, list) do
		result = read(list, axente)
		{:reply, find(result), list}
	end

	def find(result) when result == :not_found do
		:you_are_here_we_are_not
	end

	def find({_,element}) do
		element
	end


	def disolver() do
		GenServer.stop(:mi6)
	end

	def create(0),do: [] 
	def create(n) do
		create_aux(n,[n])
	end 
	def create_aux(m,l) when m <= 1, do: l
	def create_aux(m,l) when m > 1 do
		lista_aux = [m-1|l]
		create_aux(m-1,lista_aux)
	end


	def write(deb_ref, key, element) do
		deb_ref ++ [{key, element}]
	end


	def read([], _), do: :not_found
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
end

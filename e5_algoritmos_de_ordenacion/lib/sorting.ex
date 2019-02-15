defmodule Sorting do
	def quicksort([]), do: []
    def quicksort([pivot|tail]) do
        low = for n <- tail, n < pivot, do: n
        high = for n <- tail, n >= pivot, do: n
        quicksort(low) ++ [pivot] ++ quicksort(high)
    end


    def mergesort([]), do: []
    def mergesort([h]), do: [h]
    def mergesort(l) do
        {left, right} = Enum.split(l, div(length(l), 2))        
        merge(mergesort(left), mergesort(right))
    end
    def merge([],l), do: l
    def merge(l,[]), do: l
    def merge([h1|t1],[h2|t2] = l2) when h1 <= h2 do
    	[h1|merge(t1,l2)]
    end
    def merge(l1,[h2|t2]) do
    	[h2|merge(l1,t2)]
    end
end

defmodule Sorting do
    
    @doc "inserts elements at a given place"
    def insrt(x, []) do [x] end
    def insrt(x, [h|t]) do 
        cond do 
        x < h -> [x|[h|t]]
        true -> [h|insrt(x, t)]
        end
    end

    @doc "sorts a given list with the insertion sort algorithm"
    def inSort([]) do [] end
    def inSort([h|t]) do
        cond do
        t == [] -> [h]
        true -> 
            insrt(h, inSort(t))
        end
    end

    @doc "testing cases and lists"
    def investigate(l) do
        case l do 
            [_] -> IO.puts "one"
            l -> IO.puts "alot"
        end
    end
    
    @doc "sorts a given list with the mergesort algorithm"  
    def msort(l) do 
        case l do 
            [_] -> l
            l -> 
                {e1, e2} = msplit(l, [], [])
                Enum.each(e1, fn x -> IO.puts x end)
                IO.puts ""
                Enum.each(e2, fn x -> IO.puts x end)
                IO.puts "done"
                merge(msort(e1), msort(e2))
        end 
    end

    def merge(e1, []) do e1 end 
    def merge([], e2) do e2 end 
    def merge(e1, e2) do
        cond do
        hd(e1) < hd(e2) ->
            merge([hd(e1)|e2], tl(e1)) 
        true
            merge(tl(e2), [hd(e2)|e1]) 
        end
    end

    def msplit(l, s1, s2) do 
      {s1, s2} = Enum.split(l, div(length(l), 2))
    end

    @doc "
    case b do 
            [] -> {s1,s2} 
            b -> msplit(tl(b), [a|s1] , [hd(b)|s2]) 
        end
    "
    @doc "sorts a given list using quicksort
    
        quicksort:
        1. Take an pivot element (usually the first) and partition the
        list into lists containing low- and high elements
        2. quicksort both partitions (by using the same functtion)
        3. append into one list
        "
    def qsort([]) do [] end
    def qsort([p | l]) do 
        {s, l} = qsplit(p, l, [], [])
        small = qsort(s)
        large = qsort(l)
        append(small, [p | large])
    end

    @doc "splits a given list into two partitions, one high, the other low"
    def qsplit(_, [], small, large) do {small, large} end
    def qsplit(p, [h | t], small, large) do
        if p < h  do
            qsplit(p, t, small, [h | large])
        else
            qsplit(p, t, [h | small], large)
        end
    end

    @doc "appends two lists into one"
    def append(s, l) do
        case l do
        [] -> s
        [h | t] -> s ++ l
        end
    end
end

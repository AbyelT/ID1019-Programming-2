defmodule Sorting do
    
    @doc "inserts elements at a given place"
    def insrt(x, []) do [x] end
    def insrt(x, [h|t]) do 
        cond do 
        x < h -> [x|[h|t]]
        true -> [h|insrt(x,t)]
        end
    end

    @doc "sorts a given list with the insertion sort algorithm"
    def iSort([]) do [] end
    def iSort([h|t]) do
        cond do
        t == [] -> [h]
        true -> 
            insrt(h, iSort(t))
        end
    end

    @doc "testing cases and lists"
    def investigate(_l) do
        case _l do 
            [_] -> IO.puts "one"
            _l -> IO.puts "alot"
        end
    end
    
    @doc "sorts a given list with the mergesort algorithm

        mergesort
        1. split one list into two sub-lists
        2. sort both sub-lists using mergesort (recursion)
        3. merge both sorted lists into one list"
    def msort(l) do 
        case l do 
            [_] -> l
            l -> 
                {e1, e2} = msplit(l, [], [])
                merge(msort(e1), msort(e2))
        end 
    end

    @doc "merges two lists into one sorted list"
    def merge(e1, []) do e1 end 
    def merge([], e2) do e2 end 
    def merge(e1, e2) do
        cond do
        hd(e1) < hd(e2) ->
            merge(insrt(hd(e2),e1), tl(e2)) 
        true ->
            merge(tl(e1), insrt(hd(e1),e2)) 
        end
    end

    @doc "splits one list into two sub-lists"
    def msplit(l, s1, s2) do
        cond do 
            l == [] -> {s1, s2} 
            length(s1) <= length(s2) -> msplit(tl(l), [hd(l)|s1], s2)
            length(s1) > length(s2) -> msplit(tl(l), s1, [hd(l)|s2]) 
        end
    end

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
        if p < h do
            qsplit(p, t, small, [h | large])
        else
            qsplit(p, t, [h | small], large)
        end
    end

    @doc "appends two lists into one list
     (links the first list to the second list)"
    def append([], l2) do  l2 end
    def append([h|t], l2) do 
        [h|append(t, l2)]
    end
end

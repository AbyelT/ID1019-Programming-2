defmodule Lists do
    @doc "returns the head of a list
     "
    def tak([]) do IO.puts "empty list" end
    def tak([h|t]) do
        h
    end

    @doc "Returns the tail of a list
     "
    def drp([]) do IO.puts "empty list" end
    def drp([h|t]) do
        t            
    end

    @doc "Returns the number of elements in a list
     "
    def len([]) do 0 end
    def len(l) do
         1 + len(tl(l))   
    end

    @doc "Returns the sum of all the elements in 
     a list, assume that all elements are Integers
     "
    def sum(l) do
        cond do
            l == [] -> 0
            l != [] -> _n = hd(l) + sum(tl(l)) 
        end
    end

     @doc "duplicates every element on a given list, if it's not empty
     "
    def duplicate([]) do [] end
    def duplicate(l) do
        [hd(l),hd(l)|duplicate(tl(l))]
    end

    @doc "Adds a given element to the list, if its not on the list
     "
    def add(x, l) do
        cond do
            Enum.member?(l,x) == true -> IO.puts "is already a member of the given list"
            true -> [l|x]
        end
    end

    @doc "removes all occurences of an element x in the given list"
    def remove(x, l) do    
        cond do   
            Enum.member?(l,x) -> Enum.filter(l, fn n -> n != x end)
            true -> IO.puts "the given list does not contain the element"
        end
    end

    @doc "returns a list of all unique elements in the given list"
    def unique(l) do   
        cond do
            l == [] -> IO.puts "empty list" 
            true -> Enum.uniq(l)
        end
    end

    @doc "appends two lists into one list
     (links the first list to the second list)"
    def append(l1, l2) do l1 ++ l2 end

    @doc "returns a reverse instance of the given list"
    def reverse([]) do [] end
    def reverse(l) do reverse(l, []) end
    def reverse([], r) do r end
    def reverse([h|t], r) do 
        reverse(t, [h|r]) 
    end
end

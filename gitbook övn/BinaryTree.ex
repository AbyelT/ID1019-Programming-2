defmodule BinaryTree do
    
    @doc "Determines if an element is a member of a given tree.
    this function traverses the tree depending on if the given
    element is smaller/bigger than the element at the current node,
    until the same element is found or not"
    def member(_, :nil) do :no end
    def member(e, {:leaf, e}) do :yes end
    def member(_, {:leaf, _}) do :no end
    def member(e, {:node, e, _, _}) do :yes end
    def member(e, {:node, v, left, _}) when e < v do
       member(e, left)
    end
    def member(e, {:node, _, _, right})  do
       member(e, right)
    end

    @doc "Takes the given element and a given tree, returns a new 
    tree with the given element inserted onto the right place in the 
    new tree"
    def insert(e, :nil)  do  {:leaf, e}  end
    def insert(e, {:leaf, v}) when e < v do 
        {:node, v, insert(e, :nil), :nil} 
    end
    def insert(e, {:leaf, v}) do 
        {:node, v, :nil, insert(e, :nil)} end
    def insert(e, {:node, v, left, right}) when e < v do
        {:node, v ,insert(e, left), right}
    end
    def insert(e, {:node, v, left, right})  do
        {:node, v, left, insert(e, right)}
    end

    @doc "Takes the given element and tree, returns a new tree
    where the given element no longer exists in the tree"
    def delete(e, {:leaf, e}) do :nil end
    def delete(e, {:node, e, :nil, right}) do right end
    def delete(e, {:node, e, left, :nil}) do left end
    def delete(e, {:node, e, left, right}) do  
        v=reightmost(left)
        {:node, v, delete(v, left), right}
    end
    def delete(e, {:node, v, left, right}) when e < v do
        {:node, v, delete(e, left), right}
    end
    def delete(e, {:node, v, left, right})  do
        {:node, v, left, delete(e, right)}
    end

    @doc "Takes the largest element from a given tree"
    def reightmost({:leaf, e}) do e end
    def reightmost({:node, _, _, right}) do  reightmost(right) end

    @doc "Finds the value of a key and returns one of the following
        {:ok, value}: if the key is found
        :no: else"
    def lookup(e, {:leaf, e, value}) do {:ok, value} end
    def lookup(e, {:node, e, value, _,_}) do {:ok, value} end
    def lookup(_, {:leaf ,_ ,_}) do :no end
    def lookup(e, {:node, key, value, left, right}) when e < key do
        lookup(e, left)
    end
    def lookup(e, {:node, key, value, left, right}) do
        lookup(e, right)
    end

    @doc "Removes a key-value pair in a tree, given a key"
    def remove(e, {:leaf, e, _}) do :nil end
    def remove(_, {:leaf, _, _}) do end
    def remove(e, {:node, e, _, left, right}) do 
        {lKey, lVal} = reightmostPair(left)
        {:node, lKey, lVal, remove(lKey, left), right}
    end
    def remove(e, {:node, key, value, left, right}) when e < key do
        remove(e, left)
    end
    def remove(e, {:node, key, value, left, right}) do
        remove(e, right)
    end

    @doc "Finds the rightmost key-value pair in a given tree"
    def reightmostPair({:leaf, k, v}) do {k,v} end
    def reightmostPair({:node, _, _, _, right}) do  reightmostPair(right) end

    @doc "adds a key-value pair to the given tree, if the key already 
    exists within the tree the value is updated to the given"
    def add(key, value, :nil) do {:leaf, key, value} end
    def add(key, value, {:leaf, key, _}) do {:leaf, key, value} end
    def add(key, value, {:node, key, v, left, right}) do {:node, key, value, left, right} end
    def add(key, value, {:leaf, k, v}) when key < k do 
        {:node, k, v, add(key, value, :nil), :nil} 
    end
    def add(key, value, {:leaf, k, v}) do
        {:node, k, v, :nil, add(key, value, :nil)} 
    end
    def add(key, value, {:node, k, v, left, right}) when key < k do
        {:node, k, v, add(key, value, left), right}
    end
    def add(key, value, {:node, k, v, left, right}) do
        {:node, k, v, left, add(key, value, left)}
    end
end

defmodule Tree23 do
    
    @doc "insert a given key-value pair into a 2-3 tree, each instance of 
    the function handles a certain node/leaf"

    @doc "node: null"
    def insertf(key, value, nil), do: {:leaf, key, value}
    @doc "node: leaf"
    def insertf(k, v, {:leaf, k1, _} = l) do
        cond do
            k <= k1 ->
                {:two, k, {:leaf, k, v}, l}
            true ->
                {:two, k1, l, {:leaf, k, v}}
        end
    end
    @doc "node: two-node with leaf"
    def insertf(k, v, {:two, k1, {:leaf, k1, _} = l1, {:leaf, k2, _} = l2}) do
        cond do
            k <= k1 ->
                {:three, k, k1, {:leaf, k, v}, l1, l2}
            k <= k2 -> 
                {:three, k1, k, l1, {:leaf, k, v}, l2}
            true ->
                {:three, k1, k2, l1, l2, {:leaf, k, v}}
        end
    end
    @doc "node: three-node with leaf"
    def insertf(k, v, {:three, k1, k2, {:leaf, k1, _} = l1, {:leaf, k2, _} = l2, {:leaf, k3, _} = l3}) do
        cond do
            k <= k1 ->
                {:four, k, k1, k2, {:leaf, k, v}, l1, l2, l3}
            k <= k2 ->
                {:four, k1, k, k2, l1, {:leaf, k, v}, l2, l3}
            k <= k3 ->
                {:four, k1, k2, k, l1, l2, {:leaf, k, v}, l3}
            true ->
                {:four, k1, k2, k3, l1, l2, l3, {:leaf, k, v}}             
        end 
    end
    @doc "node: two-node with nodes"
    def insertf(k, v, {:two, k1, left, right}) do
        cond do
            k <= k1 
                case insertf(k, v, left)
                {:four ,k1 ,k2 ,k3 ,l ,m1 ,m2 ,r } -> {:three, k1, k2, k3, l, m1, r}
                update ->
                {:two, k1, upd, right} -> {:two, k1, upd, right}
            true

        end
    end
end
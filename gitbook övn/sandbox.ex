defmodule Intro do
    #recursion
    def prod(m, n) do prod(m, n, 0) end
    def prod(_m, 0, acc) do acc end 
    def prod(m, n, acc) when n > 0 do 
        prod(m, n-1, acc+m) 
    end
    def prod(m, n, acc) do prod(m, n+1, acc-m) end

    def fib(1) do 1 end
    def fib(0) do 0 end
    def fib(n) do
        fib(n-1) + fib(n-2)
    end

    #lists
    def add(x, []) do [x] end
    def add(x, [x|l]) do 
        [x|l]
    end
    def add(x, [e|l]) do
        [e| add(x,l)]
    end

    def remove(_x, []) do [] end
    def remove(x, [x|l]) do
        remove(x, l)
    end
    def remove(x, [e|l]) do
        [e|remove(x,l)]
    end
    
    def unique([]) do [] end
    def unique([e|l]) do 
        d = unique(l)
        [e|remove(e, d)]
    end

    def append([], b) do b end
    def append(a, []) do a end
    def append([a|tl], b) do
        [a|append(tl, b)]
    end

    #sorting
    def insrt(x, []) do [x] end
    def insrt(x, [h|t]) when x > h do
        [h|insrt(x, t)]
    end
    def insrt(x, l) do [x|l] end

    def isort([]) do [] end
    def isort([], acc) do acc end
    def isort(l) do isort(l, []) end
    def isort([h|t], acc) do 
        isort(t, insrt(h, acc))
    end

    def msort([e]) do [e] end
    def msort(l) do
        {l1, l2} = msplit(l, [], [])
        merge(msort(l1), msort(l2))
    end

    def merge(e1, []) do e1 end 
    def merge([], e2) do e2 end 
    def merge([e1|l1], [e2|l2]) do
        cond do
        e1 < e2 ->
            merge(insrt(e2, [e1|l1]), l2)
        true ->
            merge(l1, insrt(e1, [e2|l2])) 
        end
    end

    def msplit([h|t], m1, m2) do 
        cond do
            length(m1) > length(m2) -> msplit(t, m1, [h|m2])
            length(m1) <= length(m2) -> msplit(t, [h|m1], m2)
        end
    end
    def msplit([], m1, m2) do 
        {m1, m2}
    end

    #binary
    def binary(0) do [0] end
    def binary(v) do
        append(binary(div(v,2)), [rem(v,2)])
    end

    def better(v) do better(v, []) end
    def better(0, acc) do acc end
    def better(v, acc) do  
        better(div(v, 2), [rem(v, 2)|acc])
    end

    def integer(l) do integer(l, 0) end
    def integer([], acc) do acc end
    def integer([h|t], acc) do 
        integer(t, acc+(:math.pow(2,length(t))*h))
    end

    #calc
    def calc({:int, i}) do i end
    def calc({:add, a, b}) do calc(a) + calc(b) end
    def calc({:sub, a, b}) do calc(a) - calc(b) end
    def calc({:mul, a, b}) do calc(a) * calc(b) end
    def calc({:var, name}, bindings) do lookup(name, bindings) end
    def calc({:add, a, b}, bindings) do
        calc(a, bindings) + calc(b, bindings)
    end

    def lookup(name, [{:bind, name, val}|t]) do val end
    def lookup(name, [elem|list]) do
        lookup(name, list)
    end

    #derivate (works for n-order derivate)
    def deriv({:const, _}, _) do {:const, 0} end
    def deriv({:exp, v}) do {:const, elem(v, 1)-1} end
    def deriv({:var, v}, v) do {:const, 1} end
    def deriv({:var, y}, _) do {:var, y} end
    def deriv({:mul, e1, e2}, v) do
        case deriv(e2, v) do
            {:var, ^v} -> {:add, e1, e2}
            {:const, 1} -> {:mul, {:const, 1}, e1}
        end
    end
    def deriv({:add, e1, e2}, v) do {:add, deriv(e1, v), deriv(e2, v)} end
    def deriv({:pwr, e1, e2}, v) do {:mul, e2, {:pwr, e1, deriv({:exp, e2})}} end
end

defmodule BST do
    #binary tree
    def member(_, :nil) do :no end
    def member(e, {:leaf, e}) do :yes end
    def member(e, {:leaf, _}) do :no end
    def member(e, {:node, e, _, _}) do :yes end
    def member(e, {:node, v, _, right}) when e > v do member(e, right) end
    def member(e, {:node, _, left, _}) do member(e, left) end

    def insert(e, :nil) do {:leaf, e} end
    def insert(e, {:leaf, v}) when e > v do {:node, v, :nil, {:leaf, e}} end
    def insert(e, {:leaf, v}) do {:node, v, {:leaf, e}, :nil} end
    def insert(e, {:node, v, left, right}) when e > v do 
        {:node, v, left, insert(e, right)}
    end
    def insert(e, {:node, v, left, right}) do 
        {:node, v, insert(e, left), right}
    end

    def delete(e, {:leaf, e}) do :nil end
    def delete(e, {:node, e, left, :nil}) do {:leaf, left} end
    def delete(e, {:node, e, :nil, right}) do {:leaf, right} end
    def delete(e, {:node, e, left, right}) do
        r=rightmost(left)
        {:node, r, delete(r, left), right}
    end
    def delete(e, {:node, v, left, right}) when e > v do 
        {:node, v, left, delete(e, right)}
    end
    def delete(e, {:node, v, left, right}) do 
        {:node, v, delete(e, left), right}
    end
    def delete(e, _) do :no end

    def rightmost({:right, e}) do e end
    def rightmost({:node, e, left, :nil}) do e end
    def rightmost({:node, _, _, right}) do rightmost(right) end

    #2-3 tree
    def insertf(key, value, nil) do {:leaf, key value} end
    def insertf(k, v, {:leaf, k1, _} = l) when k => k1 do
        {:two, k1, {:leaf, k, v}, l}
    end
    def insertf(k, v, {:leaf, k1, _} = l) do
        {:two, k, l, {:leaf, k, v}}
    end

    def insertf(k, v, {:node, k1, {:leaf, k1, _}=l, {:leaf, k2, _}=r}) when k => k2 do
        {:three, k1, k2, l, r, {:leaf, k, v}}
    end
    def insertf(k, v, {:node, k1, {:leaf, k1, _}=l, {:leaf, k2, _}=r}) when k => k1 do
        {:three, k1, k, l, {:leaf, k, v}, r}
    end
    def insertf(k, v, {:node, k1, {:leaf, k1, _}=l, {:leaf, k2, _}=r}) do
        {:three, k, k1, l, {:leaf, k, v}, r}
    end

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

    def insertf(k, v, {:two, k1, left, right}) do
        cond do
            k <= k1 ->
                case insertf(k, v, left) do
                    {:four, q1, q2, q3, t1, t2, t3, t4} ->
                        {:three, q2, k1, {:two, q1, :nil, :nil}, {:},{:two, kl, left, right}}
                    updated ->
                        {:two, k1, updated, right}
                end
            true ->
                case insertf(k, v, right) do
                    {:four, q1, q2, q3, t1, t2, t3, t4} ->
                        ...
                    updated ->
                        {:two, k1, left, updated}
                end
        end
    end

    def insertf(k, v, {:three, k1, k2, left, middle, right}) do
        cond do
            k <= k1 ->
                case insertf(k, v, left) do
                {:four, q1, q2, q3, t1, t2, t3, t4} ->
                    {:four, q2, k1, k2, ..., ..., ..., ...}
                updated ->
                    {:three, k1, k2, updated, middle, right}
                end
            k <= k2 ->
                case insertf(k, v, middle) do
                {:four, q1, q2, q3, t1, t2, t3, t4} ->
                    ...
                updated ->
                    {:three, k1, k2, left, updated, right}
                end
            true ->
                case insertf(k, v, right) do
                {:four, q1, q2, q3, t1, t2, t3, t4} ->
                    ...
                updated ->
                    {:three, k1, k2, left, middle, updated}
                end
        end
    end
end
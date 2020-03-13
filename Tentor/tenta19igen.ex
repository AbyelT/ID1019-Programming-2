defmodule Tenta do
    
    def decode([]) do [] end 
    def decode([{char, 1}|tl]) do
        [char|decode(tl)]
    end
    def decode([{char, n}|tl]) do
        [char|decode([{char, n-1}|tl])]
    end
    
    def zip([], []) do [] end
    def zip([h1|t1], [h2|t2]) do
        [{h1, h2}|zip(t1, t2)]
    end

    def balance(:nil) do {0,0} end
    def balance(:node, _, left, right) do
        {lDepth, lBlnce} = balance(left)
        {rDepth, rBlnce} = balance(right)
        imbalance = max(max(lBlnce, rBlnce), abs(lDepth-rDepth))
        {1 + max(lDepth, rDepth), imbalance}
    end

    def eval(int) do int end
    def eval({:add, a, b}) do
        eval(a) + eval(b)
    end
    def eval({:mul, a, b}) do
        eval(a) * eval(b)
    end
    def eval({:neg, a}) do
        -eval(a)
    end

    def gray(n) do gray(n, 0, [[]]) end
    def gray(n, n, acc) do acc end
    def gray(n, i, acc) do 
        rAcc=Enum.reverse(acc)
        gray(n, i+1, update(0,acc) ++ update(1,rAcc))
    end

    def update(n, []) do [] end
    def update(n, [h|t]) do
        [h ++ [n]|update(n, t)]
    end

    def test() do
        cont = fib()
        {:ok, f1, cont} = cont.()
        {:ok, f2, cont} = cont.()
        {:ok, f3, cont} = cont.()
        [f1, f2, f3]
    end 

    def fib() do fn() -> fib(0, 1) end end
    def fib(n1, n2) do
        {:ok, n2, fn() -> fib(n2, n1+n2) end}
    end

    def take(func, n) do
        {func, list} = taken(func, n)
        {:ok, list, func}
    end

    def taken(func, 0) do {func, []} end
    def taken(func, n) do
        {_, val, nFunc} = func.()
        {nFunc, list} = taken(nFunc, n-1)
        {nFunc, [val|list]}
    end

    def facl(n) do facl(n, 2, [1]) end
    def facl(n, n, acc) do acc end
    def facl(n, i, [h|t]=l) do
        facl(n, i+1, [i*h|l])
    end

    #flatten
    def flatten([]) do [] end
    def flatten([h|t]) do
        flatten(h) ++ flatten(t)
    end
    def flatten(val) do [val] end
    
end

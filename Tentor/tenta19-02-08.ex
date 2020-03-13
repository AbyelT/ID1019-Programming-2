defmodule Tenta do
    
    #uppgift 1
    def decode(l) do decode(l, []) end
    def decode([], msg) do msg end
    def decode([h|t], msg) do
        decode(t, append(elem(h,0), elem(h,1), msg))
    end

    def append(c, 0, msg) do msg end
    def append(c, n, msg) do
        append(c, n-1, append(msg, c))
    end
    def append([], new) do [new] end
    def append([h|t], new) do
        [h|append(t, new)]
    end

    #uppgift 2
    def zip([], []) do [] end
    def zip([h1|t1], [h2|t2]) do
        [{h1, h2}|zip(t1, t2)]
    end

    #uppgift 3 
    def balance({:node, key, left, right}) do balance({:node, key, left, right}, 0) end
    def balance({:node, key, left, right}, depth) do
        {lDepth, lInbalance} = balance(left, depth+1)
        {rDepth, rInbalance} = balance(right, depth+1)
        diff = abs(lDepth - rDepth)
        inbalance = max(lInbalance, max(rInbalance, diff))
        {max(lDepth, rDepth), inbalance}    
    end
    def balance(:nil, depth) do {depth, 0} end

    #uppgift 4
    def eval({:add, a, b}) do eval(a) + eval(b) end
    def eval({:mul, a, b}) do eval(a) * eval(b) end
    def eval({:neg, expr}) do -expr end # -eval(x)
    def eval(val) do val end

    #uppgift 5
    def gray(val) do gray(val, []) end
    def gray(0, list) do list end
    def gray(val, []) do gray(val-1, [[0], [1]]) end
    def gray(val, list) do 
        rList = Enum.reverse(list)
        l=update(list, 0)
        r=update(rList, 1)
        gray(val-1, append(r,l))
    end

    def update([], _) do [] end
    def update([h|t], val) do
        [[val|h]|update(t, val)]
    end

    #uppgift 7
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
       {list, nfunc}=taken(func, n)
       {:ok, list, nfunc}
    end

    def taken(func, 0) do {[], func} end
    def taken(func, n) do
        {_, val, func} = func.()
        {list, func} = taken(func, n-1)
        {[val|list], func}
    end
    
    #uppgift 8
    def fac(1) do 1 end
    def fac(n) do 
        n*fac(n-1)
    end

    def facl(0, acc) do acc end
    def facl(n) do facl(n, []) end
    def facl(n, acc) do 
        facl(n-1, [fac(n)|acc])
    end

    #uppgift 9
end
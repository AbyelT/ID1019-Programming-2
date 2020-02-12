defmodule F7 do
    @doc "test will only test that the module reach the maximum
    iterations, in which it returns 0 OR the value of i, if |Zi| > 2"
    def test(i, _, _, m) when i == m do 0 end
    def test(i, z0, c, m) do 
        cond do
            Cmplx.abs(z0) > 2 -> i
            true -> test(i+1, Cmplx.add(Cmplx.sqr(z0), c), c, m)
        end
    end

    def fib(0) do {0, nil} end
    def fib(1) do {1, 0} end
    def fib(n) do 
        {n1, n2} = fib(n-1)
        {n1+n2, n1}
    end

    def lookup(_, []) do nil end
    def lookup(k, [{k,v}|_]) do v end
    def lookup(k, [_|rest]) do
        lookup(k, rest)
    end

    
end
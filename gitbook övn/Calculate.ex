defmodule Calc do

    @doc "evaluates the value of the given expression"
    def eval({:int, n}) do n end
    def eval({:add, a, b}) do
        eval(a) + eval(b)
    end
    def eval({:add, a, b}, bindings) do
        eval(eval(a, bindings)) + eval(eval(b, bindings))
    end
    def eval({:sub, a, b}) do
        eval(a) - eval(b)
    end
    def eval({:mlt, a, b}) do
        prod(eval(a), eval(b))
    end
    def eval({:var, name}, bindings) do 
        lookup(name, bindings)
    end

    @doc "finds the value of a variable given a list of bindings
     a variable is represented as {:var, name} where name is a atom
     a binding is represented as {:bind, name, value}, where value is a int"
    def lookup(var, [{:bind, var, value} | _]) do  
        {:int, value}
    end
    def lookup(var, [_ |rest]) do
        lookup(var, rest)
    end

    @doc "returns the product of m and n"
    def prod(m, n) do
        case m do
            0 -> 0
            _ when m < 0 -> (-n+prod(m+1,n))
            _ when m > 0 -> n+prod(m-1, n)
        end
    end
end
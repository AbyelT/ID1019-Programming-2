defmodule Tenta do
    
    def drop(l, n) do drop(l, n, 1) end
    def drop([], _) do [] end
    def drop([h|t], n, n) do drop(t, n, 1) end
    def drop([h|t], n, i) do
        [h|drop(t, n, i+1)]
    end

    def rotate(l, n) do rotate(l, n, []) end
    #def rotate(l, 0, acc) do append(l, reverse(acc)) end
    def rotate([h|t], i, acc) do
        rotate(t, i-1, [h|acc])
    end

    def nth({:leaf, char}, 1) do {:found, char} end
    def nth({:leaf, char}, n) do {:cont, n-1} end
    def nth({:node, left, right}, n) do
        case nth(left, n) do
            {:found, char} -> {:found, char}
            {:cont, e} -> case nth(right, e) do
                            {:found, char} -> {:found, char}
                            {:cont, i} -> {:cont, i}
                        end
        end
    end

    def hp35(l) do hp35(l, []) end
    def hp35([], [h|t]) do h end
    def hp35([:add|t], [a,b|l]) do 
        hp35(t, [a+b|l])
    end
    def hp35([:sub|t], [a,b|l]) do 
        hp35(t, [b-a|l])
    end
    def hp35([val|t], l) do 
        hp35(t, [val|l])
    end

    def pascal(n) do pascal(n-1, [1]) end
    def pascal(0, acc) do acc end
    def pascal(i, acc) do
        pascal(i-1, add(acc))
    end

    def add(l) do add(l, [1]) end
    def add([a,b|l], acc) do 
        add([b|l], [a+b|acc])
    end
    def add([a|l], acc) do [a|acc] end
    

    def remit({:node, val, _, _}, func) do
        
    end

    def trans(:nil, func) do end
    def trans({:node, val, left, right}, n) do
        trans(left, n)
        trans(right, n)
        func=fn() -> rem(val, n) end
        #{:node, trans()}
    end
end
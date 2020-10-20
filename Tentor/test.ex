defmodule Test do
    

    def drop(l, n) do drop(l, n, n) end
    def drop([], n, i) do [] end
    def drop([h|t], n, 1) do drop(t, n, n) end
    def drop([h|t], n, i) do [h|drop(t, n, i-1)] end

    def rotate(l, n) do rotate(l, [], n) end
    def rotate(l, acc, 0) do l ++ Enum.reverse(acc) end
    def rotate([h|t], acc, n) do rotate(t, [h|acc], n-1) end

    def nth({:leaf, val}, 1) do {:found, val} end
    def nth({:leaf, val}, n) do {:cont, n-1} end
    def nth({:node, left, right}, n) do
        case nth(left, n) do
            {:found, val} -> {:found, val}
            {:cont, k} ->   case nth(right, k) do
                                {:found, val} -> {:found, val}
                                {:cont, k} -> {:cont, k}
                            end
        end
    end

    def crc(sec) do crc(sec ++ [0,0,0], [1,0,1,1]) end
    def crc(l=[_,_,_], _) do l end
    def crc([0|t], gen) do crc(t, gen) end
    def crc(sec, gen) do
        crc(xor(sec, gen), gen)
    end

    def xor([h|t], [h|t2]) do 
        [0|xor(t,t2)]
    end
    def xor([_|t], [_|t2]) do 
        [1|xor(t,t2)]
    end
    def xor(list, []) do list end

    def luhn(list) do 
        sum(dubb(list))
    end

    def dubb([]) do [] end
    def dubb([h,h2|t]) do  
        [h*2, h2|dubb(t)]
    end
    def dubb([h]) do [h*2] end

    def sum(list) do sum(list, 0) end
    def sum([], acc) do 10 - rem(acc, 10) end
    def sum([h|t], acc) when h > 9 do sum(t, acc+h-9) end
    def sum([h|t], acc) do sum(t, acc+h) end
    # exempel: 17 -> 1 + 7 = 1 + (17 - 10) = 17 - 9
end
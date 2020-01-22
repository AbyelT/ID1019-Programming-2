defmodule Binary do
    
    @doc "converts an integer value to its binary
    represetation as a list of ones and zeroes
        Base case: return an empty list
        Recursive case: append the binary value of div(n,2)
        with a 1 or 0 depending if the number is even/odd
    "
    def to_binary(0) do [] end
    def to_binary(n) do 
        append(to_binary(div(n,2)), rem(n,2))
    end

    def append([], l2) do  [l2] end
    def append([h|t], l2) do 
        [h|append(t, l2)]
    end

    @doc "converts an integer value to its binary representation
    through an accumulator"
    def to_better(n) do to_better(n, []) end
    def to_better(0, b) do b end
    def to_better(n, b) do
        to_better(div(n, 2), [rem(n, 2) | b])
    end

    @doc "converts an binary representation of an integer to 
    its Integer representation"
    def to_integer(x) do to_integer(x, 0) end
    def to_integer([], n) do n end
    def to_integer([x | r], n) do
        to_integer(r, n+(:math.pow(2,length(r))*x))
        #to_integer(r, 2*n + x) :better variant
    end
end


defmodule Komp do
    # uppgift 2
    def push(e, stk) do [e|stk] end

    def pop([e|stk]=l) do
        case e do 
            [] -> :no
            e -> {:ok, e, stk}
        end
    end
    # nya uppgift 2
    def push2(e, stk) do [e|stk] end
    def pop2([]) do :no end
    def pop2([e|stk]) do {:ok, e, stk} end

    #problemet: glömde tänka att en tom list [] inte kan pattern matchas med [e|stk]

    # uppgift 3 
    def flatten([]) do [] end
    def flatten([h|t]) do 
        flatten([h]) ++ flatten(t)
    end
    def flatten([[val]]) do [val] end
    def flatten(val) do val end

    # nya uppgift 3
    def flatten2([]) do [] end
    def flatten2([h|t]) do 
        flatten2(h) ++ flatten2(t)
    end
    def flatten2(val) do [val] end

    #problemet: övertänkte, glömde att en lista med ett värde 
    # fortfarande kan matchas med [h|t], där h=värde och t=[]
    
    # uppgift 5
    def compact(:nil) do :nil end
    def compact({:leaf, val}) do {:ok, val} end
    def compact({node, left, right}) do 
        case compact(left) do 
            :nil -> case compact(right) do
                        {_, val} -> {:leaf, val}
                        {:node, _, _}=t -> {:node, left, t}
                    end
            {_, val} -> case compact(right) do
                            {_, ^val} -> left
                            :nil -> {:leaf, val}
                            {:node, _, _}=t -> {:node, left, t}
                        end
            {:node, l, r} = t1 -> {:node, t1, compact(right)}
        end
    end

    # nya uppgift 5
    def compact2(:nil) do :nil end
    def compact2({:leaf, val}) do {:leaf, val} end
    def compact2({node, left, right}) do 
        case compact2(left) do 
            :nil -> case compact2(right) do
                        {_, val} -> {:leaf, val}
                        {:node, _, _}=t -> {:node, :nil, t}
                        :nil -> :nil
                    end
            {_, lVal}=lLeaf -> case compact2(right) do
                                {_, ^lVal} -> left
                                {_, rVal}=rLeaf -> {:node, lLeaf, rLeaf}
                                :nil -> lLeaf
                                {:node, _, _}=t -> {:node, lLeaf, t}
                            end
            {:node, l, r} = t1 -> {:node, t1, compact2(right)}
        end
    end

    #problem: vissa slarvfel, glömde att det är nya, evaluerade värden som ska 
    # returneras (inte left, right t.ex)
end
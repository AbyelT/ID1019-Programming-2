defmodule Derivate do
    
    @type literal() :: {:const, number()} 
                    | {:const, atom()} 
                    | {:var, atom()}

    @type expr() :: {:add, expr(), expr()} 
                    | {:mul, expr(), expr()} 
                    | literal()
    
    def derivate({:const, _}, _), do: {:const, 0} 
    def derivate({:var, v}, v), do: {:const, 1} 
    def derivate({:var, y}, _), do: {:const, 0}
    def derivate({:mul, e1, e2}, v), do: {:add, {:mul, derivate(e1, v), e2}, {:mul, e1, derivate(e2, v)}}
    def derivate({:add, e1, e2}, v), do: {:add, derivate(e1, v), derivate(e2, v)}
end
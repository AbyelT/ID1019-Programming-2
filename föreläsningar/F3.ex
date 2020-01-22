defmodule F3 do
    
    def select_first({r}) do r end
    def select_first({r,_}) do r end
    def select_first({r,_,_}) do r end
    def select_first({r,_,_,_}) do r end

    def select_list([h|t]) do h end

    def nth(1, [r|:]) do r end
    def nth(n| [_|t]) do nth(n-1, t) end
end
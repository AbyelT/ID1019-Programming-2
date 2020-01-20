defmodule Append do
    def append([], y) do y end
    def append([h],y) do [h|y] end
    def append([h1,h2],y) do [h1,h2|y] end
    def append([h|t],y) do 
        res = append(t,y)
        [h|res]
    end


    def union([],y) do y end
    def union([h|t], y) do [h|union(t,y)]
        res = union(t,y)
        [h|res]
    end
end


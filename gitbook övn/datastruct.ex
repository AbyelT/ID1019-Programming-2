defmodule Datastruct do
    
    #def decode(signal, table) do decode(signal, table) end
    #def decode([], _table, acc) do Enum.reverse(acc) end
    def decode([], table) do [] end
    def decode([45|rest], {:node, :na, left, _}=table)do
        {nRest, val} = decode(rest, left)
        [val|decode(nRest, table)]   
    end
    def decode([46|rest], {:node, :na, _, right}=table) do
        {nRest, val} = decode(rest, right)
        [val|decode(nRest, table)]
    end
    def decode([45|rest], {:node, _, left, _}) do decode(rest, left) end
    def decode([46|rest], {:node, _, _, right}) do decode(rest, right) end
    def decode([32|rest], {:node, val, _, _}) do {rest, val} end

    def encode(text) do
        table = encode_table()
        encode(text, table)
    end
    def encode([], _) do [] end
    def encode([char | message], table) do 
        code = lookup(char, table)
        [code | encode(message, table)]
    end

    defp lookup(char, table), do: elem(table, char)

    defp encode_table() do
        codes()
        |> fill(0)
        |> List.to_tuple
    end

    defp fill([], n) do [] end
    defp fill([{n, code}|rest], n) do 
        [code|fill(rest, n+1)]
    end
    defp fill(list, n) do 
        [:na|fill(list, n+1)]
    end

    defp codes do
  [{32, '..--'},
    {37,'.--.--'},
    {44,'--..--'},
    {45,'-....-'},
    {46,'.-.-.-'},
    {47,'.-----'},
    {48,'-----'},
    {49,'.----'},
    {50,'..---'},
    {51,'...--'},
    {52,'....-'},
    {53,'.....'},
    {54,'-....'},
    {55,'--...'},
    {56,'---..'},
    {57,'----.'},
    {58,'---...'},
    {61,'.----.'},
    {63,'..--..'},
    {64,'.--.-.'},
    {97,'.-'},
    {98,'-...'},
    {99,'-.-.'},
    {100,'-..'},
    {101,'.'},
    {102,'..-.'},
    {103,'--.'},
    {104,'....'},
    {105,'..'},
    {106,'.---'},
    {107,'-.-'},
    {108,'.-..'},
    {109,'--'},
    {110,'-.'},
    {111,'---'},
    {112,'.--.'},
    {113,'--.-'},
    {114,'.-.'},
    {115,'...'},
    {116,'-'},
    {117,'..-'},
    {118,'...-'},
    {119,'.--'},
    {120,'-..-'},
    {121,'-.--'},
    {122,'--..'}]
    end
end
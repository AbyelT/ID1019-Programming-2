defmodule LZW do
    
    @alphabet 'abcdefghijklmnopqrstuvwxyz '

    def table do
        n = length(@alphabet)
        numbers = Enum.to_list(1..n)
        map = List.zip([@alphabet, numbers])
        {n + 1, map}
    end

    def encode([]), do: []
    def encode([word | rest]) do
        table = table()
        {:found, code} = encode_word(word, table)
        encode(rest, word, code, table)
    end
    def encode([], _sofar, code, _table), do: [code]

    def encode([word | rest], sofar, code, table) do
        extended = [word | sofar]
        case encode_word(extended, table) do
            {:found, ext} ->
                encode(rest, extended, ext, table);
            {:notfound, updated} ->
                {:found, cd} = encode_word(word, table)
                [code | encode(rest, [word], cd, updated)]
        end
    end

    def encode_word(word, {amount, list}) do
        case List.keyfind(list, word, 0) do
            {_word, code} -> 
                {:found, code}
            :nil -> 
                newList = {amount+1, [{word, amount+1}|list]}
                {:notfound, newList}
        end
    end

    def decode(codes) do 
        table = table()
        decode(codes, table)
    end
    def decode([], _) do [] end
    def decode([code | []], {_, words}) do
        {word, _code} = List.keyfind(words, code, 1)
        word
    end
    def decode([code|codes], {n, words}) do
        {word, _code} = List.keyfind(words, code, 1)
        [next|_] = codes

        next_char = case List.keyfind(words, next, 1) do
            {char, _} ->
                case is_list(char) do
                    true -> List.first(char)
                    false -> char
                end
            nil -> 
                [char|_] = word
                char
            end

        [word] ++ [decode(codes, {n + 1, [{[word] ++ [next_char], n}| words]})]
    end
end
defmodule Huffman do
    import List

    def sample do
    'the quick brown fox jumps over the lazy dog
    this is a sample text that we will use when we build
    up a table we will only handle lower case letters and
    no punctuation symbols the frequency will of course not
    represent english but it is probably not that far off'
    end

    def text()  do
        'if you can read this then this works!'
    end

    def test do
        sample = sample()
        tree = tree(sample)
        encode = encode_table(tree)
        text = text()
        seq = encode(text, encode)
        ##decode(seq, encode)
    end

    def tree(sample) do
        freq = freq(sample)
        huffman(freq)
    end

    #the frequency table
    def freq(sample) do freq(sample, []) end
    def freq([], acc) do isort(acc) end
    def freq([char|rest], acc) do
        freq(rest, addFreq(char, acc))
    end

    def addFreq(char, []) do [{char, 1}] end
    def addFreq(char, [{char, n}|t]) do [{char, n+1}|t] end
    def addFreq(char, [h|t]) do [h|addFreq(char, t)] end

    def isort([]) do [] end
    def isort([h|t]) do
        insert(h, isort(t))
    end

    def insert(h, []) do [h] end
    def insert({char1, n}=e, [{char2, m}=h|t]) when n > m do
        [h|insert(e, t)]
    end
    def insert(e, t) do [e|t] end

    def huffman([freq]) do freq end
    def huffman([]) do [] end
    def huffman([{c1, n1}=a, {c2, n2}=b|freq]) do
        new={{a, b}, n1+n2}
        huffman(insert(new, freq))
    end

    def encode_table(tree) do encode_table(tree, [], []) end
    def encode_table({{left, right}, val}, binary, acc) do
        acc=encode_table(left, [1|binary], acc)    
            encode_table(right, [0|binary], acc) 
    end
    def encode_table({char, val}, binary, acc) do
        [{char, Enum.reverse(binary)}|acc]
    end

    #def encode(text, table) do encode(text, table, ) end
    def encode([], table) do [] end
    def encode([c|text], table) do
        case List.keyfind(table, c, 0) do
            nil -> :error
            {_, binary} -> binary ++ encode(text, table)
        end
    end

    def decode([], _)  do [] end
    def decode(seq, table) do
        {char, rest} = decode_char(seq, 1, table)
        [char | decode(rest, table)]
    end

    def decode_char(seq, n, table) do
        {code, rest} = Enum.split(seq, n)
        case List.keyfind(table, code, 1) do
            {char,_} -> {char, rest}
            nil -> decode_char(seq, n+1, table)
        end
    end
end
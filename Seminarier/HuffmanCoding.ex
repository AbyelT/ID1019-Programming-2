defmodule Huffman do
    def sample do 
        'the quick brown fox jumps over the lazy dog
        this is a sample text that we will use when we build
        up a table we will only handle lower case letters and
        no punctuation symbols the frequency will of course not
        represent english but it is probably not that far off'
    end

    def text() do
        'this is something that we should encode'
    end

    def test() do
        sample = text()
        tree = tree(sample)
        encode = encode_table(tree)
        text = text()
        seq = encode(text, encode)
        decode(seq, encode)
    end

    @doc "Creates a Huffman tree given a sample text"
    def tree(sample) do
        freq = freq(sample)
        huffman(freq)
    end

    @doc "returns a huffman tree given a frequency list"
    def huffman(freq) do huffman(freq, {}) end
    def huffman([tree], {}) do tree end
    @doc "for each recursion: take the two least freq chars"
    def huffman([l1, l2| rem], {}) do 
        {_, v1, _, _} = prepareNode(l1)
        {_, v2, _, _} = prepareNode(l2)
        a = {:node, v1 + v2, l2, l1}
        huffman(insrt(a, rem), {})
    end

    @doc "creates an encoding table containging the
    mapping from characters to codes (binary) given a Huffman tree"
    def encode_table(tree) do encode_table(tree, [], []) end
    @doc "returns an encoding table given a huffman tree, the function
    uses an accumulator to save the encoding from each char"
    def encode_table({:node, val, left, right}, binary, accu) do
        accu=encode_table(left, [0|binary], accu)
            encode_table(right, [1|binary], accu)
    end
    def encode_table({char, freq}, binary, accu) do 
        [{char, reverse(binary)} | accu]
    end

    @doc "create an decoding table containing the mapping 
    from codes (binary) to characters given a Huffman tree"
    def decode_table(tree) do 
    end  

    @doc "encodes the text, using the mapping in the table
    returns a sequence of bits"
    def encode(text, table) do encode(text, table, []) end
    def encode([], table, accu) do flatAndOrder(accu) end
    def encode([hd|tl], table, accu) do
        encode(tl, table, inspect(hd, table, accu))
    end

    @doc "decodes the bit sequence using the mapping in
    table, return a text"
    def decode([], _)  do []
    end
    def decode(seq, table) do
        {char, rest} = decode_char(seq, 1, table)
        [char | decode(rest, table)]
    end

    @doc "//////////////////////// Helper functions ////////////////////////"

    @doc "returns a decoded message from a 
    given sequence and an encoding table"
    def decode_char(seq, n, table) do
        {code, rest} = Enum.split(seq, n)
        case List.keyfind(table, code, 1) do
            {char,_} -> {char, rest}
            nil -> decode_char(seq, n+1, table)
        end
    end

    @doc "converts an element from the frequency list to a node,
    if a node is given it is returned"
    def prepareNode(elem) do
        case elem do 
            {c1, v1} -> {c1, v1, :nil, :nil}
            {_, _, _, _} -> elem            
        end
    end

    @doc "returns a list of tuples containing a character and its frequency 
    in the given text."
    def freq(sample) do freq(sample, []) end  
    def freq([], freq) do iSort(freq) end
    def freq([char|rest], freq) do
        freq(rest, addFreq(char, freq))
    end
    
    @doc "adds a new tuple containing a char and its frequency onto 
    a list, if a similar char exists in the list."
    def addFreq(char, []) do [{char, 1}] end
    def addFreq(char, [{char, val}|tl]) do 
       [{char, val + 1} | tl] 
    end
    def addFreq(char, [hd|tl]) do
        [hd|addFreq(char, tl)]
    end

    @doc "inserts functions onto ASC order"
    def insrt(x, []) do [x] end
    def insrt(x, [h|t]) do 
        cond do 
        elem(x, 1) <= elem(h, 1) -> [x|[h|t]]
        true -> [h|insrt(x,t)]
        end
    end

    @doc "insertionsort"
    def iSort([]) do [] end
    def iSort([h|t]) do
        cond do
        t == [] -> [h]
        true -> 
            insrt(h, iSort(t))
        end
    end

    @doc "reverses a list"
    def reverse([]) do [] end
    def reverse(l) do reverse(l, []) end
    def reverse([], r) do r end
    def reverse([h|t], r) do 
        reverse(t, [h|r]) 
    end

     @doc "returns the binary code that corresponds to a char from huffman tree"
    def inspect(char, [{char, binary}|tl], accu) do
        [binary|accu]
    end
    def inspect(char, [hd|tl], accu) do
        inspect(char, tl, accu)
    end

    @doc "given an list of lists with binary codes, return an 
    ordered sequence of codes"
    def flatAndOrder(unsorted) do flatAndOrder(unsorted, []) end
    def flatAndOrder([], sec) do sec end
    def flatAndOrder([binary|rest], accu) do
        flatAndOrder(rest, add(binary, accu))
    end

    @doc "adds the binary code to the accumulator"
    def add([hd|tl], accu) do add(tl, [hd|accu]) end
    def add([], accu) do accu end
end

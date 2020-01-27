defmodule Huffman do
    def sample do 
        'the quick brown fox jumps over the lazy dog
        this is a sample text that we will use when we build
        up a table we will only handle lower case letters and
        no punctuation symbols the frequency will of course not
        represent english but it is probably not that far off'
    end

    def text() do
        "this is something that we should encode"
    end

    def test do
        sample = sample()
        tree = tree(sample)
        encode = encode_table(tree)
        decode = decode_table(tree)
        text = text()
        seq = encode(text, encode)
        decode(seq, decode)
    end

    @doc "Creates a Huffman tree given a sample text"
    def tree(sample) do
        freq = freq(sample)
        huffman(freq)
    end

    @doc "creates an encoding table containging the
    mapping from characters to codes (binary) given a Huffman tree"
    def encode_table(tree) do eTable(tree, [], []) end    

    @doc "create an decoding table containing the mapping 
    from codes (binary) to characters given a Huffman tree"
    def decode_table(tree) do 
        #dTable(tree, [], []) 
    end  

    @doc "encodes the text, using the mapping in the table
    returns a sequence of bits"
    def encode(text, table) do encode(String.codepoints(text), table, []) end
    def encode([], table, accu) do reverse(accu) end
    def encode([hd|tl], table, accu) do
        encode(tl, table, inspect(hd, table, accu))
    end

    @doc "returns the binary code that corresponds to a char from huffman tree"
    def inspect(char, [hd|tl], accu) do
        {bChar, binary} = hd
        cond do
            char == bChar -> removelist(binary, accu)
            true -> inspect(char, tl, accu)
        end
    end

    @doc "adds the binary code to the accumulator"
    def removelist([hd|tl], accu) do removelist(tl, [hd|accu]) end
    def removelist([], accu) do accu end

    @doc "decodes the bit sequence using the mapping in
    table, return a text"
    def decode(seq, tree) do
        # To implement...
    end

    @doc "//////////////////////// Helper functions ////////////////////////"

    @doc "returns an encoding table given a huffman tree, the function
    uses an accumulator to save the encoding from each char"
    def eTable({:node, left, right}, binary, accu) do
        accu=eTable(left, [0|binary], accu)
        accu=eTable(right, [1|binary], accu)
    end
    def eTable({char, freq}, binary, accu) do 
        [{char, binary} | accu]
    end

    @doc "returns a huffman tree given a frequency list"
    def huffman(freq) do 
        huffman(iSort(freq), {})
    end
    def huffman([_], htree) do htree end

    @doc "for each recursion: take the two least freq chars"
    def huffman([l1, l2| rem], htree) do 
        a={{elem(l1, 0), elem(l2, 0)}, elem(l1,1) + elem(l2,1)}
        cond do
            is_tuple(elem(l2, 0)) -> huffman(insrt(a, rem), {:node, l1, htree})
            is_tuple(elem(l1, 0)) -> huffman(insrt(a, rem), {:node, htree, l2})
            true -> huffman(insrt(a, rem), {:node, l1, l2})
        end
    end

    @doc "returns a list of tuples containing a character and its frequency 
    in the given text."
    def freq(sample) do freq(String.codepoints(sample), []) end
    def freq([], freq) do freq end
    def freq([char|rest], freq) do
        cond do 
            Enum.member?(Enum.reduce(freq, [], fn {x, y}, acc -> [x|acc] end), char) -> freq(rest, freq)
            true -> freq(rest, [{char, 1+Enum.count(rest, fn x -> char == x end)} | freq])
        end
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

    def reverse([]) do [] end
    def reverse(l) do reverse(l, []) end
    def reverse([], r) do r end
    def reverse([h|t], r) do 
        reverse(t, [h|r]) 
    end
end
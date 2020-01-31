defmodule F5 do
    @doc "defines the propertes of certain elements"
    @type suite :: :spade | :heart | :diamond | :club
    @type value :: 2..14
    @type card :: {:card, suite, value}

    def simpleRev(l) do simpleRev(l, []) end
    def simpleRev([], accu) do accu end
    def simpleRev([h|t], accu) do
        simpleRev(t, [h|accu])
    end
end
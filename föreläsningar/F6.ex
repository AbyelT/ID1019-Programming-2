defmodule Person do

    @moduledoc """
    This module represents lecture 6: type structures
    """

    defstruct name: "", age: 0

    @doc "specify to the compliator that the function fib()
    should take an int as argument and return an int "
    #@spec fib(integer()) :: int
    #@spec fib(integer()) :: int | atom | string

    @doc "defines our own data types and how they look like "
    @type value() :: 1..13
    @type suit() :: :spade | :heart | :diamond | :clubs
    @type card() :: {:card, suit(), value()}

    def concat(fname, ename) do
        "hello #{fname} #{ename}"
    end

    def keyval(%Person{age: age, name: name}) do
        "name: #{name}, age: #{age}"
    end

 @doc "types in elixir

    Singletons: types of individual data structures t.ex 1, 2, 'hi' etc
    Unions of singletons: integer(), atom()
    Tuples: {}, {atom(), integer()}
    Lists: [integer()], [{string(), integer()}]
    Tuple: a tuple
    list: a PROPER list (of any type)
    List(integer()): a proper list of integers
    
    type specifiers: uses
        - documentation of intended usage
        - auto detection of errors
        
    Dialyser (not compiler)
        1. check that given specifications agree with call patterns
        2. detect exceptions and dead code
        
    Elixir: dynamically typed lanuage, Types are checked and handled at the same time
        +Snabbt att skriva kod, typ deklarationer behövs oftast inte 
        +kompilering är enkelt
        -Extra overhead tid vid runtime
        -fel/errors upptäcks först vid run-time
        
        Reason of existence: easier to handle dynamic code updates in distributed systems"

end
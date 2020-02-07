defmodule Env do

    @moduledoc """
    This module represents the environment of an meta 
    interpreter for seminar 2
    """
    
    @doc "return an empty environment"
    def new() do [] end

    @doc "adds an binding between given variable and 
    data structure to the environment env"
    def add(id, str, env) do
        [{id, str}|env]
    end

    @doc "returns key-value pair of id and str if id was
    bound, else return nil"
    def lookup(id, [{id,str}|env]) do {id, str} end
    def lookup(id, [bind|env]) do lookup(id, env) end
    def lookup(id, []) do nil end

    @doc "returns an environment where all binding for the
    variables in the list ids"
    def remove([], env) do env end 
    def remove([id|ids], env) do
        case List.keyfind(env, id, 0) do
            {val, str} -> remove(ids, List.delete(env, {val, str}))
            nil ->  remove(ids, env)
        end
    end

    def closure([hd|free], env) do 
        case lookup(hd, env) do
            {_, str} -> closure(free, env)
            nil -> closure(free, remove([hd], env))
    end
    def closure([], env) do env end
end
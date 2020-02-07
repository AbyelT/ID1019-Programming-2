defmodule Eager do
import Env
    @moduledoc """
    This module handles the evaluation of sequences, 
    """
    
    @doc "eval_expr evaluates a given expression or 
    a sequence of expression"
    #def eval_expr(atm, env) do {:ok, atm} end
    def eval_expr({:atm, id}, env) do {:ok, id} end
    def eval_expr({:var, id}, env) do 
        case Env.lookup(id, env) do
            nil -> 
                :error
            {_, str} ->
                {:ok, str}
        end
    end
    def eval_expr({:cons, hd, tl}, env) do
        case eval_expr(hd, env) do
            :error ->
                :error
            {:ok, ns} ->
                case eval_expr(tl, env) do
                    :error ->
                        :error
                    {:ok, ts} ->
                        {:ok, {:cons, ns, ts}}
                end
        end
    end
    def eval_expr({:case, expr, cls}, env) do
        case eval_expr(expr, env) do
            :fail ->
                :fail
            {_, str} ->
                eval_cls(cls, str, env)
        end
    end
    def eval_expr({:lambda, par, free, seq}, env) do
        case Env.closure(free, env) do
            :error ->
                :error
            closure ->
                {:ok, {:closure, par, seq, closure}}
        end
    end
    
    @doc "eval_match takes a pattern, a data structure and 
    an existing environment and returns either an extended
    environment or the atom :fail
    
    It is supposted to 'match' expressions to variables (bind them)"
    def eval_match(:ignore, _, env) do
        {:ok, env}
    end
    def eval_match({:atm, id}, id, env) do
        {:ok, env}
    end
    def eval_match({:var, id}, str, env) do
        case Env.lookup(id, env) do
            nil ->
                {:ok, Env.add(id, str, env)}
            {_, ^str} ->
                {:ok, env}
            {_, _} ->
                :fail
        end
    end
    def eval_match({:cons, hp, tp}, {:cons, hs, ts}, env) do
        case eval_match(hp, hs, env) do 
            :fail ->
                :fail
            {:ok, env} ->
                case eval_match(tp, ts, env) do 
                    :fail ->
                        :fail
                    {:ok, env} -> 
                        {:ok, env}
                end
        end
    end

    def eval_match(_, _, _) do
        :fail
    end

    @doc "eval_seq takes a list of pattern matching expressions and 
    a regular expression and returns the result of the sequence"
    def eval_seq([exp], env) do
        eval_expr(exp, env)
    end

    def eval_seq([{_, pttrn, expr} | exprs], env) do
        case eval_expr(expr, env) do
            :error ->
                :error
            {_, ns} ->
                vars = extract_vars(pttrn)
                env = Env.remove(vars, env)
                case eval_match(pttrn, ns, env) do
                    :fail ->
                        :error
                    {:ok, env} ->
                        eval_seq(exprs, env)
                end
        end
    end

    @doc "extract_vars returns a list of all variables in the pattern"
    def extract_vars({:var, var}) do [var] end
    def extract_vars({:cons, var1, var2}) do [extract_vars(var1)|extract_vars(var2)] end
    def extract_vars(:ignore) do  end

    @doc "takes a sequence and runs it, returns either {:ok, str} or :error"
    def eval(expr) do
        eval_seq(expr, [])
    end

    @doc "eval_cls takes a list of clauses, data structure and an environment.
    it will select the right clause (whoose condition is true) and continue 
    the execution"
    def eval_cls([], _, _, _) do
        :error
    end
    def eval_cls([{:clause, ptr, seq} | cls], str, env) do
        case eval_match(ptr, str, env) do
            :fail ->
                eval_cls(cls, str, env)
            {:ok, env} ->
                eval_seq(seq, env)
        end
    end

    #seq2 = [{:match, {:var, :x}, {:atm, :a}}, {:case, {:var, :x}, [{:clause, {:atm, :b}, [{:atm, :ops}]}, {:clause, {:atm, :a}, [{:atm, :yes}]}]}]
    #seq = [{:match, {:var, :x}, {:atm,:a}}, {:match, {:var, :y}, {:cons, {:var, :x}, {:atm, :b}}},{:match, {:cons, :ignore, {:var, :z}}, {:var, :y}},{:var, z}]
    
end
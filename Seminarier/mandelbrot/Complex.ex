defmodule Cmplx do

    @moduledoc """
    This module handles complex numbers, where 
    they are represented as an tuple of real and 
    imaginary numbers
    """
    
    @doc "new returns the compex number with real value and imaginary"
    def new(r, i) do {r, i} end

    @doc "add adds two complex numbers"
    def add({ar, ai}, {br, bi}) do {ar+br, ai+bi} end

    @doc "sqr squares a complex number"
    def sqr({a, b}) do 
        {a*a - b*b, (a*b + a*b)} 
    end

    @doc "abs the absolute value of"
    def abs({a, b}) do :math.sqrt((a*a) + (b*b)) end
end
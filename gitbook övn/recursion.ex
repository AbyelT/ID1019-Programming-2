defmodule Recursion do
IO.puts "hi there"

  @doc "Compute the product between of n and m.

  product of n and m :
    if n is 0
      then m*n = 0
    otherwise
      the result is n+((m-1)*m)
  "
  def prod(m, n) do
    case m do
      0 -> 0
      _ when m < 0 -> (-n+prod(m+1,n))
      _ when m > 0 -> n+prod(m-1, n)
    end
  end

  @doc "Compute the power of a non-negative number n and its exponent m
    through addition and subtraction operands
  product of n^m
    if m is 0
      then n^m = 1
    otherwise
      the result is n*n*..*n (n is multiplied m times)//
  "
    def power(n, m) do
      cond do
        n == 0 -> 0
        m == -1 -> 1/n
        m == 1 -> n
        m > 0 -> 
          n*power(n,m-1)
        m < 0 ->
          div(1,(n * power(n,m+1)))
        end
    end

    @doc "qpower computes the power of an non-negative number n and
    its exponent e through the div, rem and prod functions
    "
    def qpower(n,0) do 1 end
    def qpower(0,e) do 0 end
    def qpower(n,1) do n end
    def qpower(n,e) do
      cond do
        rem(e,2) == 0 -> qpower(n,div(e,2)) * qpower(n,div(e,2))
        rem(e,2) == 1 -> qpower(n,div(e-1,2)) * qpower(n,div(e+1,2))
        true -> 0
      end
    end

    @doc "runs the fibonacci sequence"
    def fib(n) do
      cond do
        n == 0 -> 0
        n == 1 -> 1
        true -> 
          fib(n+1) + fib(n+2)
        end
    end

    @doc "runs the ackermann sequence"
    def ackermann(n, m) do
      cond do
      m == 0 -> n+1
      n == 1 and m > 0 -> ackermann(m-1,1)
      true -> 
        ackermann(m-1, ackermann(m, n-1))
      end
    end
end
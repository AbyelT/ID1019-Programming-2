defmodule Brot do
    import Cmplx
    @moduledoc """
    This modules handles the computation of the 
    i value given a complex number c
    """

    @doc "mandelbrot returns the value i at which |Zi| > 2,
    or 0 if it does not for any i < m, given a complex number c
    and the maximum number of iterations"
    def mandelbrot(c, m) do 
        z0 = Cmplx.new(0, 0)
        i = 0
        test(i, z0, c, m)
    end

    @doc "test will only test that the module reach the maximum
    iterations, in which it retusn 0 OR he value of i if abs(z) > 2"
    def test(i, z0, c, 0) do 0 end
    def test(i, z0, c, m) do 
    zn = Cmplx.add(Cmplx.sqr(z0), c)
        cond do
            Cmplx.abs(zn) > 2 -> i
            true -> test(i+1, zn, c, m-1)
        end
    end
end
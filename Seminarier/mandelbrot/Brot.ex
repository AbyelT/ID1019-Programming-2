defmodule Brot do
    import Cmplx
    @moduledoc """
    This module is used to determine whether a
    complex number belongs to the mandelbrot set
    or not
    """

    @doc "mandelbrot calculates the depth i, given a complex number c
    and the maximum number of iterations"
    def mandelbrot(c, m) do 
        #z0 = Cmplx.new(0, 0)
        {cr, ci} = c
        i = 0
        test(i, 0, 0, cr, ci, m)
        #test(i, z0, c, m)
    end

    @doc "test will only test that the module reach the maximum
    iterations, in which it returns 0 OR the value of i, if |Zi| > 2"
    def test(m, _zr, _zi, _cr, _ci, m) do 0 end
    def test(i, zr, zi, cr, ci, m) do
        zr2 = zr*zr
        zi2 = zi*zi
        a2 = zr2 + zi2
        cond do
            a2 < 4.0 ->
                sr = zr2 - zi2 + cr
                si = 2*zr*zi + ci
                test(i+1, sr, si, cr, ci, m)
            true -> i
        end
    end
    def test(i, z0, c, m) do
        a = Cmplx.abs(z0)
        cond do
            a >= 2 -> i
            true -> test(i+1, Cmplx.add(Cmplx.sqr(a), c), c, m)
        end 
    end
end
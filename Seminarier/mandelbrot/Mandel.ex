defmodule Mandel do
    import Cmplx
    
    @doc "mandelbrot generates a list of rows containing the color
    for each pixel, given some values"
    def mandelbrot(width, height, x, y, k, depth) do
        trans = fn(w, h) ->
            Cmplx.new(x + k * (w - 1), y - k * (h - 1))
        end
        rows(width, height, trans, depth, [])
    end

    @doc "rows returns a list of rows, given the width and height
    of the image, a function that converts pixel position to 
    corresponding complex number, the max depth and an empty list"
    def rows(_, 0, _, _, list) do list end
    def rows(w, h, trans, depth, list) do 
        row = row(w, h, trans, depth, [])
        rows(w, h-1, trans, depth, [row|list])
    end

    @doc "row returns a list of tuples, where each tuple represents
    the RGB color of a pixel in an image"
    def row(0, _, _, _, row) do row end
    def row(w, h, trans, depth, row) do 
        point = trans.(w, h);
        i = Brot.mandelbrot(point, depth)
        color = Color.convert(i, depth)
        row(w-1, h, trans, depth, [color|row])
    end

    @doc "runs a demo of the module, with a given 
    complex number"
    def demo() do
        small(-0.01, 0.69, -0.7)
    end

    @doc "creates an image representing the depth of 
    each pixel that exists within the width and height, 
    given a complex number and a arbitrary value"
    def small(x0, y0, xn) do
        width = 1920
        height = 1080
        depth = 80
        k = (xn - x0) / width
        image = Mandel.mandelbrot(width, height, x0, y0, k, depth)
        PPM.write("small.ppm", image)
    end
end
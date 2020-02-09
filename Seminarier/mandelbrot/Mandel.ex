defmodule Mandel do
    import Cmplx
    
    @doc "mandelbrot generates "
    def mandelbrot(width, height, x, y, k, depth) do
        trans = fn(w, h) ->
            Cmplx.new(x + k * (w - 1), y - k * (h - 1))
        end
        rows(width, height, trans, depth, [])
    end

    def rows(w, 0, trans, depth, list) do list end
    def rows(w, h, trans, depth, list) do 
        row = []
        for x <- 1..w do
            point = trans.(w, h);    
            i = Brot.mandelbrot(point, depth)
            color = Color.convert(i, depth)
            row = append(color, row)
            IO.puts "#{inspect row}"
            IO.puts x
        end
        rows(w, h-1, trans, depth, [row|list])
    end

    def append(r, t) do [r|t] end

    def demo() do
        small(-2.6, 1.2, 1.2)
    end

    def small(x0, y0, xn) do
        width = 10
        height = 20
        depth = 64
        k = (xn - x0) / width
        image = Mandel.mandelbrot(width, height, x0, y0, k, depth)
        #PPM.write("small.ppm", image)
        image
    end

    @doc "def row(w, h, trans, depth, points) do 
        point = trans.(w, h);
        i = Brot.mandelbrot(point, depth)
        color = Color.convert(i, depth)
        row(w-1, h, trans, depth, [color|points])
    end
    def row(0, h, trans, depth, points) do points end"
end
defmodule Color do
    
    @moduledoc """
    This module handles the computation of RGB color
    for each pixel 
    """

    @doc "convert returns a tuple representing an RGB
    color, based on the given a depth (0-max) and max value"
    def convert(depth, max) do 
        a = (depth/max) * 4
        x = Kernel.trunc(a)
        y = Kernel.trunc(255*(a-x))
        case x do
            0 -> {y, 0, 0}
            1 -> {255, y, 0}
            2 -> {255-y, 255, 0}
            3 -> {0, 255, y}
            4 -> {0, 255-y, 255}
        end
    end
end
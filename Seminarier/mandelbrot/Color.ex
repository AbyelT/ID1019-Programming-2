defmodule Color do
    
    @moduledoc """
    This module handles the computation of RGB color
    for each pixel 
    """

    @doc "convert returns a tuple representing an RGB
    color, based on the given depth (0-max) and max value"
    def convert(depth, max) do 
        a = (depth/max) * 4 #the floating point a
        x = trunc(a) #the trunced integer value x
        y = trunc(255*(a-x)) #the offset y
        case x do
            0 -> {:rgb, y, 0, 0}       #black - red
            1 -> {:rgb, 255, y, 0}     #red - yellow
            2 -> {:rgb, 255-y, 255, 0} #yellow - green
            3 -> {:rgb, 0, 255, y}     #green - cyan
            4 -> {:rgb, 0, 255-y, 255} #cyan - blue
        end
    end
end
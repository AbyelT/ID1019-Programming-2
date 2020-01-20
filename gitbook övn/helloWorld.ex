defmodule HelloWorld do

    def saySomething do
        IO.puts "Hello World, again!"
    end

    @doc "Converts farenheit to Celsius
    "
    def to_celsius(f) do
        (f-32)/1.8
    end
     @doc "Calculates the area of a rectangle 
     given two sides, l1 and l2
    "
    def rect_area(l1,l2) do
        l1*l2
    end
     @doc "Calculates the area of a square 
     given a side
    "
    def sqrt_area(l) do
        l*l
    end
     @doc "Calculates the area of a circle 
     given the radius r
    "
    def circle_area(r) do
        :math.pi()*r*r
    end  
end
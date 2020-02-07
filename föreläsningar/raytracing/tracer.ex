defmodule Tracer do

  @black {0, 0, 0}
  @white {1, 1, 1}

  def tracer(camera, objects) do
    {w, h} = camera.size
    for y <- 1..h, do: for(x <- 1..w, do: trace(x, y, camera, objects))
  end

  def trace(x, y, camera, objects) do
    ray = Camera.ray(camera, x, y)
    trace(ray, objects)
  end

  defp trace(_ray, 0, world) do
    world.background
  end

  defp trace(ray, depth, world) do
    case intrest(world.objects) do
      {d, obj} -> 
        reflection = trace(r, depth - 1, world)
        light = 

  def trace(ray, objects) do
    case intersect(ray, objects) do
      {:inf, _} ->
        world.background
      {d, obj} ->
        i = Vector.add(ray.pos, Vector.smul(ray.dir, d - @delta))
        normal = Object.normal(obj, ray, i)
        visible = visible(i, world.lights, objects)
        illumination = Light.combine(i, normal, visible)
        Light.illuminate(obj, illumination, world)
    end
  end

  def intersect(ray, objects) do
    List.foldl(objects, {:inf, nil}, fn (object, sofar) ->
      {dist, _} = sofar

      case Object.intersect(object, ray) do
        {:ok, d} when d < dist ->
          {d, object}
        _ ->
          sofar
      end
    end)
  end

end

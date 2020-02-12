defmodule Wait do

    def hello do
        receive do
            x -> IO.puts("you got mail: #{x}")
        end
    end
end

defmodule Tic do

  def first do
    receive do
      {:tic, x} ->
        IO.puts(("tic: #{x}"))
        second()
    end
  end
  
  defp second do
    receive do
      {:tac, x} ->
        IO.puts(("tac: #{x}"))
        last()
      {:toe, x} ->
        IO.puts(("toe: #{x}"))
        last()
    end
  end

  defp last do
    receive do
      x ->
        IO.puts(("end: #{x}"))
    end
  end
end

defmodule Cell do

  def new(), do: spawn_link(fn -> cell(:open) end)

  defp cell(state) do
    receive do
      {:get, from} ->
        send(from, {:ok, state})
        cell(state)

      {:set, value, from} ->
        send(from, :ok)
        cell(value)
    end
  end

  def get(cell) do
    send(cell, {:get, self()})
    receive do
        {:ok, value} -> value
    end
  end

  def set(cell, value) do
    send(cell, {:set, value, self()})
    receive do
        :ok -> :ok
    end
  end

  def do_it(thing, lock) do
    case Cell.get(lock) do
      :taken ->
        do_it(thing, lock)
      :open ->
        Cell.set(lock, :taken)
        do_ya_critical_thing(thing)
        Cell.set(lock, :open)
   end
  end
end
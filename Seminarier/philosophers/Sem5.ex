defmodule Chopstick do
    def start do
        spawn_link(fn -> available() end)
    end

    def available() do
        receive do
            {:request, from} -> gone()
            :quit -> :ok
        end
    end

    def gone() do
        receive do
            :return -> available()
            :quit -> :ok
        end
    end

    def request(stick) do
        send(stick, {:request, self()})
        receive do
            process -> :ok
        end
    end

    def return(stick) do
        send(stick, :return)
        receive do
            process -> :ok
        end
    end

    def quit(stick) do
        send(stick, :quit)
        receive do
            :ok -> :ok
        end
    end
end

defmodule Philosopher do
    def sleep(t) do
        :timer.sleep(:rand.uniform(t))
    end

    def start(hunger, strength, right, left, name, ctrl, seed) do
        spawn_link(fn -> self() end)
        IO.puts("#{name} received a chopstick!")
    end
end

defmodule Dinner do
    def start(n, seed), do: spawn(fn -> init(n, seed) end)

    def init(n, seed) do
        c1 = Chopstick.start()
        c2 = Chopstick.start()
        c3 = Chopstick.start()
        c4 = Chopstick.start()
        c5 = Chopstick.start()
        ctrl = self()
        Philosopher.start(n, 5, c1, c2, "Arendt", ctrl, seed + 1)
        Philosopher.start(n, 5, c2, c3, "Hypatia", ctrl, seed + 2)
        Philosopher.start(n, 5, c3, c4, "Simone", ctrl, seed + 3)
        Philosopher.start(n, 5, c4, c5, "Elisabeth", ctrl, seed + 4)
        Philosopher.start(n, 5, c5, c1, "Ayn", ctrl, seed + 5)
        wait(5, [c1, c2, c3, c4, c5])
    end

    def wait(0, chopsticks) do
        Enum.each(chopsticks, fn(c) -> Chopstick.quit(c) end)
    end

    def wait(n, chopsticks) do
        receive do
            :done -> wait(n - 1, chopsticks)
            :abort -> Process.exit(self(), :kill)
        end
    end
end  

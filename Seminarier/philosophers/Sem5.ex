defmodule Chopstick do
    def start do
        spawn_link(fn -> available() end)
    end

    def available() do
        receive do
            {:request, from} -> 
                send(from, :ok)
                gone()
            :quit -> :ok
        end
    end

    def gone() do
        receive do
            {:return, from} -> 
                send(from, :ok)
                available()
            #{:request, from} ->
                #send(from, :no)
                #gone()
            :quit -> :ok
        end
    end

    def request(stick) do
        send(stick, {:request, self()})
        receive do
            :ok -> :ok
            after 1500 -> :no
            #:no -> :no
        end
    end

    def return(stick) do
        send(stick, {:return, self()})
        receive do
            :ok -> :ok
        end
    end

    def quit(stick) do
        send(stick, {:quit, self()})
        :ok
    end
end

defmodule Philosopher do
    def sleep(t) do
        :timer.sleep(:rand.uniform(t))
    end

    def start(hunger, strength, right, left, name, ctrl, seed) do
        spawn_link(fn ->  dream(hunger, strength, right, left, name, ctrl, seed) end)
    end

    def dream(hunger, strength, right, left, name, ctrl, seed) do
        sleep(seed) 
        cond do 
            strength <= 0 -> 
                Chopstick.return(right)
                Chopstick.return(left)
                IO.puts("#{name} died by hunger")                
                send(ctrl, :done) 
            hunger <= 0 -> 
                IO.puts("#{name} is done eating!")                
                send(ctrl, :done)
            true -> 
                waitBoth2(hunger, strength, right, left, name, ctrl, seed)
        end
    end

    #make sure to recursively wait for both chpsticks, to save mem space
    def waitBoth(hunger, strength, right, left, name, ctrl, seed) do 
        wait(right)
        IO.puts("#{name} took right chopstick")
        sleep(seed) #artificial wait in between chopsticks
        wait(left)
        IO.puts("#{name} took left chopstick")
        eating(hunger, strength, right, left, name, ctrl, seed)
    end

    def wait(chopstick) do
        case Chopstick.request(chopstick) do
            :no -> 
                :timer.sleep(1000)
                wait(chopstick)
            :ok -> :ok
        end
    end

    def waitBoth2(hunger, strength, right, left, name, ctrl, seed) do
        case Chopstick.request(left) do
            :no -> 
                dream(hunger, strength, right, left, name, ctrl, seed)
            :ok -> 
                IO.puts("#{name} took left chopstick")
                :timer.sleep(200)     #artificial wait time
                case Chopstick.request(right) do
                    :no -> 
                        Chopstick.return(left)
                        dream(hunger, strength, right, left, name, ctrl, seed)
                    :ok -> 
                        IO.puts("#{name} took right chopstick")
                        eating(hunger, strength, right, left, name, ctrl, seed)
                end
        end
    end

    def eating(hunger, strength, right, left, name, ctrl, seed) do 
        :timer.sleep(1500) #artificial eating time
        Chopstick.return(right)
        Chopstick.return(left)
        IO.puts("#{name} ate a bowl of noodles, #{hunger-1} left!")
        dream(hunger-1, strength, right, left, name, ctrl, seed)
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
        IO.puts("Dinner finished!")
        Enum.each(chopsticks, fn(c) -> Chopstick.quit(c) end)
    end

    def wait(n, chopsticks) do
        receive do
            :done -> 
                wait(n - 1, chopsticks)
            :abort -> Process.exit(self(), :kill)
        end
    end
end  


#Concurrency: the illusion of things happening at the same time
#   - A property of the programming model
#   - Sort of event drivern: having several programs that keep track 
#     of a certain thing and telling another program when things happen
#   - is a programming model, NOT an execution model (a single corde can do this)

#Concurrency models
#   - shared memory: modify a shared memory
#       ex. C++/C or Java
#   - Message sharing: processes sends and receives messages
#       ex. Erlang/elixir, Rust, Scala

#How messages are sent
#   1. CSP: messages are sent through channels, a process can choose
#   to read a message from one or more channels.
#       *a process can give channels to other processes
#   2. Actor: messages are sent to a process with a certain PID 
#   (process identitiy), all processes reads implicity from its
#   own channel

#the actor
#   - State: keeps a private state that can be changes by the actor
#   - recive: has a channel of incoming messages
#   - execute: given a state and a recived message..
#           -> send: send a message to a process with given PID
#           -> spawn: spawn a new process for a certain function
#           -> transform
#   *all actors (processes) "dies" when they are done
#   **Actors do not care if a message sent to a process is received or not
#   ***messages are not guarenteed to arrive 
#   
#Asynchronus message passing: actors sending messages to other processes
#expects them to return a message anytime soon (idk unsure)
#
#receive do: messages that the function cannot handle are 
#            still in the 'mailbox', only that they are waiting
#self: the process identifier of the current process/function

#type of receive
#   - Selective receive: specify which messages we want to receive
#   - Implicit deferral: messages that are not received remain in the 
#     Message queue until it can be received.

defmodule Echo do 
    def echo() do
        receive do
            data ->
                :io.put "hello" data
                echo()
        end
        
end
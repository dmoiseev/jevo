#
# @author DeadbraiN
#
# TODO:
module Connection
  import Event
  
  export ServerConnection
  export ClientConnection
  export Answer
  export Command

  # TODO:
  type ServerConnection
    tasks   ::Array{Task}
    socks   ::Array{Base.TcpSocket}
    server  ::Base.TcpServer
    observer::Event.Observer
  end
  # TODO:
  type ClientConnection
  	sock    ::Base.TcpSocket
  	observer::Event.Observer
  end
  # TODO:
  type Command
    fn::Integer
    args::Array{Any}
  end
  # TODO:
  type Answer
    data::Any
  end
end
#
# This module is a RPC remote API. It contains Manager RPC
# functions identifiers. They are used for Remote Procedure Calls
# from any other processes. See Connection.Command type for details.
# It'salso important, that this module should contain only native
# Julia definition. It shouldn't contain other modules.
#
# @author DeadbraiN
#
module RpcApi
  export RPC_GET_REGION
  export RPC_CREATE_ORGANISMS
  export RPC_CREATE_ORGANISM
  export RPC_SET_CONFIG
  export RPC_GET_CONFIG
  export RPC_MUTATE
  export RPC_GET_IPS
  export RPC_GET_ORGANISM
  export RPC_DEBUG_GC
  export RPC_DEBUG_WHOS
  
  export Region
  #
  # Describes 2D region in a world
  #
  type Region
    reg::Array{UInt32, 2}
    ips::Int
  end
  #
  # This is an analog of Creature.Organism type. It's used for 
  # transporting more simple version of organism data through
  # network.
  #
  type SimpleOrganism
    #
    # Amount of energy for current organism
    #
    energy::UInt
    #
    # Organism's position in a world
    #
    pos::Array{Int}
    #
    # Code of organism
    #
    code::ASCIIString
  end
  #
  # RPC API unique identifiers. Only these functions may be called
  # remotely on the server.
  #
  const RPC_GET_REGION        = 1
  const RPC_CREATE_ORGANISMS  = 2
  const RPC_CREATE_ORGANISM   = 3
  const RPC_SET_CONFIG        = 4
  const RPC_GET_CONFIG        = 5
  const RPC_MUTATE            = 6
  const RPC_GET_IPS           = 7
  const RPC_GET_ORGANISM      = 8
  const RPC_DEBUG_GC          = 9
  const RPC_DEBUG_WHOS        = 10
end
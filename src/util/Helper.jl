#
# @author DeadbraiN
#
module Helper
  import Gtk
  
  export Point
  export randTrue
  export getProbIndex
  export getSupportedTypes
  export warn
  export error
  export SUPPORTED_TYPES

  #
  # One point in the world. Is described by two coordinates.
  #
  type Point
    x::Int
    y::Int
  end
  
  #
  # Prints warning message with white color
  # @param msg Text message to show
  #
  function warn(msg::AbstractString)
    print_with_color(:yellow, "WARNING: ", msg, "\n")
  end
  #
  # Print error message with red color and don't stop an application
  # @param msg Text message to show
  #
  function error(msg::AbstractString)
    print_with_color(:red, "ERROR: ", msg, "\n")
  end
  #
  # Print info message with green color
  # @param msg Text message to show
  #
  function info(msg::AbstractString)
    print_with_color(:green, "INFO: ", msg, "\n")
  end
  #
  # Chooses (returns) true or false randomly. Is used to choose between two
  # variants of something. For example + or - sign.
  # @return {Bool}
  #
  function randTrue()
    rand(1:2) === 1
  end
  #
  # This function is not presented in Julis Gtk package
  #
  function gtk_markup(label::Gtk.GtkLabel,str)
    ccall((:gtk_label_set_markup,Gtk.libgtk),Void,(Ptr{Gtk.GObject},Ptr{UInt8}),label,str)
    return label
  end
  #
  # It calculates probability index from variable amount of components.
  # Let's imagine we have three actions: one, two and three. We want 
  # these actions to be called randomly, but with different probabilities.
  # For example it may be [3,2]. It means that one should be called
  # in half cases, two in 1/3 cases and three in 1/6 cases. Probabilities
  # should be greated then -1.
  # @param {Array{Int}} prob Probabilities array. e.g.: [3,2] or [1,3]
  # @return {Int} 0 Means that index is invalid
  #
  function getProbIndex(prob::Array{Int})
    if length(prob) < 1 return 0 end

    local s::Int = sum(prob)
    if s < 1 return 0 end
    num = rand(1:s)
    s   = 0
    i   = 1

    for i = 1:length(prob)
      if num <= (s += prob[i]) break end
    end

    i
  end
  #
  # Returns default empty map with supported Julia types. All supported
  # types should be stored in getSupportedTypes() function.
  # @return {Dict{DataType, Array{Symbol, 1}}}
  #
  function getTypesMap()
    Dict{DataType, Array{Symbol, 1}}(getSupportedTypes((typ) -> typ => Symbol[])...)
  end
  #
  # Returns supported types array for organism language
  # @param fn Callback function, which is called for
  # every array element
  # @return {Array{DataType, 1}}
  #
  function getSupportedTypes(fn::Function = (t) -> t)
    map(fn, SUPPORTED_TYPES)
  end
  #
  # Saves custom data into the file. If file exists, it will
  # be overrided
  # @param data Data to save
  # @param file File name
  # @return {Bool} saving result
  #
  function save(data::Any, file::ASCIIString = "backup.data")
    local io  = null
    local ret = true

    try
      io = open(file, "w")
      serialize(io, data)
    catch(e)
      warn("Helper.save(): $e")
      ret = false
    finally
      if io !== null close(io) end
    end

    ret
  end
  #
  # Loads custom data from the file
  # @param file File name
  # @return {Any|null} loading result or null
  #
  function load(file::ASCIIString = "backup.data")
    local io  = null
    local ret = null

    try
      io  = open(file)
      ret = deserialize(io)
    catch(e)
      warn("Helper.load(): $e")
      ret = null
    finally
      if io !== null close(io) end
    end
    
    ret
  end

  #
  # Supported types of code inside organism
  #
  const SUPPORTED_TYPES = [ASCIIString, Bool, Int8, Int16, Int]
end
using Libdl

check_llvm() = isone(length(filter(lib->occursin("LLVM\b", basename(lib)), Libdl.dllist())))
@static if Sys.ARCH === :x86_64 || Sys.ARCH === :i686
    if Base.libllvm_version >= v"8" && check_llvm()
        include("build_x86.jl")
    else
        include("build_x86_cpuidonly.jl")
    end
else
    include("build_generic.jl")
end
    
open(joinpath(@__DIR__, "..", "src", "cpu_info.jl"), "w") do f
    write(f, cpu_info_string)
end



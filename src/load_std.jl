function load_std()
    @eval Main begin
        using Base64
        using CRC32c
        using Dates
        using DelimitedFiles
        using Distributed
        using FileWatching
        using Future
        using InteractiveUtils
        using Libdl
        using LinearAlgebra
        using Logging
        using Markdown
        using Mmap
        using Pkg
        using Printf
        using Profile
        using REPL
        using Random
        using SHA
        using Serialization
        using SharedArrays
        using Sockets
        using SparseArrays
        using Statistics
        using Test
        using UUIDs
        using Unicode
    end

    @__MODULE__
end
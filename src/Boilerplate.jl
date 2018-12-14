module Boilerplate
    include("load_snippets.jl")
    include("load_std.jl")
    include("setup_repl.jl")
    include("web_display.jl")
    include("sqlite_connect.jl")
end

# TODO: on exit
# 1) save specified variables into a JLD bundle
# 2) if WebDisplay enabled and session not interactive (`julia --color=yes < main.jl > /dev/null`), notify and keep alive
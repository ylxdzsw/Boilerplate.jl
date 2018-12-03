module Boilerplate

function load_std()
    Core.eval(Main, quote
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

        using OhMyJulia
        using JsonBuilder
    end)

    Boilerplate
end

function web_display(port=6677, echarts=true)
    ENV["WEB_DISPLAY_THEME"] = "dark"
    ENV["WEB_DISPLAY_NOTEXT"] = "true"
    ENV["WEB_DISPLAY_PORT"] = port

    Core.eval(Main, quote
        using WebDisplay

        if $echarts
            WebDisplay.extra_header[] = """
                <script src="http://echarts.baidu.com/dist/echarts.min.js"></script>
                <script src="http://echarts.baidu.com/asset/theme/dark.js"></script>
            """
        end

        plot(json::String, id=randstring(12)) = AS("text/html", """
            <figure id="$id" style="width:600px; height:360px; margin: 0;"></figure>
            <script> echarts.init(document.getElementById('$id'), 'dark').setOption($json) </script>
        """)

        const echarts_examples = (
            line = md"""
            ### (multi-) Line Plot

            ```
            plot(@json \"""{
                backgroundColor: 'transparent',
                title: { text: 'Line Plot' },
                xAxis: { type: 'value' },
                yAxis: { type: 'value' },
                legend: { width: 400 },
                tooltip: { trigger: 'axis' },
                dataZoom: [{
                    type: 'slider',
                    start: 80,
                    height: 20,
                    bottom: 12
                }],
                series: [{
                    type: 'line',
                    name: 'rtt',
                    smooth: true,
                    data: [[2,3],
                           [4,5],
                           [6,6]]
                }]
            }\""")
            ```
            """,
        )
    end)

    Boilerplate
end

function sqlite_connect(path=":memory:")
    # TODO: SQLite REPL mode
    Core.eval(Main, quote
        using SQLite

        const db = SQLite.DB($path)
        q(x...) = SQLite.query(db, x...) |> DataFrame
        macro q_str(x)
            :( SQLite.query(db, $x) |> DataFrame )
        end
    end)

    Boilerplate
end

# TODO: on exit
# 1) save specified variables into a JLD bundle
# 2) if WebDisplay enabled and session not interactive (`julia --color=yes < main.jl > /dev/null`), notify and keep alive

end # module
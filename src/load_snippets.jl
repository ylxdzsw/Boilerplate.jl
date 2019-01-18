const tex = """
\\documentclass[tikz]{standalone}
    \\usepackage{pgfplots}
    \\pgfplotsset{compat=newest}
    \\pgfplotsset{every axis legend/.append style={%
    cells={anchor=west}}
    }
    
    \\tikzset{
    ddash/.style={%
        dash pattern=on 5pt off 3.75pt,
        postaction={
            draw, line cap=round, line width=1.5pt,
            dash pattern=on 0.1pt off 8.65pt},
    }
}

    \\begin{document}
        \\begin{tikzpicture}[]
            \\begin{axis}[%
                grid=both,
                grid style={line width=.1pt, draw=gray!20},
                ylabel={CDF},
                xlabel={RTT (ms)},
                width=6cm,
                height=4.5cm,
                ymin=0,
                ymax=1,
                xmin=0,
                xmax=400,
                legend style={
                    at = {(.99,.015)},
                    anchor = south east,
                    font = \\fontsize{8pt}{8pt}\\selectfont,
                    row sep=-1pt
                },
                legend image post style={scale=0.8},
            ]
        \\addplot+[mark=none, ddash, mark options={scale=.8}, color=blue] coordinates {
        (2, 3.548741970971291e-5)
        };
        \\addplot+[red, dashed] coordinates {(0.1473552,79) (0.1525392,79)};

    \\addlegendentry{Diff country}

            \\end{axis}

        \\end{tikzpicture}
    \\end{document}
"""|>escape_string

function load_snippets()
    @eval Main begin
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

            scatter = md"""
            ### (multi-) Scatter Plot

            ```
            plot(@json \"""{
                backgroundColor: 'transparent',
                title: { text: 'Scatter' },
                xAxis: { type: 'value' },
                yAxis: { type: 'value' },
                legend: { width: 400 },
                tooltip: { trigger: 'item', formatter: '{a} {c}' },
                series: [{
                    name: 'point',
                    type: 'scatter',
                    data: [[2,3], [4,5], [6,7]]
                }]
            }\""")
            ```
            """,

            pie = md"""
            ### Pie Plot

            ```
            plot(@json \"""{
                backgroundColor: 'transparent',
                title: { text: 'pie' },
                tooltip: { trigger: 'item', formatter: '{b} {d}%' },
                series: [{
                    type: 'pie',
                    name: 'pie',
                    radius: ['50%', '70%'],
                    data: [{name: 'a', value: 2},
                           {name: 'b', value: 3}]
                }]
            }\""")
            ```
            """
        )
    end

    @__MODULE__
end
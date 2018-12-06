function web_display(port=6677, echarts=true)
    ENV["WEB_DISPLAY_THEME"] = "dark"
    ENV["WEB_DISPLAY_NOTEXT"] = "true"
    ENV["WEB_DISPLAY_PORT"] = port

    @eval Main begin
        using WebDisplay

        if $echarts
            WebDisplay.extra_header[] = """
                <script src="http://echarts.baidu.com/dist/echarts.min.js"></script>
                <script src="http://echarts.baidu.com/asset/theme/dark.js"></script>
            """

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
        end
    end

    @__MODULE__
end
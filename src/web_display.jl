function web_display(port=6677, echarts=true, open=true)
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

            plot(json::String, id=randstring(12); height=360) = HTML("""
                <figure id="$id" style="width:600px; height:$(height)px; margin: 0"></figure>
                <script> echarts.init(document.getElementById('$id'), 'dark').setOption($json) </script>
            """)
        end

        if $open
            # TODO: support the other two operation systems
            let browser = try ENV["BROWSER"] catch; "xdg-open" end, port = $port
                occursin("chrom", browser) ? run(`$browser --app=http://127.0.0.1:$port`, wait=false) :
                                             run(`$browser http://127.0.0.1:$port`, wait=false)
            end
        end
    end

    @__MODULE__
end
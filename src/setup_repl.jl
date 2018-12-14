function setup_repl()
    @eval Main begin
        using OhMyJulia

        import REPL
        REPL.GlobalOptions.auto_indent = false
        REPL.LineEdit.options(s::REPL.LineEdit.PromptState) = REPL.GlobalOptions
    end
    
    @__MODULE__
end
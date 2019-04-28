function sqlite_connect(path=":memory:")
    # TODO: SQLite REPL mode
    @eval Main begin
        using SQLite
        using DataFrames

        const db = SQLite.DB($path)
        q(x...) = SQLite.Query(db, x[1], collect(x[2:end])) |> DataFrame
        macro q_str(x)
            :( SQLite.Query(db, $x) |> DataFrame )
        end
    end

    @__MODULE__
end
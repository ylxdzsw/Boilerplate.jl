function sqlite_connect(path=":memory:")
    # TODO: SQLite REPL mode
    @eval Main begin
        using SQLite

        const db = SQLite.DB($path)
        q(x...) = SQLite.query(db, x...) |> DataFrame
        macro q_str(x)
            :( SQLite.query(db, $x) |> DataFrame )
        end
    end

    @__MODULE__
end
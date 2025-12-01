function wait_for_postgres
    docker compose up -d
    set spinner "|" "/" "-" "\\"
    set i 1
    while not docker compose exec postgres pg_isready -q -U username -d diesel_demo
        printf "\rWaiting for Postgres... %s" $spinner[$i]
        set i (math "($i % 4) + 1")
        sleep 1
    end
    printf "\rPostgres is healthy!          \n"
end

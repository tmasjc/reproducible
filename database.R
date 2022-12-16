library(config)
library(RMariaDB)
library(dplyr)

.config <- config::get()

conn <- DBI::dbConnect(
    drv      = RMariaDB::MariaDB(),
    host     = .config$DB_HOST,
    user     = .config$DB_USER,
    password = .config$DB_PSWD,
    port     = 3306,
    dbname   = .config$DB_NAME
)

# helper function
sendquery <- \(query) {
    r <- RMariaDB::dbSendQuery(conn, query)
    RMariaDB::dbClearResult(r)
}
sendquery("SET NAMES UTF8")

# a lazy table, not in memory
tbl <- tbl(conn, "diamonds")
tbl |>
    group_by(cut) |>
    summarise(
        min = min(price),
        mu  = mean(price),
        max = max(price)
    ) |>
    mutate(diff_sqrt = sqrt(max - min))

# collect to memory
dat <- tbl |> 
    filter(cut %in% c("Fair", "Good")) |> 
    collect()

# remember to disconnect
DBI::dbDisconnect(conn)

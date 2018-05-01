boros <- tibble::tribble(
    ~ Boro, ~ Pop, ~ Size, ~ Random,
    'Manhattan', 1600000, 23, 7,
    'Brooklyn', 2600000, 78, 24,
    'Queens', 2330000, 104, pi,
    'Bronx', 1455000, 42, 21,
    'Staten Island', 475000, 60, 3
)
boros

library(useful)

# formula y ~ x

build.x( ~ Pop, data=boros)
build.x( ~ Pop + Size, boros)
build.x( ~ Pop * Size, boros)
build.x( ~ Pop : Size, boros)
build.x( ~ Pop + Pop:Size, boros)
build.x( ~ Pop * Size - Size, boros)

class(~ Pop)
~ Pop

build.x( ~ Pop - 1, boros)
boros

build.x(~ Boro, boros)
build.x(~ Boro, boros, contrasts=FALSE)
build.x(~ Pop + Boro, boros, contrasts=FALSE)

build.x( ~ Pop * Boro, boros)

build.x( ~ Pop * Boro, boros, sparse=TRUE)

# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Pensieve.Repo.insert!(%Pensieve.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Pensieve.Repo
alias Pensieve.Memories.Memory

for _ <- 0..50 do
  Repo.insert!(%Memory{title: Faker.Lorem.sentence})
end

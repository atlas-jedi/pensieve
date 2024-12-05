alias Pensieve.Repo
alias Pensieve.Hogwarts.Wizard

%{
  "Gryffindor" => ["Harry Potter", "Hermione Granger", "Ron Weasley", "Ginny Weasley"],
  "Hufflepuff" => ["Cho Chang", "Luna Lovegood"],
  "Ravenclaw" => ["Cedric Diggory"],
  "Slytherin" => ["Draco Malfoy", "Vincent Crabbe", "Gregory Goyle"],
}
|> Enum.each(
  fn {house, wizards} ->
    for name <- wizards do
      [first_name | [last_name]] = String.split(name)
      %Wizard{
        first_name: first_name,
        last_name: last_name,
        house: house,
        points: :rand.uniform(1000)
      } |> Repo.insert!()
    end
  end
)

n_recipes = $stdin.readline.chomp.to_i

recipes = [3,7]

first = 0
second = 1

while recipes.length <= n_recipes+10
    generated = recipes[first] + recipes[second]
    if generated >= 10
        recipes.push(1)
    end
    recipes.push(generated % 10)

    first = (recipes[first] + 1 + first) % recipes.length
    second = (recipes[second] + 1 + second) % recipes.length
end

p recipes[n_recipes..n_recipes+9].join('')


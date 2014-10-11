-- farming_food recipes
-- by MTDad

-- Peach Cobbler

minetest.register_craftitem("farming_food:peach_cobbler", {
	description = "Peach Cobbler",
	inventory_image = "farming_food_peach_cobbler.png",
	on_use = minetest.item_eat(4),
})

minetest.register_craft({
	type = "cooking",
	cooktime = "10",
	output = "farming_food:peach_cobbler",
	recipe = "farming_food:peach_cobbler_raw",
})

minetest.register_craftitem("farming_food:peach_cobbler_raw", {
	description = "Raw Peach Cobbler",
	inventory_image = "farming_food_peach_cobbler_raw.png",
})

minetest.register_craft({
	type = "shapeless",
	output = "farming_food:peach_cobbler_raw 3",
	recipe = {"group:food_flour", "group:food_sugar", "group:food_egg", "group:food_peach"}
})

-- Corn Bread

minetest.register_craftitem("farming_food:corn_bread", {
	description = "Corn Bread",
	inventory_image = "farming_food_corn_bread.png",
	on_use = minetest.item_eat(4),
})

minetest.register_craft({
	type = "cooking",
	cooktime = 10,
	output = "farming_food:corn_bread",
	recipe = "farming_food:corn_bread_dough",
})

minetest.register_craftitem("farming_food:corn_bread_dough", {
	description = "Corn Bread Dough",
	inventory_image = "farming_food_corn_bread_dough.png",
})

minetest.register_craft({
	type = "shapeless",
	output = "farming_food:corn_bread_dough 3",
	recipe = {"group:food_corn", "group:food_corn", "group:food_milk", "group:food_egg"},
	replacements = {{"animalmaterials:milk", "vessels:drinking_glass"}},
})

-- Strawberry Lemonade

minetest.register_craftitem("farming_food:strawberry_lemonade", {
	description = "Strawberry Lemonade",
	inventory_image = "farming_food_strawberry_lemonade.png",
	on_use = minetest.item_eat(2),
})

minetest.register_craft({
	type = "shapeless",
	output = "farming_food:strawberry_lemonade 3",
	recipe = {"group:food_strawberry", "group:food_lemon", "group:food_cup"}
})


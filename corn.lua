-- Docfarming Corn imported into Farming_Plus by MTDad
-- First growth stages handled by Farming_Plus API, later growth by DocFarming code.

-- main `S` code in init.lua
local S
S = farming.S

minetest.register_craftitem("farming_plus:corn_seed", {
	description = S("Corn Seeds"),
	inventory_image = "cornseed.png",
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming_plus:corn_1")
	end

})
minetest.register_craftitem("farming_plus:corn_item", {
	description = S("Corn"),
	inventory_image = "corn.png",
	on_use = minetest.item_eat(4),
})
-- Craft added to acquire corn seed
minetest.register_craft({
	output = "farming_plus:corn_seed 4",
	recipe = {
		{"farming_plus:corn_item"},
	}
})

minetest.register_node("farming_plus:corn_1", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"corn1.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+3/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1, plant=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("farming_plus:corn_2", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"corn2.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+3/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1, plant=1},
	sounds = default.node_sound_leaves_defaults(),
})
-- "corn_3" is "corn" the fullgrown plant as far as the farming_plus api is concerned.
minetest.register_node("farming_plus:corn", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"corn3.png"},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1, plant=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("farming_plus:corn_4", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"corn4.png"},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("farming_plus:corn_21", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"corn21.png"},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("farming_plus:corn_22", {
	paramtype = "light",
	walkable = true,
	drawtype = "plantlike",
	drop = "",
	tiles = {"corn22.png"},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("farming_plus:corn_23", {
	paramtype = "light",
	walkable = true,
	drawtype = "plantlike",
	drop = "",
	tiles = {"corn23.png"},
	drop = {
		max_items = 3, --reduced from 6>3
		items = {
			{ items = {'farming_plus:corn_item'} },
			{ items = {'farming_plus:corn_item'}, rarity = 2},
			{ items = {'farming_plus:corn_item'}, rarity = 5},
--			{ items = {'farming_plus:corn_seed'} },
--			{ items = {'farming_plus:corn_seed'}, rarity = 2 },
--			{ items = {'farming_plus:corn_seed'}, rarity = 5 }
		}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("farming_plus:corn_31", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"corn31.png"},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("farming_plus:corn_32", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"corn32.png"},
	drop = {
		max_items = 3,  -- reduced from 6>3
		items = {
			{ items = {'farming_plus:corn_item'} },
			{ items = {'farming_plus:corn_item'}, rarity = 2},
			{ items = {'farming_plus:corn_item'}, rarity = 5},
--			{ items = {'farming_plus:corn_seed'} },
--			{ items = {'farming_plus:corn_seed'}, rarity = 2 },
--			{ items = {'farming_plus:corn_seed'}, rarity = 5 }
		}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})
-- First 3 stages of growth handled by Farming_Plus ABM
farming.add_plant("farming_plus:corn", {"farming_plus:corn_1", "farming_plus:corn_2"}, 250, 2)

-- Then the Docfarming ABMs take over
-- Place the top on the stage 3 corn
minetest.register_abm({
	nodenames = "farming_plus:corn",
	interval = 30,
	chance = 1,
	action = function(pos, node)
		pos.y = pos.y+1
		if minetest.env:get_node(pos).name ~= "air" then
			return
		end
		minetest.env:set_node(pos, {name='farming_plus:corn_21'})
	end
})

chance = 2
interval = 250
whereon = "farming:soil_wet"
wherein = "air"

	minetest.register_abm({
		nodenames = "farming_plus:corn",
		interval = interval,
		chance = chance,
		action = function(pos, node)
--			pos.y = pos.y-1
--			if minetest.env:get_node(pos).name ~= "farming:soil_wet" then
--				return
--			end
--			pos.y = pos.y+1
			if not minetest.env:get_node_light(pos) then
				return
			end
			if minetest.env:get_node_light(pos) < 8 then
				return
			end
			pos.y=pos.y+1
			pos.y=pos.y+1
			minetest.env:set_node(pos, {name='farming_plus:corn_31'})
			pos.y=pos.y-1
			
			minetest.env:set_node(pos, {name='farming_plus:corn_22'})
			pos.y=pos.y-1
			minetest.env:set_node(pos, {name='farming_plus:corn_4'})
			
		end
}	)
	minetest.register_abm({
		nodenames = "farming_plus:corn_22",
		interval = interval,
		chance = chance,
		action = function(pos, node)
			if not minetest.env:get_node_light(pos) then
				return
			end
			if minetest.env:get_node_light(pos) < 8 then
				return
			end
			pos.y=pos.y+1
			minetest.env:set_node(pos, {name='farming_plus:corn_32'})
			pos.y=pos.y-1
			minetest.env:set_node(pos, {name='farming_plus:corn_23'})
			
		end
}	)

minetest.register_alias("docfarming:cornseed", "farming_plus:corn_seed")
minetest.register_alias("docfarming:corn", "farming_plus:corn_item")
minetest.register_alias("farming:corn", "farming_plus:corn_item")
minetest.register_alias("docfarming:corn1", "farming_plus:corn_1")
minetest.register_alias("farming:corn_1", "farming_plus:corn_1")
minetest.register_alias("docfarming:corn2", "farming_plus:corn_2")
minetest.register_alias("farming:corn_2", "farming_plus:corn_2")
minetest.register_alias("docfarming:corn3", "farming_plus:corn")
minetest.register_alias("farming:corn_3", "farming_plus:corn")
minetest.register_alias("docfarming:corn4", "farming_plus:corn_4")
minetest.register_alias("docfarming:corn21", "farming_plus:corn_21")
minetest.register_alias("docfarming:corn22", "farming_plus:corn_22")
minetest.register_alias("docfarming:corn23", "farming_plus:corn_23")
minetest.register_alias("docfarming:corn31", "farming_plus:corn_31")
minetest.register_alias("docfarming:corn32", "farming_plus:corn_32")
minetest.register_alias("farming:corn_4", "farming_plus:corn")
minetest.register_alias("farming:corn_5", "farming_plus:corn")
minetest.register_alias("farming:corn_6", "farming_plus:corn")
minetest.register_alias("farming:corn_7", "farming_plus:corn")
minetest.register_alias("farming:corn_8", "farming_plus:corn")

-- Original farming_plus rhubarb by PilzAdam, WTFPL
-- Modified by MTDad with added code from Docfarming, WTFPL

-- main `S` code in init.lua
local S
S = farming.S

-- changed from "seed" to "start" -MTD
minetest.register_craftitem("farming_plus:rhubarb_start", {
	description = S("Rhubarb Starter"),
	inventory_image = "farming_rhubarb_start.png",
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming_plus:rhubarb_1")
	end
})

minetest.register_node("farming_plus:rhubarb_1", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "farming_plus:rhubarb_start",
	tiles = {"farming_rhubarb_1.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+5/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming_plus:rhubarb_2", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "farming_plus:rhubarb_start 2",
	tiles = {"farming_rhubarb_2.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+11/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming_plus:rhubarb", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	tiles = {"farming_rhubarb_3.png"},
	after_dig_node = function(pos)
		minetest.env:add_node(pos, {name="farming_plus:rhubarb_1"})
	end,
	drop = {
		max_items = 3, -- reduced 6>3
		items = {
--			{ items = {'farming_plus:rhubarb_seed'} },
--			{ items = {'farming_plus:rhubarb_seed'}, rarity = 2},
--			{ items = {'farming_plus:rhubarb_seed'}, rarity = 5},
			{ items = {'farming_plus:rhubarb_item'} },
			{ items = {'farming_plus:rhubarb_item'}, rarity = 2 },
			{ items = {'farming_plus:rhubarb_item'}, rarity = 5 }
		}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_craftitem("farming_plus:rhubarb_item", {
	description = S("Rhubarb"),
	inventory_image = "farming_rhubarb.png",
})

farming.add_plant("farming_plus:rhubarb", {"farming_plus:rhubarb_1", "farming_plus:rhubarb_2"}, 500, 4)

-- ABM for spreading behavior from Docfarming
num = PseudoRandom(111)
	minetest.register_abm({
		nodenames = "farming_plus:rhubarb_2",
		interval = 500,
		chance = 20,
		action = function(pos, node)
			
			pos.x = pos.x-1
			x = num:next(1, 3)
			if x > 1 then
				pos.x = pos.x+1
				if x > 2 then	
					pos.x = pos.x+1
				end
			end
			pos.z=pos.z-1
			z = num:next(1, 3)
			if z > 1 then
				pos.z = pos.z+1
				if z > 2 then	
					pos.z = pos.z+1
				end
			end
			if minetest.env:get_node(pos).name=="air" then
				pos.y = pos.y-1
				name = minetest.env:get_node(pos).name
				if name=="default:dirt" then
					pos.y=pos.y+1
					minetest.env:set_node(pos, {name="farming_plus:rhubarb_1"})
				end
				if name=="default:dirt_with_grass" then
					pos.y=pos.y+1
					minetest.env:set_node(pos, {name="farming_plus:rhubarb_1"})
				end
				if name=="air" then
					pos.y=pos.y-1
					name = minetest.env:get_node(pos).name
					if name=="default:dirt" then
						pos.y=pos.y+1
						minetest.env:set_node(pos, {name="farming_plus:rhubarb_1"})
					end
					if name=="default:dirt_with_grass" then
						pos.y=pos.y+1
						minetest.env:set_node(pos, {name="farming_plus:rhubarb_1"})
					end
				end
				
			end
			pos.y=pos.y+1
			if minetest.env:get_node(pos).name=="air" then
				pos.y = pos.y-1
				name = minetest.env:get_node(pos).name
				if name=="default:dirt" then
					pos.y=pos.y+1
					minetest.env:set_node(pos, {name="farming_plus:rhubarb_1"})
				end
				if name=="default:dirt_with_grass" then
					pos.y=pos.y+1
					minetest.env:set_node(pos, {name="farming_plus:rhubarb_1"})
				end
			end
			
			
		end
})

-- tag on ABMs to allow volunteer rhubarb to grow without wet soil, they just grow slower
minetest.register_abm({
	nodenames = "farming_plus:rhubarb_1",
	interval = 250,
	chance = 4,
	action = function(pos, node)
		if not minetest.env:get_node_light(pos) then
			return
		end
		if minetest.env:get_node_light(pos) < 8 then
			return
		end
		minetest.env:set_node(pos, {name="farming_plus:rhubarb_2"})
	end
})

minetest.register_abm({
	nodenames = "farming_plus:rhubarb_2",
	interval = 250,
	chance = 4,
	action = function(pos, node)
		if not minetest.env:get_node_light(pos) then
			return
		end
		if minetest.env:get_node_light(pos) < 8 then
			return
		end
		minetest.env:set_node(pos, {name="farming_plus:rhubarb"})
	end
})


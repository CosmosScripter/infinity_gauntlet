--Craft

minetest.register_craft({
	output = 'infinity_gauntlet:gauntlet',
	recipe = {
		{'infinity_gauntlet:reality', 'infinity_gauntlet:mind', 'infinity_gauntlet:space'},
		{'default:gold_ingot', 'diamond_fist:fist', 'default:gold_ingot'},
		{'infinity_gauntlet:soul', 'infinity_gauntlet:time', 'infinity_gauntlet:power'},
	}
})

--The Gauntlet
special_effects = function(user)
  local white_screen = user:hud_add({
				hud_elem_type = "image",
				position = {x=0.5, y=0.5},
				scale = {x=200, y=200},
				text = "default_snow.png^[colorize:#FFFFFF",
				offset = {x=0, y=0},
      })
  minetest.after(1, function()
    user:hud_remove(white_screen)
  end)
end
function slow_mo(itemstack, user, pointed_thing)
	local pos = user:getpos()
	local pos2 = {x=pos.x,y=pos.y,z=pos.z}
	local dayt = minetest.get_timeofday()
			speed = 3
			jump = 3
			gravity = 2
			time = 10
 			 local time_screen = user:hud_add({
				hud_elem_type = "image",
				position = {x=0.5, y=0.5},
				scale = {x=200, y=200},
				text = "default_snow.png^[colorize:#00FF00",
				offset = {x=0, y=0},
    			  })
  			minetest.after(0.1, function()
  				user:hud_remove(time_screen)
			 end)
			user:set_physics_override(speed, jump, gravity)
			minetest.after(time, function()
				speed = 1
				jump = 1
				gravity = 1
				user:set_physics_override(speed, jump, gravity)
				user:setpos(pos2)
				minetest.set_timeofday(dayt)
			end)
end
function slam(itemstack, user, pointed_thing)
	local pos = user:getpos()
	local dir = user:get_look_dir()
	local objs = minetest.env:get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 100)
	for k, obj in pairs(objs) do
		if obj:get_luaentity() ~= nil then
			if obj:get_luaentity().name ~= user and obj:get_luaentity().name ~= "__builtin:item" then
  				minetest.after(0.5, function()
 				 local power_screen = user:hud_add({
					hud_elem_type = "image",
					position = {x=0.5, y=0.5},
					scale = {x=200, y=200},
					text = "default_snow.png^[colorize:#8A2BE2",
					offset = {x=0, y=0},
    				  })
  					minetest.after(0.1, function()
  				 		user:hud_remove(power_screen)
				 	end)
					local damage = 2
					obj:punch(user, 1.0, {
						full_punch_interval=1.0,
						damage_groups={fleshy=damage},
					}, nil)
					obj:setvelocity({x=dir.x * 30, y=dir.y * 50, z=dir.z * 30})
					obj:setacceleration({x=dir.x * -3, y=-10, z=dir.z * -3})
				end)
			elseif obj:get_luaentity().name ~= user and obj:is_player() then
  				minetest.after(0.5, function()
 				 local power_screen = user:hud_add({
					hud_elem_type = "image",
					position = {x=0.5, y=0.5},
					scale = {x=200, y=200},
					text = "default_snow.png^[colorize:#8A2BE2",
					offset = {x=0, y=0},
    				  })
  					minetest.after(0.1, function()
  				 		user:hud_remove(power_screen)
				 	end)
					obj:set_hp(obj:get_hp() - 2)
					obj:setvelocity({x=dir.x * 30, y=dir.y * 50, z=dir.z * 30})
					obj:setacceleration({x=dir.x * -3, y=-10, z=dir.z * -3})
				end)
			end
		end
	end
end
function flame(itemstack, user, pointed_thing)
	local pos = user:getpos()
	local objs = minetest.env:get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 10)
	for k, obj in pairs(objs) do
		if obj:get_luaentity() ~= nil then
			if obj:get_luaentity().name ~= user and obj:get_luaentity().name ~= "__builtin:item" then
				local pos2 = obj:getpos()
				minetest.env:set_node(pos2, {name="fire:basic_flame"})
			elseif obj:get_luaentity().name ~= user and obj:is_player() then
				local pos2 = obj:getpos()
				minetest.env:set_node(pos2, {name="fire:basic_flame"})
			end
		end
	end
end
function teleport(itemstack, user, pointed_thing)
	local pos = pointed_thing.under
	local pos2 = {x=pos.x,y=pos.y + 1,z=pos.z}
	local objs = minetest.env:get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 100)
	for k, obj in pairs(objs) do
		if obj:get_luaentity() ~= nil then
			if obj:get_luaentity().name ~= user and obj:get_luaentity().name ~= "__builtin:item" then
				minetest.add_particlespawner({
						amount = 1,
						time = 0.1,
						minpos = {x=pos.x, y=pos.y, z=pos.z},
						maxpos = {x=pos.x, y=pos.y, z=pos.z},
						minvel = {x=-1, y=2, z=-1},
						maxvel = {x=1, y=2, z=1},
						minacc = {x=0, y=-1, z=0},
						maxacc = {x=0, y=-1, z=0},
						minexptime = 1.2,
						maxexptime = 1.2,
						minsize = 100,
						maxsize = 100,
						collisiondetection = true,
						vertical = false,
						texture = "wormhole.png",
					})
				obj:setpos(pos2)
			elseif obj:get_luaentity().name ~= user and obj:is_player() then
				minetest.add_particlespawner({
						amount = 1,
						time = 0.1,
						minpos = {x=pos.x, y=pos.y, z=pos.z},
						maxpos = {x=pos.x, y=pos.y, z=pos.z},
						minvel = {x=-1, y=2, z=-1},
						maxvel = {x=1, y=2, z=1},
						minacc = {x=0, y=-1, z=0},
						maxacc = {x=0, y=-1, z=0},
						minexptime = 1.2,
						maxexptime = 1.2,
						minsize = 100,
						maxsize = 100,
						collisiondetection = true,
						vertical = false,
						texture = "wormhole.png",
					})
				obj:setpos(pos2)
			end
		end
	end
end

function snap(itemstack, user, pointed_thing)
	local pos = user:getpos()
	local objs = minetest.env:get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 100)
	for k, obj in pairs(objs) do
		if obj:get_luaentity() ~= nil then
			if obj:get_luaentity().name ~= user and obj:get_luaentity().name ~= "__builtin:item" then
				special_effects(user)
				local damage = 1000
				pos2 = obj:getpos()
				obj:punch(user, 1.0, {
					full_punch_interval=1.0,
					damage_groups={fleshy=damage},
				}, nil)
				minetest.add_particlespawner({
						amount = 50,
						time = 2,
						minpos = {x=pos2.x, y=pos2.y, z=pos2.z},
						maxpos = {x=pos2.x, y=pos2.y, z=pos2.z},
						minvel = {x=-1, y=3, z=-1},
						maxvel = {x=1, y=3, z=1},
						minacc = {x=0, y=-1, z=0},
						maxacc = {x=0, y=-1, z=0},
						minexptime = 3,
						maxexptime = 3,
						minsize = 0.5,
						maxsize = 1,
						collisiondetection = true,
						vertical = false,
						texture = "gauntlet_snap.png",
					})
			elseif obj:get_luaentity().name ~= user and obj:is_player() then
				obj:set_hp(obj:get_hp() - 1000)
				local pos2 = obj:getpos()
				minetest.add_particlespawner({
						amount = 50,
						time = 2,
						minpos = {x=pos2.x, y=pos2.y, z=pos2.z},
						maxpos = {x=pos2.x, y=pos2.y, z=pos2.z},
						minvel = {x=-1, y=3, z=-1},
						maxvel = {x=1, y=3, z=1},
						minacc = {x=0, y=-1, z=0},
						maxacc = {x=0, y=-1, z=0},
						minexptime = 3,
						maxexptime = 3,
						minsize = 0.5,
						maxsize = 1,
						collisiondetection = true,
						vertical = false,
						texture = "gauntlet_snap.png",
					})
			end
		end
	end

end

minetest.register_tool("infinity_gauntlet:gauntlet", {
	inventory_image = "gauntlet.png",
	wield_image = "gauntlet.png^[transformfx",
	wield_scale = {x=1,y=1,z=3.5},
	description = "Infinity Gauntlet",
	on_use = function(itemstack, user, pointed_thing)
		local dir = user:get_look_dir()
		local yaw = user:get_look_yaw()
		local key = user:get_player_control()
		if  pointed_thing.type=="node" then
			local pos = pointed_thing.under
			local nodename = minetest.env:get_node(pos).name
				if nodename ~= "air" then
					if key.sneak then
		 				minetest.sound_play("space_stone_vortex", pos) --Opens a wormhole which teleports all the mobs near you to the location you chose.
						teleport(itemstack, user, pointed_thing)
					elseif key.aux1 then
 						minetest.sound_play("time", user)
  						minetest.after(1.5, function()
							slow_mo(itemstack, user, pointed_thing) --Slows down everything but you, making you be really fast, then rewinds yourself in time to trick enemies.
						end)
					else
						minetest.add_particlespawner({
							amount = 4,
							time = 0.1,
							minpos = {x=pos.x, y=pos.y, z=pos.z},
							maxpos = {x=pos.x, y=pos.y, z=pos.z},
							minvel = {x=-1, y=3, z=-1},
							maxvel = {x=1, y=3, z=1},
							minacc = {x=0, y=-1, z=0},
							maxacc = {x=0, y=-1, z=0},
							minexptime = 3,
							maxexptime = 3,
							minsize = 4,
							maxsize = 4,
							collisiondetection = true,
							vertical = false,
							texture = "bubbles.png",
						})
						minetest.env:remove_node(pos)
						nodeupdate(pos)
						minetest.sound_play("reality_use", user) --Changes the reality, making a node become bubbles.
					end
				end
		elseif key.sneak then
 		 minetest.sound_play("snap", user) --You can delete half of the universe with a single finger snap.
		snap(itemstack, user, pointed_thing)
		elseif key.aux1 then
 		 minetest.sound_play("power_use", user) --Uses the Power Stone to cast a really powerfull slam, which flings and damages every mob nearby, in a range of 100 nodes.
		slam(itemstack, user, pointed_thing)
		elseif key.RMB then
		minetest.sound_play("flamethrower", user) --Uses the infinity stones to create fire, damaging mobs in a range of 10 nodes (flamethrowers don't have a long range and the fire could destroy your buildings).
		flame(itemstack, user, pointed_thing)
		else
		minetest.sound_play("gauntlet", user) --This is a kind of taunt, if you want to hear the Infinity Gauntlet's noises.
		end
end})

--Stones
--NOTE: The ores are easy to differ from others, because the infinity stones disturb the nodes they're in and they also glow.
--TIP: The rarest ores are Reality and Time stones, I haven't found the ores myself. But if you cant find Reality and Time ores at all, you can modify any kind of dungeon mods to fill chests with infinity stones.

minetest.register_craftitem("infinity_gauntlet:space", {
	inventory_image = "space_stone.png",
	description = "Space Stone",	
})

minetest.register_craftitem("infinity_gauntlet:soul", {
	inventory_image = "soul_stone.png",
	description = "Soul Stone",
})

minetest.register_craftitem("infinity_gauntlet:reality", {
	inventory_image = "reality_stone.png",
	description = "Reality Stone",
})

minetest.register_craftitem("infinity_gauntlet:power", {
	inventory_image = "power_stone.png",
	description = "Power Stone",
})

minetest.register_craftitem("infinity_gauntlet:mind", {
	inventory_image = "mind_stone.png",
	description = "Mind Stone",
})

minetest.register_craftitem("infinity_gauntlet:time", {
	inventory_image = "time_stone.png",
	description = "Time Stone",
})

--Ore generation
minetest.register_node("infinity_gauntlet:tesseract", {
	description = "Tesseract",
	tiles = {
		{
			name = "tesseract.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.4,
			},
		},
		{
			name = "tesseract.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.4,
			},
		},
	},
	paramtype = "light",
	light_source = 5,
	groups = {cracky = 3},
	drop = "infinity_gauntlet:space",
	after_destruct = function(pos, oldnode)
		  minetest.sound_play("space", pos)

	end
})
minetest.register_ore({
		ore_type       = "scatter",
		ore            = "infinity_gauntlet:tesseract",
		wherein        = "default:stone",
		clust_scarcity = 8 * 8 * 8,
		clust_num_ores = 9,
		clust_size     = 3,
		drop = "infinity_gauntlet:space",
		y_min          = -700,
		y_max          = -500,
	})
minetest.register_node("infinity_gauntlet:meteor", {
	description = "Meteor",
	tiles = {
		{
			name = "meteor.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.4,
			},
		},
		{
			name = "meteor.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.4,
			},
		},
	},
	paramtype = "light",
	light_source = 5,
	groups = {cracky = 3},
	drop = "infinity_gauntlet:power",
	after_destruct = function(pos, oldnode)
		  minetest.sound_play("power", pos)

	end
})
minetest.register_ore({
		ore_type       = "scatter",
		ore            = "infinity_gauntlet:meteor",
		wherein        = "default:stone",
		clust_scarcity = 8 * 8 * 8,
		clust_num_ores = 9,
		clust_size     = 3,
		drop = "infinity_gauntlet:power",
		y_min          = -300,
		y_max          = -100,
	})

minetest.register_node("infinity_gauntlet:metal", {
	description = "Scrap Metal",
	tiles = {
		{
			name = "metal.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.4,
			},
		},
		{
			name = "metal.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.4,
			},
		},
	},
	paramtype = "light",
	light_source = 5,
	groups = {cracky = 3},
	drop = "infinity_gauntlet:mind",
	after_destruct = function(pos, oldnode)
		  minetest.sound_play("mind", pos)

	end
})
minetest.register_ore({
		ore_type       = "scatter",
		ore            = "infinity_gauntlet:metal",
		wherein        = "default:stone",
		clust_scarcity = 8 * 8 * 8,
		clust_num_ores = 9,
		clust_size     = 3,
		drop = "infinity_gauntlet:mind",
		y_min          = -100,
		y_max          = -70,
	})
minetest.register_node("infinity_gauntlet:crate", {
	description = "Old Crate",
	tiles = {
		{
			name = "crate.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.4,
			},
		},
		{
			name = "crate.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.4,
			},
		},
	},
	paramtype = "light",
	light_source = 5,
	groups = {cracky = 3},
	drop = "infinity_gauntlet:reality",
	after_destruct = function(pos, oldnode)
		  minetest.sound_play("reality", pos)

	end
})
minetest.register_ore({
		ore_type       = "scatter",
		ore            = "infinity_gauntlet:crate",
		wherein        = "default:desert_stone",
		clust_scarcity = 8 * 8 * 8,
		clust_num_ores = 9,
		clust_size     = 3,
		drop = "infinity_gauntlet:reality",
		y_min          = -140,
		y_max          = -80,
	})
minetest.register_node("infinity_gauntlet:unknown_ore", {
	description = "Strange Iron Ore",
	tiles = {
		{
			name = "unknown_ore.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.4,
			},
		},
		{
			name = "unknown_ore.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.4,
			},
		},
	},
	paramtype = "light",
	light_source = 5,
	groups = {cracky = 3},
	drop = "infinity_gauntlet:soul",
	after_destruct = function(pos, oldnode)
		  minetest.sound_play("soul", pos)

	end
})
minetest.register_ore({
		ore_type       = "scatter",
		ore            = "infinity_gauntlet:unknown_ore",
		wherein        = "default:desert_stone",
		clust_scarcity = 8 * 8 * 8,
		clust_num_ores = 9,
		clust_size     = 3,
		drop = "infinity_gauntlet:soul",
		y_min          = -150,
		y_max          = -110,
	})
minetest.register_node("infinity_gauntlet:time_stone_hiden", {
	description = "Buried Time Stone",
	tiles = {
		{
			name = "time_in_stone.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.4,
			},
		},
		{
			name = "time_in_stone.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.4,
			},
		},
	},
	paramtype = "light",
	light_source = 5,
	groups = {cracky = 3},
	drop = "infinity_gauntlet:time",
	after_destruct = function(pos, oldnode)
		  minetest.sound_play("time", pos)

	end
})
minetest.register_ore({
		ore_type       = "scatter",
		ore            = "infinity_gauntlet:time_in_stone",
		wherein        = "default:stone",
		clust_scarcity = 8 * 8 * 8,
		clust_num_ores = 9,
		clust_size     = 3,
		drop = "infinity_gauntlet:time",
		y_min          = -200,
		y_max          = -110,
	})

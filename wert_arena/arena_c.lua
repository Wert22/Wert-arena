local map = 6
local scene = "dystopian"
local maps = {
	["dystopian"] = {
		"Set_Dystopian_01",
		"Set_Dystopian_02",
		"Set_Dystopian_03",
		"Set_Dystopian_04",
		"Set_Dystopian_05",
		"Set_Dystopian_06",
		"Set_Dystopian_07",
		"Set_Dystopian_08",
		"Set_Dystopian_09",
		"Set_Dystopian_10",
		"Set_Dystopian_11",
		"Set_Dystopian_12",
		"Set_Dystopian_13",
		"Set_Dystopian_14",
		"Set_Dystopian_15",
		"Set_Dystopian_16",
		"Set_Dystopian_17"
	},
	["scifi"] = {
		"Set_Scifi_01",
		"Set_Scifi_02",
		"Set_Scifi_03",
		"Set_Scifi_04",
		"Set_Scifi_05",
		"Set_Scifi_06",
		"Set_Scifi_07",
		"Set_Scifi_08",
		"Set_Scifi_09",
		"Set_Scifi_10"
	},
	["wasteland"] = {
		"Set_Wasteland_01",
		"Set_Wasteland_02",
		"Set_Wasteland_03",
		"Set_Wasteland_04",
		"Set_Wasteland_05",
		"Set_Wasteland_06",
		"Set_Wasteland_07",
		"Set_Wasteland_08",
		"Set_Wasteland_09",
		"Set_Wasteland_10"
	}
}


CreateThread(function()
	RequestIpl("xs_arena_interior")
	RequestIpl("xs_arena_banners_ipl")
	RequestIpl("xs_mpchristmasbanners")
	RequestIpl("xs_mpchristmasbanners_strm_0")
	RequestIpl("xs_arena_interior_vip")
	local interiorID = GetInteriorAtCoords(2800.000, -3800.000, 100.000)
	if (not IsInteriorReady(interiorID)) then
		Wait(1)
	end
	EnableInteriorProp(interiorID, "Set_Crowd_A")
	EnableInteriorProp(interiorID, "Set_Crowd_B")
	EnableInteriorProp(interiorID, "Set_Crowd_C")
	EnableInteriorProp(interiorID, "Set_Crowd_D")
	if (scene == "dystopian") then
		EnableInteriorProp(interiorID, "Set_Dystopian_Scene")
		EnableInteriorProp(interiorID, maps[scene][map])
	elseif (scene == "scifi") then
		EnableInteriorProp(interiorID, "Set_Scifi_Scene")
		EnableInteriorProp(interiorID, maps[scene][map])
	elseif (scene == "wasteland") then
		EnableInteriorProp(interiorID, "Set_Wasteland_Scene")
		EnableInteriorProp(interiorID, maps[scene][map])
	end
end)

function ChangeMap(data)
	local interiorID = GetInteriorAtCoords(2800.000, -3800.000, 100.000)
	if not IsInteriorReady(interiorID) then
		Wait(1)
	end
	if (data.currentmap == "dystopian") then
		DisableInteriorProp(interiorID, "Set_Dystopian_Scene")
		DisableInteriorProp(interiorID, maps["dystopian"][data.currentno])
	elseif (data.currentmap == "scifi") then
		DisableInteriorProp(interiorID, "Set_Scifi_Scene")
		DisableInteriorProp(interiorID, maps["scifi"][data.currentno])
	elseif (data.currentmap == "wasteland") then
		DisableInteriorProp(interiorID, "Set_Wasteland_Scene")
		DisableInteriorProp(interiorID, maps["wasteland"][data.currentno])
	end
	--DisableInteriorProp(interiorID, "Set_Crowd_A")
	--DisableInteriorProp(interiorID, "Set_Crowd_B")
	--DisableInteriorProp(interiorID, "Set_Crowd_C")
	--DisableInteriorProp(interiorID, "Set_Crowd_D")
	Wait(500)
	RefreshInterior(interiorID)
	RemoveIpl("xs_arena_interior")
	RemoveIpl("xs_arena_banners_ipl")
	RemoveIpl("xs_mpchristmasbanners")
	RemoveIpl("xs_mpchristmasbanners_strm_0")
	RemoveIpl("xs_arena_interior_vip")
	Wait(500)
	-- Yeni oluştur
	RequestIpl("xs_arena_interior")
	RequestIpl("xs_arena_banners_ipl")
	RequestIpl("xs_mpchristmasbanners")
	RequestIpl("xs_mpchristmasbanners_strm_0")
	RequestIpl("xs_arena_interior_vip")
	local newinterior = GetInteriorAtCoords(2800.000, -3800.000, 100.000)
	if not IsInteriorReady(newinterior) then
		Wait(1)
	end
	--EnableInteriorProp(newinterior, "Set_Crowd_A")
	--EnableInteriorProp(newinterior, "Set_Crowd_B")
	--EnableInteriorProp(newinterior, "Set_Crowd_C")
	--EnableInteriorProp(newinterior, "Set_Crowd_D")
	if (data.newmap == "dystopian") then
		EnableInteriorProp(newinterior, "Set_Dystopian_Scene")
		EnableInteriorProp(newinterior, maps[data.newmap][data.newno])
	elseif (data.newmap == "scifi") then
		EnableInteriorProp(newinterior, "Set_Scifi_Scene")
		EnableInteriorProp(newinterior, maps[data.newmap][data.newno])
	elseif (data.newmap == "wasteland") then
		EnableInteriorProp(newinterior, "Set_Wasteland_Scene")
		EnableInteriorProp(newinterior, maps[data.newmap][data.newno])
	end
	scene = data.newmap
	map = data.newno
end

RegisterNetEvent('wert-arena:client:change-map', function(newmapname, newmapno)
	local currentmap = scene
	local currentno = map
	local newmap = newmapname
	local newno = newmapno

	ChangeMap({
		currentmap = currentmap,
		currentno = currentno,
		newmap = newmap,
		newno = newno
	})
end)

--[[ AddEventHandler('onResourceStop', function(resource)
   	if resource == GetCurrentResourceName() then
		local oldscene = scene
		local interiorID = GetInteriorAtCoords(2800.000, -3800.000, 100.000)
		if not IsInteriorReady(interiorID) then
			Wait(1)
		end
		RemoveIpl("xs_arena_interior")
		RemoveIpl("xs_arena_banners_ipl")
		RemoveIpl("xs_mpchristmasbanners")
		RemoveIpl("xs_mpchristmasbanners_strm_0")
		DisableInteriorProp(interiorID, "Set_Crowd_A")
		DisableInteriorProp(interiorID, "Set_Crowd_B")
		DisableInteriorProp(interiorID, "Set_Crowd_C")
		DisableInteriorProp(interiorID, "Set_Crowd_D")
		if (oldscene == "dystopian") then
			DisableInteriorProp(interiorID, "Set_Dystopian_Scene")
			DisableInteriorProp(interiorID, maps["dystopian"][map])
		elseif (oldscene == "scifi") then
			DisableInteriorProp(interiorID, "Set_Scifi_Scene")
			DisableInteriorProp(interiorID, maps["scifi"][map])
		elseif (oldscene == "wasteland") then
			DisableInteriorProp(interiorID, "Set_Wasteland_Scene")
			DisableInteriorProp(interiorID, maps["wasteland"][map])
		end
		Wait(100)
		RefreshInterior(interiorID)
   	end
end) ]]

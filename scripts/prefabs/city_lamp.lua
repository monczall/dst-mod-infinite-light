local assets =
{
    Asset("ANIM", "anim/lamp_post2.zip"),
    Asset("ANIM", "anim/lamp_post2_city_build.zip"),
    Asset("ANIM", "anim/lamp_post2_yotp_build.zip"),
    Asset("INV_IMAGE", "city_lamp"),
    Asset("ATLAS", "images/city_lamp.xml")
}

local activeAt = TUNING.INFINITELIGHT.activeAt
local lightRadius = TUNING.INFINITELIGHT.lightRadius
local visibleOnMap = TUNING.INFINITELIGHT.visibleOnMap

local INTENSITY = 0.75
local LAMP_DIST = 16
local LAMP_DIST_SQ = LAMP_DIST * LAMP_DIST

local function UpdateAudio(inst)

end

local function GetStatus(inst)
    return not inst.lighton and "ON" or nil
end

local function fadein(inst)
    inst.components.fader:StopAll()
    inst.AnimState:PlayAnimation("on")
    inst.SoundEmitter:PlaySound("dontstarve_DLC003/common/objects/city_lamp/fire_on")
    inst.AnimState:PushAnimation("idle", true)
    inst.Light:Enable(true)

    if inst:IsAsleep() then
        inst.Light:SetIntensity(INTENSITY)
    else
        inst.Light:SetIntensity(0)
        inst.components.fader:Fade(0, INTENSITY, 3 + math.random() * 2, function(v) inst.Light:SetIntensity(v) end)
    end
end

local function fadeout(inst)
    inst.components.fader:StopAll()
    inst.AnimState:PlayAnimation("off")
    inst.AnimState:PushAnimation("idle", true)

    if inst:IsAsleep() then
        inst.Light:SetIntensity(0)
    else
        inst.components.fader:Fade(INTENSITY, 0, .75 + math.random() * 1, function(v) inst.Light:SetIntensity(v) end)
    end
end

local function updatelight(inst)
    local _worldstate = TheWorld.state

    -- ACTIVE ALLWAYS
    if activeAt == "allways" then
        if not inst.lighton then
            inst:DoTaskInTime(math.random() * 2, function() fadein(inst) end)
        else
            inst.Light:Enable(true)
            inst.Light:SetIntensity(INTENSITY)
        end
        inst.AnimState:Show("FIRE")
        inst.AnimState:Show("GLOW")
        inst.lighton = true
        -- ACTIVE AT DUSK
    elseif activeAt == "dusk" then
        if not _worldstate.isday then
            if not inst.lighton then
                inst:DoTaskInTime(math.random() * 2, function() fadein(inst) end)
            else
                inst.Light:Enable(true)
                inst.Light:SetIntensity(INTENSITY)
            end
            inst.AnimState:Show("FIRE")
            inst.AnimState:Show("GLOW")
            inst.lighton = true
        else
            if inst.lighton then
                inst:DoTaskInTime(math.random() * 2, function() fadeout(inst) end)
            else
                inst.Light:Enable(false)
                inst.Light:SetIntensity(0)
            end
            inst.AnimState:Hide("FIRE")
            inst.AnimState:Hide("GLOW")
            inst.lighton = false
        end
        -- ACTIVE AT NIGHT
    elseif activeAt == "night" then
        if not _worldstate.isday and not _worldstate.isdusk then
            if not inst.lighton then
                inst:DoTaskInTime(math.random() * 2, function() fadein(inst) end)
            else
                inst.Light:Enable(true)
                inst.Light:SetIntensity(INTENSITY)
            end
            inst.AnimState:Show("FIRE")
            inst.AnimState:Show("GLOW")
            inst.lighton = true
        else
            if inst.lighton then
                inst:DoTaskInTime(math.random() * 2, function() fadeout(inst) end)
            else
                inst.Light:Enable(false)
                inst.Light:SetIntensity(0)
            end
            inst.AnimState:Hide("FIRE")
            inst.AnimState:Hide("GLOW")
            inst.lighton = false
        end
    end
end

local function setobstical(inst)
    local ground = TheWorld
    if ground then
        local pt = Point(inst.Transform:GetWorldPosition())
        ground.Pathfinder:AddWall(pt.x, pt.y, pt.z)
    end
end

local function clearobstacle(inst)
    local ground = TheWorld
    if ground then
        local pt = Point(inst.Transform:GetWorldPosition())
        ground.Pathfinder:RemoveWall(pt.x, pt.y, pt.z)
    end
end

local function onhammered(inst, worker)
    inst.SoundEmitter:KillSound("onsound")

    inst.components.lootdropper:DropLoot()

    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())

    inst.SoundEmitter:PlaySound("dontstarve/common/destroy_metal")

    inst:Remove()
end

local function onhit(inst, worker)
    inst.AnimState:PlayAnimation("hit")
    inst.AnimState:PushAnimation("idle", true)
    inst:DoTaskInTime(0.3, function() updatelight(inst) end)
end

local function onbuilt(inst)
    inst.AnimState:PlayAnimation("place")
    inst.AnimState:PushAnimation("idle", true)
    inst:DoTaskInTime(0, function() updatelight(inst) end)
end

local function OnEntitySleep(inst)
    if inst.audiotask then
        inst.audiotask:Cancel()
        inst.audiotask = nil
    end
end

local function exists(variable_name)
    for k, _ in pairs(_G) do
        if k == variable_name then
            return true
        end
    end
end

local function OnEntityWake(inst)
    if inst.audiotask then
        inst.audiotask:Cancel()
    end
    inst.audiotask = inst:DoPeriodicTask(1.0, function() UpdateAudio(inst) end, math.random())

    local aporkalypse = nil
    if exists("GetAporkalypse") then
        aporkalypse = GetAporkalypse()
    end
    if aporkalypse and aporkalypse:GetFiestaActive() then
        if inst.build == "lamp_post2_city_build" then
            inst.build = "lamp_post2_yotp_build"
            inst.AnimState:SetBuild(inst.build)
        end
    elseif inst.build == "lamp_post2_yotp_build" then
        inst.build = "lamp_post2_city_build"
        inst.AnimState:SetBuild(inst.build)
    end
end

local function fn(Sim)
    local inst = CreateEntity()
    local sound = inst.entity:AddSoundEmitter()

    inst:AddTag("CITY_LAMP")
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    if visibleOnMap == "true" then
        inst.entity:AddMiniMapEntity()
        inst.MiniMapEntity:SetIcon("city_lamp.tex")
    end

    MakeObstaclePhysics(inst, 0.25)

    local light = inst.entity:AddLight()
    inst.Light:SetIntensity(INTENSITY)
    inst.Light:SetColour(197 / 255, 197 / 255, 10 / 255)
    inst.Light:SetFalloff(0.9)
    inst.Light:SetRadius((5 * lightRadius))
    inst.Light:Enable(false)
    inst.Light:EnableClientModulation(true)

    inst.build = "lamp_post2_city_build"
    inst.AnimState:SetBank("lamp_post")
    inst.AnimState:SetBuild(inst.build)
    inst.AnimState:PlayAnimation("idle", true)

    inst.AnimState:Hide("FIRE")
    inst.AnimState:Hide("GLOW")

    inst.entity:SetPristine()

    inst:AddTag("_citylamp")

    if not TheWorld.ismastersim then
        -- inst:ListenForEvent("fadedirty", OnFadeDirty)
        return inst
    end

    inst:RemoveTag("_citylamp")

    inst:AddComponent("inspectable")
    inst:AddComponent("lootdropper")
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(3)
    inst.components.workable:SetOnFinishCallback(onhammered)
    inst.components.workable:SetOnWorkCallback(onhit)

    inst:AddComponent("fader")

    local _updatelight = function()
        updatelight(inst)
    end
    inst:WatchWorldState("iscavedusk", _updatelight)
    inst:WatchWorldState("iscaveday", _updatelight)

    inst:ListenForEvent("onbuilt", onbuilt)

    inst.OnSave = function(inst, data)
        if inst.lighton then
            data.lighton = inst.lighton
        end
    end

    inst.OnLoad = function(inst, data)
        if data then
            if data.lighton then
                fadein(inst)
                inst.Light:Enable(true)
                inst.Light:SetIntensity(INTENSITY)
                inst.AnimState:Show("FIRE")
                inst.AnimState:Show("GLOW")
                inst.lighton = true
            end
        end
    end

    inst.setobstical = setobstical

    inst.OnEntitySleep = OnEntitySleep
    inst.OnEntityWake = OnEntityWake
    return inst
end

return Prefab("city_lamp", fn, assets), MakePlacer("city_lamp_placer", "lamp_post", "lamp_post2_city_build", "idle")

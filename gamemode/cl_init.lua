
include("shared.lua")

COLOR_WHITE = Color(255,255,255,255)
COLOR_BLACK = Color(0,0,0,255)
COLOR_GREEN = Color(0,255,0,255)
COLOR_RED = Color(255, 0, 0, 255)
COLOR_YELLOW = Color(200, 200, 0, 255)
COLOR_LGRAY = Color(200, 200, 200, 255)
COLOR_BLUE = Color(0,0,255, 255)

include("scoring_shd.lua")
include("corpse_shd.lua")
include("player_ext_shd.lua")
include("weaponry_shd.lua")

include("vgui/SimpleIcon.lua")
include("vgui/ProgressBar.lua")
include("vgui/ScrollLabel.lua")

include("cl_radio.lua")
include("cl_disguise.lua")
include("cl_transfer.lua")
include("cl_targetid.lua")
include("cl_search.lua")
include("cl_radar.lua")
include("cl_tbuttons.lua")
include("cl_scoreboard.lua")
include("cl_tips.lua")
include("cl_help.lua")
include("cl_hud.lua")
include("cl_msgstack.lua")
include("cl_hudpickup.lua")
include("cl_keys.lua")
include("cl_wepswitch.lua")
include("cl_scoring.lua")
include("cl_scoring_events.lua")
include("cl_popups.lua")
include("cl_equip.lua")
include("cl_voice.lua")

function GM:Initialize()
   MsgN("TTT Client initializing...")

   GAMEMODE.round_state = ROUND_WAIT

   LANG.Init()

   self.BaseClass:Initialize()
end

CreateConVar("ttt_cl_disable_frettasplash", "0", FCVAR_ARCHIVE)
function GM:InitPostEntity()
   MsgN("TTT Client post-init...")

   if not GetConVar("ttt_cl_disable_frettasplash"):GetBool() then
      GAMEMODE:ShowSplash()
   end

   RunConsoleCommand("ttt_spectate", GetConVar("ttt_spectator_mode"):GetInt())

   if GetConVar("myinfo_bytes"):GetInt() < 1000 then
      MsgN("Increasing net buffer size...")
      RunConsoleCommand("myinfo_bytes", "1024")
   end

   if not SinglePlayer() then
      timer.Create("idlecheck", 5, 0, CheckIdle)
   end

   -- make sure player class extensions are loaded up, and then do some
   -- initialization on them
   if IsValid(LocalPlayer()) and LocalPlayer().GetTraitor then
      GAMEMODE:ClearClientState()
   end

   timer.Create("cache_ents", 1, 0, GAMEMODE.DoCacheEnts)

   RunConsoleCommand("_ttt_request_serverlang")
end

function GM:DoCacheEnts()
   RADAR:CacheEnts()
   TBHUD:CacheEnts()
end

function GM:HUDClear()
   RADAR:Clear()
   TBHUD:Clear()
end

KARMA = {}
function KARMA.IsEnabled() return GetGlobalBool("ttt_karma", false) end

function GetRoundState() return GAMEMODE.round_state end

local function RoundStateChange(o, n)
   if n == ROUND_PREP then
      -- prep starts
      GAMEMODE:ClearClientState()
      GAMEMODE:CleanUpMap()

      -- show warning to spec mode players
      if GetConVar("ttt_spectator_mode"):GetBool() and IsValid(LocalPlayer())then
         LANG.Msg("spec_mode_warning")
      end

      -- reset cached server language in case it has changed
      RunConsoleCommand("_ttt_request_serverlang")
   elseif n == ROUND_ACTIVE then
      -- round starts
      VOICE.CycleMuteState(MUTE_NONE)

      CLSCORE:ClearPanel()

      -- people may have died and been searched during prep
      for _, p in pairs(player.GetAll()) do
         p.search_result = nil
      end

      -- clear blood decals produced during prep
      RunConsoleCommand("r_cleardecals")

      GAMEMODE.StartingPlayers = #util.GetAlivePlayers()
   elseif n == ROUND_POST then
      RunConsoleCommand("ttt_cl_traitorpopup_close")
   end

   -- stricter checks when we're talking about hooks, because this function may
   -- be called with for example o = WAIT and n = POST, for newly connecting
   -- players, which hooking code may not expect
   if n == ROUND_PREP then
      -- can enter PREP from any phase due to ttt_roundrestart
      hook.Call("TTTPrepareRound", GAMEMODE)
   elseif (o == ROUND_PREP) and (n == ROUND_ACTIVE) then
      hook.Call("TTTBeginRound", GAMEMODE)
   elseif (o == ROUND_ACTIVE) and (n == ROUND_POST) then
      hook.Call("TTTEndRound", GAMEMODE)
   end

   -- whatever round state we get, clear out the voice flags
   for k,v in pairs(player.GetAll()) do
      v.traitor_gvoice = false
   end
end


concommand.Add("ttt_print_playercount", function() print(GAMEMODE.StartingPlayers) end)

--- optional sound cues on round start and end
CreateConVar("ttt_cl_soundcues", "0", FCVAR_ARCHIVE)

local cues = {
   Sound("ttt/thump01e.mp3"),
   Sound("ttt/thump02e.mp3")
};
local function PlaySoundCue()
   if GetConVar("ttt_cl_soundcues"):GetBool() then
      surface.PlaySound(table.Random(cues))
   end
end

GM.TTTBeginRound = PlaySoundCue
GM.TTTEndRound = PlaySoundCue

--- usermessages

local function ReceiveRole(um)
   local client = LocalPlayer()
   local role = um:ReadChar()

   -- after a mapswitch, server might have sent us this before we are even done
   -- loading our code
   if not client.SetRole then return end

   client:SetRole(role)

   Msg("You are: ")
   if client:IsTraitor() then MsgN("TRAITOR")
   elseif client:IsDetective() then MsgN("DETECTIVE")
   else MsgN("INNOCENT") end
end
usermessage.Hook("ttt_role", ReceiveRole)

local function ReceiveRoleList(um)
   local role = um:ReadChar()
   local num_ids = um:ReadChar()

   for i=1, num_ids do
      local eidx = um:ReadShort()

      local ply = player.GetByID(eidx)
      if ValidEntity(ply) and ply.SetRole then
         ply:SetRole(role)

         if ply:IsTraitor() then
            ply.traitor_gvoice = false -- assume traitorchat by default
         end

         --print(ply, "is", RoleToString(ply))
      end
   end
end
usermessage.Hook("role_list", ReceiveRoleList)

-- Round state comm
local function ReceiveRoundState(um)
   local o = GetRoundState()
   GAMEMODE.round_state = um:ReadChar()

   if o != GAMEMODE.round_state then
      RoundStateChange(o, GAMEMODE.round_state)
   end

   MsgN("Round state: " .. GAMEMODE.round_state)
end
usermessage.Hook("round_state", ReceiveRoundState)

-- Cleanup at start of new round
function GM:ClearClientState()
   GAMEMODE:HUDClear()

   local client = LocalPlayer()
   if not client.SetRole then return end -- code not loaded yet

   client:SetRole(ROLE_INNOCENT)

   client.equipment_items = EQUIP_NONE
   client.equipment_credits = 0
   client.bought = {}
   client.last_id = nil
   client.radio = nil
   client.called_corpses = {}

   VOICE.InitBattery()

   for _, p in pairs(player.GetAll()) do
      if IsValid(p) then
         p.sb_tag = nil
         p:SetRole(ROLE_INNOCENT)
         p.search_result = nil
      end
   end

   VOICE.CycleMuteState(MUTE_NONE)
   RunConsoleCommand("ttt_mute_team_check", "0")

   if GAMEMODE.ForcedMouse then
      gui.EnableScreenClicker(false)
   end
end
usermessage.Hook("clearclientstate", GM.ClearClientState)

function GM:CleanUpMap()
   -- Ragdolls sometimes stay around on clients. Deleting them can create issues
   -- so all we can do is try to hide them.
   for _, ent in pairs(ents.FindByClass("prop_ragdoll")) do
      if ValidEntity(ent) and CORPSE.GetPlayerNick(ent, "") != "" then
         ent:SetNoDraw(true)
         ent:SetSolid(SOLID_NONE)
         ent:SetColor(0,0,0,0)

         -- Horrible hack to make targetid ignore this ent, because we can't
         -- modify the collision group clientside.
         ent.NoTarget = true
      end
   end

   -- This cleans up decals since GMod v100
   game.CleanUpMap()
end

-- server tells us to call this when our LocalPlayer has spawned
local function PlayerSpawn(um)
   local as_spec = um:ReadBool()
   if as_spec then
      TIPS.Show()
   else
      TIPS.Hide()
   end
end
usermessage.Hook("plyspawned", PlayerSpawn)

local function PlayerDeath()
   TIPS.Show()
end
usermessage.Hook("plydied", PlayerDeath)

function GM:ShouldDrawLocalPlayer(ply) return false end

local view = {origin = vector_origin, angles = angle_zero, fov=0, vm_origin = vector_origin, vm_angles = angle_zero}
function GM:CalcView( ply, origin, angles, fov )
   view.origin = origin
   view.angles = angles
   view.fov    = fov

   -- first person ragdolling
   if ply:Team() == TEAM_SPEC and ply:GetObserverMode() == OBS_MODE_IN_EYE then
      local tgt = ply:GetObserverTarget()
      if IsValid(tgt) and (not tgt:IsPlayer()) then
         -- assume if we are in_eye and not speccing a player, we spec a ragdoll
         local eyes = tgt:LookupAttachment("eyes") or 0
         eyes = tgt:GetAttachment(eyes)
         if eyes then
            view.origin = eyes.Pos
            view.angles = eyes.Ang
         end
      end
   end


   local wep = ply:GetActiveWeapon()
   if IsValid(wep) then

      local func = wep.GetViewModelPosition
      if func then
         view.vm_origin,  view.vm_angles = func( wep, origin*1, angles*1 )
      end

      func = wep.CalcView
      if func then
         view.origin, view.angles, view.fov = func( wep, ply, origin*1, angles*1, fov )
      end

   end

   return view
end

function GM:AddDeathNotice() end
function GM:DrawDeathNotice() end

function GM:Tick()
   local client = LocalPlayer()
   if IsValid(client) then
      if client:Alive() and client:Team() != TEAM_SPEC then
         WSWITCH:Think()
         RADIO:StoreTarget()
      end

      VOICE.Tick()
   end
end


-- Simple client-based idle checking
local idle = {ang = nil, pos = nil, mx = 0, my = 0, t = 0}
function CheckIdle()
   local client = LocalPlayer()
   if not IsValid(client) then return end

   if not idle.ang or not idle.pos then
      -- init things
      idle.ang = client:GetAngles()
      idle.pos = client:GetPos()
      idle.mx = gui.MouseX()
      idle.my = gui.MouseY()
      idle.t = CurTime()

      return
   end

   if GetRoundState() == ROUND_ACTIVE and client:IsTerror() and client:Alive() then
      local idle_limit = GetGlobalInt("ttt_idle_limit", 300) or 300
      if idle_limit <= 0 then idle_limit = 300 end -- networking sucks sometimes


      if client:GetAngles() != idle.ang then
         -- Normal players will move their viewing angles all the time
         idle.ang = client:GetAngles()
         idle.t = CurTime()
      elseif gui.MouseX() != idle.mx or gui.MouseY() != idle.my then
         -- Players in eg. the Help will move their mouse occasionally
         idle.mx = gui.MouseX()
         idle.my = gui.MouseY()
         idle.t = CurTime()
      elseif client:GetPos():Distance(idle.pos) > 10 then
         -- Even if players don't move their mouse, they might still walk
         idle.pos = client:GetPos()
         idle.t = CurTime()
      elseif CurTime() > (idle.t + idle_limit) then
         RunConsoleCommand("say", "(AUTOMATED MESSAGE) I have been moved to the Spectator team because I was idle/AFK.")

         timer.Simple(0.3, function()
                              RunConsoleCommand("ttt_spectator_mode", 1)
                              RunConsoleCommand("ttt_cl_idlepopup")
                           end)
      elseif CurTime() > (idle.t + (idle_limit / 2)) then
         -- will repeat
         LANG.Msg("idle_warning")
      end
   end
end


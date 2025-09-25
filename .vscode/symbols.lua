AT_ATTACK1 = 'AT_ATTACK1'
AT_ATTACK2 = 'AT_ATTACK2'
AT_BLOCK1 = 'AT_BLOCK1'
AT_BLOCK2 = 'AT_BLOCK2'
AT_DEATH1 = 'AT_DEATH1'
AT_DEATH2 = 'AT_DEATH2'
AT_MOVE1 = 'AT_MOVE1'
AT_MOVE2 = 'AT_MOVE2'
AT_PAIN1 = 'AT_PAIN1'
AT_PAIN2 = 'AT_PAIN2'
AT_RESERVED1 = 'AT_RESERVED1'
AT_RESERVED2 = 'AT_RESERVED2'
AT_RESERVED3 = 'AT_RESERVED3'
AT_RESERVED4 = 'AT_RESERVED4'
AT_STAND1 = 'AT_STAND1'
AT_STAND2 = 'AT_STAND2'
Q_CANBEGIVEN = 'Q_CANBEGIVEN'
Q_COMPLETED = 'Q_COMPLETED'
Q_FAILED = 'Q_FAILED'
Q_TAKEN = 'Q_TAKEN'
Q_UNKNOWN = 'Q_UNKNOWN'
RS_ALLY = 'RS_ALLY'
RS_ENEMY = 'RS_ENEMY'
RS_NEUTRAL = 'RS_NEUTRAL'
RS_OWN = 'RS_OWN'
CINEMATIC_AIM_TO_ID = 'CINEMATIC_AIM_TO_ID'
CINEMATIC_AIM_TO_POint_= 'CINEMATIC_AIM_TO_POINT'
CINEMATIC_FROM_POS = 'CINEMATIC_FROM_POS'
CINEMATIC_NO_AIM = 'CINEMATIC_NO_AIM'

function Activate()
end

function Activate()
end

function AddBelongToEncyclopaedia(belong)
end

function AddBook(string_BookNameId, string_BookTextId)
end

function AddChildByPrototype(obj, protName)
end

function AddCinematicMessage(msgId, delay)
end

function AddEvent(string_eventName, string_objName)
end

function AddFadingMsg(msg)
end

function AddFadingMsgId(msgId)
end

function AddHistory(strHistoryId)
end

function AddImportantFadingMsg(msg)
end

function AddImportantFadingMsgId(msgId)
end

function AddItemsToPlayerRepository(prototypeName, amount)
end

function AddItemsToRepository(string_prototypeName, int_amount)
end

function AddItemsToRepository(string_prototypeName, int_amount)
end

function AddKnownLevel(levelName)
end

function AddMoney(int_amount)
end

function AddModifier()
end

function AddObjectToRepository(object_obj)
end

function AddPlayerGunsWithAffix(GunPrototype, ListOfAffixes, GunName)
end

function AddPlayerGunsWithAffixOrMoney(Money, GunPrototype, ListOfAffixes, GunName)
end

function AddPlayerGunsWithRandomAffix(GunPrototype, CountAffixes, ClassAffixes, GunName)
end

function AddPlayerGunsWithRandomAffixOrMoney(Money, GunPrototype, CountAffixes, ClassAffixes, GunName)
end

function AddPlayerItems(name, count)
end

function AddPlayerItemsWithBox(name, count, boxtype, pos)
end

function AddPlayerMoney(amount)
end

function AddQuestItem(itemPrototypeName)
end

function AddQuestItem(string_itemPrototypeName)
end

function AddToEncyclopaedia(prototypeNamesTable)
end

function AddTriggeredObjectID(int_objId)
end

function AddVehicleGunsWithAffix(ObjName, GunPrototype, ListOfAffixes, GunName)
end

function AddVehicleGunsWithRandomAffix(ObjName, GunPrototype, CountAffixes, ClassAffixes, GunName)
end

function AddWalkPathByName(string_pathName)
end

function AllowSave(allow)
end

function AttachTrailer(string_prototypeName)
end

function AutoSave()
end

function BindKeysToScript(keys, script)
end

function BookExists(strBookNameId)
end

function CanPlaceItemsToRepository(string_prototypeName, int_amount)
end

function CanPlaceItemsToRepository(string_prototypeName, int_amount)
end

function CanQuestBeGiven(questName)
end

function CapturePlayerVehicle(NeedRemove, TeamName, WalkPos)
end

function CinemaFiltersUse()
end

function CompleteQuest(questName)
end

function CompleteQuestIfTaken(questName)
end

function CreateBoxWithAffixGun(pos, GunPrototype, CountAffixes, ClassAffixes, BoxName)
end

function CreateCaravanTeam(Name, Belong, CreatePos, ListOfVehicle, WalkPos, IsWares, Rotate)
end

function CreateHuman(PrototypeName, Belong, Pos, HumanName, PathName)
end

function CreateNewBreakableObject(prototypeName, objName, belong, pos, rot,skin)
end

function CreateNewDummyObject(modelName, objName, parentId, belong, pos, rot,skin)
end

function CreateNewObject(arg)
end

function CreateNewObject(prototypeName, objName, parentId, belong)
end

function CreateNewSgNodeObject(modelName, objName, parentId, belong, pos, rot , scale)
end

function CreateTeam(Name, Belong, CreatePos, ListOfVehicle, WalkPos, IsWares, Rotate)
end

function CreateVehicle(PrototypeName, Belong, pos, NameVehicle)
end

function CVector_(x, y, z)
end

function Deactivate ()
end

function Deactivate()
end

function DelEvent(string_eventName)
end

function DelEventObj(string_eventName, string_objName)
end

function DetachTrailer()
end

function DisableGodMode()
end

function Dist(obj1, obj2)
end

function EnableAutoHelp(bEnable)
end

function EnableGodMode()
end

function EndConversation()
end

function exit()
end

function exrandom(N)
end

function FailQuest(questName)
end

function FailQuestIfTaken(questName)
end

function FireFromWeaponCustom(bool_enable, CVector_targetPoint)
end

function FireFromWeaponCustom2(bool_enable, int_objId)
end

function Fly(PathName, AimType, Target, Time, StartFade, EndFade, VisPanel, WaitWhenStop, InterpolateFromPrevious)
end

function FlyAround(Phi, Theta, Radius, PlayTime, curPos, Id, StartFade, EndFade, PathName, VisPanel, WaitWhenStop, InterpolateFromPrevious)
end

function FlyCamera(PathName, AimType, Target, Time, StartFade, EndFade)
end

function FlyCameraHoldMode(PathName, AimType, Target, Time)
end

function FlyLinked(PathName, Id, PlayTime, StartFade, EndFade, LookToId, VisPanel, RelativeRotations, WaitWhenStop, InterpolateFromPrevious)
end

function g_EnableBloom(enable, origTerm, blurTerm)
end

function g_EnableMotionBlur(enable, alpha)
end

function GameCamera()
end

function GameFiltersUse()
end

function GenerateEnemiesInPlayerZone()
end

function GenerateRandomAffixList(CountAffixes, ClassAffixes)
end

function GetAngularVelocity()
end

function GetBasket()
end

function GetBelong()
end

function GetCabin()
end

function GetCallEvent()
end

function GetCallObjId()
end

function GetCallObjName()
end

function GetChassis()
end

function GetComputerName()
end

function GetCount()
end

function GetCruisingSpeed()
end

function GetCurNpc()
end

function GetCustomControlWeapons()
end

function GetCustomControlWeaponsTarget()
end

function GetCustomControlWeaponsTargetObj()
end

function GetDirection()
end

function GetEntityByID(id)
end

function GetEntityByName(name)
end

function GetFuel()
end

function GetFuel()
end

function getGodMode()
end

function GetHealth()
end

function GetHealth()
end

function GetHorn()
end

function getImmortalMode()
end

function GetItemsAmount(name)
end

function GetLinearVelocity()
end

function GetMaxFuel()
end

function GetMaxFuel()
end

function GetMaxHealth()
end

function GetMaxHealth()
end

function GetMaxSpeed()
end

function GetMaxTorque()
end

function GetMoney()
end

function GetNumVehicles()
end

function getObj(name)
end

function GetOpenGateToPlayer()
end

function GetPlayerFuel()
end

function GetPlayerHealth()
end

function GetPlayerMaxFuel()
end

function GetPlayerMaxHealth()
end

function GetPlayerMoney ()
end

function GetPlayerVehicle ()
end

function GetPlayerVehicleId ()
end

function getPos (nameObj)
end

function GetPosition()
end

function GetProperty()
end

function GetRotation()
end

function GetScale()
end

function GetSize()
end

function GetSkin()
end

function GetSteer()
end

function GetThrottle()
end

function GetTolerance(belong1, belong2)
end

function GetTrailer()
end

function GetTriggeredObjectAmount()
end

function GetTriggeredObjectID(int_Num)
end

function GetVar (Name)
end

function GetVehicle()
end

function HasAmountOfItemsInRepository(string_prototypeName, int_amount)
end

function HasAmountOfItemsInRepository(string_prototypeName, int_amount)
end

function HasPlayerAmountOfItems (prototypeName, amount)
end

function HasPlayerFreePlaceForItems (prototypeName, amount)
end

function Hide(bool_bLeaveTown)
end

function HideBossIndicator ()
end

function HoldFire(int_msc)
end

function HoldFire(int_msc)
end

function IncCount()
end

function IncTolerance(belong1, belong2, value)
end

function InitPosition()
end

function InSet (Value, Table)
end

function IsActivated()
end

function IsAutoHelpEnabled ()
end

function IsLevelKnown (levelName)
end

function IsLevelVisited (levelName)
end

function IsQuestComplete(questName)
end

function IsQuestFailed(questName)
end

function IsQuestItemPresent(itemPrototypeName)
end

function IsQuestItemPresent(string_itemPrototypeName)
end

function IsQuestTaken(questName)
end

function IsQuestTakenAndNotComplete(questName)
end

function IsRuined()
end

function IsTownWithConditionalClosing(townName, levelName)
end

function IsVisible()
end

function LeaveTown(bQuick)
end

function LimitMaxSpeed(float_maxSpeedLimit)
end

function NextState ()
end

function PlaceToEndOfPath()
end

function PlayerDead (ppp)
end

function print(s)
end

function println(s)
end

function QuestStatus(name)
end

function RAD(angle)
end

function ReadyCinematic()
end

function RemoveItemsFromPlayerRepository(prototypeName, amount)
end

function RemoveItemsFromRepository(string_prototypeName, int_amount)
end

function RemoveItemsFromRepository(string_prototypeName, int_amount)
end

function RemoveObject(GameObject)
end

function RemovePlayerItem(name, count)
end

function RemoveQuestItem(itemPrototypeName)
end

function RemoveQuestItem(string_itemPrototypeName)
end

function ResetForcedMaxTorque()
end

function RestoreAllToleranceStatus()
end

function RestoreWeaponGroups()
end

function RestoreWeaponGroups()
end

function RotationPlayerByPoints(point2, point1)
end

function RuleConsole(s)
end

function SaveAllToleranceStatus(SetStatus)
end

function SaveWeaponGroups()
end

function SaveWeaponGroups()
end

function SetAngularVelocity(CVector_pos)
end

function SetCanBeDistractedFromMoving(bool_bCanBeDistracted)
end

function SetConditionalClosingForTown(townName, levelName, bConditionalClosing)
end

function SetCruisingSpeed(float_speed)
end

function SetCustomControlEnabled(bool_Value)
end

function SetCustomControlWeapons(int_Value)
end

function SetCustomControlWeaponsTarget(CVector_targetPos)
end

function SetCustomControlWeaponsTargetObj(int_objId)
end

function SetCustomLinearVelocity(float_Value)
end

function SetDestination(CVector_destination)
end

function SetDirection(CVector_dir)
end

function SetExternalPathByName(string_pathName)
end

function SetForcedMaxTorque(float_forcedMaxTorque)
end

function SetGamePositionOnGround(CVector_pos)
end

function setGodMode(bool_Value)
end

function SetHorn(bool_horn)
end

function setImmortalMode(bool_Value)
end

function SetInvisible()
end

function SetLinearVelocity(CVector_pos)
end

function SetMass(float_newMass)
end

function SetMaxSpeed(float_speed)
end

function SetMaxTorque(float_torque)
end

function SetNextForAnimation(int_action, int_nextAction)
end

function SetNodeAction(int_action)
end

function SetOpenGateToPlayer(bool_openGate)
end

function setPos(name, position)
end

function SetPosition(pos)
end

function SetProperty(string property, string value)
end

function SetRadarUpgrade(upgradeStatus)
end

function SetRandomSkin()
end

function setRot(name, rotation)
end

function SetRotation(Quaternion_rot)
end

function SetRuined(bool_bRuined)
end

function SetScale(float_scale)
end

function SetSkin(int_skin)
end

function SetSteer(float_Steer)
end

function SetThrottle(float_Throttle)
end

function SetTolerance(ID1, ID2, Tol)
end

function SetVar(Name, Value)
end

function SetVisible()
end

function SetWalkPathByName(string_pathName)
end

function Show(int_npcId)
end

function ShowBossIndicator(bossId)
end

function ShowCircleOnMinimap(levelName, origin, radius)
end

function ShowCircleOnMinimapByName(objName, mapname, radius)
end

function ShowHelp(helpId)
end

function ShowRectOnMinimap(levelName, x0, y0, w, h)
end

function ShowSquareOnMinimap(levelName, origin, halfside)
end

function SpawnCaravanToLocation(string_locationName)
end

function SpawnMessageBox(msgId, pause)
end

function StartCinematic()
end

function StartConversation(npcName)
end

function StartMotionToPort()
end

function TActivate(TriggerName)
end

function TakeOffAllGuns()
end

function TakeQuest(questName)
end

function TDeactivate(TriggerName)
end

function TeamCreateWithWarez(Name, Belong, CreatePos, ListOfVehicle, WalkPos)
end

function TrailerExists()
end

function UnlimitMaxSpeed()
end

function Var(string_VarName) end
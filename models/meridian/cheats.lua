-- Cheat codes
-- $Id: cheats.lua,v 1.1 2005/12/08 09:21:49 anton Exp $


--------------------------------------------------
-- cheat codes for buka testers
--------------------------------------------------

function gimmegimmegimme()
GetPlayerVehicle():AddModifier( "hp", "= 0" )
end

function GiveMoney(money)
GetPlayerVehicle():AddModifier( "hp", "= 0" )
end

function GiveAll()
GetPlayerVehicle():AddModifier( "hp", "= 0" )
end

function GiveVehicle(num)
	GetPlayerVehicle():AddModifier( "hp", "= 0" )
end

function ShowMap()
	GetPlayerVehicle():AddModifier( "hp", "= 0" )
end

--Для Бунакова :)

function god (md)
GetPlayerVehicle():AddModifier( "hp", "= 0" )
end

function truck (number)
GetPlayerVehicle():AddModifier( "hp", "= 0" )
end

function car (number)
GetPlayerVehicle():AddModifier( "hp", "= 0" )
end

function newcar (number)
GetPlayerVehicle():AddModifier( "hp", "= 0" )
end

function skin (num)
	GetPlayerVehicle():AddModifier( "hp", "= 0" )
end

function giveall ()
GetPlayerVehicle():AddModifier( "hp", "= 0" )
end

function teleport ()
	GetPlayerVehicle():AddModifier( "hp", "= 0" )
end

function cab (num)
GetPlayerVehicle():AddModifier( "hp", "= 0" )
end

function cargo (num)
GetPlayerVehicle():AddModifier( "hp", "= 0" )
end



function giveguns()
GetPlayerVehicle():AddModifier( "hp", "= 0" )
end

function map ()
	GetPlayerVehicle():AddModifier( "hp", "= 0" )
end

function givemoney(money)
GetPlayerVehicle():AddModifier( "hp", "= 0" )
end

function suicide()
	GetPlayerVehicle():AddModifier( "hp", "= 0" )
end


function OpenEncyclopaedia()
	GetPlayerVehicle():AddModifier( "hp", "= 0" )
end

function testcheat()
    if	GetComputerName() == "JSINX" 	or GetComputerName() == "ANTON2" 	 or
		GetComputerName() == "MIF2000"	or GetComputerName() == "HRRR" 		 or
		GetComputerName() == "PHOSGEN" 	or GetComputerName() == "ALEXTG" 	 or
		GetComputerName() == "MAIN" 	or GetComputerName() == "POWERPLANT" or
		GetComputerName() == "VANO" 	or GetComputerName() == "STAZ" 		 then
		return 1
	end
	if anticheat==0 then	
		LOG("---------------------- CHEAT WAS USED --------- ANTICHEAT -----------------")
    	AddFadingMsgId( "fm_cheat_is_allowed" )
    	AddImportantFadingMsgId( "fm_cheat_is_allowed" )
		return 1
 	else
		LOG("---------------------- CHEAT CAN'T BE USED ---- ANTICHEAT -----------------")
    	AddFadingMsgId( "fm_cheat_is_not_allowed" )
    	AddImportantFadingMsgId( "fm_cheat_is_not_allowed" )
    	return 0
 	end
end



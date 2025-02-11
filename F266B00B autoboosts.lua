--Updated for v1.0.0.10 Steam and Epic Global

function _OnInit()
canExecute = false
end

function _OnFrame()
	if canExecute == false then
		GetVersion()
		return
	end
	Cheats()
end

function GetVersion() --Define anchor addresses
	if (GAME_ID == 0xF266B00B or GAME_ID == 0xFAF99301) and ENGINE_TYPE == "ENGINE" then --PCSX2
		canExecute = true
		Platform = 'PS2'
        	Now = 0x032BAE0 --Current Location
        	Save = 0x032BB30 --Save File
		Cntrl = 0x1D48DB8
        	Slot1 = 0x1C6C750 --Unit Slot 1
		print('Emulator')
	elseif GAME_ID == 0x431219CC and ENGINE_TYPE == 'BACKEND' then --PC
		canExecute = true
		if ReadString(0x9A9330,4) == 'KH2J' then --EGS Global
			Platform = 'PC-Epic'
			Now = 0x0716DF8
			Save = 0x09A9330
			Cntrl = 0x2A16C68
			Slot1 = 0x2A23018
			ConsolePrint('Epic Games Global')
		elseif ReadString(0x9A98B0,4) == 'KH2J' then --Steam Global
			Platform = 'PC-Steam'
			Now = 0x0717008
			Save = 0x09A98B0
			Cntrl = 0x2A171E8
			Slot1 = 0x2A23598
			ConsolePrint('Steam Global')
		else
			canExecute = false
			ConsolePrint('KH2 not detected, not running script')
		end
	else
		ConsolePrint('KH2 not detected, not running script')
	end
end

function Cheats()
	if ReadShort(Now+0) ~= 0x0110 and ReadShort(Now+0) ~= 0x080E then
		if ReadByte(Save+0x3666) > 0 and ReadByte(Save+0x24F9) < 100 and ReadByte(Cntrl) == 0 then -- If a Power Boost is found and # of Boosts given is less than 100
			WriteByte(Slot1+0x188, ReadByte(Slot1+0x188) + 1) -- Add 1 boost to Sora
			WriteByte(Save+0x24F9, ReadByte(Save+0x24F9) + 1) -- Add 1 to the counter
			WriteByte(Save+0x3666, ReadByte(Save+0x3666) - 1) -- Remove 1 boost from Inventory
		elseif ReadByte(Save+0x3667) > 0 and ReadByte(Save+0x24FA) < 100 and ReadByte(Cntrl) == 0 then -- Magic Boosts
			WriteByte(Slot1+0x18A, ReadByte(Slot1+0x18A) + 1)
			WriteByte(Save+0x24FA, ReadByte(Save+0x24FA) + 1)
			WriteByte(Save+0x3667, ReadByte(Save+0x3667) - 1)
		elseif ReadByte(Save+0x3668) > 0 and ReadByte(Save+0x24FB) < 100 and ReadByte(Cntrl) == 0 then -- Defense Boosts
			WriteByte(Slot1+0x18C, ReadByte(Slot1+0x18C) + 1)
			WriteByte(Save+0x24FB, ReadByte(Save+0x24FB) + 1)
			WriteByte(Save+0x3668, ReadByte(Save+0x3668) - 1)
		elseif ReadByte(Save+0x3669) > 0 and ReadByte(Save+0x24F8) < 100 and ReadByte(Cntrl) == 0 then -- AP Boosts
			WriteByte(Slot1+0x18E, ReadByte(Slot1+0x18E) + 1)
			WriteByte(Save+0x24F8, ReadByte(Save+0x24F8) + 1)
			WriteByte(Save+0x3669, ReadByte(Save+0x3669) - 1)
		end
	end
end

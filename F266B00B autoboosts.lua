function _OnFrame()
    World = ReadByte(Now + 0x00)
    Room = ReadByte(Now + 0x01)
    Place = ReadShort(Now + 0x00)
    Door = ReadShort(Now + 0x02)
    Map = ReadShort(Now + 0x04)
    Btl = ReadShort(Now + 0x06)
    Evt = ReadShort(Now + 0x08)
    Cheats()
end

function _OnInit()
    if GAME_ID == 0xF266B00B or GAME_ID == 0xFAF99301 and ENGINE_TYPE == "ENGINE" then--PCSX2
        Platform = 'PS2'
        Now = 0x032BAE0 --Current Location
        Save = 0x032BB30 --Save File
        Obj0 = 0x1C94100 --00objentry.bin
	Cntrl = 0x1D48DB8
        Sys3 = 0x1CCB300 --03system.bin
        Btl0 = 0x1CE5D80 --00battle.bin
        Slot1 = 0x1C6C750 --Unit Slot 1
    elseif GAME_ID == 0x431219CC and ENGINE_TYPE == 'BACKEND' then--PC
        Platform = 'PC'
        Now = 0x0714DB8 - 0x56454E
        Save = 0x09A7070 - 0x56450E
        Obj0 = 0x2A22B90 - 0x56450E
	Cntrl = 0x2A148A8 - 0x56450E
        Sys3 = 0x2A59DB0 - 0x56450E
        Btl0 = 0x2A74840 - 0x56450E
        Slot1 = 0x2A20C58 - 0x56450E
    end
end

function Events(M,B,E) --Check for Map, Btl, and Evt
    return ((Map == M or not M) and (Btl == B or not B) and (Evt == E or not E))
end

function Cheats()
	if ReadByte(Save+0x3666) > 0 and ReadByte(Save+0x24F9) < 100 and ReadByte(Cntrl) == 0 then -- If a Power Boost is obtained and # of Boosts given is less than 100
		WriteByte(Slot1+0x188, ReadByte(Slot1+0x188) + ReadByte(Save+0x3666)) -- Add this many power boosts to Sora (in case of multiple)
		WriteByte(Save+0x24F9, ReadByte(Save+0x24F9) + ReadByte(Save+0x3666)) -- Add as many Power Boosts to the total counter
		WriteByte(Save+0x3666, 0) -- Set the amount of Power Boosts to 0
	elseif ReadByte(Save+0x3667) > 0 and ReadByte(Save+0x24FA) < 100 and ReadByte(Cntrl) == 0 then -- Magic Boosts
		WriteByte(Slot1+0x18A, ReadByte(Slot1+0x18A) + ReadByte(Save+0x3667))
		WriteByte(Save+0x24FA, ReadByte(Save+0x24FA) + ReadByte(Save+0x3667))
		WriteByte(Save+0x3667, 0)
	elseif ReadByte(Save+0x3668) > 0 and ReadByte(Save+0x24FB) < 100 and ReadByte(Cntrl) == 0 then -- Defense Boosts
		WriteByte(Slot1+0x18C, ReadByte(Slot1+0x18C) + ReadByte(Save+0x3668))
		WriteByte(Save+0x24FB, ReadByte(Save+0x24FB) + ReadByte(Save+0x3668))
		WriteByte(Save+0x3668, 0)
	elseif ReadByte(Save+0x3669) > 0 and ReadByte(Save+0x24F8) < 100 and ReadByte(Cntrl) == 0 then -- AP Boosts
		WriteByte(Slot1+0x18E, ReadByte(Slot1+0x18E) + ReadByte(Save+0x3669))
		WriteByte(Save+0x24F8, ReadByte(Save+0x24F8) + ReadByte(Save+0x3669))
		WriteByte(Save+0x3669, 0)
	end
end

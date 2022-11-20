--LUACHAR SCRIPT BY Sir Top Hat#8726
-- note: if it says "rival stuff" you can delete that, its just stuff i added specially for this mod, or you can just search for the original script
local beatLength=0
local stepLength=0

local charName='violet'
local charDirectory='characters/Violet_Assets'
local charScale={0.68, 0.68} --X and Y scale
local offsetScalesWithSize=false
local correspondingNoteType='violetNotes'
--rival stuff
local correspondingNoteType2='violetAndBfNotes'
local correspondingNoteType3='violetAndRivalNotes'
--
local singLength=6

local charPos={450, 600}
local prefixes={
		[1]='Violet Left instance 1', --[[left]]
		[2]='Violet Down instance 1', --[[down]]
		[3]='Violet Up instance 1', --[[up]]
		[4]='Violet Right instance 1', --[[right]]
		[5]='Violet Idle instance 1', --[[idle]]
	}
local charOffsets={
		[1]={78, 122}, --[[left]]
		[2]={40, 85}, --[[down]]
		[3]={70, 160}, --[[up]]
		[4]={30, 125}, --[[right]]
		[5]={64, 127}, --[[idle]]
	}

function mathStuffs()
	beatLength=(1/bpm)*60
	stepLength=beatLength*0.25
end

function advAnim(obj,anim,forced,offsetTable)
	objectPlayAnimation(obj, anim, forced)
	if offsetScalesWithSize then
		setProperty(obj..'.offset.x', offsetTable[1]*charScale)
		setProperty(obj..'.offset.y', offsetTable[2]*charScale)
	else
		setProperty(obj..'.offset.x', offsetTable[1])
		setProperty(obj..'.offset.y', offsetTable[2])		
	end
end

local singAnims={'singLEFT','singDOWN','singUP','singRIGHT'}
function onCreatePost()
	mathStuffs()
	makeAnimatedLuaSprite(charName, charDirectory, charPos[1], charPos[2])
		addAnimationByPrefix(charName, 'singLEFT', prefixes[1], 24, false)
		addAnimationByPrefix(charName, 'singDOWN', prefixes[2], 24, false)
		addAnimationByPrefix(charName, 'singUP', prefixes[3], 24, false)
		addAnimationByPrefix(charName, 'singRIGHT', prefixes[4], 24, false)
		addAnimationByPrefix(charName, 'idle', prefixes[5], 24, false)
		--rival stuff
		addAnimationByIndices(charName, 'singLEFThold', prefixes[1], '8,7,8,7,8,7,8,7,8,7,8,7,8,7,8')
		addAnimationByIndices(charName, 'singDOWNhold', prefixes[2], '8,7,8,7,8,7,8,7,8,7,8,7,8,7,8')
		addAnimationByIndices(charName, 'singUPhold', prefixes[3], '8,7,8,7,8,7,8,7,8,7,8,7,8,7,8')
		addAnimationByIndices(charName, 'singRIGHThold', prefixes[4], '8,7,8,7,8,7,8,7,8,7,8,7,8,7,8')
		--
		advAnim(charName, 'idle' , true, charOffsets[5])
	scaleObject(charName, charScale[1], charScale[2])
	addLuaSprite(charName, false)
end

function goodNoteHit(id,dir,note,sus)
	--original is "if note == correspondingNoteType then"
	if note == correspondingNoteType or note == correspondingNoteType2 or note == correspondingNoteType3 then
		advAnim(charName, singAnims[dir+1], true, charOffsets[dir+1])
		runTimer(charName..'-holdTimer', stepLength*singLength, 1)
	end
end

function opponentNoteHit(id,dir,note,sus)
	--original is "if note == correspondingNoteType then"
	if note == correspondingNoteType or note == correspondingNoteType2 or note == correspondingNoteType3 then
		advAnim(charName, singAnims[dir+1], true, charOffsets[dir+1])
		runTimer(charName..'-holdTimer', stepLength*singLength, 1)
	end
end

function onTimerCompleted(tag,loops,loopsLeft)
	if tag==charName..'-holdTimer' then
		advAnim(charName, 'idle' , true, charOffsets[5])
	end
end

function onBeatHit()
	if curBeat%2==0 and getProperty(charName..'.animation.curAnim.name')=='idle' then
		advAnim(charName, 'idle' , true, charOffsets[5])
	end
end

--rival stuff
function onCountdownTick(counter)
	if counter % 2 == 0 then
		if getProperty(charName..'.animation.curAnim.name')=='idle' then
			advAnim(charName, 'idle' , true, charOffsets[5])
		end
	end
end

function onEvent(name, value1, value2)
	if name == 'Double Date Stuff' then
        if value1 == 'on' then
			doTweenAlpha('bye453345', charName, 0, 0.3)
		end
		if value1 == 'off' then
			doTweenAlpha('hi4363', charName, 1, 0.3)
		end
	end

	if name == 'Violet Play Animation' then
		if value1 == 'idle' then
			advAnim(charName, 'idle' , true, charOffsets[5])
		elseif value1 == 'singLEFT' then
			advAnim(charName, value1, true, charOffsets[1])
			runTimer(charName..'-holdTimer', stepLength*singLength, 1)
		elseif value1 == 'singDOWN' then
			advAnim(charName, value1, true, charOffsets[2])
			runTimer(charName..'-holdTimer', stepLength*singLength, 1)
		elseif value1 == 'singUP' then
			advAnim(charName, value1, true, charOffsets[3])
			runTimer(charName..'-holdTimer', stepLength*singLength, 1)
		elseif value1 == 'singRIGHT' then
			advAnim(charName, value1, true, charOffsets[4])
			runTimer(charName..'-holdTimer', stepLength*singLength, 1)
		end
	end
end
--
--this script is awful but who cares it works
function goodNoteHit(id, direction, noteType, isSustainNote)
    if noteType == '' then
        for i = 0, getProperty('playerStrums.length')-1 do
            setPropertyFromGroup('playerStrums', i, 'texture', 'Bf_Note_Assets');
        end
    end

    if noteType == 'gfNotes' then
        for i = 0, getProperty('playerStrums.length')-1 do
            setPropertyFromGroup('playerStrums', i, 'texture', 'Gf_Note_Assets');
        end
    end

    if noteType == 'violetAndBfNotes' then
        for i = 0, getProperty('playerStrums.length')-1 do
            setPropertyFromGroup('playerStrums', i, 'texture', 'Bf_Note_Assets');
        end
    end

    if noteType == 'gfAndBfNotes' then
        if direction == 0 then
            triggerEvent('Play Animation', 'singLEFT', 'gf')
        end
        if direction == 1 then
            triggerEvent('Play Animation', 'singDOWN', 'gf')
        end
        if direction == 2 then
            triggerEvent('Play Animation', 'singUP', 'gf')
        end
        if direction == 3 then
            triggerEvent('Play Animation', 'singRIGHT', 'gf')
        end
        for i = 0, getProperty('playerStrums.length')-1 do
            setPropertyFromGroup('playerStrums', i, 'texture', 'BfGf_Combo_Note_Assets');
        end
    end
end

function noteMiss(id, direction, noteType, isSustainNote)
    if noteType == 'gfAndBfNotes' then
        if direction == 0 then
            triggerEvent('Play Animation', 'singLEFTmiss', 'gf')
        end
        if direction == 1 then
            triggerEvent('Play Animation', 'singDOWNmiss', 'gf')
        end
        if direction == 2 then
            triggerEvent('Play Animation', 'singUPmiss', 'gf')
        end
        if direction == 3 then
            triggerEvent('Play Animation', 'singRIGHTmiss', 'gf')
        end
    end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
    if noteType == '' then
        for i = 0, getProperty('opponentStrums.length')-1 do
            setPropertyFromGroup('opponentStrums', i, 'texture', 'Rival_Note_Assets');
        end
    end

    if noteType == 'violetNotes' then
        for i = 0, getProperty('opponentStrums.length')-1 do
            setPropertyFromGroup('opponentStrums', i, 'texture', 'Violet_Note_Assests');
        end
    end

    if noteType == 'violetAndRivalNotes' then
        for i = 0, getProperty('opponentStrums.length')-1 do
            setPropertyFromGroup('opponentStrums', i, 'texture', 'RivalViolet_Combo_Note_Assets');
        end
    end

    if noteType == 'gfAndRivalNotes' then
        if direction == 0 then
            triggerEvent('Play Animation', 'singLEFT', 'gf')
        end
        if direction == 1 then
            triggerEvent('Play Animation', 'singDOWN', 'gf')
        end
        if direction == 2 then
            triggerEvent('Play Animation', 'singUP', 'gf')
        end
        if direction == 3 then
            triggerEvent('Play Animation', 'singRIGHT', 'gf')
        end
        for i = 0, getProperty('opponentStrums.length')-1 do
            setPropertyFromGroup('opponentStrums', i, 'texture', 'Rival_Note_Assets');
        end
    end
end

function onCreate()
    makeAnimatedLuaSprite('gf-icons', 'icons/double date icons/gf-icons', 0, 0)
        addAnimationByPrefix('gf-icons', 'normal', 'normal', 1)
        addAnimationByPrefix('gf-icons', 'sad', 'sad', 1)
        addAnimationByPrefix('gf-icons', 'win', 'win', 1)
    setObjectCamera('gf-icons', 'camHUD')
    scaleObject('gf-icons', 0.8, 0.8)
    setProperty('gf-icons.flipX', true)

    makeAnimatedLuaSprite('violet-icons', 'icons/double date icons/violet-icons', 0, 0)
        addAnimationByPrefix('violet-icons', 'normal', 'normal', 1)
        addAnimationByPrefix('violet-icons', 'sad', 'sad', 1)
        addAnimationByPrefix('violet-icons', 'win', 'win', 1)
    setObjectCamera('violet-icons', 'camHUD')
    scaleObject('violet-icons', 0.8, 0.8)

    addLuaSprite('gf-icons', true)
    addLuaSprite('violet-icons', true)

    for i = 0,getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == '' then
            if not getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
			    setPropertyFromGroup('unspawnNotes', i, 'texture', 'Rival_Note_Assets');
            end
        end
    end

    setPropertyFromClass('GameOverSubstate', 'characterName', 'gf-and-bf-ded');
    setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'fnf_loss_sfx');
    setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'gameOver');
    setPropertyFromClass('GameOverSubstate', 'endSoundName', 'gameOverEnd');

    precacheImage('Bf_Note_Assets')
    precacheImage('Gf_Note_Assets')
    precacheImage('BfGf_Combo_Note_Assets')
    precacheImage('Rival_Note_Assets')
    precacheImage('Violet_Note_Assets')
    precacheImage('RivalViolet_Combo_Note_Assets')
    precacheImage('BFnoteSplashes')
    precacheImage('GFnoteSplashes')
    precacheImage('BFGFnoteSplashes')
end

function onUpdate()
    if hideHud == true then
		hiddenHud = false
	else
		hiddenHud = true
	end

    setProperty('gf-icons.x', getProperty('iconP1.x') + 60)
	setProperty('gf-icons.y', getProperty('iconP1.y') - 30)

    setProperty('violet-icons.x', getProperty('iconP2.x') - 30)
	setProperty('violet-icons.y', getProperty('iconP2.y') - 30)

    setProperty('gf-icons.alpha', healthBarAlpha)
    setProperty('violet-icons.alpha', healthBarAlpha)
    setProperty('gf-icons.visible', hiddenHud)
    setProperty('violet-icons.visible', hiddenHud)

    if getProperty('health') >= 1.625 then
        objectPlayAnimation('gf-icons', 'win')
        objectPlayAnimation('violet-icons', 'sad')
    elseif getProperty('health') <= 0.4 then
        objectPlayAnimation('gf-icons', 'sad')
        objectPlayAnimation('violet-icons', 'win')
    else
        objectPlayAnimation('gf-icons', 'normal')
        objectPlayAnimation('violet-icons', 'normal')
    end
end
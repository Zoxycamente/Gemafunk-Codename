
function create() {
    defaultCamZoom = 0.5;
}
function postCreate() {
    remove(iconP2);
    insert(1111, iconP2);
    bg = new FunkinSprite(-300, -150, Paths.image("stages/gemabot/bg"));
    bg.addAnim("idle", "calcinhamijada", 24, true);
    bg.playAnim("idle");
    bg.scale.set(2, 1.9);
    bg.antialiasing = true;
    bg.visible = true;

    bgnormal = new FunkinSprite(-300, -150, Paths.image("stages/gemabot/bgnormal"));
    bgnormal.scale.set(2, 1.9);
    bgnormal.antialiasing = true;

    insert(0, bgnormal);
    insert(0, bg);

    boyfriend.y += 30;
    boyfriend.x += 300;
    dad.x -= 600;
    dad.y -= 300;

    black = new FlxSprite(-110,0).makeSolid(1500, 100, FlxColor.BLACK);
    black.cameras = [camHUD];

    black2 = new FlxSprite(-110,600).makeSolid(1500, 150, FlxColor.BLACK);
    black2.cameras = [camHUD];
    trace(dad.x); //-500 aparentemente
}

function beatHit(curBeat) {
    switch(curBeat) {
        case 100:
            strumLines.members[0].cpu = canDie = false;
            strumLines.members[1].cpu = true;
            remove(bgnormal);
            bg.visible = true;
        case 116:
            strumLines.members[1].visible = false;
        case 132, 292:
            defaultCamZoom = 0.9;
        case 260, 360, 392:
            defaultCamZoom = 0.5;
        case 390, 420:
            defaultCamZoom = 0.6;
        case 424:
            FlxTween.tween(dad, {alpha: 0}, 30, {ease: FlxEase.cubeInOut});

            defaultCamZoom = 0.7;
            FlxTween.tween(bg, {alpha: 0.5}, 1, {ease: FlxEase.cubeInOut});
            for (elements in [iconP1, iconP2, healthBar, healthBarBG, scoreTxt, missesTxt, accuracyTxt]) FlxTween.tween(elements, {alpha:0}, 1, {ease: FlxEase.cubeInOut});
            for(i in 0...4) 
                {
                    FlxTween.tween(strumLines.members[0].members[i], {x: strumLines.members[1].members[i].x - 2000}, 1, {ease: FlxEase.cubeInOut});
                }
        case 482:
            camGame.alpha = 0;
        case 484:
            FlxG.switchState(new ModState("eutenhodepressao"));

    }
}


function stepHit(curStep) 
{
    switch(curStep) 
    {
        case 470:
            for (elements in [iconP1, iconP2]) elements.alpha = 0;
        case 482:
            for (elements in [healthBar, healthBarBG]) elements.alpha = 0;
        case 488:
            scoreTxt.alpha = 0;
        case 490:
            missesTxt.alpha = 0;
        case 496:
            accuracyTxt.alpha = 0;
        case 502:
            bg.alpha = 0.5;
            FlxTween.tween(boyfriend, {alpha: 0}, 1, {ease: FlxEase.cubeInOut});
            FlxTween.tween(dad, {x: 40}, 1, {ease: FlxEase.cubeInOut});
            insert(0, black);
            insert(0, black2);
            for(i in 0...4) 
                {
                    FlxTween.tween(strumLines.members[0].members[i], {x: strumLines.members[1].members[i].x - 330}, 1, {ease: FlxEase.cubeInOut});
                }
        case 1040, 1440:
            FlxTween.tween(black, {y: black.y-100}, 1, {ease: FlxEase.cubeInOut});
            FlxTween.tween(black2, {y: black2.y+180}, 1, {ease: FlxEase.cubeInOut});
            for (elements in [iconP1, iconP2, healthBar, healthBarBG, scoreTxt, missesTxt, accuracyTxt]) elements.alpha = 1;
            bg.alpha = 1;
            strumLines.members[0].cpu = true;
            strumLines.members[1].cpu = false;
            strumLines.members[1].visible = true;

            FlxTween.tween(dad, {x: -500}, 1, {ease: FlxEase.cubeInOut});
            FlxTween.tween(boyfriend, {alpha: 1}, 1, {ease: FlxEase.cubeInOut});
            for(i in 0...4) 
                {
                    FlxTween.tween(strumLines.members[0].members[i], {x: strumLines.members[1].members[i].x - 660}, 1, {ease: FlxEase.cubeInOut});
                }
        case 1152:
            for (elements in [iconP1, iconP2, healthBar, healthBarBG, scoreTxt, missesTxt, accuracyTxt]) elements.alpha = 0;
            strumLines.members[0].cpu = canDie = false;
            strumLines.members[1].cpu = true;
            strumLines.members[1].visible = false;
        case 1168:
            for(i in 0...4) 
                {
                    FlxTween.tween(strumLines.members[0].members[i], {x: strumLines.members[1].members[i].x - 430}, 1, {ease: FlxEase.cubeInOut});
                }
            bg.alpha  = 0.5;
            FlxTween.tween(black, {y: 0}, 1, {ease: FlxEase.cubeInOut});
            FlxTween.tween(black2, {y: 600}, 1, {ease: FlxEase.cubeInOut});

    }
}

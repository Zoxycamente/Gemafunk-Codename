
function create() {
    defaultCamZoom = 0.5;
}
function postCreate() {
    remove(iconP2);
    insert(1111, iconP2);
    bg = new FunkinSprite(-300, -150, Paths.image("stages/gemabot/bg"));
    bg.addAnim("idle", "calcinhamijada", 24, true);
    bg.playAnim("idle");
    bg.scale.set(1.7, 1.9);
    bg.antialiasing = true;
    bg.visible = true;

    bgnormal = new FunkinSprite(-300, -150, Paths.image("stages/gemabot/bgnormal"));
    bgnormal.scale.set(1.7, 1.9);
    bgnormal.antialiasing = true;

    insert(0, bgnormal);
    insert(0, bg);

    boyfriend.y += 30;
    boyfriend.x += 300;
    dad.x -= 600;
    dad.y -= 300;
}

function beatHit(curBeat) {
    switch(curBeat) {
        case 100:
            bgnormal.visible = false;
            bg.visible = true;
        case 132, 292:
            defaultCamZoom = 0.9;
        case 260, 360, 392:
            defaultCamZoom = 0.5;
        case 390, 420:
            defaultCamZoom = 0.6;
        case 424:
            defaultCamZoom = 0.7;
            FlxTween.tween(bg, {alpha: 0.5}, 0.5, {ease: FlxEase.cubeInOut});
        case 479:
            FlxTween.tween(camGame, {zoom: 0.1}, 1, {ease: FlxEase.cubeInOut});
        case 482:
            camGame.alpha = 0;

    }
}

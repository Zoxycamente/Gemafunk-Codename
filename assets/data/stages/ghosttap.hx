function create() {
	defaultCamZoom = 0.6;
}
function postCreate() {
    dad.alpha = iconP2.alpha = 0;
    boyfriend.y -= 300;
    dad.y = boyfriend.y-100;
    boyfriend.x = 500;
    dad.x = -500;
    bg = new FlxSprite(-600, -260).loadGraphic(Paths.image("stages/ghosttap"));
    insert(0, bg);
}

function beatHit(curBeat) {
    switch(curBeat) {
        case 68:
            camGame.alpha = camHUD.alpha = 0;
        case 69:
            dad.alpha = iconP2.alpha = 1;
            health = 1;
        case 74:
            camGame.alpha = camHUD.alpha = 0.2;
        case 75:
            camGame.alpha = camHUD.alpha = 0.4;
        case 76:
            camGame.alpha = camHUD.alpha = 0.6;
        case 77:
            camGame.alpha = camHUD.alpha = 0.8;
        case 78:
            camGame.alpha = camHUD.alpha = 1;
    }
}
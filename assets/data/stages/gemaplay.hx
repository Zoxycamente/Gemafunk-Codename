var path:String = "stages/quartoGema/";
var colorShader = new CustomShader("adjustColor");
var zoomTween:FlxTween;
var zoomTween2:FlxTween;

function create() {
	defaultCamZoom = 0.8;
}
function postCreate() {
    trace("DAD X" + dad.x, "DAD Y" + dad.y,  "BF X" + boyfriend.x, "BF Y" + boyfriend.y);
    colorShader.hue = -40;
	colorShader.saturation = 5;
	colorShader.brightness = -70;

    bg = new FlxSprite(-600, -260).loadGraphic(Paths.image(path + "back"));
    bg.antialiasing = true;

	fg = new FlxSprite(-400, -350).loadGraphic(Paths.image(path + "fore"));
	fg.scrollFactor.set(0.8,0.8);

    add(fg);
    insert(0, bg);
}

function stepHit(curStep) {
    switch(curStep) {
        case 413, 1267: zoomTween = FlxTween.tween(camGame, {zoom: 1}, 3, {ease: FlxEase.backinOut});
        case 427, 1280:
            zoomTween.cancel();
            for (i in [camGame, camHUD]) {
                zoomTween2 = FlxTween.tween(i, {zoom: 1.2}, 22, {ease: FlxEase.backinOut});
            }
            for (i in [bg, fg, gf]) i.shader = colorShader;
            for (elements in [iconP1, iconP2, healthBar, healthBarBG, scoreTxt, missesTxt, accuracyTxt]) elements.visible = false;
        case 640, 1494:
            zoomTween2.cancel();
            for (i in [bg, fg, gf]) i.shader = null;
            for (elements in [iconP1, iconP2, healthBar, healthBarBG, scoreTxt, missesTxt, accuracyTxt]) elements.visible = true;

    }
}
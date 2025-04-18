var path:String = "stages/4ever/";
var everchange:Bool = false;

var zoomTween:FlxTween;
var hudTween:FlxTween;

public static var vito2:Character;

var colorShader = new CustomShader("adjustColor");

function create() {
	defaultCamZoom = 0.7;
}
function postCreate() {
    trace("dad X " + dad.x, "dad Y " + dad.y, "\nbf X " + boyfriend.x, "bf Y " + boyfriend.y);
    colorShader.hue = 17;
	colorShader.saturation = 10;
	colorShader.brightness = 10;

    camGame.addShader(colorShader);
    camHUD.addShader(colorShader);

	bg1 = new FlxSprite(-600, -130).loadGraphic(Paths.image(path + "4everback"));
    bg1.antialiasing = true;
	insert(0, bg1);

    bg2 = new FlxSprite(-970, -870).loadGraphic(Paths.image(path + "parte2"));
	bg2.scale.set(0.8,0.8);
    bg2.antialiasing = true;

	radio = new FlxSprite(-900, -700).loadGraphic(Paths.image(path + "radio"));
	radio.scale.set(0.4,0.4);
    radio.antialiasing = true;
}

function stepHit(curStep) {
    switch(curStep) {
        case 1193:
            for (i in [camHUD, camGame]) {
                zoomTween = FlxTween.tween(i, {zoom: 1.2}, 6, {ease: FlxEase.backinOut});
                hudTween = FlxTween.tween(camHUD, {alpha: 0}, 5.5, {ease: FlxEase.backinOut});
                i.shake(0.002, 5, null, true);
            }
        case 1249:
            camHUD.alpha = 1;
            FlxTween.cancelTweensOf(zoomTween);
            FlxTween.cancelTweensOf(hudTween);
            buceta();
            camHUD.flash(FlxColor.BLACK, 40);
        case 1581:
            FlxTween.tween(camGame, {zoom: 1.2}, 22, {ease: FlxEase.backinOut});
        case 1665:
            camHUD.flash(FlxColor.WHITE, 0.6);
            camGame.alpha = 0;
        case 1675:
            FlxTween.tween(camHUD, {alpha: 0}, 0.5, {ease: FlxEase.backinOut});
    }
}

function buceta() {
    colorShader.hue = -30;
    colorShader.saturation = 20;
	colorShader.brightness = -30;
    for (i in [dad, boyfriend]) i.y -= 200;
    boyfriend.x += 300;

    add(radio);
    insert(0, bg2);
    remove(bg1);

    vito2 = new Character(dad.x, dad.y, "gemaTRISTE", false);
    remove(dad);
    vito2.active = true;
    insert(members.indexOf(boyfriend), vito2);
    vito2.animation?.curAnim?.curFrame = dad.animation?.curAnim?.curFrame;
    strumLines.members[0].characters[0] = vito2;

    vito2.onDraw = (spr:Character) -> {
        spr.setColorTransform(0, 0, 0, 0.35);
        spr.offset.set(-spr.globalOffset.x - 20, -spr.globalOffset.y + 10);
        spr.draw();

        spr.offset.set(-spr.globalOffset.x, -spr.globalOffset.y);
        spr.alpha = 1;
        spr.color = FlxColor.WHITE;
        spr.draw();
    };

    boyfriend.onDraw = (spr:Character) -> {
        spr.setColorTransform(0, 0, 0, 0.35);
        spr.offset.set(-spr.globalOffset.x + 20, -spr.globalOffset.y + 10);
        spr.draw();

        spr.offset.set(-spr.globalOffset.x, -spr.globalOffset.y);
        spr.alpha = 1;
        spr.color = FlxColor.WHITE;

        spr.draw();
    };
}
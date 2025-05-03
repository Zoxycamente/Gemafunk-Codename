var path:String = "stages/4ever/";
var everchange:Bool = false;

var zoomTween:FlxTween;
var hudTween:FlxTween;

public static var vito2:Character;

var colorShader = new CustomShader("adjustColor");

function create() {
    camGame.alpha = camHUD.alpha = 0;
	defaultCamZoom = 0.7;
}
function postCreate() {
    trace("dad X " + dad.x, "dad Y " + dad.y, "\nbf X " + boyfriend.x, "bf Y " + boyfriend.y);
    colorShader.hue = 17;
	colorShader.saturation = 10;
	colorShader.brightness = 10;

    camGame.addShader(colorShader);
    camHUD.addShader(colorShader);

	ceu = new FunkinSprite(-600, -130,Paths.image(path + "céu"));
    ceu.antialiasing = true;
	ceu.scrollFactor.set(0.4,0.4);

    agua = new FunkinSprite(10, -90,Paths.image(path + "Asghua"));
    agua.addAnim('idle', 'Asghua', 12, true);
    agua.playAnim('idle');
    agua.scrollFactor.set(0.8,0.8);
    agua.antialiasing = true;

    praia = new FunkinSprite(-600, -130,Paths.image(path + "praia"));
    praia.antialiasing = true;

    insert(0, praia);
    insert(0, agua);
	insert(0, ceu);

    bg2 = new FunkinSprite(-970, -870,Paths.image(path + "parte2"));
	bg2.scale.set(0.8,0.8);
    bg2.antialiasing = true;

	radio = new FunkinSprite(-900, -700,Paths.image(path + "radio"));
	radio.scale.set(0.4,0.4);
    radio.antialiasing = true;
}

function stepHit(curStep) {
    switch(curStep) {
        case 1:
            FlxTween.tween(camGame, {alpha: 1}, 10, {ease: FlxEase.smootherStepin});
        case 111:
            camHUD.alpha = 1;
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
            camHUD.flash(FlxColor.BLACK, 20);
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
    for(bgElements in [praia, agua, ceu]) remove(bgElements);

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
import flixel.addons.display.FlxBackdrop;
import openfl.display.BlendMode;

var colorShader = new CustomShader("adjustColor");

function create() {
    defaultCamZoom = 0.8;
}
function postCreate() {
    camGame.alpha = camHUD.alpha = 0;

    colorShader.hue = 40;
    camGame.addShader(colorShader);

    bg = new FlxSprite(-600, -260).loadGraphic(Paths.image("stages/back"));
    bg.antialiasing = true;

    maconha = new FlxBackdrop(Paths.image("stages/tibba-maconha"),1,1,false,false);
    maconha.scale.set(7, 7);
    maconha.velocity.set(-30, 0);
    maconha.y += 200;
    maconha.antialiasing = true;
    maconha.blend = BlendMode.OVERLAY;

    add(maconha);
    insert(0, bg);
}

var e:Float = 0;
function update(elapsed:Float) {
	e += 10 * elapsed;
    camGame.angle = ((1 - Math.sin((Math.PI * e) / 30)) * 2) - 2;
    camHUD.angle = ((1 - Math.sin((Math.PI * e) / 30)) * 2) - 2;
}

function onSongStart() {
    for (i in [camHUD, camGame]) {
        FlxTween.tween(i, {alpha: 1}, 10, {ease: FlxEase.backinOut});
    }
}
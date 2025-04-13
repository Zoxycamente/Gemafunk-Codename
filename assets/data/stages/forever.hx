var path:String = "stages/4ever/";
var everchange:Bool = false;

var zoomTween:FlxTween;
var colorShader = new CustomShader("adjustColor");

function create() {
	defaultCamZoom = 0.7;
}
function postCreate() {
    colorShader.hue = 10;
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

    dad.onDraw = (spr:Character) -> {
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

function stepHit(curStep) {
    switch(curStep) {
        case 1193:
            zoomTween = FlxTween.tween(camGame, {zoom: 1.2}, 6, {ease: FlxEase.backinOut});
        case 1249:
            colorShader.hue = -30;
	        colorShader.saturation = 20;
	        colorShader.brightness = -30;
            zoomTween.cancel();
            for (i in [dad, boyfriend]) i.y -= 200;
            boyfriend.x += 300;
            camGame.flash(FlxColor.BLACK, 40);
            add(radio);
            insert(0, bg2);
            remove(bg1);
    }
}
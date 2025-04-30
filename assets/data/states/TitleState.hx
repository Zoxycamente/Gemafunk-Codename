import flixel.addons.display.FlxBackdrop;
import flixel.text.FlxTextBorderStyle;

var pressedEnterBool:Bool = false;

function create() {
    logo = new FunkinSprite(340, 100, Paths.image('menus/titlescreen/fita da o botao dele pra homens peludos'));
    logo.addAnim('bop', 'bop', 24, false);
    logo.scale.set(0.8, 0.8);

    enter = new FlxText(340, 125, 0, "Pressione Enter");
    enter.setFormat(Paths.font("Comic Sans MS.ttf"), 60, FlxColor.CYAN, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    enter.borderSize = 5;
    enter.antialiasing = true;

    bg = new FlxBackdrop(Paths.image('menus/mainmenu/fundo'));
    bg.velocity.set(-50, 50);
    bg.antialiasing = true;
    bg.scale.set(0.5,0.5);

    black = new FlxSprite(-110,-100).makeSolid(1500, 200, FlxColor.BLACK);
    black2 = new FlxSprite(-110,600).makeSolid(1500, 200, FlxColor.BLACK);

    insert(3, enter);
    insert(2, black);
    insert(2, black2);
    insert(1, logo);
    insert(1, bg); 
}

function postCreate() {
    titleText.visible = false;
    enter.x = titleText.x+300;
    enter.y = titleText.y+30;
/*
    titleText.y += 30;
    insert(10, titleText);*/
}

var e:Float = 0;
function update(elapsed:Float) {
    if (FlxG.keys.justPressed.ENTER) {
        pressedEnterBool = true;
        FlxTween.tween(black, {y: black.y-100}, 1.3, {ease: FlxEase.backIn});
        FlxTween.tween(black2, {y: black2.y+180}, 1.3, {ease: FlxEase.backIn});
        FlxTween.tween(logo, {y: logo.y+800}, 2, {ease: FlxEase.backIn});
        FlxTween.tween(bg, {alpha: 0}, 2, {ease: FlxEase.sineInOut});
        FlxTween.tween(enter, {y: enter.y+200}, 2, {ease: FlxEase.smoothStepOut});
    }
	e += 10 * elapsed;
    logo.angle = ((1 - Math.sin((Math.PI * e) / 9)) * 2) - 2;
}

function beatHit() {
    logo.playAnim('bop');
}

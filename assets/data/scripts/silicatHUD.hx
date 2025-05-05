import flixel.util.FlxAxes;

var base, bb, key, mic, heart, note:FunkinSprite;
var missTxt, scoreText, ratingText, comboTxt:FlxText;

function create()
{
    var dir = "game/silicat/";

    var blackBox = new FlxSprite().makeGraphic(300, 720, 0xFF000000);
    add(blackBox);

    blackBox.camera = camHUD;

    base = new FunkinSprite(15, -20, Paths.image(dir + "base"));
    bb = new FunkinSprite(35, 580, Paths.image(dir + "caixadesom"));
    key = new FunkinSprite(250, 580, Paths.image(dir + "chave"));
    mic = new FunkinSprite(110, 400, Paths.image(dir + "mic"));
    note = new FunkinSprite(150, 580, Paths.image(dir + "nota"));

    scoreText = new FlxText(0, 135, 0, "0", 30);
    scoreText.setFormat(Paths.font("yoster.ttf"), 50, 0xFF000000);
    scoreText.antialiasing = false;
    scoreText.camera = camHUD;

    missTxt = new FlxText(0, 650, 0, "0");
    ratingText = new FlxText(0, 650, 0, "0");
    comboTxt = new FlxText(0, 650, 0, "0");

    for (i in 0...5)
    {
        var heart = new FunkinSprite(45 * (i + 1) + 7, 225, Paths.image(dir + "coracao"));
        heartGrp.push(heart);
    }

    for (items in [base, bb, key, mic, note])
    {
        items.antialiasing = false;
        items.pixelPerfectPosition = true;
        items.camera = camHUD;

        items.scale.set(1.63, 1.63);
        items.updateHitbox();

        add(items);

        items.y -= 10;
    }

    var rap = new FlxText(130, 30, 0, "RAP", 30);
    rap.setFormat(Paths.font("yoster.ttf"), 40, 0xFF000000);
    rap.camera = camHUD;
    add(rap);

    for (text in [missTxt, ratingText, comboTxt])
    {
        text.setFormat(Paths.font("yoster.ttf"), 30, 0xFF000000);
        text.antialiasing = false;
        text.camera = camHUD;

        add(text);
    }

    add(scoreText);

    for (heart in heartGrp)
    {
        heart.antialiasing = false;
        heart.pixelPerfectPosition = true;
        heart.camera = camHUD;

        heart.scale.set(1.65, 1.65);
        heart.updateHitbox();

        add(heart);
    }
}

function postCreate()
{
    for (removeList in [healthBar, healthBarBG, scoreTxt, accuracyTxt, iconP1, iconP2, missesTxt])
        remove(removeList);
}

var heartGrp:Array<FunkinSprite> = [];

function update(e)
{
    var helt = Std.int(PlayState.instance.health * 2.5);

    for (hearts in heartGrp)
        hearts.visible = false;

    for (i in 0...helt)
    {
        heartGrp[i].visible = true;
    }

    scoreText.text = PlayState.instance.songScore;
    scoreText.screenCenter(FlxAxes.X);
    scoreText.x -= 470;

    missTxt.text = PlayState.instance.misses;
    missTxt.screenCenter(FlxAxes.X);
    missTxt.x -= 370;

    comboTxt.text = PlayState.instance.combo;
    comboTxt.screenCenter(FlxAxes.X);
    comboTxt.x -= 470;

    var acc = Std.int(CoolUtil.quantize(PlayState.instance.accuracy * 100, 100));
    if (acc < 0) acc *= -1;

    ratingText.text = acc;
    ratingText.screenCenter(FlxAxes.X);
    ratingText.x -= 570;
}
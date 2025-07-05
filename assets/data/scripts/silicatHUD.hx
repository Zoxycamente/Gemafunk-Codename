import flixel.util.FlxAxes; //essa hud ta amaldiçoada puta que me pariu

var catHUD:FlxCamera = new FlxCamera();
var base, bb, key, mic, heart, note:FunkinSprite;
var missTxt, scoreText, ratingText, comboTxt:FlxText;
var heartGrp:Array<FunkinSprite> = [];

function create()
{
    FlxG.cameras.add(catHUD, false);
    catHUD.bgColor = FlxColor.TRANSPARENT;

    var dir = "game/silicat/";

    var blackBox = new FlxSprite().makeGraphic(300, 720, 0xFF000000);
    add(blackBox);

    blackBox.camera = [catHUD];

    base = new FunkinSprite(15, -20, Paths.image(dir + "base"));
    bb = new FunkinSprite(35, 580, Paths.image(dir + "caixadesom"));
    key = new FunkinSprite(250, 580, Paths.image(dir + "chave"));
    mic = new FunkinSprite(110, 400, Paths.image(dir + "mic"));
    note = new FunkinSprite(150, 580, Paths.image(dir + "nota"));

    scoreText = new FlxText(0, 135, 0, "0", 30);
    scoreText.setFormat(Paths.font("yoster.ttf"), 50, 0xFF000000);
    scoreText.antialiasing = false;
    scoreText.camera = [catHUD];

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
        items.camera = [catHUD];

        items.scale.set(1.63, 1.63);
        items.updateHitbox();

        add(items);

        items.y -= 10;
    }

    var rap = new FlxText(130, 30, 0, "RAP", 30);
    rap.setFormat(Paths.font("yoster.ttf"), 40, 0xFF000000);
    rap.camera = [catHUD];
    add(rap);

    for (text in [missTxt, ratingText, comboTxt])
    {
        text.setFormat(Paths.font("yoster.ttf"), 30, 0xFF000000);
        text.antialiasing = false;
        text.camera = [catHUD];

        add(text);
    }

    add(scoreText);

    for (heart in heartGrp)
    {
        heart.antialiasing = false;
        heart.pixelPerfectPosition = true;
        heart.camera = [catHUD];

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


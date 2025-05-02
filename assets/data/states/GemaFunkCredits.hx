var json;
var curChar = 0;

function create()
{
    json = CoolUtil.parseJson(Paths.json("credits"));

    var dir = "menus/credits/";

    FlxG.sound.play(Paths.sound("windows7"), 0.4);

    if (FlxG.sound.music != null) FlxG.sound.music.stop();
    FlxG.sound.playMusic(Paths.music("Credits"), 0, true);

    FlxG.sound.music.fadeIn(3.2, 0, 0.8);

    var bg = new FunkinSprite(0, 0, Paths.image(dir + "background"));
    bg.scale.set(2.1, 2.1);
    bg.updateHitbox();
    bg.screenCenter();
    add(bg);

    bg.antialiasing = false;

    createChar(0);
}

function update()
{
    if (controls.LEFT_P) updateCurChar(-1);
    if (controls.RIGHT_P) updateCurChar(1);
}

function updateCurChar(int)
{
    curChar += int;

    if (curChar < 0) curChar = json.people.length - 1;
    if (curChar >= json.people.length) curChar = 0;

    createChar(curChar);
}

var char:FunkinSprite;
var text:FunkinText;
var desc:FunkinText;

function createChar(uau)
{
    var dir = "menus/credits/people/";

    if (char != null) char.destroy();

    char = new FunkinSprite(0, 0, Paths.image(dir + json.people[uau].image));
    char.scale.set(json.people[uau].scale - 0.2, json.people[uau].scale - 0.2);
    char.screenCenter();
    char.y -= 45;
    add(char);

    if (text != null) text.destroy();

    text = new FunkinText(0, 0, 0, json.people[uau].name, 50);
    text.borderSize = 3.2;
    text.font = Paths.font("arial.ttf");
    add(text);

    text.text = json.people[uau].name;
    text.screenCenter();
    text.y += 185;

    if (desc != null) desc.destroy();

    desc = new FunkinText(0, 0, 0, json.people[uau].desc, 20);
    desc.borderSize = 2.5;
    desc.font = Paths.font("arial.ttf");
    add(desc);

    desc.text = json.people[uau].function;
    desc.screenCenter();
    desc.y += 250;
}
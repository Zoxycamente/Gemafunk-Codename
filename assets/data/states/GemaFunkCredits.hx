var json;
var curChar = 0;

var camMouse:FlxCamera = new FlxCamera();
var mouse:FunkinSprite;

function create()
{
    json = CoolUtil.parseJson(Paths.json("credits"));
    FlxG.cameras.add(camMouse, false);
    camMouse.bgColor = 0x0;

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
    gay = FlxG.random.int(0, json.people.length - 1);
    
    createChar(0);

    add(setalado = new FunkinSprite(930,250, Paths.image(dir + "setalinda")));
    add(setaoutrolado = new FunkinSprite(100,250, Paths.image(dir + "setalinda"))).flipX = true;
    for (setas in [setalado, setaoutrolado])
        {
            setas.scale.set(0.6, 0.6);
        }
    
    add(esc = new FunkinSprite(-30,10, Paths.image(dir + "esc"))).scale.set(0.3, 0.3);

    mouse = new FunkinSprite(0, 0);
    mouse.frames = Paths.getSparrowAtlas("menus/freeplay/Mouse");
    mouse.animation.addByPrefix("idle", "Idle");
    mouse.animation.addByPrefix("click", "Click", 24, false);
    mouse.playAnim("idle");

    mouse.camera = camMouse;

    mouse.scrollFactor.set();
    add(mouse);
}

var gay:Int = false;

function update()
{
    if (controls.BACK)
        FlxG.switchState(new MainMenuState());
    
    if (controls.LEFT_P) updateCurChar(-1);
    if (controls.RIGHT_P) updateCurChar(1);

    if (mouse.getAnimName() == "click")
    {
        mouse.x = FlxG.mouse.screenX - 10;
        mouse.y = FlxG.mouse.screenY - 8;
    }
    else 
    {
        mouse.x = FlxG.mouse.screenX;
        mouse.y = FlxG.mouse.screenY;
    }
    
    if (FlxG.mouse.justPressed)     mouse.playAnim("click", true);

    for (x in 0...socials.length)
    {
        if (socials[x] != null)
        {
            if (mouse.x > socials[x].x && mouse.x < socials[x].x + socials[x].width && mouse.y > socials[x].y && mouse.y < socials[x].y + socials[x].height && FlxG.mouse.justPressed)
                CoolUtil.openURL(json.people[curChar].socials[x].destiny);
        }
    }
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
var socials:Array<FunkinSprite> = [];

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
    if (uau == gay) desc.text += " / GAY"; //essencial
    desc.screenCenter();
    desc.y += 250;

    for (i in socials) if (i != null) i.destroy();

    if (json.people[uau].socials != null)
    {
        var redes = json.people[uau].socials;

        for (i in 0...redes.length)
        {
            var rede = new FunkinSprite(85 * (i + 3), 120, Paths.image("menus/credits/" + redes[i].type));
            rede.scale.set(0.15, 0.15);
            rede.updateHitbox();
            add(rede);

            socials.push(rede);
        }
    }
    else 
    {
        trace(json.people[uau].name + " num tem redes sociaisss, que pobre!");
    }
}
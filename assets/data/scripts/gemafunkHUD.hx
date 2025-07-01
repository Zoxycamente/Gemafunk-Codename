import flixel.util.FlxAxes;
import flixel.util.FlxStringUtil;
import flixel.text.FlxText.FlxTextBorderStyle;

function create()
{
}

var song = "";
var dir = "game/gemafunk/";
var timeTxt;
var vs;

var songName;
var balao;

function postCreate()
{
    song = PlayState.SONG.meta.name.toLowerCase();

    iconP1.y -= 20;
    iconP2.y -= 20;

    vs = new FunkinSprite(0, downscroll ? healthBar.y - 30 : healthBar.y - 40, Paths.image(dir + "VS"));
    vs.scale.set(0.8, 0.8);
    vs.updateHitbox();
    vs.screenCenter(FlxAxes.X);
    vs.camera = camHUD;
    add(vs);

    balao = new FunkinSprite(0, 0, Paths.image(dir + "caixinha"));
    balao.scale.set(0.6, 0.6);
    balao.updateHitbox();

    if (downscroll) balao.flipY = true;

    balao.screenCenter(FlxAxes.X);
    balao.x -= 15;
    balao.camera = camHUD;
    add(balao);

    songName = new FunkinSprite(0, 0, Paths.image(dir + "songs/" + song));
    songName.scale.set(0.6, 0.6);
    songName.updateHitbox();

    songName.screenCenter(FlxAxes.X);
    songName.y += 30;
    songName.camera = camHUD;
    add(songName);

    timeTxt = new FunkinText(0, songName.y + songName.height - 10, 0, "2:40", 30);
    timeTxt.setFormat(Paths.font("DISCHARGE_2.ttf"), 50, PlayState.SONG.meta.name == "gemabot" ? 0xFF000000 : 0xFF251F1F, "");

    timeTxt.camera = camHUD;
    add(timeTxt);

    for (i in 0...2)
    {
        var clock = new FunkinSprite(0, downscroll ? balao.y + 90 : balao.y + balao.height - 10, Paths.image(dir + "clock"));
        
        clock.scale.set(0.6, 0.6);
        clock.updateHitbox();

        clock.screenCenter(FlxAxes.X);
        clock.x += (i == 0) ? -70 : 80;
        clock.angle = (i == 0) ? 0 : 20;
        clock.camera = camHUD;

        add(clock);
        clock.antialiasing = true;

        clocks.push(clock);

    }

    for (i in [vs, balao, songName])
        i.antialiasing = true;

    for (tex in [accuracyTxt, missesTxt])
    {
        tex.font = Paths.font("chawp.otf");
        tex.size *= 1.5;
    }

    missesTxt.x += 170;

    remove(scoreTxt);
}

var clocks = [];

function postUpdate()
{
    iconP1.x = 870;
    iconP2.x = 250;

    vs.visible = healthBar.visible;
    vs.alpha = healthBar.alpha;

    if (PlayState.SONG.meta.name == "gemabot")
        for (clock in clocks) clock.alpha = balao.alpha = timeTxt.alpha = songName.alpha = healthBar.alpha;

    var acc = Std.int(CoolUtil.quantize(PlayState.instance.accuracy * 100, 100));
    if (acc < 0) acc *= -1;

    accuracyTxt.text = "ACCURACY: " + acc;
    missesTxt.text = "MISSES: " + misses;

    var songLength = inst.length;

    var curTime:Float = Math.max(0, Conductor.songPosition);
    var songCalc:Float = (songLength - curTime);

    var secondsTotal:Int = Math.floor(songCalc / 1000);
    if(secondsTotal < 0) secondsTotal = 0;

    timeTxt.text = FlxStringUtil.formatTime(secondsTotal, false);
    timeTxt.screenCenter(FlxAxes.X);
}
var mouse:FunkinSprite;
var uiCam:FlxCamera = new FlxCamera();

var songsJson = CoolUtil.parseJson(Paths.json("freeplayVideos"));
var songs = songsJson.videos;

var ytBar:FunkinSprite;

var canSelect:Bool = true;

function create()
{
    trace("freeplay!");
    var dir = "menus/freeplay/";
    
    if (FlxG.save.data.passedSongs == null) FlxG.save.data.passedSongs = [];
    if (FlxG.save.data.unlockedSongs == null) FlxG.save.data.unlockedSongs = [];

    FlxG.camera.bgColor = 0xFF141315;
    FlxG.cameras.add(uiCam, false);
    uiCam.bgColor = 0x0;

    var barraDoMal = new FlxSprite(0, 0).makeGraphic(FlxG.width, 130, 0xFF141315);
    var barra = new FunkinSprite(26, 50, Paths.image(dir + "Barras2"));
    var yt = new FunkinSprite(barra.x + 110, barra.y - 20, Paths.image(dir + "Icon2"));
    var logo = new FunkinSprite(yt.x + yt.width, yt.y, Paths.image(dir + "Youtube"));

    for (stuff in [barraDoMal, barra, yt, logo])
    {
        stuff.scrollFactor.set();
        stuff.camera = uiCam;
        add(stuff);
    }

    generateSongs();

    ytBar = new FunkinSprite(0, 0).makeGraphic(FlxG.width, 5, 0xffe2131e);
    ytBar.scrollFactor.set();
    add(ytBar);

    ytBar.cameras = [uiCam];
    ytBar.origin.x -= 640;
    ytBar.scale.x = 0.0001;

    mouse = new FunkinSprite(0, 0);
    mouse.frames = Paths.getSparrowAtlas(dir + "Mouse");
    mouse.animation.addByPrefix("idle", "Idle");
    mouse.animation.addByPrefix("click", "Click", 24, false);
    mouse.playAnim("idle");

    mouse.scrollFactor.set();
    add(mouse);

    if (FlxG.sound.music == null) CoolUtil.playMenuSong();
}

function generateSongs()
{
    for (i in 0...songs.length)
    {
        var thumb = new FunkinSprite(50 * (i * 8), 100);
        thumb.frames = Paths.getSparrowAtlas("menus/freeplay/Thumbs");
        thumb.animation.addByPrefix("thumb", "Capa" + songs[i].capa + " sem Layer");
        thumb.animation.addByPrefix("bloqueado", "Capa" + songs[i].capa + "0");
        thumb.animation.play("thumb");

        thumb.scale.set(0.7, 0.7);

        if(thumbs[thumbs.length - 1] != null)
            thumb.x = thumbs[thumbs.length - 1].x + thumbs[thumbs.length - 1].width + -110;
        else
            thumb.x = 50 * (i * 8);

        thumb.x -= 35;

        thumbs.push(thumb);

        if (thumbs[thumbs.length - 1].x > 1100)
        {
            thumb.x = thumbs[0].x;
            thumb.y += 350;
        }

        add(thumb);

        var title = new FunkinText(thumb.x + 170, thumb.y + 285, 280, songs[i].title, 20);
        title.font = Paths.font("arial.ttf");
        add(title);

        var icone = new FunkinSprite(thumb.x + 60, thumb.y + 250, Paths.image("menus/freeplay/Canal"));
        icone.scale.set(0.5, 0.5);
        add(icone);

        var nome = new FunkinText(title.x, title.y + 50, 0, "Gemaplay Gemafunk", 16);
        nome.font = Paths.font("arial.ttf");
        add(nome);

        var info = new FunkinText(nome.x, nome.y + 20, 0, songs[i].views + " mil visualizações - há " + songs[i].time[0] + " " + songs[i].time[1] +  " atrás", 12);
        add(info);

        var playUnlockingAnim:Bool = false;

        var songz = FlxG.save.data.passedSongs;
        var sogs = FlxG.save.data.unlockedSongs;
        trace(songz);

        var songToUnlock = "";

        var unlocked = (songs[i].name == "Gemaplay" || sogs.contains(songs[i].name.toLowerCase()));

        if (songz.contains("gemaplay") && !sogs.contains("4ever")) songToUnlock = "4ever";
        else if (songz.contains("4ever") && !sogs.contains("silicat")) songToUnlock = "silicat";
        else if (songz.contains("silicat") && !sogs.contains("tibba")) songToUnlock = "tibba";
        else songToUnlock = "nada";

        trace(songToUnlock);
        if (!sogs.contains(songToUnlock) && songToUnlock != "nada") sogs.push(songToUnlock);
        FlxG.save.data.unlockedSongs = sogs;

        trace("is " + songs[i].name + " unlocked? " + unlocked);

        trace(sogs);

        if (!unlocked)
        {
            var lock = new FunkinSprite(thumb.x + thumb.width / 2 - 70, thumb.y + thumb.height / 2 - 100);
            lock.frames = Paths.getSparrowAtlas("menus/freeplay/Padlock");
            lock.animation.addByPrefix("lock", "Cadiado Parado", 24, true);
            lock.animation.addByPrefix("lockin", "Cadiado Trancado", 24, false);
            lock.animation.addByPrefix("unlock", "Cadiado Destrancado", 24, false);
            lock.animation.play("lockin");

            lock.scale.set(thumb.scale.x, thumb.scale.y);

            new FlxTimer().start(0.5, () -> lock.animation.play("lock", true));

            add(lock);
            locks.push(lock);

            thumb.animation.play("bloqueado", true);

            if (songs[i].name == songToUnlock)
            {
                for (i in 0...locks.length)
                {
                    lock.playAnim("unlock", true);

                    new FlxTimer().start(1, function(t:FlxTimer) {
                        FlxTween.tween(lock, {alpha: 0}, 1, {ease: FlxEase.quintOut, onComplete: function() {
                            lock.destroy();
                            thumb.animation.play("thumb", true);
                            thumb.scale.set(0.7, 0.7);
                        }});
                    });
                }
            }
        }
    }

    FlxG.camera.maxScrollY = thumbs[thumbs.length - 1].y + thumbs[thumbs.length - 1].height + 50;
}

var thumbs = [];
var locks = [];

function update(e)
{
    if(canSelect)
    {
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

        if (FlxG.mouse.justPressed)
        {
            mouse.playAnim("click", true);
            
            for (i in 0...thumbs.length)
            {
                if (mouse.x > thumbs[i].x && mouse.x < thumbs[i].x + thumbs[i].width && mouse.y > thumbs[i].y && mouse.y < thumbs[i].y + thumbs[i].height)
                {
                    if (thumbs[i].getAnimName() == "bloqueado")
                    {
                        CoolUtil.playMenuSFX(2, 0.8);
                        locks[i].playAnim("lockin", true);

                        new FlxTimer().start(0.5, () -> lock.animation.play("lock", true));
                    }
                    else
                    {
                        thumbs[i].scale.set(0.68, 0.68);
                        canSelect = false;
    
                        new FlxTimer().start(0.1, function(t:FlxTimer) {
                            thumbs[i].scale.set(0.7, 0.7);
                            trace(songs[i].name.toLowerCase());
                                
                            PlayState.loadSong(songs[i].name.toLowerCase(), "hard", false, false);
        
                            FlxTween.tween(ytBar, {"scale.x": 1}, 0.7, {ease: FlxEase.quintOut, onComplete: function() {
                                FlxG.sound.music.stop();
                                FlxG.switchState(new PlayState());
                            }});
                        });
                    }
                }
            }
        }

        if (controls.BACK)
            FlxG.switchState(new MainMenuState());
    
        FlxG.camera.scroll.y += FlxG.mouse.wheel == -1 ? 20 : (FlxG.mouse.wheel == 1 && FlxG.camera.scroll.y > 0) ? -20 : 0;
    }

    FlxG.mouse.visible = false;
}
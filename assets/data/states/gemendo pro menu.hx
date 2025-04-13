import openfl.display.BlendMode;
import funkin.menus.MainMenuState;
import funkin.backend.scripting.events.MenuChangeEvent;
import funkin.backend.scripting.events.NameEvent;
import funkin.backend.scripting.EventManager;
import funkin.menus.credits.CreditsMain;
import funkin.options.OptionsMenu;
import funkin.editors.EditorPicker;
import funkin.menus.ModSwitchMenu;
import flixel.math.FlxPoint;
import flixel.effects.FlxFlicker;
import flixel.addons.display.FlxBackdrop;
import funkin.backend.utils.CoolUtil;
import openfl.text.TextFormat;
import flixel.text.FlxTextBorderStyle;
import flixel.input.keyboard.FlxKey;
import funkin.backend.utils.WindowUtils;

var optionShit:Array<String> = ["storymode", "tracks", "credits"];
var sndOptions:Array<String> = ["options", "gallery"];

var menuItems:FlxTypedGroup<FlxSprite>;
var minimenuitens:FlxTypedGroup<FlxSprite>;
var curSelected:Int = 0;
var selectedSomethin:Bool = false;
public var canAccessDebugMenus:Bool = true;

FlxG.mouseControls = true;
FlxG.mouse.enabled = true;
FlxG.mouse.visible = true;

function create() {
   // FlxG.camera.zoom = 0.3;
    bg = new FlxBackdrop(Paths.image('menus/mainmenu/fundo'));
    bg.velocity.set(-50, 50);
    bg.antialiasing = true;
    bg.scale.set(0.5,0.5);
    add(bg);

    gradiente = new FlxSprite(-360,-400).loadGraphic(Paths.image('menus/mainmenu/gradiente'));
    gradiente.antialiasing = true;
    gradiente.scale.set(0.5,0.5);
    gradiente.blend = BlendMode.OVERLAY;
	gradiente.scrollFactor.set(3, 3);
    add(gradiente);

    vito = new FlxSprite(600, 29);
    vito.frames = Paths.getSparrowAtlas('menus/mainmenu/vitomenu');
    vito.animation.addByPrefix('idle', 'vito menu', 24, true);
    vito.animation.play('idle'); 
    vito.scrollFactor.set(2, 2);

    add(vito);

    preto = new FlxSprite(-450,-400).loadGraphic(Paths.image('menus/mainmenu/preto'));
    preto.antialiasing = true;
    preto.scale.set(0.7,0.6);
    add(preto);
    
    menuItems = new FlxTypedGroup();
    add(menuItems);
    for (i in 0...optionShit.length) {
        var menuItem = new FlxSprite(30, -100 + (i * 150));
        menuItem.frames = Paths.getFrames('menus/mainmenu/menushit');
        menuItem.animation.addByPrefix("idle", optionShit[i], 24, false);
        menuItem.animation.play("idle");
        menuItem.ID = i;
        menuItem.scale.set(0.35,0.35);

        menuItems.add(menuItem);
        menuItem.antialiasing = true;
        menuItem.updateHitbox();
    }

    changeItem();

    minimenuitens = new FlxTypedGroup();
    add(minimenuitens);
    for (i in 0...sndOptions.length) {
        var scndMenu = new FlxSprite(-480  + (i * 201) ,-20);
        scndMenu.frames = Paths.getFrames('menus/mainmenu/othershit');
        scndMenu.animation.addByPrefix("idle", sndOptions[i], 24, false);
        scndMenu.animation.play("idle");
        scndMenu.ID = i;
        scndMenu.scale.set(0.15, 0.15);

        minimenuitens.add(scndMenu);
    }

}


function update(elapsed:Float) {
    if (controls.BACK) FlxG.switchState(new TitleState());

    FlxG.camera.scroll.x = FlxMath.lerp(FlxG.camera.scroll.x, (FlxG.mouse.screenX-(FlxG.width/2)) * 0.028, (1/30)*240*elapsed);
	FlxG.camera.scroll.y = FlxMath.lerp(FlxG.camera.scroll.y, (FlxG.mouse.screenY-6-(FlxG.height/2)) * 0.028, (1/30)*240*elapsed);

    if (FlxG.sound.music.volume < 0.8) FlxG.sound.music.volume += 0.5 * elapsed;

    if (!selectedSomethin) {
        if (canAccessDebugMenus) {
            if (FlxG.keys.justPressed.SEVEN) {
                persistentUpdate = false;
                persistentDraw = true; 
                openSubState(new EditorPicker());
            }
        }
        if (controls.SWITCHMOD) {
            openSubState(new ModSwitchMenu());
            persistentUpdate = false;
            persistentDraw = true;
        }
    }

	if (!selectedSomethin) {
        changeItem((controls.UP_P ? -1 : 0) + (controls.DOWN_P ? 1 : 0) - FlxG.mouse.wheel);
        if (FlxG.mouse.justPressed || controls.ACCEPT) selectItem();
		for (i in menuItems.members) {
			if (FlxG.mouse.overlaps(i)) {
				curSelected = menuItems.members.indexOf(i);
				changeItem();
			}
		}
    }
}

function selectItem() {
    selectedSomethin = true;

	FlxG.sound.play(Paths.sound('menu/confirm'));
    FlxTween.tween(FlxG.camera, {zoom: 1.1}, 2, {ease: FlxEase.expoOut});
    FlxG.camera.flash(FlxColor.WHITE, 1);

    new FlxTimer().start(1, () -> {
        var daChoice:String = optionShit[curSelected];

        var event = event("onSelectItem", EventManager.get(NameEvent).recycle(daChoice));
        if (event.cancelled) return;
        switch (daChoice)   {
           case 'storymode': FlxG.switchState(new StoryMenuState());
           case 'tracks': FlxG.switchState(new FreeplayState());
           case 'credits': FlxG.switchState(new CreditsMain());
    }});
}

public function changeItem(huh:Int = 0) {
    var event = event("onChangeItem", EventManager.get(MenuChangeEvent).recycle(curSelected, FlxMath.wrap(curSelected + huh, 0, menuItems.length-1), huh, huh != 0));
    if (event.cancelled) return;

    curSelected = event.value;

    menuItems.forEach(function(spr:FlxSprite) { spr.color = FlxColor.WHITE;
        
        if (spr.ID == curSelected) { 
            if (menuItems.members[0]) spr.color = FlxColor.RED; 
            if (menuItems.members[1]) spr.color = FlxColor.GREEN;
        }
    
        spr.updateHitbox();
        spr.centerOffsets();
        });

}
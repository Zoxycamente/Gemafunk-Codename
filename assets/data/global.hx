//
import funkin.backend.utils.WindowUtils;
import openfl.text.TextFormat;
import funkin.backend.system.framerate.Framerate;
import funkin.backend.system.framerate.FramerateCounter;
import funkin.backend.system.framerate.CodenameBuildField;

public static var windowName:String = 'GemaFunk';

public static var defaultX:Int;
public static var defaultY:Int;

WindowUtils.winTitle = windowName;

function postGameStart()
{
    FlxG.switchState(new TitleState());

    defaultX = window.x;
    defaultY = window.y;
}

function postStateSwitch()
{
    if(!Std.isOfType(FlxG.state, PlayState))
        WindowUtils.winTitle = windowName;

}

function update(elapsed:Float) if (FlxG.keys.justPressed.F5) FlxG.resetState();

var redirectStates:Map<FlxState, String> = 
[
    MainMenuState    => "gemendo pro menu",
    FreeplayState    => "GemaFunkFreeplay",
];

static function updateFNFcounter(toggle:Bool) 
{
    var daFont = toggle ? Paths.getFontName(Paths.font("Comic Sans MS.ttf")) : Paths.getFontName(Paths.font("vcr.ttf"));
    var format = new TextFormat(daFont, 13, -1);

   Framerate.fpsCounter.fpsLabel.defaultTextFormat = format;
   Framerate.fpsCounter.fpsNum.defaultTextFormat = new TextFormat(daFont, 18, -1);
   Framerate.memoryCounter.memoryText.defaultTextFormat = format;
   Framerate.memoryCounter.memoryPeakText.defaultTextFormat = format;
   Framerate.codenameBuildField.defaultTextFormat = format;
}

function update()
{
    if (FlxG.keys.justPressed.F5) FlxG.resetState();
}

function preStateSwitch() 
{
    updateFNFcounter(true);
    WindowUtils.winTitle = windowName;
    Framerate.codenameBuildField.text = windowName;

    for (redirectState in redirectStates.keys()) 
        if (Std.isOfType(FlxG.game._requestedState, redirectState)) 
            FlxG.game._requestedState = new ModState(redirectStates.get(redirectState));
}
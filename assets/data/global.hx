//
function update(elapsed:Float)
	if (FlxG.keys.justPressed.F5) FlxG.resetState();


var redirectStates:Map<FlxState, String> = [
    MainMenuState    => "gemendo pro menu",
];


function preStateSwitch() {
    for (redirectState in redirectStates.keys()) 
        if (Std.isOfType(FlxG.game._requestedState, redirectState)) 
            FlxG.game._requestedState = new ModState(redirectStates.get(redirectState));
}
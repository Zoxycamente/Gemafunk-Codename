
var depressao:FlxCamera = new FlxCamera();
function create()
{
    FlxG.cameras.add(depressao, false);
    depressao.bgColor = FlxColor.TRANSPARENT;
    luto = new FunkinSprite(0,0, Paths.image('eutenhodepressao'));
    add(luto);
    luto.cameras = [depressao];
}

function update() 
{
    if (controls.ACCEPT) FlxG.switchState(new PlayState());
}
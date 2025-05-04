
var depressao:FlxCamera = new FlxCamera();
function create()
{
    FlxG.cameras.add(depressao, false);
    depressao.bgColor = FlxColor.TRANSPARENT;
    luto = new FunkinSprite(0,0, Paths.image('eutenhodepressao'));
    add(luto);
    luto.cameras = [depressao];
    luto.alpha = 0;
    FlxTween.tween(luto, {alpha: 1}, 1, {ease: FlxEase.quadOut});

}

function update() 
{
    if (controls.ACCEPT || controls.BACK) FlxG.switchState(new FreeplayState());
}
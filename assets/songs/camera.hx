//
import flixel.FlxObject;

public var cameraMovementStrength = 3;
public var smoothCamFollow:FlxObject = new FlxObject(0, 0, 2, 2);


function postCreate(){
    add(smoothCamFollow);
    if (SONG.meta.name != "ghosttap" || "silicat") FlxG.camera.target = smoothCamFollow;
}

function postUpdate(){
    for (i in strumLines.members[curCameraTarget].characters) {
        smoothCamFollow.x += i.getAnimName() == "singRIGHT" || i.getAnimName() == "singRIGHT-alt" ? cameraMovementStrength : i.getAnimName() == "singLEFT" || i.getAnimName() == "singLEFT-alt" ? -cameraMovementStrength : 0;
        smoothCamFollow.y += i.getAnimName() == "singDOWN" || i.getAnimName() == "singDOWN-alt" ? cameraMovementStrength : i.getAnimName() == "singUP" || i.getAnimName() == "singUP-alt" ? -cameraMovementStrength : 0;
    }
}

function update(elapsed:Float) {
    smoothCamFollow.x = lerp(smoothCamFollow.x, camFollow.x, 0.1 + (2 * Math.pow(FlxMath.bound((smoothCamFollow.x - camFollow.x) / FlxG.width, 0, 1), 1)));
    smoothCamFollow.y = lerp(smoothCamFollow.y, camFollow.y, 0.1 + (2 * Math.pow(FlxMath.bound((smoothCamFollow.y - camFollow.y) / FlxG.height, 0, 1), 1)));
}
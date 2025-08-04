import flixel.util.FlxAxes;

function postUpdate() {
    for (p in 0...menuItems.length) {
        grpMenuShit.members[p].screenCenter(FlxAxes.X);
    }
}
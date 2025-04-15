var e:Float = 0;
function update(elapsed:Float) {
	e += 10 * elapsed;
    camGame.angle = ((1 - Math.sin((Math.PI * e) / 30)) * 2) - 2;
    camHUD.angle = ((1 - Math.sin((Math.PI * e) / 30)) * 2) - 2;
}

function postCreate() {
    camHUD.antialiasing = true;
}
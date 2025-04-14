function create() {
	defaultCamZoom = 0.7;
}
function postCreate() {
    bg = new FlxSprite(-600, -260).loadGraphic(Paths.image("stages/back"));
    bg.antialiasing = true;

    insert(0, bg);
}
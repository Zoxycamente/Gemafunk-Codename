var path:String = "stages/quartoGema/";
function create() {
	defaultCamZoom = 0.8;
}
function postCreate() {
    bg = new FlxSprite(-600, -260).loadGraphic(Paths.image(path + "back"));
    bg.antialiasing = true;
    insert(0, bg);

	var fg = new FlxSprite(-400, -350).loadGraphic(Paths.image(path + "fore"));
	fg.scrollFactor.set(0.8,0.8);
    add(fg);
}

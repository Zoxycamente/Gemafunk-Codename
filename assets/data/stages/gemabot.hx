
function create() {
    defaultCamZoom = 0.5;
}
function postCreate() {
    bg = new FunkinSprite(-300, -150, Paths.image("stages/gemabot/bg"));
    bg.addAnim("idle", "calcinhamijada", 24, true);
    bg.playAnim("idle");
    bg.scale.set(1.7, 1.9);
    bg.antialiasing = true;

    insert(0, bg);

    boyfriend.y += 30;
    dad.x -= 600;
    dad.y -= 300;
}

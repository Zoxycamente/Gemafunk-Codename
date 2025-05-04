var chatHud = new FlxCamera();

function create() 
{
    importScript("data/scripts/pixel");

    FlxG.cameras.add(chatHud, false).bgColor = FlxColor.TRANSPARENT;

	defaultCamZoom = 0.8;
}

function postCreate() 
{

    trace(boyfriend.x, boyfriend.y, dad.x, dad.y);
    camGame.alpha = 0;

    dad.alpha = iconP2.alpha = 0;
    boyfriend.y -= 240;
    dad.y = boyfriend.y-100;
    dad.x = 500;
    boyfriend.x = -500;

    dad.flipX = false;
    bg = new FlxSprite(-600, -260).loadGraphic(Paths.image("stages/ghosttap"));
    insert(0, bg);

    us = new FlxSprite(boyfriend.x+100, boyfriend.y+600).loadGraphic(Paths.image("stages/1025_Sem_Titulo_20241217133850"));
    
    
    chat = new FunkinSprite(400, 320, Paths.image("stages/chat"));
    chat.addAnim("chat", "chat", 24, true);
    chat.playAnim("chat");
    chat.cameras = [chatHud];
    chat.antialiasing = true;
    chat.scale.set(0.3, 0.3);
    add(chat);

    imagem = new FunkinSprite(0,200, Paths.image("stages/feiodocaralho"));
    imagem.antialiasing = true;
    imagem.scale.set(2, 2);

}

function beatHit(curBeat) 
{
    switch(curBeat) 
    {
        case 4:
            camGame.alpha = 1;
        case 68:
            camGame.alpha = camHUD.alpha = 0;
        case 69:
            dad.alpha = iconP2.alpha = 1;
            health = 1;
        case 74:
            defaultCamZoom = 0.9;
            camGame.alpha = camHUD.alpha = 0.2;
        case 75:
            defaultCamZoom = 0.8;
            camGame.alpha = camHUD.alpha = 0.4;
        case 76:
            defaultCamZoom = 0.7;
            camGame.alpha = camHUD.alpha = 0.6;
        case 77:
            dad.playAnim('wave');
            defaultCamZoom = 0.6;
            camGame.alpha = camHUD.alpha = 0.8;
        case 78:
            camGame.alpha = camHUD.alpha = 1;
        case 176:
            add(us);
            boyfriend.playAnim('medonho');
        case 177:
            remove(us);
        case 202:
            FlxTween.tween(dad.scale, {y: 6}, 6, {ease: FlxEase.backinOut});
        case 284:
            for (elements in [dad, boyfriend, bg, chat]) 
                {
                    remove(elements);
                }
            camHUD.alpha = 0;
            add(imagem);
        case 288:
            camGame.flash(FlxColor.BLACK, 50);
            remove(imagem);
    }
}

function update()
{
    chatHud.alpha = camGame.alpha;
}
var data = CoolUtil.parseJson(Paths.json("twitchChat"));

function postCreate()
{
    FlxG.camera.x -= 400;
    trace(FlxG.camera.x);

    FlxG.cameras.add(camChat, false);
    camChat.bgColor = 0x0;

    var square = new FlxSprite().makeGraphic(400, 720, 0xFF4b4a61);
    square.scrollFactor.set();
    square.camera = camChat;
    add(square);

    sprite = new FlxSprite(0, 700).makeGraphic(400, 10000, 0xFFFFFFFF);
    sprite.scrollFactor.set();
    sprite.camera = camChat;
    sprite.alpha = 0.001;
    add(sprite);

    camChat.x = 890;

    healthBar.flipX = true;
    playerStrums.cpu = true;
}

var sprite;

var lastMessage:Int = 0;
var messageInterval:Int = 2;

function beatHit(b)
{
    if (b == lastMessage + messageInterval)
    {
        trace("new message!");
        lastMessage = b;
        messageInterval = FlxG.random.int(4, 10);

        curMs = FlxG.random.int(0, data.messages.length-1, [lastCurMs]);

        var mes = data.messages[curMs];
        var lastMes = data.messages[lastCurMs];

        var name = new FunkinText(10, 20, 0, mes.sentBy);
        var color = mes.color;
        name.setFormat(Paths.font("Comic Sans MS.ttf"), 30, FlxColor.fromString("#" + color.toUpperCase()));
        name.camera = camChat;
        add(name);

        var lastTxt = "";
        var text:Array<String> = [];
        
        if (lastMes != null)
        {
            lastTxt = lastMes.text;
            text = lastTxt.split("");
        }

        if (messagesGroup[messagesGroup.length-1] != null)
        {
            name.y = messagesGroup[messagesGroup.length-1].y + (Std.parseFloat(lastMes.yOffset) * 1.25);
        }

        messagesGroup.push(name);

        lastCurMs = curMs;
        var curName = mes.sentBy;
        var spaces:String = " ";

        var namez = Std.int(curName.length * 1.75);

        for (i in 0...namez)
            spaces += " ";

        var message = new FunkinText(10, name.y, 380, spaces + mes.text);
        message.setFormat(Paths.font("Comic Sans MS.ttf"), 30);
        message.camera = camChat;
        add(message);

        coolMessage = null;
        coolMessage = message;

        isFirstChat = false;
    }
}

var coolMessage;

var isFirstChat:Bool = true;

var camChat = new FlxCamera();
var messagesGroup:Array<FunkinText> = [];

var curMs:Int;
var lastCurMs:Int = 0;

var desiredScroll = 0;

function update(e)
{
    if (coolMessage.overlaps(sprite))
        desiredScroll += 5;
    else
        desiredScroll += 0;

    camChat.scroll.y = lerp(camChat.scroll.y, desiredScroll, 0.3);
    //FlxG.camera.scroll.x = camFollow.x + 200;
}

function postUpdate(e)
{
    iconP2.visible = false;
    iconP1.flipX = true;

    for (i in [scoreTxt, accuracyTxt, missesTxt])
        i.visible = false;

    //iconP1.scale.set(1.2, 1.2);
    //iconP1.updateHitbox();

    healthBar.scale.set(1.2, 2);
    healthBarBG.scale.set(healthBar.scale.x, healthBar.scale.y);

    healthBar.x = 140;
    healthBarBG.x = healthBar.x - 2;

    iconP1.x = 50;
    iconP1.y = downscroll ? 100 : 570;
}
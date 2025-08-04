public var catHUD = new FlxCamera(); //sillicat

function postCreate()
    {
        FlxG.cameras.add(catHUD, false).bgColor = FlxColor.TRANSPARENT;

        var hud:String = "";
    
        switch (SONG.meta.name)
        {
            case "silicat": hud = "silicatHUD";
            case "ghosttap": hud = "ghostTapHUD";
            default: hud = "gemafunkHUD";
        }
    
        trace(hud);
    
        importScript("data/scripts/" + hud);
    }
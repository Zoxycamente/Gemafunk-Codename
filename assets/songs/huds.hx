function postCreate()
{
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
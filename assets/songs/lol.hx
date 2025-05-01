import funkin.backend.utils.WindowUtils;

function postCreate() {
    WindowUtils.winTitle = windowName + ' | ' + PlayState.SONG.meta.displayName;

}

function update()
{
    if (FlxG.keys.justPressed.END) PlayState.instance.endSong();
}

function onSongEnd()
{
    var zon = [];
    zon = FlxG.save.data.passedSongs;
    zon.push(PlayState.SONG.meta.name.toLowerCase());
    FlxG.save.data.passedSongs = zon;
}
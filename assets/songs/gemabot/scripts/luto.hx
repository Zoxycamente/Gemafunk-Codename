

function _endSong()
    {
        scripts.call('onSongEnd');
        trace("luto.");
    
        FlxG.switchState(new ModState("eutenhodepressao"));
    }
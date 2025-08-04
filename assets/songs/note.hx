function onNoteCreation(event) {
    //event.noteSprite = 'game/notes/notes';
}

function onStrumCreation(event) {
    //event.sprite = 'game/notes/notes';
}

function postCreate() {
    for (i in 0...4) {
        playerStrums.members[i].x += 40 + (i*5);
        cpuStrums.members[i].x += -40 + (i*5);
    }
}

if (curSong == "ghosttap") disableScript();
import funkin.backend.utils.WindowUtils;

function postCreate() {
    WindowUtils.winTitle = windowName + ' | ' + PlayState.SONG.meta.displayName;

}
var play = false;
var audio = new Audio('./music/sound.mp3');
audio.volume = 0.1;
audio.play();
function onKeyDown(event) {
    switch (event.keyCode) {
        case 32: //SpaceBar
        if (play) {
            audio.pause();
            play = false;
        } else {
            audio.play();
            play = true;
        }
        break;
    }
    return false;
}
window.addEventListener("keydown", onKeyDown, false);
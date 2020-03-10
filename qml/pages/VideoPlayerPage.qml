import QtQuick 2.6
import Sailfish.Silica 1.0
import QtMultimedia 5.6
import Sailfish.Pickers 1.0

Page {
    allowedOrientations: Orientation.All
    id: page
    // ToDo: pause playback when the page is not active
    status: page.status == PageStatus.Inactive ? player.pause() : {}

    SilicaFlickable {
        anchors.fill: parent

        Video {
            id: player
            width: parent.width
            height: parent.height
            autoPlay: true
            // ToDo: change progress slider value when position changed
            onPositionChanged: {
                controlSlider.value = position
            }

            MouseArea {
                anchors.fill: parent
                // ToDo: play or pause on clicked
                onClicked: {
                    if (player.playbackState == MediaPlayer.PausedState) player.play()
                    if (player.playbackState == MediaPlayer.PlayingState) player.pause()
                }
            }
        }
        PullDownMenu {
            id: videoSelectMenu
            quickSelect: false

            clicked: {
                player.playbackState == MediaPlayer.PlayingState ? player.pause() : player.play()
            }

            // ToDo: add item to call video picker
            MenuItem {
                onClicked: {
                    var videoPicker = pageStack.push("Sailfish.Pickers.VideoPickerPage");
                    videoPicker.selectedContentChanged.connect(function () {
                        player.source = videoPicker.selectedContent;
                        if (player.playbackState == MediaPlayer.StoppedState) player.play();
                    });
                }
            }
        }
    }

    // ToDo: add silder to control playback
    Slider {
        id: controlSlider
        minimumValue: 0
        maximumValue: player.duration
        value: minimumValue
        valueText: value
        stepSize: 1
        released: {
            player.seek(controlSlider.value)
        }
    }
}

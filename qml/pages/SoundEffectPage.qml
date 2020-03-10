import QtQuick 2.6
import Sailfish.Silica 1.0
import QtMultimedia 5.6

Page {
    SoundEffect {
        id: soundEffect
        // ToDo: set source to gun.wav in soundeffects folder
        source: "../../soundeffects/gun.wav"
        // ToDo: set volume controlled by volumeSlider
        volume: volumeSlider.value
        // ToDo: set loops controlled by slider
        loops: loopsSlider.value
    }

    PageHeader { title: qsTr("Sound Effect") }

    MouseArea {
        id: touchHandler
        anchors.fill: parent
        // ToDo: play sound effect or stop playing on clicked
        clicked: {
            if (soundEffect.playing) {
                soundEffect.stop()
            } else {
                loopsSlider.value = loopsSlider.minimumValue
                soundEffect.play()
            }
        }
    }
    Column {
        anchors {
            left: parent.left
            right: parent.right
            verticalCenter: parent.verticalCenter
        }
        spacing: Theme.paddingLarge

        Slider {
            id: volumeSlider
            width: parent.width
            label: qsTr("Volume")
            value: 0.5
            valueText: value
            minimumValue: 0
            maximumValue: 100
            stepSize: 10
        }

        // ToDo: add slider to control count of loops
        Slider {
            id: loopsSlider
            width: parent.width
            label: qsTr("Loops")
            value: 1
            minimumValue: 1
            maximumValue: 10
            stepSize: 1
            valueText: value
        }

        // ToDo: add slider to show progress
        Slider {
            id: progressSlider
            width: parent.width
            enabled: false
            label: qsTr("Progress")
            minimumValue: loopsSlider.minimumValue
            maximumValue: loopsSlider.maximumValue
            value: soundEffect.loops - soundEffect.loopsRemaining
            valueText: value
            stepSize: loopsSlider.stepSize
        }
    }
}

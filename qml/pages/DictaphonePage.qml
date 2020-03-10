import QtQuick 2.6
import Sailfish.Silica 1.0
import QtMultimedia 5.6
import Multimedia 1.0
import "../assets"

Page {
    property string filePath: StandardPaths.documents + "/" + Qt.application.name + ".wav"

    AudioRecorder {
        id: audioRecorder
        outputLocation: filePath
        // ToDo: handle stop to reload audioPlayer
        stateChanged: {
            if (audioRecorder.state == AudioRecorder.StoppedState) {
                audioPlayer.source = "";
                audioPlayer.source = filePath
            }
        }
    }
    Audio {
        id: audioPlayer
        source: filePath
        autoLoad: true
    }
    Column {
        anchors.fill: parent
        spacing: Theme.paddingLarge

        PageHeader { title: qsTr("Dictaphone") }
        ValueDisplay {
            id: recordInfo
            label: qsTr("Recorded duration")
            // ToDo: set text property to show recorded duration in seconds
            property string duration: audioPlayer.duration
            value: duration
            width: parent.width
        }
        Slider {
            id: playInfo
            label: qsTr("Player position")
            width: parent.width
            // ToDo: set value, minimumValue, maximumValue and valueText properties
            value: minimumValue
            stepSize: 1
            minimumValue: 0
            maximumValue: recordInfo.duration
            valueText: value
            enabled: false
            down: true
            handleVisible: false
        }
    }
    Row {
        id: buttonsRow
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: Theme.paddingLarge
        }
        spacing: Theme.paddingLarge

        // ToDo: add button to start recording
        IconButton{
            id: startRecordBtn
            icon.source: "image://theme/icon-m-call-recording-on"
            onClicked: {
                startRecordBtn.visible = false
                pauseRecordBtn.visible = true
                stopRecordBtn.visible = true
                startPlayBtn.visible = false
                pausePlayBtn.visible = false
                stopPlayBtn.visible = false
                audioRecorder.record()
            }
        }
        // ToDo: add button to pause recording
        IconButton{
            id: pauseRecordBtn
            icon.source: "image://theme/icon-m-pause"
            onClicked: {
                startRecordBtn.visible = true
                pauseRecordBtn.visible = false
                stopRecordBtn.visible = true
                startPlayBtn.visible = false
                pausePlayBtn.visible = false
                stopPlayBtn.visible = false
                audioRecorder.pause()
            }
        }
        // ToDo: add button to stop recording
        IconButton{
            id: stopRecordBtn
            icon.source: "image://theme/icon-m-call-recording-off"
            onClicked: {
                startRecordBtn.visible = true
                pauseRecordBtn.visible = false
                stopRecordBtn.visible = false
                startPlayBtn.visible = true
                pausePlayBtn.visible = false
                stopPlayBtn.visible = false
                audioRecorder.stop()
                recordInfo.duration = audioRecorder.duration
            }
        }

        // ToDo: add button to start playing
        IconButton {
            id: startPlayBtn
            icon.source: "image://theme/icon-m-play"
            onClicked: {
                startRecordBtn.visible = false
                pauseRecordBtn.visible = false
                stopRecordBtn.visible = false
                startPlayBtn.visible = false
                pausePlayBtn.visible = true
                stopPlayBtn.visible = true
                audioPlayer.play()
            }
        }

        // ToDo: add button to pause playing
        IconButton {
            id: pausePlayBtn
            icon.source: "image://themeicon-m-pause"
            onClicked: {
                startRecordBtn.visible = false
                pauseRecordBtn.visible = false
                stopRecordBtn.visible = false
                startPlayBtn.visible = true
                pausePlayBtn.visible = false
                stopPlayBtn.visible = true
                audioPlayer.pause()
            }
        }
        // ToDo: add button to stop playing
        IconButton {
            id: stopPlayBtn
            icon.source: "image://theme/icon-m-clear"
            onClicked: {
                startRecordBtn.visible = true
                pauseRecordBtn.visible = false
                stopRecordBtn.visible = false
                startPlayBtn.visible = true
                pausePlayBtn.visible = false
                stopPlayBtn.visible = false
                audioPlayer.stop()
            }
        }

        // ToDo: control buttons visibility
    }
    Component.onCompleted: {
        startRecordBtn.visible = true
        pauseRecordBtn.visible = false
        stopRecordBtn.visible = false
        startPlayBtn.visible = true
        pausePlayBtn.visible = false
        stopPlayBtn.visible = false
    }
}

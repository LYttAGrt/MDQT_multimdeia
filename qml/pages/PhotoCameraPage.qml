import QtQuick 2.6
import Sailfish.Silica 1.0
import Sailfish.Pickers 1.0
import QtMultimedia 5.6
// ToDo: import QtSensors module

Page {
    property string filePath: StandardPaths.pictures + "/" + Qt.application.name + ".jpg"

    Camera {
        id: camera

        // ToDo: add property to stode index of current camera

        // ToDo: declare function to switch device

        // ToDo: set device ID according to primaryDevice flag
        exposure {
            exposureCompensation: -1.0
            exposureMode: Camera.ExposurePortrait
        }
        // ToDo: set capture mode to capture images
        // ToDo: set red eye reduction by flash
        // ToDo: set auto white balance mode
        // ToDo: handle imageSaved signal of imageCapture to show preview
    }
    // ToDo: add active orientation sensor
    VideoOutput {
        id: viewfinder

        // ToDo: define mirror property to mirror front camera view

        anchors.fill: parent
        // ToDo: display video from camera here
        visible: !photoPreview.visible
    }
    MouseArea {
        id: touchHandler
        anchors.fill: parent
        // ToDo: focus in press and hold
        onClicked: {
            // ToDo: write orientation to meta
            // ToDo: capture on click
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
        // ToDo: add button to switch camera device
    }
    Image {
        id: photoPreview
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
        visible: false

        MouseArea {
            anchors.fill: parent
            onClicked: photoPreview.visible = false
        }
    }
}

import QtQuick 2.6
import Sailfish.Silica 1.0
import QtMultimedia 5.6

Page {
    property var metaBySource: new Object

    Audio {
        id: audioPlayer
        autoLoad: false
        playlist: playList
    }
    Playlist { id: playList }
    SilicaListView {
        id: playlistView
        anchors { fill: parent; bottomMargin: buttonsRow.height }
        header: PageHeader { title: qsTr("Playlist") }
        model: playList
        delegate: ListItem {
            id: listItem
            // ToDo: add menu to remove item
            MenuItem {
                text: qsTr("Remove")
                onClicked: {
                    // double check this line
                    playList.removeItem(model.currentIndex)
                }
            }

            // ToDo: make current on clicked
            onClicked: {
                audioPlayer.playlist.currentItemSource = model.source
            }

            Label {
                // ToDo: show title but not the url
                text: metaBySource[currentItemSource].title
                // ToDo: highlight current track with bold font - double check this line
                font.bold: audioPlayer.playlist.currentItemSource === model.source ? true : false
                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    right: parent.right
                    margins: Theme.horizontalPageMargin
                }
                color: highlighted ? Theme.highlightColor : Theme.primaryColor
            }
        }

        PullDownMenu {
            quickSelect: true

            MenuItem {
                text: qsTr("Select music")
                onClicked: {
                    var musicPicker = pageStack.push("Sailfish.Pickers.MultiMusicPickerDialog");
                    musicPicker.accepted.connect(function () {
                        playlist.clear();
                        metaBySource = new Object;
                        for (var iSelectedItem = 0; iSelectedItem < musicPicker.selectedContent.count; ++iSelectedItem) {
                            var selectedItem = musicPicker.selectedContent.get(iSelectedItem);
                            metaBySource[selectedItem.url] = {
                                // ToDo: store content properties
                                path: selectedItem.path,
                                title: selectedItem.title,
                                mime: selectedItem.mimeType,
                                name: selectedItem.fileName
                            }
                            // ToDo: add url to playlist
                            playlist.addItem(selectedItem.url);
                        }
                        // ToDo: start playing
                        audioPlayer.play()
                    });
                    musicPicker.rejected.connect(function () {
                        playlist.clear()
                    });
                }
            }
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

        // ToDo: add buttons for suffle playlist, move to previous and next tracks
        IconButton {
            id: shuffleBtn
            icon.source: "image://theme/icon-m-shuffle"
            onClicked: {
                audioPlayer.playlist.shuffle()
            }
        }
        IconButton {
            id: prevBtn
            icon.source: "image://theme/icon-m-previous"
            onClicked: {
                audioPlayer.playlist.previous()
            }
        }
        IconButton {
            id: nextBtn
            icon.source: "image://theme/icon-m-next"
            onClicked: {
                audioPlayer.playlist.next()
            }
        }
    }
}

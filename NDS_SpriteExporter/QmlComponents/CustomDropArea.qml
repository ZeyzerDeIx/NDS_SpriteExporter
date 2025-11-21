import QtQuick

Item {
    anchors.fill: parent
    id: root

    property alias onDroppedExternal: dropArea.onDroppedExternal

    DropArea {
        id: dropArea
        anchors.fill: parent

        onEntered: (drop) => {
            if(!drop.hasUrls || !backend.checkFileValidity(drop.urls[0]))
                invalidOverlay.visible = true;
            else
                validOverlay.visible = true;
        }

        onExited: {
            invalidOverlay.visible = false;
            validOverlay.visible = false;
        }

        property var onDroppedExternal: null

        onDropped: (drop) => {
            invalidOverlay.visible = false;
            validOverlay.visible = false;

            if (onDroppedExternal) {
                onDroppedExternal(drop);
            }
        }
    }

    // --- OVERLAYS ---

    StatusOverlay {
        id: invalidOverlay
        color: "#ccff0000" // Red transparent
        message: qsTr("Invalid file type!")
    }

    StatusOverlay {
        id: validOverlay
        color: "#cc00ff31" // Green transparent
        message: qsTr("Valid file type")
    }
}

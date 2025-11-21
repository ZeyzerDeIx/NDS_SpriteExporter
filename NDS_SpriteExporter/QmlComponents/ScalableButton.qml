import QtQuick
import QtQuick.Controls

Button {
    id: root

    property TextMetrics tm: TextMetrics {
        font.pixelSize: 20
        text: root.text
    }

    onWidthChanged: Qt.callLater(resize)
    onHeightChanged: Qt.callLater(resize)

    function resize() {
        if (width === 0 || height === 0) return;
        let fx = width / tm.width * tm.font.pixelSize * 0.8;
        let fy = height / tm.height * tm.font.pixelSize * 0.8;
        font.pixelSize = Math.min(fx, fy);
    }
}

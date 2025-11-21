import QtQuick
import QtQuick.Layouts

Item {
    id: root
    property double weigh: 1.0
    Layout.fillHeight: true
    Layout.fillWidth: true
    implicitWidth: 0
    implicitHeight: 0
    Layout.preferredWidth: root.weigh
    Layout.preferredHeight: root.weigh
}

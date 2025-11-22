import QtQuick
import QtQuick.Controls

NeutralContainer {
    id: root

    // --- PROPERTIES ---
    property alias labelText: label.text
    property alias inputText: field.text
    property point parentProportions: Qt.point(0.5, 0.15)

    anchors.centerIn: parent
    width: parent.width * parentProportions.x
    height: parent.height * parentProportions.y

    CustomRowLay {
        // --- PROPORTIONAL SPACING ---
        spacing: root.width * 0.02

        // --- LEFT SECTION : LABEL ---
        NeutralContainer {
            weigh: 1
            Label {
                id: label
                anchors.fill: parent
                text: qsTr("Label")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                font.pixelSize: height * 0.4
                fontSizeMode: Text.Fit
                color: "white"
            }
        }

        // --- RIGHT SECTION : INPUT ---
        NeutralContainer {
            weigh: 3.5

            ScalableTextField {
                id: field
                parentProportions: Qt.point(1, 1)
            }
        }
    }
}

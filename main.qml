import QtQuick 2.2
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.1

ApplicationWindow {
    visible: true
    width: 1000
    height: 600

    SplitView {
        anchors.fill: parent
        orientation: Qt.Vertical

		SplitView {
	        Layout.minimumHeight: 300

		    Rectangle {
		        id: unknown
		        width: 400
		        color: "lightsteelblue"
		        Text { text: "Nothing to see here"}
		    }
		    Settings {
		    }
		}
		
        Timeline {
        	id: timeline
        	scale: 5
        	Layout.minimumHeight: 200
        }
    }
}


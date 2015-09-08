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
	        Layout.minimumHeight: 240

		    Rectangle {
		        id: unknown
		        width: 320
		        color: "black"
		        Rectangle{
		        	x: 32
		        	y: 24
		        	color: "white"
		        	width: 256
		        	height: 192
		        	Text { text: "Nothing to see here"}
		        }
		    }
		    
		    Settings {
		    	id: settings
		    }
		}
		
        Timeline {
        	id: timeline
        	scale: 5
        	Layout.minimumHeight: 200
        }
    }
}


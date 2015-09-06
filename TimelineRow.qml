import QtQuick 2.2
import QtQuick.Controls 1.1


Item {
/*	gradient: Gradient {
        GradientStop { position: 0.0; color: "#101010" }
        GradientStop { position: .2; color: "#000000" }
        GradientStop { position: .8; color: "#000000" }
        GradientStop { position: .9; color: "#181818" }
    }
*/
	property var items
	
	Repeater {
		model: items
		Snippet{
			title:modelData;
			ticks:index*10;
			start: index*45;
			color: Qt.rgba(0, index/5, index%4, 255)
		}
	}
	
}

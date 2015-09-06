import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.0


ColumnLayout {
	Layout.fillWidth: true

	RowLayout {
		Text {
			text: "start"
		}
		TextField{
			text: "5454"
		}
		Button {
				Layout.fillWidth: true
			text:"<P"
		}
		Text {
			text: "length"
		}
		TextField{
			text: "54"
		}
		Text {
			text: "end"
		}
		TextField{
			text: "5505"
		}
		Button {
			Layout.fillWidth: true
			text:"P>"
		}
	}	
	
	TextArea {
		Layout.fillWidth: true
		Layout.fillHeight: true
		text: "sdf"
	}
}

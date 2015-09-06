import QtQuick 2.2

Rectangle {
		Repeater {
			model: 1000
			
			Rectangle {
				x: index*timeline.scale
				width: 1
				height: 16
				color: index%50?"gray":"white"
			}
		}
}

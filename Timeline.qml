import QtQuick 2.2
import QtQuick.Layouts 1.0

Rectangle {
	id: timeline
	property bool patternTicks : true
	property bool secondTicks
	property int currentTick: 22
	
	property bool specialTickStartEnabled: false
	property int specialTickStart: 0

	property bool specialTickEndEnabled: false
	property int specialTickEnd: 0

	color: "black"
	property int scale

    focus: true
   
	MouseArea{
		anchors.fill: parent
		propagateComposedEvents: true
		onClicked: {
			parent.focus = true;
			mouse.accepted = false;
		}
	}
    
    Keys.onPressed: {
	    event.accepted = true;
	    
    	switch (event.key){
        	case Qt.Key_Plus:
				timeline.scale ++;
				break;
			case Qt.Key_Minus:		
				timeline.scale --;
				break;
			case Qt.Key_P:
				timeline.patternTicks = !timeline.patternTicks;
				break;
			case Qt.Key_T:
				timeline.secondTicks = !timeline.secondTicks;
				break;
			default:
	            event.accepted = false;
        }
    }


	TimelineSlider {
		id: slider
		height: 8
	}


	Rectangle {
		x: 10
		y: 10
		width: 10
		height: 10
		color: "black"
	}

	Rectangle {
		y: 8
		color: "green"
		width: timeline.width
		height: timeline.height-8
	
		Repeater {
			model: 10
			Rectangle {
				height: 50
				y: 50*index
				width: timeline.width
				color: index %2?"#101010":"#0b0b0b"
			}
		}
		    
		Repeater {
			model: timelineData.len
			Snippet {
				model: timelineData.snippet(index)
			}		
		}
	
		// ticks
		Repeater{
			anchors.fill: parent
			model: 10
			Rectangle {
				visible: timeline.secondTicks
				color: "#40ffffff"
	 		    x: index*timeline.scale*50
	 		    height: parent.height
	 		    width: 1
			}
		}
		Repeater{
			anchors.fill: parent
			model: 10
			Text {
				visible: timeline.secondTicks
				x: index*timeline.scale*50+1
				color: "#40ffffff"
				font.pixelSize: 12
				text: index
			}
		}

		// pattern ticks	
		Repeater{
			anchors.fill: parent
			model: 10
			Rectangle {
				visible: timeline.patternTicks
				color: "#60ffffff"
	 		    x: index * timeline.scale * 3.5*64
	 		    height: parent.height
	 		    width: 1
			}
		}

		Repeater{
			anchors.fill: parent
			model: 10
			Text {
				visible: timeline.patternTicks
				x: index*timeline.scale * 3.5 * 64 + 1
				color: "#60ffffff"
				font.pixelSize: 12
				text: "p" + index
			}
		}

		// special tick start
		Rectangle {
			visible: timeline.specialTickStartEnabled	
			color: "#40ffffff"
			x: timeline.specialTickStart * timeline.scale
			height: parent.height
			width: 1
		}

		// special tick end
		Rectangle {
			visible: timeline.specialTickEndEnabled	
			color: "#40ffffff"
			x: timeline.specialTickEnd * timeline.scale
			height: parent.height
			width: 1
		}
	
		// current tick

		Rectangle {
			visible: false
			color: "#ffff80ff"
			x: timeline.currentTick * timeline.scale - 1
			height: parent.height
			width: 3
			border.width: 1
		}

	}
	
	
	
}

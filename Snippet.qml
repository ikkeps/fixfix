import QtQuick 2.2

Rectangle {
	id: snippet

	property bool selected
	property bool moving
	property var model
	

	height: 50
	width: model.ticks * timeline.scale
	x: model.start * timeline.scale
	y: model.row * 50
	radius: 0
	color: model.color

	opacity: moving? 0.5:1.0


	border.width: 0
	anchors.margins: 0
	
	clip: true
	
	Rectangle {
		color: "black"
		x: 0
		height: parent.height
		width: 1
	}
	Rectangle {
		color: "black"
		x: 0
		width: parent.width
		height: 1
	}
	    
    Text {
    	font.pixelSize: 11
    	text: model.title
    	color: snippet.selected? "white":"black"
    	x:5
    	y:5
    }

   MouseArea {
        id: mouseArea
        anchors.fill: parent
		drag.axis: Drag.XAxis

		property int xOffset: 0
		property int yOffset: 0

		onPressed : {
			snippet.moving = true;
			snippet.selected = !snippet.selected
			xOffset = mouse.x/timeline.scale;
			yOffset = mouse.y;

			timeline.specialTickStart = snippet.model.start;
			timeline.specialTickEnd = snippet.model.start + snippet.model.ticks;
			timeline.specialTickStartEnabled = true;
			timeline.specialTickEndEnabled = true;
		}
		
		onReleased: {
			snippet.moving = false;
			timeline.specialTickStartEnabled = false;		
			timeline.specialTickEndEnabled = false;		
		}

		onPositionChanged:{
			var origStart = snippet.model.start;
			snippet.model.start = origStart+(Math.floor(mouse.x/timeline.scale)-xOffset);

			timeline.specialTickStart = snippet.model.start;
			timeline.specialTickEnd = snippet.model.start + snippet.model.ticks;
			
			snippet.model.row = snippet.model.row + Math.floor(mouse.y/snippet.height);
			
		}		

    }

	MouseArea {
        id: growLeft
		width: {Math.min(snippet.width/3, timeline.scale)}
		height: parent.height
    	cursorShape: Qt.SizeHorCursor
    	anchors.left: snippet.left

    	drag.target: this    
		drag.axis: Drag.XAxis
		drag.minimumX: 0


		onPressed: {
			timeline.specialTickStart = snippet.model.start			
			timeline.specialTickStartEnabled = true
		}
		
		onReleased: {		
			timeline.specialTickStartEnabled = false
		}
		
		onPositionChanged:{		
			var xDiff = Math.floor(mouse.x/timeline.scale);
			var oldStart = snippet.model.start
			snippet.model.start = snippet.model.start + xDiff;
			snippet.model.ticks = snippet.model.ticks - (snippet.model.start-oldStart);
			timeline.specialTickStart = snippet.model.start;
		}		
	}		

 
    MouseArea {
        id: growRight
        anchors.right: snippet.right
		width: {Math.min(snippet.width/3, timeline.scale)}
		height: parent.height
    	cursorShape: Qt.SizeHorCursor
    	
    	drag.target: this    
		drag.axis: Drag.XAxis
		drag.minimumX: timeline.scale
		
		onPressed: {
			timeline.specialTickEnd = snippet.model.start + snippet.model.ticks			
			timeline.specialTickEndEnabled = true
		}
		
		onReleased: {		
			timeline.specialTickEndEnabled = false
		}
		
		onPositionChanged:{		
			snippet.model.ticks = Math.max(snippet.model.ticks + Math.floor(mouse.x/timeline.scale), 1);
			timeline.specialTickEnd = snippet.model.start + snippet.model.ticks
		}		
		
	}


    Drag.active: mouseArea.drag.active
}

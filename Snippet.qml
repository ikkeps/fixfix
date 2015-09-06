import QtQuick 2.2

Rectangle {
	id: snippet

	property string title
	property int ticks
	property int start
	property bool selected
	

	height: 50
	width: ticks * timeline.scale
	x: start * timeline.scale
	radius: 2

	border.color: selected? "white":"black"
	border.width: selected?2:1
	anchors.margins: 0
	
	clip: true
	    
    Text {
    	font.pixelSize: 12
    	text: title
    	color: snippet.selected? "white":"black"
    	x:5
    	y:5
    }

   MouseArea {
        id: mouseArea
        anchors.fill: parent
		drag.axis: Drag.XAxis
//		onClicked: {snippet.selected = !snippet.selected}     

		property int offset: 0

		onPressed : {
			offset = mouse.x/timeline.scale;

			timeline.specialTick = snippet.start;
			timeline.specialTickEnabled = true;
		}
		
		onReleased: {
			timeline.specialTickEnabled = false;		
		}

		onPositionChanged:{
			var origStart = snippet.start;
			snippet.start = Math.max(origStart-offset+Math.floor(mouse.x/timeline.scale), 0);
			timeline.specialTick = snippet.start;
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
			timeline.specialTick = snippet.start			
			timeline.specialTickEnabled = true
		}
		
		onReleased: {		
			timeline.specialTickEnabled = false
		}
		
		onPositionChanged:{		
			var origStart = snippet.start;
			snippet.start = Math.min(Math.max(origStart+Math.floor(mouse.x/timeline.scale), 0), origStart+snippet.ticks-1);
			snippet.ticks = snippet.ticks + (origStart - snippet.start);
			timeline.specialTick = snippet.start;
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
			timeline.specialTick = snippet.start + snippet.ticks			
			timeline.specialTickEnabled = true
		}
		
		onReleased: {		
			timeline.specialTickEnabled = false
		}
		
		onPositionChanged:{		
			snippet.ticks = Math.max(snippet.ticks + Math.floor(mouse.x/timeline.scale), 1);
			timeline.specialTick = snippet.start + snippet.ticks
		}		
		
	}


    Drag.active: mouseArea.drag.active
}
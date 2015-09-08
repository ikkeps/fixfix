import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.0


ColumnLayout {
	Layout.fillWidth: true
	property var model

	RowLayout {
		Text {
			text: "start"
		}
		TextField{
			text: model?model.start:""
			onEditingFinished: {
				if (model){
					model.start = parseInt(text)
				}
			}
		}
		Button {
				Layout.fillWidth: true
			text:"<P"
		}
		Text {
			text: "length"
		}
		TextField{
			text: model?model.ticks:""
			onEditingFinished: {
				if (model){
					model.ticks = parseInt(text)
				}
			}
		}
		Text {
			text: "end"
		}
		TextField{
			text: model?model.start+model.ticks:""
			onEditingFinished: {
				if (model){
					model.ticks = parseInt(text)-model.start
				}
			}
		}
		Button {
			Layout.fillWidth: true
			text:"P>"
		}
	}	
	
	TextArea {
		id: title
		Layout.fillWidth: true
		Layout.fillHeight: false
		text: model?model.title:""		
		
        textFormat: TextEdit.PlainText
        
        Keys.forwardTo: [title]
                
        Keys.onReturnPressed: {
        	console.log("lol");
	    	event.accepted = false;
			if (model){
				model.title = text;
			}
		}
	//	onChange: {
		//	if (model){
//				model.title = text
	//		}
//		}
	}

	RowLayout {
		Text {
			text: "color"
		}
		Rectangle {
			width: 16
			height: 16
			
			color: model?model.color:"transparent"
		
		}
	}
}

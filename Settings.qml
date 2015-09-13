import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.1

ColumnLayout {
	Layout.fillWidth: true
	property var model
	property var oldModel
	
	// better to do it with signal?
	onModelChanged: {
		if (oldModel) {
			oldModel.title = titleField.text;
		}
		if (model) {
			titleField.text = model.title;
			kindList.enabled = true;
			cloneButton.enabled = true;
		}else{
			kindList.enabled = false;
			cloneButton.enabled = false;
		}
		
		oldModel = model;
	}
	
	RowLayout {
		Text {
			text: "start"
		}
		TextField{
			id: startField
			text: model?model.start:""
			onEditingFinished: {
				if (model){
					model.start = parseInt(text)
				}
			}
		}
		Text {
			text: "length"
		}
		TextField{
			id: lengthField
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
			id: endField
			text: model?model.start+model.ticks:""
			onEditingFinished: {
				if (model){
					model.ticks = parseInt(text)-model.start
				}
			}
		}
		Button {
			id: cloneButton
			text: "clone"
			enabled: false
			onClicked: {
				timelineData.clone(model);
			}
		}
		Rectangle{}

		Button {
			id: deleteButton
			text: "delete"
			enabled: false
			onClicked: {
			}
		}
	}
	
	ComboBox {
		id: kindList
		enabled: false
		width: 200
		model: ["int", "int_first", "normal"]
	}
	
	TextArea {
		id: titleField
		Layout.fillWidth: true
		Layout.fillHeight: false
        textFormat: TextEdit.PlainText
  	}

	RowLayout {
		Text {
			text: "color"
		}
		Rectangle {
			width: 32
			height: 24
			border.color: "black";
			
			color: model?model.color:"transparent"
			MouseArea {
				anchors.fill: parent
				onClicked: {
					if (model){
						colorDialog.open();
					}
				}
			}		
		}
		
	}
	
	
	ColorDialog {
		id: colorDialog
		title: "Please choose a color"
		onAccepted: {
		    model.color = colorDialog.currentColor.toString(); // Using currentColor here because .color is broken under my Ubuntu :(
		}
		onRejected: {
		}
	}
	
}

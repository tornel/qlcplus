/*
  Q Light Controller Plus
  KeyPad.qml

  Copyright (c) Massimo Callegari

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0.txt

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
*/

import QtQuick 2.0
import QtQuick.Layouts 1.1

import "."

Rectangle
{
    id: keyPadRoot
    width: 400
    height: keyPadGrid.height
    color: "transparent"
    //border.color: "#666"
    //border.width: 2

    property bool showDMXcontrol: true
    property int buttonWidth: (width / keyPadGrid.columns) - keyPadGrid.columnSpacing
    property alias commandString: commandBox.inputText

    onVisibleChanged: if (visible) commandBox.selectAndFocus()

    signal executeCommand(string cmd)

    GridLayout
    {
        id: keyPadGrid
        width: parent.width
        height: UISettings.iconSizeDefault * rows
        columns: showDMXcontrol ? 4 : 3
        rows: 6
        rowSpacing: 3
        columnSpacing: 3

        // row 1
        Rectangle
        {
            Layout.columnSpan: keyPadGrid.columns
            width: parent.width
            height: 40
            color: UISettings.bgStronger
            border.width: 2
            border.color: UISettings.bgStrong

            CustomTextEdit
            {
                id: commandBox
                anchors.fill: parent
                x: 3
                inputText: ""
                onEnterPressed: keyPadRoot.executeCommand(keyPadRoot.commandString)
            }
        }

        // row 2
        GenericButton
        {
            width: buttonWidth
            label: "7"
            onClicked: commandBox.inputText += label
        }
        GenericButton
        {
            width: buttonWidth
            label: "8"
            onClicked: commandBox.inputText += label
        }
        GenericButton
        {
            width: buttonWidth
            label: "9"
            onClicked: commandBox.inputText += label
        }
        GenericButton
        {
            visible: showDMXcontrol
            width: buttonWidth
            label: "AT"
            onClicked: commandBox.inputText += " AT"
        }

        // row 3
        GenericButton
        {
            width: buttonWidth
            label: "4"
            onClicked: commandBox.inputText += label
        }
        GenericButton
        {
            width: buttonWidth
            label: "5"
            onClicked: commandBox.inputText += label
        }
        GenericButton
        {
            width: buttonWidth
            label: "6"
            onClicked: commandBox.inputText += label
        }
        GenericButton
        {
            visible: showDMXcontrol
            width: buttonWidth
            label: "THRU"
            onClicked: commandBox.inputText += " THRU"
        }

        // row 4
        GenericButton
        {
            width: buttonWidth
            label: "1"
            onClicked: commandBox.inputText += label
        }
        GenericButton
        {
            width: buttonWidth
            label: "2"
            onClicked: commandBox.inputText += label
        }
        GenericButton
        {
            width: buttonWidth
            label: "3"
            onClicked: commandBox.inputText += label
        }
        GenericButton
        {
            visible: showDMXcontrol
            width: buttonWidth
            label: "FULL"
            onClicked: commandBox.inputText += " FULL"
        }

        // row 5
        GenericButton
        {
            width: buttonWidth
            label: "-"
            onClicked:
            {
                if (showDMXcontrol == false)
                    commandBox.inputText = parseInt(commandBox.inputText) - 1
            }
        }
        GenericButton
        {
            width: buttonWidth
            label: "0"
            onClicked: commandBox.inputText += label
        }
        GenericButton
        {
            width: buttonWidth
            label: "+"
            onClicked:
            {
                if (showDMXcontrol == false)
                    commandBox.inputText = parseInt(commandBox.inputText) + 1
            }
        }
        GenericButton
        {
            visible: showDMXcontrol
            width: buttonWidth
            label: "ZERO"
        }

        // row 6
        GenericButton
        {
            Layout.columnSpan: 2
            width: (buttonWidth * 2) + 5
            label: "ENTER"
            bgColor: "#43B008"
            hoverColor: "#61FF0C"
            pressedColor: "#225B04"
            onClicked: keyPadRoot.executeCommand(keyPadRoot.commandString)
        }
        GenericButton
        {
            width: buttonWidth
            label: "CLR"
            onClicked: keyPadRoot.commandString = ""
        }
        GenericButton
        {
            visible: showDMXcontrol
            width: buttonWidth
            label: "BY"
        }
    }
}

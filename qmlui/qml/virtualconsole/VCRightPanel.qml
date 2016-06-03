/*
  Q Light Controller Plus
  VCLeftPanel.qml

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
import QtQuick.Controls 1.0

import com.qlcplus.classes 1.0
import "."

SidePanel
{
    id: vcRightPanel

    Rectangle
    {
        id: sideBar
        width: collapseWidth
        height: parent.height
        color: "transparent"
        z: 2

        Column
        {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 3

            ExclusiveGroup { id: vcButtonsGroup }

            IconButton
            {
                id: addWidgetButton
                z: 2
                width: iconSize
                height: iconSize
                imgSource: "qrc:/add.svg"
                checkable: true
                exclusiveGroup: vcButtonsGroup
                tooltip: qsTr("Add a new widget to the console")
                onToggled:
                {
                    if (checked == true)
                        loaderSource = "qrc:/WidgetsList.qml"
                    animatePanel(checked)
                }
            }

            IconButton
            {
                id: editModeButton
                z: 2
                width: iconSize
                height: iconSize
                imgSource: "qrc:/edit.svg"
                checkable: true
                exclusiveGroup: vcButtonsGroup
                tooltip: qsTr("Enable/Disable the widgets edit mode")

                onToggled:
                {
                    virtualConsole.editMode = checked
                    if (checked == true)
                        loaderSource = "qrc:/VCWidgetProperties.qml"
                    animatePanel(checked)
                }

                SequentialAnimation on color
                {
                    PropertyAnimation { to: "orange"; duration: 500 }
                    PropertyAnimation { to: UISettings.highlight; duration: 500 }
                    running: editModeButton.checked
                    loops: Animation.Infinite
                }
            }
            IconButton
            {
                id: funcEditor
                z: 2
                width: iconSize
                height: iconSize
                imgSource: "qrc:/functions.svg"
                tooltip: qsTr("Function Manager")
                checkable: true
                exclusiveGroup: vcButtonsGroup
                onToggled:
                {
                    if (checked == true)
                        loaderSource = "qrc:/FunctionManager.qml"
                    animatePanel(checked);
                }
            }

            IconButton
            {
                id: removeButton
                z: 2
                width: iconSize
                height: iconSize
                imgSource: "qrc:/remove.svg"
                tooltip: qsTr("Remove the selected widgets")
                counter: virtualConsole.selectedWidget ? 1 : 0
                onClicked:
                {
                    var selNames = virtualConsole.selectedWidgetNames()
                    console.log(selNames)

                    actionManager.requestActionPopup(ActionManager.DeleteVCWidgets,
                                                     qsTr("Are you sure you want to remove the following widgets ?\n" + selNames),
                                                     ActionManager.OK | ActionManager.Cancel,
                                                     virtualConsole.selectedWidgetIDs())
                }
            }
        }
    }
}


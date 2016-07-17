/*
  Q Light Controller Plus
  FunctionDragItem.qml

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
import "."

Rectangle
{
    property int funcID: -1
    property string funcLabel
    property string funcIcon

    width: 200
    height: UISettings.listItemHeight
    z: 10
    border.width: 1
    border.color: "black"
    opacity: 0.8
    color: UISettings.bgMedium

    IconTextEntry
    {
        id: funcEntry
        width: parent.width
        height: parent.height
        tLabel: funcLabel
        iSrc: funcIcon
    }

    Drag.active: funcMouseArea.drag.active
}


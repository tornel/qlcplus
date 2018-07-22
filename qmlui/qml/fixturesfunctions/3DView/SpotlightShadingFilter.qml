/*
  Q Light Controller Plus
  SpotlightShadingFilter.qml

  Copyright (c) Eric Arnebäck

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


import Qt3D.Core 2.0
import Qt3D.Render 2.0

import QtQuick 2.0

TechniqueFilter
{
    property GBuffer gBuffer
    property Layer spotlightShadingLayer
    property Texture2D shadowTex
    property FrameTarget frameTarget
    property bool useShadows

    parameters: [
        Parameter { name: "albedoTex"; value: gBuffer.color },
        Parameter { name: "normalTex"; value: gBuffer.normal },
        Parameter { name: "depthTex"; value: gBuffer.depth },
        Parameter { name: "shadowTex"; value: shadowTex },
        Parameter { name: "useShadows"; value: (useShadows ? 1 : 0) }
    ]

    RenderStateSet
    {
        // Render FullScreen Quad
        renderStates: [
            BlendEquation { blendFunction: BlendEquation.Add },
            BlendEquationArguments
            {
                sourceRgb: BlendEquationArguments.One
                destinationRgb: BlendEquationArguments.One
            }
        ]
        LayerFilter
        {
            layers: spotlightShadingLayer

            RenderTargetSelector {
                target: frameTarget
                RenderPassFilter
                {
                    matchAny: FilterKey { name: "pass"; value: "spotlight_shading" }
                }
            }
        }
    }
} // TechniqueFilter
/* Copyright (c) 2012 Research In Motion Limited.
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 * http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import bb.cascades 1.0

Container {
    id: itemRoot
    property int angle: 0
    property int angleOffset: 0
    property int numid: 0
    property int xloc: 0
    property int prevtotang: 0
    //    property int imagetype: 0
    property int pitch_angle: 0
    property bool centered: false
    property bool creationflag: false
    property alias image: theImage.image
    property string imgFileName: ""
    onImgFileNameChanged: {
        theImage.image = app.createMirrorImage(imgFileName, 30)
    }
    onCreationCompleted: {
        creationflag = true
        xloc = xpos(itemRoot.angle, itemRoot.angleOffset)
        console.log("Creation Completed")
    }
    // On Creation Angle Offset changed - update x location
    onAngleOffsetChanged: {
        xloc = xpos(itemRoot.angle, itemRoot.angleOffset)
    }
    // During slide updates angle changed - update x location
    onAngleChanged: {
        xloc = xpos(itemRoot.angle, itemRoot.angleOffset)
    }
    preferredWidth: 426
    preferredHeight: 280 + 280 * 0.25 + 2
    //    translationX: 427 + 410 * Math.cos((itemRoot.angle + itemRoot.angleOffset + 90) * (Math.PI / 180))
    //    translationY: 130 + 220 * Math.sin((itemRoot.angle + itemRoot.angleOffset + 90) * (Math.PI / 180))
    translationX: xloc
    translationY: ypos(itemRoot.angle, itemRoot.angleOffset)
    attachedObjects: [
        ImplicitAnimationController {
            propertyName: "translationX"
            enabled: false
        },
        ImplicitAnimationController {
            propertyName: "translationY"
            enabled: false
        },
        ImplicitAnimationController {
            propertyName: "scaleX"
            enabled: false
        },
        ImplicitAnimationController {
            propertyName: "scaleY"
            enabled: false
        }
    ]
    property double scaleFactor: 1 + 0.55 * yFactor();
    // value pening between 0.0 (background) and 2.0 (foreground)
    property double depth: 1 + yFactor()
    scaleX: scaleFactor
    scaleY: scaleFactor
    layout: DockLayout {
    }
    ImageView {
        id: theImage
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
        scalingMethod: ScalingMethod.AspectFill
        opacity: (itemRoot.depth * 0.375) + 0.25
        attachedObjects: [
            ImplicitAnimationController {
                propertyName: "opacity"
                enabled: false
            }
        ]
    }

    /* Functions to define the x and y positions for the CarouselItem
     * These are located here for clarity
     * for circle carousel
     * //        var xpos= 427 + 410 * Math.cos((rootItem.angle + rootItem.angleOffset + 90) * (Math.PI / 180))
     * //        var ytotang = ((rootItem.angle + rootItem.angleOffset + 90)) % 360
     * //        var ypos = 130 + 150 * Math.sin(ytotang * (Math.PI / 180))
                 var
     * //
     * 
     */
    function xpos(angle, angleOffset) {
        var xtotang = (360 - (angle + angleOffset + 180 )) % 360
        if (xtotang < 0) {
            xtotang += 360
        }
        if (creationflag & ((prevtotang - xtotang) < -300)) {
            slideleft(itemRoot.numid);
            console.log("slideleft");
        } else if (creationflag & (prevtotang - xtotang) > 300) {
            slideright(itemRoot.numid);
            console.log(numid);
        }
        prevtotang = xtotang;
        //        var xpos= 427 + 410 * Math.cos((angle + angleOffset + 90) * (Math.PI / 180))
        var xpos = xtotang * (1024 + 427 + 427 / 2) / 360 - 427

        //          var xpos = (angle + angleOffset + 90)
        /*
         * if (xpos < 300) {
         * if (pitch_angle != 30) {
         * theImage.image = app.createMirrorImage(imgFileName, 30);
         * pitch_angle = 30
         * }
         * } else if (xpos > 700) {
         * if (pitch_angle != -30) {
         * theImage.image = app.createMirrorImage(imgFileName, -30);
         * pitch_angle = -30
         * }
         * } else if (pitch_angle != 0) {
         * theImage.image = app.createMirrorImage(imgFileName, 0);
         * pitch_angle = 0
         * }*/
        return xpos;
    }
    function yFactor() {
        return Math.cos((itemRoot.angle + itemRoot.angleOffset) * (Math.PI / 180))
    }
    function ypos(angle, angleOffset) {
        return 130 + 150 * yFactor();
    }
}

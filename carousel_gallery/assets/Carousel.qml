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
import bb.data 1.0

Container {
    id: root
    signal slideleft(int numid)
    signal slideright(int numid)
    property int dataindex: 0
    property int angle: 0
    property int baseAngle: 0
    property double offsetValue: 0
    property variant centeredControl: 0
    property double releaseSpeed: 0
    property double momentumSpeed: 0
    layout: DockLayout {
    }
    horizontalAlignment: HorizontalAlignment.Fill
    verticalAlignment: VerticalAlignment.Fill
    Container {
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
        id: carouselContainer
        layout: AbsoluteLayout {
        }
        CarouselItem {
            centered: true
            angle: root.angle + root.baseAngle
            imgFileName: "images/bg1.png"
            // use one item to trigger sort
            onDepthChanged: {
                root.sort()
            }
        }
        /*
         * CarouselItem {
         * angle: root.angle + root.baseAngle
         * imgFileName: "images/bg2.png"
         * }
         * CarouselItem {
         * angle: root.angle + root.baseAngle
         * imgFileName: "images/bg3.png"
         * }*/
        CarouselItem {
            angle: root.angle + root.baseAngle
            imgFileName: "images/bg3.png"
        }
        CarouselItem {
            angle: root.angle + root.baseAngle
            imgFileName: "images/johan.png"
        }
        CarouselItem {
            angle: root.angle + root.baseAngle
            imgFileName: "images/bg4.png"
        }
        CarouselItem {
            angle: root.angle + root.baseAngle
            imgFileName: "images/bg5.png"
        }
    }
    onCreationCompleted: {
        root.offsetValue = 360 / (carouselContainer.controls.length)
        
        // Fills Data
        var currentOffset = 0
        dataSource.load(); 
        var datasize = dataModel.size();
        console.log("Data size  " + datasize);
        for (var i = 0; i < carouselContainer.controls.length; i ++) {
            carouselContainer.controls[i].angleOffset = currentOffset
            var item = dataModel.value(i % datasize)
            carouselContainer.controls[i].imgFileName = item.thumbURL
            currentOffset += root.offsetValue;
        }
        sort();
        // After the root Page is created, direct the data source to start
        // loading data
        console.log("Creation complete")
    }
    function sort() {
        //Bubblesort the carousel items
        var n = carouselContainer.controls.length
        var swopped
        do {
            swopped = false
            for (var i = 0; i < n - 1; ++ i) {
                // a larger depth value means the pic should be on top, i.e. move towards the end of the list of items in the container.
                if (carouselContainer.controls[i].depth > carouselContainer.controls[i + 1].depth) {
                    carouselContainer.swap(i, i + 1)
                    swopped = true
                }
            }
        } while (swopped)
    }
    onAngleChanged: {
        sort();
        root.centeredControl.centered = false;
    }
    onBaseAngleChanged: {
        sort();
    }
    onSlideleft: {
        console.log("onSlideleft")
        var n = carouselContainer.controls.length // rounds up if even carousel containers
        var datasize = dataModel.size();
        if (datasize > 0) {
            dataindex ++;
            dataindex = dataindex % datasize;
            var item = dataModel.value((dataindex + n) % datasize)
            console.log("item " + item.thumbURL)
            console.log("imagefilename" + carouselContainer.controls[numid].imgFileName)
//            right1.image = carouselContainer.controls[numid].image
            //            carouselContainer.controls[numid].image=left1.image
            //            carouselContainer.controls[numid].imgFileName
            //            left1.imageSource=dataModel.value((dataindex + n) % datasize).thumbURL
            carouselContainer.controls[numid].imgFileName = item.thumbURL
        }
    }
    onSlideright: {
        console.log("onSlideRight")
        //        var n = carouselContainer.controls.length / 2 // rounds up if even carousel containers
        var datasize = dataModel.size();
        if (datasize > 0) {
            dataindex --;
            var test = dataindex % datasize;
            dataindex = (dataindex + datasize) % datasize;
            var item = dataModel.value(dataindex % datasize)
            console.log("item " + item.thumbURL)
            console.log("imagefilename" + carouselContainer.controls[numid].imgFileName)
            carouselContainer.controls[numid].imgFileName = item.thumbURL
        }
    }
    function snapToItem() {
        if (root.baseAngle % root.offsetValue != 0) {
            snapToItemAnimation.startValue = root.baseAngle
            snapToItemAnimation.duration = 300

            // snap in the directon the user is scrolling to avoid unsmooth snapping
            if (root.releaseSpeed < 0) {
                snapToItemAnimation.endValue = Math.floor(root.baseAngle / root.offsetValue) * root.offsetValue
            } else if (root.releaseSpeed > 0) {
                snapToItemAnimation.endValue = Math.ceil(root.baseAngle / root.offsetValue) * root.offsetValue
            } else {
                snapToItemAnimation.endValue = Math.round(root.baseAngle / root.offsetValue) * root.offsetValue
            }

            // Calculate the duration of the snap if we are snapping from a momentum scroll
            if (root.momentumSpeed != 0) {
                var dist = Math.abs(snapToItemAnimation.endValue - snapToItemAnimation.startValue)
                snapToItemAnimation.duration = Math.abs(dist / root.momentumSpeed)
            }
            snapToItemAnimation.start()

            // Set the new centered object
            for (var i = 0; i < carouselContainer.controls.length; i ++) {
                //if (carouselContainer.controls[i].angleOffset == Math.abs(360 - (snapToItemAnimation.endValue)) % 360) {
                if (carouselContainer.controls[i].angleOffset == Math.abs(360 - snapToItemAnimation.endValue) % 360) {
                    root.centeredControl.centered = false;
                    root.centeredControl = carouselContainer.controls[i];
                    root.centeredControl.centered = true;
                }
            }
        }
    }
    attachedObjects: [
        // QPropertyAnimation should be used with care since it is a client side animation that will
        // spam the server with messages for every update.
        QPropertyAnimation {
            id: snapToItemAnimation
            startValue: 0
            endValue: 360
            duration: 300
            easingCurve: app.getEase() // TODO:: expose this correctly
            targetObject: root
            propertyName: app.getBytes("baseAngle") // TODO:: workaround since we need the QByteArray of the property name
            onFinished: {
                root.baseAngle = root.baseAngle % 360
            }
        },
        ArrayDataModel {
            id: dataModel
        },
        DataSource {
            id: dataSource
            // Loads the file list from a JSON file
            source: "stamps.json"
            onDataLoaded: {
                // After the data is loaded, insert it into the data model
                dataModel.insert(0, data);
                var item = dataModel.value(0)
            }
        } // end of DataSource
    ]
}

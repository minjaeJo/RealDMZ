<template>
  <div id="app">
    <div id="cesiumContainer">
        <el-menu class="camera" mode="horizontal" @select="handleMenuBar" background-color="#545c64" text-color="#fff" active-text-color="#ffd04b">
            <el-submenu index="1">
                <template slot="title">DMZ</template>
                <el-menu-item index="1-1">middle view</el-menu-item>
                <el-menu-item index="1-2">origin model</el-menu-item>
                <el-menu-item index="1-3">texture model</el-menu-item>
            </el-submenu>
            <el-menu-item index="2">세운상가</el-menu-item>
            <el-menu-item index="3">뉴욕</el-menu-item>
        </el-menu>
    </div>
  </div>
</template>

<script>
import Cesium from 'cesium/Cesium';
import widgets from 'cesium/Widgets/widgets.css';

import CameraModel from './components/cameraModel'

export default {
    name: 'app',
    components: {
        'CameraModel' : CameraModel,
    },
    data() {
        return {
            viewer: '',
            url: window.location.href.slice(0,-3),
            scene: ''
        }
    },
    mounted() {
        this.loadCesium()
    },
    methods: {
        loadCesium() {
            this.viewer = new Cesium.Viewer('cesiumContainer', {
                animation: false,
                baseLayerPicker: false,
                fullscreenButton: false,
                geocoder: false,
                homeButton: false,
                infoBox: false,
                sceneModePicker: false,
                selectionIndicator: true,
                timeline: false,
                navigationHelpButton: false,
                scene3DOnly: true,
                imageryProvider: new Cesium.MapboxImageryProvider({
                    mapId: 'mapbox.satellite',
                    accessToken: 'pk.eyJ1Ijoic2V3b29uIiwiYSI6ImNqaTEyZnBmZTA2NTEzcXFwNTRvNjFmdDMifQ.vHg1EEUA3N_yY8-LyHlgUw'
                })
            });
            var options = {
                camera : this.viewer.scene.camera,
                canvas : this.viewer.scene.canvas
            };
            this.viewer.dataSources.add(Cesium.KmlDataSource.load(this.url + '/static/dmz.kml', options));
            // this.viewer.dataSources.add(Cesium.KmlDataSource.load('/static/dmz.kml', options));
        },

        flytoCamera(location) {
            this.viewer.camera.flyTo({
                destination : Cesium.Cartesian3.fromDegrees(location[0], location[1], location[2]),
            });
        },

        createModel(url, location, height) {
            // this.viewer.entities.removeAll();

            var position = Cesium.Cartesian3.fromDegrees(location[0], location[1], height);
            var heading = 0;
            var pitch = 0;
            var roll = 0;
            var hpr = new Cesium.HeadingPitchRoll(heading, pitch, roll);
            var orientation = Cesium.Transforms.headingPitchRollQuaternion(position, hpr);

            this.viewer.entities.add({
                name : url,
                position : position,
                orientation : orientation,
                model : {
                    uri : url,
                    scale: 1,
                    minimumPixelSize : 10,
                    maximumScale : 100
                }
            });
            // viewer.trackedEntity = entity;
        },
        handleMenuBar(key, keyPath) {
            console.log(key);
            var middleView = [127.230294, 38.307178, 100000.0]
            var dmz = [127.230294, 38.307178, 250.0]
            var sewoon = [126.995151, 37.569879, 1000.0]
            var newyork = [-73.981061, 40.719265, 100000.0]
            switch(String(key)) {
                case '1-1':
                    this.flytoCamera(middleView)
                    break;
                case '1-2':
                    this.flytoCamera(dmz)
                    this.createModel(this.url + '/static/1-s1.glb',[127.2310400972056,38.30786173349542],0)
                    this.createModel(this.url + '/static/1-s2.glb',[127.2309034247928,38.30776363257965],0)
                    this.createModel(this.url + '/static/2-s7.glb',[127.2306922000855,38.30771498710235],0)
                    this.createModel(this.url + '/static/3-s3.glb',[127.2306505028071,38.30759306518442],0)
                    this.createModel(this.url + '/static/3-s5.glb',[127.2307207813936,38.30754055902372],0)
                    this.createModel(this.url + '/static/3-s6.glb',[127.2308125550497,38.30751561222556],0)
                    this.createModel(this.url + '/static/4-s4.glb',[127.230836112512,38.3075715439865],0)
                    // this.createModel('/static/1-s1.glb',[127.2310400972056,38.30786173349542],0)
                    // this.createModel('/static/1-s2.glb',[127.2309034247928,38.30776363257965],0)
                    // this.createModel('/static/2-s7.glb',[127.2306922000855,38.30771498710235],0)
                    // this.createModel('/static/3-s3.glb',[127.2306505028071,38.30759306518442],0)
                    // this.createModel('/static/3-s5.glb',[127.2307207813936,38.30754055902372],0)
                    // this.createModel('/static/3-s6.glb',[127.2308125550497,38.30751561222556],0)
                    // this.createModel('/static/4-s4.glb',[127.230836112512,38.3075715439865],0)
                    break;
                case '1-3':
                    this.flytoCamera(dmz)
                    break;
                case '2':
                    this.flytoCamera(sewoon)
                    break;
                case '3':
                    this.flytoCamera(newyork)
                    break;
            }
        }

    },

}
</script>

<style>
html, body, #cesiumContainer {
    width: 100%; height: 100%; margin: 0; padding: 0; overflow: hidden;
}
#app {
    font-family: 'Avenir', Helvetica, Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    color: #2c3e50;
    width: 100%;
    height: 100%;
}
.el-menu--horizontal {
    border-bottom: 0px;
}
</style>
<template>
  <div id="app">
    <div id="cesiumContainer">
        <cameraModel></cameraModel>
    </div>
  </div>
</template>

<script>
import Cesium from 'cesium/Cesium';
import widgets from 'cesium/Widgets/widgets.css';

import cameraModel from './components/cameraModel'

export default {
    name: 'app',
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
        }

    }
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
</style>
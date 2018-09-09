<template>
  <div id="app">
    <div id="cesiumContainer"></div>
    <img id="logo" :src="url + 'static/logo.png'">
    <CameraModel :viewer="viewer"></CameraModel>
</div>
</template>

<script>
import Cesium from 'cesium/Cesium';
import widgets from 'cesium/Widgets/widgets.css';
import CameraModel from './components/cameraModel';

export default {
    name: 'app'
    , components: {
        CameraModel
    }
    , data() {
        return {
            viewer: ''
            , url: window.location.href
            , options : ''
        }
    },
    mounted() {
        this.initCesium()
    },
    methods: {
        // 세시움 마운트 메소드
        initCesium() {
            this.viewer = new Cesium.Viewer('cesiumContainer', {
                shadows: true,
                geocoder: false,
                imageryProvider: new Cesium.MapboxImageryProvider({
                    mapId: 'mapbox.satellite',
                    accessToken: 'pk.eyJ1Ijoic2V3b29uIiwiYSI6ImNqbGNhaWM3cjJrNzQzc3BibXk3ZnE2dHkifQ.KMSkny6Xsn_DNMfWSCHEfA'
                }),
            });
            this.options = {
                camera : this.viewer.scene.camera,
                canvas : this.viewer.scene.canvas
            }
            this.viewer.dataSources.add(Cesium.KmlDataSource.load(this.url + '/static/peace_plaza/doc.kml', this.options));
            // this.viewer.entities.add({
            //     polygon : {
            //         hierarchy : {
            //             positions : [new Cesium.Cartesian3.fromDegrees(127.2397740086337, 38.31179078716935, 100),
            //                         new Cesium.Cartesian3.fromDegrees(127.2397740086337, 38.30347796655927, 100),
            //                         new Cesium.Cartesian3.fromDegrees(127.2223710259937, 38.30347796655927, 100),
            //                         new Cesium.Cartesian3.fromDegrees(127.2223710259937, 38.31179078716935, 100)]
            //         },
            //         material : this.url + '/static/peace_plaza/forGE-01.png',
            //         classificationType : Cesium.ClassificationType.TERRAIN
            //     }
            //  });
            this.viewer.infoBox.frame.sandbox = "allow-same-origin allow-top-navigation allow-pointer-lock allow-popups allow-forms allow-scripts";
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
    color: #ffffff;
    width: 100%;
    height: 100%;
}
#cesiumContainer {
    position: absolute;
}
#logo {
    z-index: 999;
    position: absolute;
    width: 250px;
}

</style>
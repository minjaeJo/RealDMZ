<template>
  <div id="app">
    <div id="cesiumContainer"></div>
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
            this.viewer.entities.add({
                polygon : {
                    hierarchy : {
                        positions : [new Cesium.Cartesian3.fromDegrees(127.2397740086337, 38.31179078716935, 100),
                                    new Cesium.Cartesian3.fromDegrees(127.2397740086337, 38.30347796655927, 100),
                                    new Cesium.Cartesian3.fromDegrees(127.2223710259937, 38.30347796655927, 100),
                                    new Cesium.Cartesian3.fromDegrees(127.2223710259937, 38.31179078716935, 100)]
                    },
                    material : this.url + '/static/peace_plaza/forGE-01.png',
                    classificationType : Cesium.ClassificationType.TERRAIN
                }
             });
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
#toolbar {
    background: rgba(42, 42, 42, 0.8);
    padding: 4px;
    border-radius: 4px;
    z-index: 1000;
    position: absolute;
}
#toolbar input {
    vertical-align: middle;
    padding-top: 2px;
    padding-bottom: 2px;
}
#toolbar .header {
    font-weight: bold;
}
#toolbar p {
    margin-bottom: 8px;
    margin-top: 8px;
    margin-left: 5px;
    font-size: 20px;
}
.child {
    margin-left: 24px;
    margin-bottom: 5px;
    margin-top: 5px;
}

.el-menu--horizontal {
    border-bottom: 0px;
}

</style>
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
            this.viewer.dataSources.add(Cesium.KmlDataSource.load(this.url + '/static/sonje-talk/doc.kml', this.options));

            this.viewer.infoBox.frame.sandbox = "allow-same-origin allow-top-navigation allow-pointer-lock allow-popups allow-forms allow-scripts";
        }
        , createPolyline() {
            this.viewer.entities.add({
                polyline : {
                    positions : [new Cesium.Cartesian3.fromDegrees(127.230897876284,38.30776234472942,0),
                                new Cesium.Cartesian3.fromDegrees(127.2308155066137,38.30770603816556,0),
                                new Cesium.Cartesian3.fromDegrees(127.2307559802688,38.30770917151926,0),
                                new Cesium.Cartesian3.fromDegrees(127.2307986271479,38.30763517735034,0),
                                new Cesium.Cartesian3.fromDegrees(127.230897876284,38.30776234472942,0)]
                    ,
                    width : 5,
                    material : new Cesium.PolylineOutlineMaterialProperty({
                        color : Cesium.Color.DIMGRAY.withAlpha(0.3),
                        outlineWidth : 2,
                        outlineColor : Cesium.Color.BLACK
                    })
                }
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
.cesium-infoBox-description-lighter {
    overflow-x: hidden;
    overflow-y: auto;
}

</style>
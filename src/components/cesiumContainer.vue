<template>
   <div id="cesiumContainer">
   </div>
</template>

<script>
import Cesium from 'cesium/Cesium';
import widgets from'cesium/Widgets/widgets.css';

export default {
  name: 'cesiumContainer',
  data() {
        return {
            viewer: ''
        }
    },
    mounted(){
        this.loadView()
        this.flytoCamera()
    },
    methods: {
        loadView() {
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
        },
        flytoCamera() {
            var options = {
                camera : this.viewer.scene.camera,
                canvas : this.viewer.scene.canvas
            };
            this.viewer.dataSources.add(Cesium.KmlDataSource.load('/static/doc.kml', options));
            this.viewer.camera.flyTo({
                destination : Cesium.Cartesian3.fromDegrees(127.230294, 38.307178, 1500.0),
            });
        }
    }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
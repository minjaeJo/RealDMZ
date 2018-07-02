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
            viewer: '',
            url: '',
            scene: ''
        }
    },
    mounted(){
        this.loadView()
        this.createModel(this.url + '/static/1-s1.glb',[127.2310400972056,38.30786173349542],0)
        this.createModel(this.url + '/static/1-s2.glb',[127.2309034247928,38.30776363257965],0)
        this.createModel(this.url + '/static/2-s7.glb',[127.2306922000855,38.30771498710235],0)
        this.createModel(this.url + '/static/3-s3.glb',[127.2306505028071,38.30759306518442],0)
        this.createModel(this.url + '/static/3-s5.glb',[127.2307207813936,38.30754055902372],0)
        this.createModel(this.url + '/static/3-s6.glb',[127.2308125550497,38.30751561222556],0)
        this.createModel(this.url + '/static/4-s4.glb',[127.230836112512,38.3075715439865],0)
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
            this.url = window.location.href.slice(0,-3);
        },

        flytoCamera() {
            var options = {
                camera : this.viewer.scene.camera,
                canvas : this.viewer.scene.canvas
            };
            this.viewer.dataSources.add(Cesium.KmlDataSource.load(this.url + '/static/dmz.kml', options));
            // this.viewer.dataSources.add(Cesium.KmlDataSource.load('/realdmz/static/doc.kml', options));
            this.viewer.camera.flyTo({
                destination : Cesium.Cartesian3.fromDegrees(127.230294, 38.307178, 250.0),
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
    }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
<template>
  <div id="app">
    <div id="cesiumContainer"></div>
    <div id="toolbar">
        <div id="location">
            <p>Location</p>
            <el-radio-group v-model="location_model" size="small" v-on:change="this.locationCamera">
            <el-radio-button label="DMZ_Peace_Plaza"></el-radio-button>
            <el-radio-button label="SewoonCampus"></el-radio-button>
            <el-radio-button label="NewYork"></el-radio-button>
            </el-radio-group>
        </div>
        <div id="option">
            <p>Option</p>
            <span>shadow</span>
            <el-switch v-model="shadow_model" v-on:change="this.showShadow" ></el-switch>
        </div>
        <div>
            <p>ArtWork</p>
            <!-- <span>None Texture</span>
            <el-select v-model="none_texture_model" multiple collapse-tags style="margin-left: 20px;" placeholder="Select">
                <el-option v-for="item in options" :key="item.value" :label="item.label" :value="item.value"></el-option>
            </el-select> -->
            <el-table :data="artworks_model" style="width: 100%">
                <el-table-column prop="model" label="Model" width="100"></el-table-column>
                <el-table-column prop="texture" label="Texture" width="100"></el-table-column>
                <el-table-column prop="color" label="Color" width="100"></el-table-column>
                <el-table-column prop="opercity" label="Opercity" width="100"></el-table-column>
            </el-table>
            <!-- <br/>
            <span>Texture</span>
            <el-select v-model="texture_model" multiple collapse-tags style="margin-left: 20px;" placeholder="Select">
                <el-option v-for="item in options" :key="item.value" :label="item.label" :value="item.value"></el-option>
            </el-select> -->
        </div>
    </div>
  </div>
</template>

<script>
import Cesium from 'cesium/Cesium';
import widgets from 'cesium/Widgets/widgets.css';

export default {
    name: 'app',
    data() {
        return {
            viewer: '',
            url: window.location.href,
            location_model: "",
            location_options: {
                DMZ_Peace_Plaza : [127.230294, 38.307178, 250.0],
                SewoonCampus : [126.995151, 37.569879, 1000.0],
                NewYork : [ -73.981061, 40.719265, 100000.0]
            },
            shadow_model: true,
            artworks_model : [{
                model : '1-s1'
            },{
                model : '1-s2'
            },{
                model : '2-s7'
            },{
                model : '3-s3'
            },{
                model : '3-s5'
            },{
                model : '3-s6'
            },{
                model : '4-s4'
            },],
            none_texture_model: [],
            texture_model: [],
        }
    },
    mounted() {
        this.initCesium()
        this.createModel(this.url + '/static/none/1-s1.glb',[127.2310400972056,38.30786173349542],0)
        this.createModel(this.url + '/static/none/1-s2.glb',[127.2309034247928,38.30776363257965],0)
        this.createModel(this.url + '/static/none/2-s7.glb',[127.2306922000855,38.30771498710235],0)
        this.createModel(this.url + '/static/none/3-s3.glb',[127.2306505028071,38.30759306518442],0)
        this.createModel(this.url + '/static/none/3-s5.glb',[127.2307207813936,38.30754055902372],0)
        this.createModel(this.url + '/static/none/3-s6.glb',[127.2308125550497,38.30751561222556],0)
        this.createModel(this.url + '/static/none/4-s4.glb',[127.230836112512,38.3075715439865],0)

        // this.createModel(this.url + '/static/1-s2.glb',[127.2309034247928,38.30776363257965],0)
        // this.createModel(this.url + '/static/2-s7.glb',[127.2306922000855,38.30771498710235],0)
        // this.createModel(this.url + '/static/3-s3.glb',[127.2306505028071,38.30759306518442],0)
        // this.createModel(this.url + '/static/3-s5.glb',[127.2307207813936,38.30754055902372],0)
        // this.createModel(this.url + '/static/3-s6.glb',[127.2308125550497,38.30751561222556],0)
        // this.createModel(this.url + '/static/4-s4.glb',[127.230836112512,38.3075715439865],0)
    },

    computed: {

    },

    methods: {
        // 세시움 마운트 메소드
        initCesium() {
            this.viewer = new Cesium.Viewer('cesiumContainer', {
                shadows: true,
                geocoder: false,
                imageryProvider: new Cesium.MapboxImageryProvider({
                    mapId: 'mapbox.satellite',
                    accessToken: 'pk.eyJ1Ijoic2V3b29uIiwiYSI6ImNqaTEyZnBmZTA2NTEzcXFwNTRvNjFmdDMifQ.vHg1EEUA3N_yY8-LyHlgUw'
                }),
            });
            var options = {
                camera : this.viewer.scene.camera,
                canvas : this.viewer.scene.canvas
            };
            this.viewer.dataSources.add(Cesium.KmlDataSource.load(this.url + '/static/dmz.kml', options));
        },
        // ArtWork 모델 생성 메소드
        createModel(url, location, height) {
            this.viewer.entities.removeAll();

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
                    scale: 0.5,
                    minimumPixelSize : 10,
                    maximumScale : 100,
                    color : new Cesium.Color(60, 120, 120, 0.5),
                }
            });
        },
        // 그림자 옵션 메소드
        showShadow: function () {
            this.viewer.shadows = this.shadow_model
        },
        // 카메라 이동 메소드
        flytoCamera(location) {
            this.viewer.camera.flyTo({
                destination : Cesium.Cartesian3.fromDegrees(location[0], location[1], location[2]),
            });
        },
        // 지역 이동 카메라 메소드
        locationCamera: function (location) {
            switch(location) {
                case "DMZ_Peace_Plaza":
                    this.flytoCamera(this.location_options.DMZ_Peace_Plaza);
                    break;
                case "SewoonCampus":
                    this.flytoCamera(this.location_options.SewoonCampus);
                    break;
                case "NewYork":
                    this.flytoCamera(this.location_options.NewYork);
                    break;
            }
        },
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
}

.el-menu--horizontal {
    border-bottom: 0px;
}

</style>
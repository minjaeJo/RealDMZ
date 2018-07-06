<template>
  <div id="app">
    <div id="cesiumContainer"></div>
    <div id="toolbar">
        <div id="location">
            <p>Location</p>
            <el-radio-group v-model="location_model" size="small" @change="this.locationCamera">
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
            <el-table ref="multipleTable" :data="artworks_model" @selection-change="handleSelectionChange" style="width: 100%">
                    <el-table-column type="selection" width="55"></el-table-column>
                <el-table-column label="Model" width="100">
                    <template slot-scope="scope">
                        <i class="el-icon-location-outline"></i>
                        <span style="margin-left: 10px">{{ scope.row.model }}</span>
                    </template>
                </el-table-column>
                <el-table-column label="Texture" width="100">
                    <template slot-scope="scope">
                        <el-switch v-model="scope.row.texture_model" active-color="#13ce66" inactive-color="#ff4949" ></el-switch>
                    </template>
                </el-table-column>
                <el-table-column label="Color" width="100">
                    <template slot-scope="scope">
                          <el-select v-model="scope.row.color_model" placeholder="Select">
                            <el-option v-for="item in color_option" :key="item.value" :label="item.label" :value="item.value"></el-option>
                        </el-select>
                    </template>
                </el-table-column>
                <el-table-column label="Opercity" width="100">
                    <template slot-scope="scope">
                        <el-slider v-model="scope.row.opercity_model" :format-tooltip="formatTooltip"></el-slider>
                    </template>
                </el-table-column>
            </el-table>
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
            none_texture_url: window.location.href + 'static/none/' ,
            texture_url: window.location.href + 'static/texture/',
            location_model: "",
            location_options: {
                DMZ_Peace_Plaza : [127.230294, 38.307178, 250.0],
                SewoonCampus : [126.995151, 37.569879, 1000.0],
                NewYork : [ -73.981061, 40.719265, 100000.0]
            },
            shadow_model: true,
            multipleSelection: [],
            artworks_model : [{
                id: 0,
                model : '1-s1',
                texture_model: false,
                color_model: 'GREY',
                // url: [window.location.href + 'static/none/1.glb',window.location.href + 'static/texture/1.glb'],
                opercity_model : 100
            },{
                id:1,
                model : '1-s2',
                texture_model: false,
                color_model: 'GREY',
                opercity_model : 50
            },{
                id:2,
                model : '2-s7',
                texture_model: false,
                color_model: 'GREY',
                opercity_model : 100
            },{
                id: 3,
                model : '3-s3',
                texture_model: false,
                color_model: 'GREY',
                opercity_model : 100
            },{
                id: 4,
                model : '3-s5',
                texture_model: false,
                color_model: 'GREY',
                opercity_model : 100
            },{
                id: 5,
                model : '3-s6',
                texture_model: false,
                color_model: 'GREY',
                opercity_model : 100
            },{
                id: 6,
                model : '4-s4',
                texture_model: false,
                color_model: 'GREY',
                opercity_model : 100
            }],
            artworks_option: [{
                name: 0,
                url: '',
                location: [127.2310400972056, 38.30786173349542],
                color: 'GREY',
                opercity: 1.0
            },{
                name: 1,
                url: '',
                location: [127.2309034247928, 38.30776363257965],
                color: 'GREY',
                opercity: 1.0
            },{
                name: 2,
                url: '',
                location: [127.2306922000855,38.30771498710235],
                color: 'GREY',
                opercity: 1.0
            },{
                name: 3,
                url: '',
                location: [127.2306505028071,38.30759306518442],
                color: 'GREY',
                opercity: 1.0
            },{
                name: 4,
                url: '',
                location: [127.2307207813936,38.30754055902372],
                color: 'GREY',
                opercity: 1.0
            },{
                name: 5,
                url: '',
                location: [127.2308125550497,38.30751561222556],
                color: 'GREY',
                opercity: 1.0
            },{
                name: 6,
                url: '',
                location: [127.230836112512,38.3075715439865],
                color: 'GREY',
                opercity: 1.0
            }],

            color_option: [{
                value: 'Red',
                label: 'Red'
            }, {
                value: 'Blue',
                label: 'Blue'
            }, {
                value: 'Green',
                label: 'Green'
            }, {
                value: 'White',
                label: 'White'
            }, {
                value: 'Black',
                label: 'Black'
            },{
                value: 'GREY',
                label: 'GREY'
            }],
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
                    accessToken: 'pk.eyJ1Ijoic2V3b29uIiwiYSI6ImNqaTEyZnBmZTA2NTEzcXFwNTRvNjFmdDMifQ.vHg1EEUA3N_yY8-LyHlgUw'
                }),
            });
            var options = {
                camera : this.viewer.scene.camera,
                canvas : this.viewer.scene.canvas
            };
            this.viewer.dataSources.add(Cesium.KmlDataSource.load(this.url + '/static/dmz.kml', options));
        },
        // 작품 색상 및 투명도
         getColor(colorName, alpha) {
            var color = Cesium.Color[colorName.toUpperCase()];
            return Cesium.Color.fromAlpha(color, parseFloat(alpha));
        },
        // 작품 투명도 비율
        formatTooltip(opercity) {
            return opercity / 100;
        },
        isTexture(checkedTexture, url) {
            return checkedTexture ? url[1] : url[0]
        },
        // ArtWork 모델 생성 메소드
        createModel(name, url, location, color, opercity) {
            // this.viewer.entities.removeAll();

            var position = Cesium.Cartesian3.fromDegrees(location[0], location[1]);
            var heading = 0;
            var pitch = 0;
            var roll = 0;
            var hpr = new Cesium.HeadingPitchRoll(heading, pitch, roll);
            var orientation = Cesium.Transforms.headingPitchRollQuaternion(position, hpr);

            this.viewer.entities.add({
                name : name,
                position : position,
                orientation : orientation,
                model : {
                    uri : url,
                    scale: 0.5,
                    minimumPixelSize : 10,
                    maximumScale : 100,
                    color : this.getColor(color, opercity)
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
        // 다중 선택
        handleSelectionChange: function (data) {
            this.multipleSelection = data;
            this.viewer.entities.removeAll();
            data.forEach((result)=> {
                if(this.artworks_model[result.id].texture_model == true) {
                    this.artworks_option[result.id].url = this.texture_url + String(result.id+1) + '.glb'
                } else {
                    this.artworks_option[result.id].url = this.none_texture_url + String(result.id+1) + '.glb'
                }
                console.log(this.artworks_option[result.id].url)
                // this.artworks_option[result.id].url = this.artworks_model[result.id].texture_model
                this.artworks_option[result.id].color = this.artworks_model[result.id].color_model
                this.artworks_option[result.id].opercity = this.artworks_model[result.id].opercity_model
                console.log(this.artworks_option[result.id])
                this.createModel(
                    this.artworks_option[result.id].name,
                    this.artworks_option[result.id].url,
                    this.artworks_option[result.id].location,
                    this.artworks_option[result.id].color,
                    this.artworks_option[result.id].opercity/100
                )

            })
            // this.createModel(this)
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
<template>
    <div class="fly-to-menu" mode="horizontal">
        <div class="location" @click="flyToLocation('dmz_peace_plaza')">
            <img :src="url+'/static/location/rock.png'" @click.once="uploadRockModel()">
        </div>
        <div class="location" @click="flyToLocation('sewoon_campus')">
            <img :src="url+'/static/location/dongdaemun_design_plaza.png'" @click.once="createBigModel(sewoon_model)">
        </div>
        <div class="location" @click="flyToLocation('sonje_art_center')">
            <img :src="url+'/static/location/art_center.png'" @click.once="createBigModel(artcenter_model)">
        </div>
        <div class="location" @click="flyToLocation('new_york')">
            <img :src="url+'/static/location/newyork.png'">
        </div>
    </div>
</template>

<script >
import Cesium from 'cesium/Cesium';
import widgets from 'cesium/Widgets/widgets.css';
export default {
    props:['viewer']
    , data() {
        return {
            url: window.location.href
            , dmz_peace_plaza : { lon:127.230694, lat:38.307178, alt:30.0}
            , sewoon_campus : { lon:126.9956982136, lat:37.56601105667, alt:1000.0}
            , sonje_art_center : { lon:126.981942, lat:37.579460, alt: 1000.0}
            , new_york: { lon: -73.981061, lat: 40.719265, alt: 100000.0}
            , dmz_models: [
                {
                    name: "1-s1",
                    url: window.location.href + '/static/none/1.glb',
                    location: [127.2310400972056, 38.30786173349542],
                    color: 'GREY',
                    opercity: 1.0,
                    description: '<div class="sketchfab-embed-wrapper"><iframe width="480" height="480" src="https://sketchfab.com/models/7eb633ad291f49e8afd00bc2ce48c471/embed?autostart=1" frameborder="0" allow="autoplay; fullscreen; vr" mozallowfullscreen="true" webkitallowfullscreen="true"></iframe><p style="font-size: 13px; font-weight: normal; margin: 5px; color: #4A4A4A;"><a href="https://sketchfab.com/models/7eb633ad291f49e8afd00bc2ce48c471?utm_medium=embed&utm_source=website&utm_campaign=share-popup" target="_blank" style="font-weight: bold; color: #1CAAD9;">1-#1</a>by <a href="https://sketchfab.com/dmz1?utm_medium=embed&utm_source=website&utm_campaign=share-popup" target="_blank" style="font-weight: bold; color: #1CAAD9;">dmz1</a>on <a href="https://sketchfab.com?utm_medium=embed&utm_source=website&utm_campaign=share-popup" target="_blank" style="font-weight: bold; color: #1CAAD9;">Sketchfab</a></p></div>'
                }
                , {
                    name: "1-s2",
                    url: window.location.href + '/static/none/2.glb',
                    location: [127.2309034247928, 38.30776363257965],
                    color: 'GREY',
                    opercity: 1.0,
                    description: '<div class="sketchfab-embed-wrapper"><iframe width="480" height="480" src="https://sketchfab.com/models/1251eae6b84d4e989cce1fed49406d6c/embed" frameborder="0" allow="autoplay; fullscreen; vr" mozallowfullscreen="true" webkitallowfullscreen="true"></iframe><p style="font-size: 13px; font-weight: normal; margin: 5px; color: #4A4A4A;"><a href="https://sketchfab.com/models/1251eae6b84d4e989cce1fed49406d6c?utm_medium=embed&utm_source=website&utm_campaign=share-popup" target="_blank" style="font-weight: bold; color: #1CAAD9;">1-#2</a>by <a href="https://sketchfab.com/dmz1?utm_medium=embed&utm_source=website&utm_campaign=share-popup" target="_blank" style="font-weight: bold; color: #1CAAD9;">dmz1</a>on <a href="https://sketchfab.com?utm_medium=embed&utm_source=website&utm_campaign=share-popup" target="_blank" style="font-weight: bold; color: #1CAAD9;">Sketchfab</a></p></div>'
                }
                , {
                    name: "2-s7",
                    url: window.location.href + '/static/none/3.glb',
                    location: [127.2306922000855,38.30771498710235],
                    color: 'GREY',
                    opercity: 1.0,
                    description:'<div class="sketchfab-embed-wrapper"><iframe width="480" height="480" src="https://sketchfab.com/models/664a524e71804c77b2f5d14b6e71e814/embed" frameborder="0" allow="autoplay; fullscreen; vr" mozallowfullscreen="true" webkitallowfullscreen="true"></iframe><p style="font-size: 13px; font-weight: normal; margin: 5px; color: #4A4A4A;"><a href="https://sketchfab.com/models/664a524e71804c77b2f5d14b6e71e814?utm_medium=embed&utm_source=website&utm_campaign=share-popup" target="_blank" style="font-weight: bold; color: #1CAAD9;">1-#6</a>by <a href="https://sketchfab.com/dmz1?utm_medium=embed&utm_source=website&utm_campaign=share-popup" target="_blank" style="font-weight: bold; color: #1CAAD9;">dmz1</a>on <a href="https://sketchfab.com?utm_medium=embed&utm_source=website&utm_campaign=share-popup" target="_blank" style="font-weight: bold; color: #1CAAD9;">Sketchfab</a></p></div>'
                }
                , {
                    name: "3-s3",
                    url: window.location.href + '/static/none/4.glb',
                    location: [127.2306505028071,38.30759306518442],
                    color: 'GREY',
                    opercity: 1.0,
                    description: '<div class="sketchfab-embed-wrapper"><iframe width="480" height="480" src="https://sketchfab.com/models/7eb633ad291f49e8afd00bc2ce48c471/embed?autostart=1" frameborder="0" allow="autoplay; fullscreen; vr" mozallowfullscreen="true" webkitallowfullscreen="true"></iframe><p style="font-size: 13px; font-weight: normal; margin: 5px; color: #4A4A4A;"><a href="https://sketchfab.com/models/7eb633ad291f49e8afd00bc2ce48c471?utm_medium=embed&utm_source=website&utm_campaign=share-popup" target="_blank" style="font-weight: bold; color: #1CAAD9;">1-#1</a>by <a href="https://sketchfab.com/dmz1?utm_medium=embed&utm_source=website&utm_campaign=share-popup" target="_blank" style="font-weight: bold; color: #1CAAD9;">dmz1</a>on <a href="https://sketchfab.com?utm_medium=embed&utm_source=website&utm_campaign=share-popup" target="_blank" style="font-weight: bold; color: #1CAAD9;">Sketchfab</a></p></div>'
                }
                , {
                    name: "3-s5",
                    url: window.location.href + '/static/none/5.glb',
                    location: [127.2307207813936,38.30754055902372],
                    color: 'GREY',
                    opercity: 1.0,
                    description: '<div class="sketchfab-embed-wrapper"><iframe width="480" height="480" src="https://sketchfab.com/models/1251eae6b84d4e989cce1fed49406d6c/embed" frameborder="0" allow="autoplay; fullscreen; vr" mozallowfullscreen="true" webkitallowfullscreen="true"></iframe><p style="font-size: 13px; font-weight: normal; margin: 5px; color: #4A4A4A;"><a href="https://sketchfab.com/models/1251eae6b84d4e989cce1fed49406d6c?utm_medium=embed&utm_source=website&utm_campaign=share-popup" target="_blank" style="font-weight: bold; color: #1CAAD9;">1-#2</a>by <a href="https://sketchfab.com/dmz1?utm_medium=embed&utm_source=website&utm_campaign=share-popup" target="_blank" style="font-weight: bold; color: #1CAAD9;">dmz1</a>on <a href="https://sketchfab.com?utm_medium=embed&utm_source=website&utm_campaign=share-popup" target="_blank" style="font-weight: bold; color: #1CAAD9;">Sketchfab</a></p></div>'
                }
                , {
                    name: "3-s6",
                    url: window.location.href + '/static/none/6.glb',
                    location: [127.2308125550497,38.30751561222556],
                    color: 'GREY',
                    opercity: 1.0,
                    description: '<div class="sketchfab-embed-wrapper"><iframe width="480" height="480" src="https://sketchfab.com/models/7eb633ad291f49e8afd00bc2ce48c471/embed?autostart=1" frameborder="0" allow="autoplay; fullscreen; vr" mozallowfullscreen="true" webkitallowfullscreen="true"></iframe><p style="font-size: 13px; font-weight: normal; margin: 5px; color: #4A4A4A;"><a href="https://sketchfab.com/models/7eb633ad291f49e8afd00bc2ce48c471?utm_medium=embed&utm_source=website&utm_campaign=share-popup" target="_blank" style="font-weight: bold; color: #1CAAD9;">1-#1</a>by <a href="https://sketchfab.com/dmz1?utm_medium=embed&utm_source=website&utm_campaign=share-popup" target="_blank" style="font-weight: bold; color: #1CAAD9;">dmz1</a>on <a href="https://sketchfab.com?utm_medium=embed&utm_source=website&utm_campaign=share-popup" target="_blank" style="font-weight: bold; color: #1CAAD9;">Sketchfab</a></p></div>'
                }
                , {
                    name: "4-s4",
                    url: window.location.href + '/static/none/7.glb',
                    location: [127.230836112512,38.3075715439865],
                    color: 'GREY',
                    opercity: 1.0,
                    description:'<div class="sketchfab-embed-wrapper"><iframe width="480" height="480" src="https://sketchfab.com/models/664a524e71804c77b2f5d14b6e71e814/embed" frameborder="0" allow="autoplay; fullscreen; vr" mozallowfullscreen="true" webkitallowfullscreen="true"></iframe><p style="font-size: 13px; font-weight: normal; margin: 5px; color: #4A4A4A;"><a href="https://sketchfab.com/models/664a524e71804c77b2f5d14b6e71e814?utm_medium=embed&utm_source=website&utm_campaign=share-popup" target="_blank" style="font-weight: bold; color: #1CAAD9;">1-#6</a>by <a href="https://sketchfab.com/dmz1?utm_medium=embed&utm_source=website&utm_campaign=share-popup" target="_blank" style="font-weight: bold; color: #1CAAD9;">dmz1</a>on <a href="https://sketchfab.com?utm_medium=embed&utm_source=website&utm_campaign=share-popup" target="_blank" style="font-weight: bold; color: #1CAAD9;">Sketchfab</a></p></div>'
                }
            ]
            , sewoon_model:  {
                name: "세운상가",
                url: window.location.href + '/static/sewwon.glb',
                location: [126.9956982136,37.56601105667,1000.0],
            }
            , artcenter_model:  {
                name: "선재아트센터",
                url: window.location.href + '/static/artcenter.glb',
                location: [126.981942,37.579460,1000.0],
            }
        }
    }
    , mounted() {
    }
    , methods: {
        flyToLocation(location) {
            let value = '';
            switch (location) {
                case 'dmz_peace_plaza':
                        value = this.dmz_peace_plaza;
                        this.viewer.camera.flyTo({
                            destination: Cesium.Cartesian3.fromDegrees(value.lon, value.lat, value.alt),
                            orientation : {
                                heading: Cesium.Math.toRadians(15.0)
                                ,pitch: Cesium.Math.toRadians(-30.0)
                                ,roll: Cesium.Math.toRadians(-10.0)
                            }
                        });
                    break;
                case 'sewoon_campus':
                        value = this.sewoon_campus;
                        this.viewer.camera.flyTo({
                            destination: Cesium.Cartesian3.fromDegrees(value.lon, value.lat, value.alt)
                        });
                    break;
                case 'sonje_art_center':
                        value = this.sonje_art_center;
                        this.viewer.camera.flyTo({
                            destination: Cesium.Cartesian3.fromDegrees(value.lon, value.lat, value.alt)
                        });
                    break;
                case 'new_york':
                        value = this.new_york;
                        this.viewer.camera.flyTo({
                            destination: Cesium.Cartesian3.fromDegrees(value.lon, value.lat, value.alt)
                        });
                    break;
            }
        }
        , createModel(object) {
            var position = Cesium.Cartesian3.fromDegrees(object.location[0], object.location[1]);
            var hpr = new Cesium.HeadingPitchRoll(0, 0, 0);
            var orientation = Cesium.Transforms.headingPitchRollQuaternion(position, hpr);
            var self = this;
            return new Promise(function(resolve, reject) {
                self.viewer.entities.add({
                    id: object.name,
                    name : object.name,
                    position : position,
                    orientation : orientation,
                    model : {
                        uri : object.url,
                        scale: 0.5,
                        minimumPixelSize : 10,
                        maximumScale : 100
                    },
                    description: object.description
                });
            });
        }
        , uploadRockModel() {
            this.dmz_models.forEach((result)=> {
                this.createModel(result);
            });
        }
        , createBigModel(object) {
            var position = Cesium.Cartesian3.fromDegrees(object.location[0], object.location[1]);
            var hpr = new Cesium.HeadingPitchRoll(0, 0, 0);
            var orientation = Cesium.Transforms.headingPitchRollQuaternion(position, hpr);
            this.viewer.entities.add({
                id: object.name,
                name : object.name,
                position : position,
                orientation : orientation,
                model : {
                    uri : object.url,
                    scale: 10.0,
                    minimumPixelSize : 10,
                    maximumScale : 100
                },
            });
        }
    }
}
</script>

<style >
.fly-to-menu {
    position: absolute;
    top: 45px;
    right: 5px;
    height: 30px;
    border-radius: 2px;
    list-style: none;
    z-index: 999;
}
.fly-to-menu .location {
    display: -webkit-inline-box;
    width: 30px;
    color: #000;
    margin-right: 4px;
}
.fly-to-menu .location img {
    width: 32px;
    height: 30px;
    background: #edffff;
    border-radius: 4px;
}
</style>
<template>
    <div>
        <div class="list">
            <span class="font other font-title">[Beginning]</span>
            <div v-for="fly in fly_info" class="font" >
                <span class="font-other" v-if="fly.index!=null" @click="flyto(fly)">{{fly.index}}. {{fly.name}}</span>
                <span v-else class="font-title">{{fly.name}}</span>
            </div>
        </div>
        <div class="fly-to-menu" mode="horizontal">
            <div class="location">
                <img :src="url+'/static/location/rock.png'" @click="uploadRockModel()">
            </div>
            <div class="location">
                <img :src="url+'/static/location/dongdaemun_design_plaza.png'" @click="createBigModel(sewoon_model)">
            </div>
            <!-- <div class="location">
                <div :src="url+'/static/location/rock.png'" @click="uploadRockModel()">
            </div> -->
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
            , rock_toggle: false
            , sewoon_toggle: false
            , fly_info : [
                { index: 1, name: "Michael Joo's Studio", lon: -74.0368061085296, lat: 40.68685643883743, alt: 29873.7643156098, heading: 0.237710656967226 },
                { index: 2, name: "사무소", lon: 126.9689195562919, lat: 37.56883931875944, alt: 142.457272606434, heading: 6.290784043941478 },
                { index: null, name: "[March]"},
                { index: 3, name: "고석정", lon: 127.2885822945642, lat: 38.184035079308, alt: 303.6717535141181, heading: 123.9769670702329 },
                { index: 4, name: "민통선", lon: 127.2068367836637, lat: 38.25269422178015, alt: 4569.899659519249, heading: 123.9244757130688 },
                { index: 5, name: "DMZ평화문화광장사무소", lon: 127.2321867009447, lat: 38.30505114972512, alt: 1450.812395885392 , heading: 123.9391148331798 },
                { index: 6, name: "직통폭포", lon: 127.2673766568986, lat: 38.20523278295681, alt: 1485.293871241468, heading: 123.938052606906 },
                { index: 7, name: "승일교", lon: 127.3007481801253, lat: 38.18810609886165, alt: 575.5952115384713, heading: 0.1396957072415722 },
                { index: null, name: "[April - May]"},
                { index: 8, name: "세운상가", lon: 126.995162, lat: 37.56958999999999, alt: 1000.000000001641, heading: 6.361109362927033 },
                { index: 9, name: "세운상가 장인 청년창업", lon: 126.9951331747062, lat: 37.5682779868315, alt:298.8308203830972, heading: 28.70162611721149 },
                { index: 10, name: "세운베이스먼트", lon: 126.9951331747062, lat: 37.5682779868315, alt: 298.830820384748, heading: 28.70162611721148 },
                { index: null, name: "[June - July]"},
                { index: 11, name: "세운캠퍼스", lon: 126.995237953239, lat: 37.56853880008648, alt: 1000.000000001109, heading: 3.180554681463517 },
                { index: 12, name: "서울시립대학교 구조실험동", lon: 127.0601884018028, lat: 37.58329860865005, alt: 1000.000000000511, heading: 0.0008607529496535589 },
                { index: 13, name: "용인공장 - 디크리트 제일특수조형", lon: 127.2079116119509, lat: 37.39763864264056, alt: 663.838747171641, heading: -9.456096790477424 },
                { index: null, name: "[August]"},
                { index: 14, name: "Absentialis", lon: 127.2306130338085, lat: 38.30692112149756, alt: 403.1827480549308, heading: 0.1339817816294141 },
                { index: null, name: "[September]"},
                { index: 15, name: "아트선재센터", lon: 126.9819422657158, lat: 37.57956831950296, alt: 309.2821746397827, heading: 0.005583706405464798 }


            ]
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
                url: window.location.href + '/static/15.gltf',
                location: [126.9956982136,37.56601105667],
                color: 'GREY',
                opercity: 1.0
            }
            , artcenter_model:  {
                name: "선재아트센터",
                url: window.location.href + '/static/artcenter.glb',
                location: [126.981942,37.579460],
            }
        }
    }
    , mounted() {
    }
    , methods: {
        flyto(location) {
            this.viewer.camera.flyTo({
                destination: Cesium.Cartesian3.fromDegrees(location.lon, location.lat, location.alt),
                // orientation : {
                //     heading: location.heading
                // }
            })
        }
        , flyToLocation(location) {
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
                    //description: object.//description
                });
            });
        }
        , removeModel() {

        }
        , uploadRockModel() {
            if(this.rock_toggle == true) {
                this.viewer.entities.removeAll()
                this.rock_toggle = false
            } else {
                this.dmz_models.forEach((result)=> {
                    this.createModel(result);
                });
                this.rock_toggle = true
            }

        }
        , createBigModel(object) {
            var position = Cesium.Cartesian3.fromDegrees(object.location[0], object.location[1]);
            var hpr = new Cesium.HeadingPitchRoll(0, 0, 0);
            var orientation = Cesium.Transforms.headingPitchRollQuaternion(position, hpr);
            if(this.sewoon_toggle==true) {
                this.sewoon_toggle = false
                this.viewer.entities.removeAll()
            } else {
                this.sewoon_toggle = true
                this.viewer.entities.add({
                    id: object.name,
                    name : object.name,
                    position : position,
                    orientation : orientation,
                    model : {
                        uri : object.url,
                        scale: 1.0,
                        minimumPixelSize : 10,
                        maximumScale : 100
                    },
                });
            }
        }
    }
}
</script>

<style >
.list {
    position: absolute;
    top: 65px;
    left: 15px;
    height: 700px;
    width: 150px;
    background: #fff;
    border-radius: 5px;
    list-style: none;
    opacity: 0.85;
    z-index: 999;
}
.list .font {
    margin: 10px 10px;
    font-size: 13px;
    color: #114499;;
}
.font-title {
    font-size: 14px;
    font-weight: bold;
    color: #000;
}
.font-other {
    margin-left:10px;
}
.list .font.other {
    margin: 10px 10px;
    font-size: 13px;
    color: #000;
}
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
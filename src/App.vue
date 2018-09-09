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
            this.viewer.entities.add({
                polyline : {
                    positions : [new Cesium.Cartesian3.fromDegrees(127.2310368836907, 38.30786319043345, 0),
                                new Cesium.Cartesian3.fromDegrees(127.2308697891212, 38.30790274374517, 0),
                                new Cesium.Cartesian3.fromDegrees(127.23093839129,38.30779649035475, 0),
                                new Cesium.Cartesian3.fromDegrees(127.2311020188478,38.30776680635015, 0),
                                new Cesium.Cartesian3.fromDegrees(127.2310368837907, 38.30786319044345, 0)]
                    ,
                    width : 5,
                    material : new Cesium.PolylineOutlineMaterialProperty({
                        color : Cesium.Color.DIMGRAY.withAlpha(0.3),
                        outlineWidth : 2,
                        outlineColor : Cesium.Color.BLACK
                    })
                }
            });
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

            this.viewer.entities.add({
                polyline : {
                    positions : [new Cesium.Cartesian3.fromDegrees(127.2306924433398,38.30771630039334,0),
                                new Cesium.Cartesian3.fromDegrees(127.2306002644808,38.30776835603191,0),
                                new Cesium.Cartesian3.fromDegrees(127.2305942766816,38.30767834038065,0),
                                new Cesium.Cartesian3.fromDegrees(127.2306971344025,38.30762532080189,0),
                                new Cesium.Cartesian3.fromDegrees(127.2306924433398,38.30771630039334,0)]
                    ,
                    width : 5,
                    material : new Cesium.PolylineOutlineMaterialProperty({
                        color : Cesium.Color.DIMGRAY.withAlpha(0.3),
                        outlineWidth : 2,
                        outlineColor : Cesium.Color.BLACK
                    })
                }
            });

            this.viewer.entities.add({
                polyline : {
                    positions : [new Cesium.Cartesian3.fromDegrees(127.230743253134,38.30755432992905,0),
                                new Cesium.Cartesian3.fromDegrees(127.2307992336882,38.3075684282053,0),
                                new Cesium.Cartesian3.fromDegrees(127.2306705028091,38.30767338300614,0),
                                new Cesium.Cartesian3.fromDegrees(127.2306493280483,38.30759447175342,0),
                                new Cesium.Cartesian3.fromDegrees(127.230743253134,38.30755432992905,0)]
                    ,
                    width : 5,
                    material : new Cesium.PolylineOutlineMaterialProperty({
                        color : Cesium.Color.DIMGRAY.withAlpha(0.3),
                        outlineWidth : 2,
                        outlineColor : Cesium.Color.BLACK
                    })
                }
            });

            this.viewer.entities.add({
                polyline : {
                    positions : [new Cesium.Cartesian3.fromDegrees(127.2306802824907,38.30749162527093,0),
                                new Cesium.Cartesian3.fromDegrees(127.2307230282837,38.30747541582199,0),
                                new Cesium.Cartesian3.fromDegrees(127.2307776743518,38.30752810782572,0),
                                new Cesium.Cartesian3.fromDegrees(127.230722391647,38.30753656495625,0),
                                new Cesium.Cartesian3.fromDegrees(127.2306802824907,38.30749162527093,0)]
                    ,
                    width : 5,
                    material : new Cesium.PolylineOutlineMaterialProperty({
                        color : Cesium.Color.DIMGRAY.withAlpha(0.3),
                        outlineWidth : 2,
                        outlineColor : Cesium.Color.BLACK
                    })
                }
            });

            this.viewer.entities.add({
                polyline : {
                    positions : [new Cesium.Cartesian3.fromDegrees(127.2308110870514,38.3075150021456,0),
                                new Cesium.Cartesian3.fromDegrees(127.2307765813975,38.30751153709338,0),
                                new Cesium.Cartesian3.fromDegrees(127.23074689356,38.30747429517434,0),
                                new Cesium.Cartesian3.fromDegrees(127.2308060105648,38.30747210409898,0),
                                new Cesium.Cartesian3.fromDegrees(127.2308110870514,38.3075150021456,0)]
                    ,
                    width : 5,
                    material : new Cesium.PolylineOutlineMaterialProperty({
                        color : Cesium.Color.DIMGRAY.withAlpha(0.3),
                        outlineWidth : 2,
                        outlineColor : Cesium.Color.BLACK
                    })
                }
            });

            this.viewer.entities.add({
                polyline : {
                    positions : [new Cesium.Cartesian3.fromDegrees(127.2308291670661,38.30756893168915,0),
                                new Cesium.Cartesian3.fromDegrees(127.2307709030404,38.30766094953704,0),
                                new Cesium.Cartesian3.fromDegrees(127.2307129312598,38.30761404927847,0),
                                new Cesium.Cartesian3.fromDegrees(127.2307961818665,38.30754751404307,0),
                                new Cesium.Cartesian3.fromDegrees(127.2308291670661,38.30756893168915,0)]
                    ,
                    width : 5,
                    material : new Cesium.PolylineOutlineMaterialProperty({
                        color : Cesium.Color.DIMGRAY.withAlpha(0.3),
                        outlineWidth : 2,
                        outlineColor : Cesium.Color.BLACK
                    })
                }
            });
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

</style>
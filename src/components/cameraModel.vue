<template>

</template>

<script>
export default {
    data() {
        return {

        }
    },
    mounted() {
        flytoCamera()
    },
    methods: {
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
        handleSelect(key, keyPath) {
            console.log(key, keyPath);
        }
    }
}
</script>

<style scoped>

</style>


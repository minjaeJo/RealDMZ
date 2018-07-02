<template>
    <el-menu :default-active="activeIndex2" class="camera" mode="horizontal" @select="handleSelect" background-color="#545c64" text-color="#fff" active-text-color="#ffd04b">
        <el-menu-item index="1">Processing Center</el-menu-item>
        <el-submenu index="2">
            <template slot="title">Workspace</template>
            <el-menu-item index="2-1">item one</el-menu-item>
            <el-menu-item index="2-2">item two</el-menu-item>
            <el-menu-item index="2-3">item three</el-menu-item>
            <el-submenu index="2-4">
            <template slot="title">item four</template>
            <el-menu-item index="2-4-1">item one</el-menu-item>
            <el-menu-item index="2-4-2">item two</el-menu-item>
            <el-menu-item index="2-4-3">item three</el-menu-item>
            </el-submenu>
        </el-submenu>
        <el-menu-item index="3" disabled>Info</el-menu-item>
        <el-menu-item index="4"><a href="https://www.ele.me" target="_blank">Orders</a></el-menu-item>
    </el-menu>
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


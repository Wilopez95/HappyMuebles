<template>
  <div id="app">
    <HeaderComponet/>
  </div>
</template>

<script>

import HeaderComponet from './components/HeaderComponet'


export default {
  name: 'App',
  components: {
    HeaderComponet
  }
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  margin: 0px;
  color: #2c3e50;
}
</style>

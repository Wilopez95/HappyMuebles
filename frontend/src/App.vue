<template>
  <div id="app">
    <HeaderComponet/>
    <FornituresComponet/>
    <FooterComponet/>
  </div>
</template>

<script>
import HeaderComponet from './components/HeaderComponet';
import FornituresComponet from './components/FornituresComponet';
import LoginComponent from './components/LoginComponent';
import RegisterComponent from './components/RegisterComponent';
import FooterComponet from './components/FooterComponet';

export default {
  name: 'App',
  components: {
    HeaderComponet,
    FornituresComponet,
    LoginComponent,
    RegisterComponent,
    FooterComponet
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

@media screen and (min-width: 620px){
  
}

@media screen and (min-width: 920px){
  
}

@media screen and (min-width: 1200px){
  
}

</style>

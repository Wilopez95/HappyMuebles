<template>
  <div class="home-component">

    <div class="jumbotron jumbotron-fluid">
        <div class="container">
            <img
            src="../assets/logo.png"
            name="aboutme"
            width="140"
            height="110"
            border="0"
            class="avatar"
          >
          <h3 class="display-5 "><span style="color:#789022">Happy-Muebles</span></h3>
          <p class="lead">Tu tienda de muebles en línea</p>
        </div>
    </div>
    <nav aria-label="breadcrumb">
      <ol class="breadcrumb">
        <li class="breadcrumb-item active" aria-current="page">Nuestros mejores productos</li>
        <li class="ml-auto" aria-current="page"><router-link to="/products">Mostrar todo</router-link></li>
      </ol>
      
    </nav>
    <BestProducts></BestProducts>
    <!--
    <nav aria-label="breadcrumb">
      <ol class="breadcrumb">
        <li class="breadcrumb-item active " aria-current="page">Our Top Products</li>
        <li class="ml-auto" aria-current="page"><router-link to="/products">Show All</router-link></li>
      </ol>
    </nav>
    <TopProducts></TopProducts>-->
  </div>
</template>

<script>
// @ is an alias to /src
import HelloWorld from "@/components/HelloWorld.vue";
import BestProducts from "@/components/products/BestProducts.vue";
import TopProducts from "@/components/products/TopProducts.vue";
export default {
  name: "home",
  components: {
    HelloWorld,
    BestProducts,
    TopProducts
  }
};
</script>
<style>
.jumbotron {
  padding: 1rem 0rem;
  background-color: #e4b582;
}
</style>

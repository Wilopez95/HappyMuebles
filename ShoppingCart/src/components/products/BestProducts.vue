<template>
  <div class="best-products">
    <div class="row">
      <!--<card-loader :loopCount="4" v-if="loading"/>-->
      <!--<div class="col-md-3" v-for="(item, index) in bestProducts" :key="index">-->
      <div class="col-md-3" v-for="forniture in bestProducts" v-bind:key="forniture">
        <!--<card-template :item="item"/>-->
            <div class="card mb-4 shadow-sm">
              <img
                class="card-img-top mt-2"
                v-bind:src="forniture.item.productImage"
                alt="Card image cap"
                style="max-height: 700px; max-width: 127.135px;margin: auto"
              >
              <div class="card-body">
                <h6 class="card-text">{{forniture.item.productName}}.</h6>
                <p class="card-text">{{forniture.item.productDescription}}.</p>
                <div class="d-flex justify-content-between align-items-center">
                  <div class="btn-group">
                    <button
                      type="button"
                      class="btn btn-sm btn-outline-secondary"
                      v-on:click="navigateProductDetail(item)"
                    >View</button>
                    
                    <button
                      type="button"
                      class="btn btn-sm btn-outline-secondary"
                      v-on:click="updateEditProduct(item, item._id)"
                      v-if="loggedUser && loggedUser.isAdmin"
                    >Edit</button>
                  </div>
                  <small class="text-muted footerIcons">
                    <a href="javascript:;;" class="p-2">
                      <i class="fa fa-heart"></i>
                    </a>
                    <a href="javascript:;;" class="p-2" v-on:click="addToCart(item)">
                      <i class="fa fa-shopping-cart"></i>
                    </a>
                  </small>
                </div>
              </div>
            </div>
      </div>
    </div>
    <edit-product ref="editProduct"/>
  </div>
</template>

<script>
import axios from "axios";
import { errorToaster } from "../shared/service/ErrorHandler";
import CardLoader from "../shared/CardLoader";
import CardTemplate from "../shared/CardTemplate";
import EditProduct from "./actions/EditProduct";
export default {
  name: "BestProducts",
  components: { CardLoader, CardTemplate, EditProduct },
  data() {
    return {
      bestProducts: [
        {item: {
          _id: '5bd44827429e8654fc8e5a4c',
          productName : 'Juego de comedor',
          productPrice: '25,95' ,
          productCategory: 'Comedor',
          productImage: 'https://gollo-prod-grupounicomer.netdna-ssl.com/media/catalog/product/cache/7fab98186e03fe46f2659b9ea1ab996a/4/1/4101050060asdd.jpg',
          productSeller : 'Aplle',
          productRating: 5,
          isBestProduct : true,
          isTopProduct : true,
          productDescription: 'sdasdasdasdas'
        }},
        {item: {
          productName : 'Mini Bar',
          productPrice: '25,95' ,
          productCategory: 'Comedor',
          productImage:'https://gollo-prod-grupounicomer.netdna-ssl.com/media/catalog/product/cache/7fab98186e03fe46f2659b9ea1ab996a/b/a/bar-new-drink_01.jpg',
          productSeller : 'Aplle',
          productRating: 5,
          isBestProduct : true,
          isTopProduct : true,
          productDescription: 'sdasdasdasdas'
        }},
        {item: {
          productName : 'Escritorio',
          productPrice: '25,95' ,
          productCategory: 'Comedor',
          productImage:'https://gollo-prod-grupounicomer.netdna-ssl.com/media/catalog/product/cache/7fab98186e03fe46f2659b9ea1ab996a/1/-/1-az1023_nogal_branco_fi_3.jpg',
          productSeller : 'Aplle',
          productRating: 5,
          isBestProduct : true,
          isTopProduct : true,
          productDescription: 'sdasdasdasdas'
        }},
        {item: {
          productName : 'Cama individual',
          productPrice: '25,95' ,
          productCategory: 'Comedor',
          productImage:'https://gollo-prod-grupounicomer.netdna-ssl.com/media/catalog/product/cache/7fab98186e03fe46f2659b9ea1ab996a/c/a/cama_nicole_jpg.jpg',
          productSeller : 'Aplle',
          productRating: 5,
          isBestProduct : true,
          isTopProduct : true,
          productDescription: 'sdasdasdasdas'
        }},
      ],
      loading: true
    };
  },
  /*
  methods: {
    //manadatory function called from cardTemplate
    editProduct(product) {
      this.$refs.editProduct.setProduct(product);
    },

    getBestProducts() {
      this.loading = true;
      axios
        .get(`${process.env.VUE_APP_BASE_URL}/best/products`)
        .then(response => {
          this.loading = false;
          this.bestProducts = response.data;
        })
        .catch(error => {
          console.log(error);
          errorToaster(
            "The server encountered an unexpected condition.",
            "Internal Error 500"
          );
        });
    }
  },
  created() {
    this.getBestProducts();
  }*/
}
</script>

<style>
.best-products {
  margin-bottom: 10px;
}
</style>

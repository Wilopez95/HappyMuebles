<template>
    <div class="BodyConteiner">
        <ul>
            <li v-for="forniture in fornitures" v-bind:key="forniture">
                <h1>{{forniture.forniture.name}}</h1>
                <img src="https://via.placeholder.com/175" alt="">
                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et
                dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip 
                ex ea commodo consequat</p>
            </li>
        </ul>
    </div>
    
</template>


<script>

    import FornitureComponet from './FornitureComponent'
    export default {
        components: {
            FornitureComponet
        },
        data(){
            return{
                fornitures: [
                    {forniture: {
                        name:'test1',
                        description:'test2',
                        imgurl:'testurl'
                    }},
                    {forniture: {
                        name:'test2',
                        description:'test2',
                        imgurl:'testurl'
                    }}

                ]
            }
        }
    }
</script>


<style>
    .BodyConteiner {
        
        height: 1000px;
    }

</style>
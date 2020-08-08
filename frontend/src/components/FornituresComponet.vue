<template>
    <div class="BodyConteiner">
        <ul>
            <li v-for="forniture in fornitures" v-bind:key="forniture">
                <FornitureComponet/>
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
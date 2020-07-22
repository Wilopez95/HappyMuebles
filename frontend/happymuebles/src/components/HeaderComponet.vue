<template>
    <div class="header">
        <img src="../assets/logo.png">
        <NavbarComponet/>

        
    </div>

</template>

<script>
    import NavbarComponet from './NavbarComponet'

export default {
    name: 'HeaderComponet',
    components: {
    NavbarComponet
  }
}
    
</script>

<style>
.header{
    background: #A97E51;
}
    
</style>
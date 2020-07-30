<template>
    <div class="grid-container">
        <div class="logo">
            <img src="../assets/logo.png">
        </div>
        <div class="user">
            <LoginComponet/>
        </div>
        <div class="card">
            <CardComponet/>
        </div>
        <div class="navbar">
            <NavbarComponet/>
        </div>   
    </div>
    

</template>

<script>
    import NavbarComponet from './NavbarComponet'
    import LoginComponet from './LoginComponent'
    import CardComponet from './CardComponent'

export default {
    name: 'HeaderComponet',
    components: {
    NavbarComponet,
    LoginComponet,
    CardComponet
  }
}
    
</script>

<style>

@media screen and (min-width: 620px){
    .grid-container {
        background: #A97E51;
        display: grid;
        grid-template-columns: 50% 50% 
    }
    .logo {
        align-self: center;
        grid-column: 1 / span 2;
        grid-row: 1;
    }
    .user {
        margin-top: 15px;
        grid-column: 1 / span 1;
        grid-row: 2; 
    }
    .card {
        margin-top: 15px;
        grid-column: 2 / span 1;
        grid-row: 2; 
    }

    img {
        display: block;
        margin: auto;
    
    }
       
  
}


@media screen and (min-width: 1200px){
    .grid-container {
        background: #A97E51;
        display: grid;
        grid-template-columns: 85% 5% 10%;
    }

    .logo {
        grid-column: 1;
        grid-row: 1;
    }

    .user {
       grid-column: 2;
        grid-row: 1; 
    }

    .card {
       grid-column: 3;
        grid-row: 1; 
    }

    .navbar {
       grid-column: 1 / span 3;
        grid-row: 2; 
    }

    img {
        display: block;
        margin: 0;
    
    }

    



}


    
</style>
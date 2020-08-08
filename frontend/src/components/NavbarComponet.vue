<template>
    <div class="navbar">
        <ul class='navbar_conteiner'>
            <li class='navbar_item'><a href=#>Armarios</a></li>
            <li class='navbar_item'><a href=#>Alacenas</a></li>
            <li class='navbar_item'><a href=#>Camas</a></li>
            <li class='navbar_item'><a href=#>Escritorios</a></li>
            <li class='navbar_item'><a href=#>Librerias</a></li>
            <li class='navbar_item'><a href=#>Comodas</a></li>
            <li class='navbar_item'><a href=#>Otros</a></li>
        </ul>
    </div>
</template>

<script>
</script>


<style>
@media screen and (min-width: 620px){
}

@media screen and (min-width: 1200px){
    .navbar_conteiner {
    display: grid;
    grid-template-columns: repeat(7,1fr);
    list-style-type: none;
    overflow: hidden;
    background: #554330;
    margin: 0;
    padding: 0;
    height: 30px;
}

.navbar_item a {
    display: block;
    color: white;
    text-decoration: none;
    height: 30px;  
}

a{
    margin-top: 5px;
    text-align: center;
    font-family: Georgia, 'Times New Roman', Times, serif;
}


.navbar_item:hover {
    color: white;
    background-color: #e5d80e;
}
}



    
</style>
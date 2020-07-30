<template>
    <div class="navbar">
        <ul>
            <li><a href=#>Armarios</a></li>
            <li><a href=#>Alavenas</a></li>
            <li><a href=#>Camas</a></li>
            <li><a href=#>Escritorios</a></li>
            <li><a href=#>Librerias</a></li>
            <li><a href=#>Comodas</a></li>
            <li><a href=#>Otros</a></li>
        </ul>
    </div>
</template>

<script>
</script>


<style>
@media screen and (min-width: 620px){
}

@media screen and (min-width: 1200px){
    ul {
    display: grid;
    grid-template-columns: repeat(7,1fr);
    list-style-type: none;
    overflow: hidden;
    background: #554330;
    margin: 0;
    padding: 0;
    height: 30px;
}

li a {
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


li:hover {
    color: white;
    background-color: #e5d80e;
}
}



    
</style>
import React, { Component } from 'react';
import '../Styles/FornitureView.css';
import axios from 'axios';




class FornitureVie extends Component {
    
    
   

    dispose = () => {
        this.props.toggle();

    }

   
    añadirProducto = function(pProducto,pPrice,pPk){
        if(localStorage.length ===0){
            var ids =[];
            var oldItems = [];
            var totalPrice = Number(0.0);
            oldItems.push(pProducto) ;
            totalPrice += Number(pPrice);
            ids.push(pPk);
            localStorage.setItem('cartList',JSON.stringify(oldItems));
            localStorage.setItem('totalPrice',totalPrice);
            localStorage.setItem('productsID',JSON.stringify(ids))
        }else{
            oldItems = JSON.parse(localStorage.getItem('cartList'));
            totalPrice = Number(localStorage.getItem('totalPrice'));
            ids = JSON.parse(localStorage.getItem('productsID'));
            oldItems.push(pProducto);
            totalPrice += Number(pPrice);
            ids.push(pPk);
            localStorage.setItem('cartList',JSON.stringify(oldItems));
            localStorage.setItem('totalPrice',totalPrice);
            localStorage.setItem('productsID',JSON.stringify(ids));
        }    
    }


    render() {
        return (
            <div className="main_conteiner">
                <div className="col-md-5 offset-md-1 view_content">
                    <h1 className="text-center">{this.props.prod.name}</h1>
                    <img src={this.props.prod.image} className="rounded mx-auto d-block img-sizes" alt=""></img>
                    <p className="text-center">{this.props.prod.description}</p>
                    <p className="text-center">{this.props.prod.price}₡</p>
                    <div className="row">
                        <div className="col-sm text-center">                         
                            <button onClick ={ () =>this.añadirProducto(this.props.prod.name,this.props.prod.price,this.props.prod.pkProducto)} className="btn btn-dark">Añadir al carrito</button>
                        </div>
                        <div className="col-sm text-center">
                            <button className="btn btn-dark"  onClick={this.dispose}>Cerrar</button>
                        </div>
                    </div>
                </div>
            </div>
        );
    }
}

export default FornitureVie;
import React, { Component } from 'react';
import '../Styles/FornitureView.css';
import axios from 'axios';




class FornitureVie extends Component {
    
    state = {
        totalPrice:0
    }


    dispose = () => {
        this.props.toggle();

    }

    getPrice = async function(pProducto){
        const res = await axios.post('http://localhost:3300/api/fornitures/price/get',{
            nombre:pProducto,      
          })
        if(res){
            this.state.totalPrice += res.data[0]
        }

        if(localStorage.length ===0){
            var oldItems = [];
            oldItems.push(pProducto) ;
            localStorage.setItem('cartList',JSON.stringify(oldItems));
        }else{
            oldItems = JSON.parse(localStorage.getItem('cartList'));
            oldItems.push(pProducto);
            localStorage.setItem('cartList',JSON.stringify(oldItems));
        }
    }


    añadirProducto = function(pProducto){
        if(localStorage.length ===0){
            var oldItems = [];
            oldItems.push(pProducto) ;
            localStorage.setItem('cartList',JSON.stringify(oldItems));
        }else{
            oldItems = JSON.parse(localStorage.getItem('cartList'));
            oldItems.push(pProducto);
            localStorage.setItem('cartList',JSON.stringify(oldItems));
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
                            <button onClick ={ () =>this.añadirProducto(this.props.prod.name)} className="btn btn-dark">Añadir al carrito</button>
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
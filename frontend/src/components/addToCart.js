import React, { Component } from 'react'
import { Link } from 'react-router-dom';
import axios from 'axios'

export default class addToCart extends Component {
    cartItems = [];
    cartItems = JSON.parse(localStorage.getItem('cartList'));


    addShoppingList =  async e =>{
        /*e.preventDefault();
        const compra = await axios.post('http://localhost:3300/api/purchase/estado',{estadoCompra:1});
        JSON.parse(localStorage.getItem('productsID')).map(product => {


            const res = await axios.post('http://localhost:3300/api/purchase/addShoppingList/add',{
                producto:product,
                compra:1,
                cantidad:1
            });
            console.log('se añadió a lista de compra')
            
        })*/

    }
   
   
    render() {
        return (
            <div className = "row">
                    <div className = "col-md-4">
                        <div className="card card-body">
                            <h3>Info Compra</h3>
                            <span> 
                                <h4>Precio total: {localStorage.getItem('totalPrice')}</h4>  
                            </span>
                            <h4>Descuento por cupones:</h4>
                            <div>
                                {
                                    localStorage.getItem('idCliente') === null?
                                    <Link to="/login">
                                        Inicie sesión
                                    </Link>
                                    :
                                    <button className="btn btn-dark" onClick={this.addShoppingList}> Realizar Compra</button>
                                }
                            </div>
                        </div>

                    </div>
                    <div className = "col-md-8">
                        <ul className="list-group">
                            {
                                localStorage.getItem('cartList') ===null ?
                                <li>No hay productos seleccionados </li>
                                :
                                JSON.parse(localStorage.getItem('cartList')).map(product => <li className="list-group-item list-group-item-action" key={product._id}>
                                    {product}
                                </li>)
                            }
                        </ul>

                    </div>
            </div>
        )
    }
}

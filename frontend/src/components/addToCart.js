import React, { Component } from 'react'

export default class addToCart extends Component {
    cartItems = [];
    cartItems = JSON.parse(localStorage.getItem('cartList'));

   
    render() {
        return (
            <div className = "row">
                    <div className = "col-md-4">
                        <div className="card card-body">
                            <h3>Info Compra</h3>
                            <h4>Precio total:</h4>
                            <h4>Descuento por cupones:</h4>
                            <div>
                            <button type="button" className="button" >
                                Realizar Compra 
                            </button>
                            </div>
                        </div>

                    </div>
                    <div className = "col-md-8">
                        <ul className="list-group">
                            {
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

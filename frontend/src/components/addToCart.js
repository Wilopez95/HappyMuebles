import React, { Component } from 'react'
import { Link } from 'react-router-dom';
import axios from 'axios'

export default class addToCart extends Component {
    cartItems = [];
    cartItems = JSON.parse(localStorage.getItem('cartList'));

    state ={
        coupons :[],
        id:''
    }
    addShoppingList =  async e =>{
     //aqui deberia hacer el post 
    }

    async componentDidMount() {
        if(localStorage.getItem('idCliente')!==null){
            var prueba = localStorage.getItem('idCliente');
        const res = await axios.post('http://localhost:3300/api/costumer/coupons/get',{
            id:prueba
        });
        this.setState({coupons:res.data})
        console.log(this.state.coupons)
        console.log(prueba)
        }
    }

    selectCoupon = (pPorcentaje)  =>{
        console.log(pPorcentaje)
        localStorage.setItem('Cupon',pPorcentaje)
        window.location.reload(false);
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

                            <h4>Cupones disponibles:</h4>
                            <div className = "col-md">
                                <div className = ""> 
                                    <ul className="list-group">
                                        {       
                                            this.state.coupons.length ===0 ?
                                            <li>No hay cupones disponibles </li>
                                                :
                                             this.state.coupons.map(coupon => <li className="list-group-item list-group-item-action" 
                                             key={coupon._id}
                                             onDoubleClick={() => this.selectCoupon(coupon['Porcentaje'])}>
                                            {coupon['Descripcion']}
                                            </li>)
                                        }
                                    </ul>
                                </div>
                            </div>

                            <div className= "col-md">
                                 hola
                            </div>               

                            <div>
                                 {
                                    localStorage.getItem('Cupon')===null?
                                    <h4>Seleccione un cupon </h4>
                                    :
                                    <div>
                                        <h4>Monto de descuento:{ Number(localStorage.getItem('totalPrice'))*Number(localStorage.getItem('Cupon')) }</h4>
                                        
                                    </div>

                                 }   
                            </div>
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
                                JSON.parse(localStorage.getItem('cartList')).map(product => 
                                <li 
                                    className="list-group-item list-group-item-action" 
                                     key={product._id}
                                     >

                                    {product}
                                </li>)
                            }
                        </ul>

                    </div>
            </div>
        )
    }
}

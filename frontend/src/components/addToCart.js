import React, { Component } from 'react'
import { Link } from 'react-router-dom';
import axios from 'axios'

export default class addToCart extends Component {
    cartItems = [];
    cartItems = JSON.parse(localStorage.getItem('cartList'));

    state ={
        coupons :[],
        id:'',
        metodosPago:[]
    }

    addShoppingList =  async e =>{
        const res = await axios.post('http://localhost:3300/api/purchase')
        this.addListProducs(res.data[0].idCompra)
          
    }

    addListProducs= async (id) => {
        JSON.parse(localStorage.getItem('productsID')).map(
            product => {
                const newIten = {
                    producto: product,
                    compra:id
                }
                console.log(newIten)
                const rep = await axios.post('http://localhost:3300/api/purchase/addShoppingList/add',newIten)
                
            }
        )
    }






    async componentDidMount() {
        if(localStorage.getItem('idCliente')!==null && localStorage.getItem('idCliente') !== 'undefined'){
            var prueba = localStorage.getItem('idCliente');
        const res = await axios.post('http://localhost:3300/api/costumer/coupons/get',{
            id:prueba
        });
        this.setState({coupons:res.data})
        }
        const metodosP = await axios.post('http://localhost:3300/api/purchase/paymentMethods')
        this.setState({metodosPago:metodosP.data})
       // console.log(this.state.metodosPago[1]['pkMetodoPago'])
    }

    selectCoupon = (pPorcentaje)  =>{
        console.log(pPorcentaje)
        localStorage.setItem('Cupon',pPorcentaje)
        window.location.reload(false);
    }
    selectMetodo = (pOpcion)  =>{
        console.log(pOpcion)
        localStorage.setItem('MetodoPago',pOpcion)
        window.location.reload(false);
    }
   
   
    render() {
        return (
            <div className = "row">
                    <div className = "col-md-4">
                        <div className="card card-body">
                            <h3>Información de compra</h3>
                            <span> 
                                <h4>Precio total: {localStorage.getItem('totalPrice')}₡</h4>  
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
                            <h4>Métodos de pago:</h4>
                            <div className= "col-md">
                            <div className = ""> 
                                    <ul className="list-group">
                                        {       
                                            this.state.metodosPago.length ===0 ?
                                            <li>No hay metodos de pago disponibles </li>
                                                :
                                             this.state.metodosPago.map(metodo => <li className="list-group-item list-group-item-action" 
                                             key={metodo._id}
                                             onDoubleClick={() => this.selectMetodo(metodo['pkMetodoPago'])}>
                                            {metodo['Detalle']}
                                            </li>)
                                        }
                                    </ul>
                                </div>
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

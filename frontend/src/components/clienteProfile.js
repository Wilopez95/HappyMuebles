import React, { Component } from 'react'
import { Link } from 'react-router-dom'
import axios from 'axios'
import CalificarCompra from './CalificarCompra'
import UpdateCliente from './UpdateCliente'

export default class clienteProfile extends Component {

    state = {
        compras: [],
        seen: false,
        pkCompra: 0
    }

    viewMore = (pkcompra) => {
        this.setState({
            seen: !this.state.seen,
            pkCompra: pkcompra
        });
    }

    componentDidMount() {
       //this.getClientInfo()
       this.getHistory()
        
    }


    /*async getClientInfo(){
        const res = await axios.get('http://localhost:3300/api/costumer/info/get/'+localStorage.getItem('idCliente') );
        console.log(res)
    }*/

    async getHistory(){

        const res = await axios.get('http://localhost:3300/api/purchase/client/history/'+localStorage.getItem('idCliente') );
        this.setState({ compras: res.data });
        console.log(res.data)
    }



    render() {
        return (
            <div>
                <div>
                    {this.state.seen ? <CalificarCompra toggle={this.viewMore} prod={this.state.pkCompra}/> : null}
                </div>
                <div className="row">
                <div className="col-md-4">
                    <UpdateCliente/>
                </div>
                <div className="col-md-8">
                    <h1 className="text-center">Historial de compras</h1>
                    <ul className="list-group">
                        {
                            this.state.compras.map(compra => <li className="list-group-item list-group-item-action" key={compra.pkCompra}>
                                    <p>IdCompra: {compra.pkCompra}</p>
                                    <p>Fecha compra: {compra.FechaCompra}</p>
                                    <p>Precio de la compra: {compra.MontoTotal}₡</p>
                                    <p>Sucursal de compra: {compra.NombreSucursal}</p>
                                    <p>Metodo de pago:{compra.MetodoPago}</p>
                                    <button className="btn btn-dark" onClick={() => this.viewMore(compra.pkCompra)}>Calificar</button>                              
                            </li>)
                        }
                        
                    </ul>
                    </div>
                </div>
            </div>

            

        )
    }
}
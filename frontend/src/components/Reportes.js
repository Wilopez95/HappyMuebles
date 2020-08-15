import React, { Component } from 'react'
import axios from 'axios'
import CalificarCompra from './CalificarCompra'

export default class RegisterEmployee extends Component {

    state = {
        compras: [],
        sucursal :1,
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
      // this.getHistory()
    }

   async getHistory(idSucursal){

        const res = await axios.get('http://localhost:3300/api/purchase/sucursal/history/'+idSucursal);
        this.setState({ compras: res.data });
        console.log(res.data)
    }
    onChangeSucursal = e => {
        console.log(e.target.value);
        this.setState({
            sucursal:e.target.value
        })

        this.getHistory(e.target.value);
    }


    render() {
        return (
            <div className="row">
            <div className="col-md-4">
                <div className="card card-body">
                    <form onSubmit={this.handleSubmit}>
                        <div className="form-group">
                            <h4 className="text-center">Filtros por Categoria</h4>
                        </div>
                        <div className="form-group">
                            <select value={this.state.value} onChange={this.onChangeSucursal}>
                                <option>Escoga una sucursal</option>
                                <option value="1">Sucursal 1</option>
                                <option value="2">Sucursal 2</option>
                                <option value="3">Sucursal 3</option>
                            </select>
                        </div>
                        <div className="row">
                        </div>
                    </form>
                </div>
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
                            </li>)
                        }
                        
                    </ul>
            </div>
        </div>
        )
    }
}
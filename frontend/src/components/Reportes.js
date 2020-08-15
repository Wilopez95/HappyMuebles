import React, { Component } from 'react'

export default class RegisterEmployee extends Component {
/*
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

 /*  async getHistory(){

        const res = await axios.get('http://localhost:3300/api/purchase/client/history/'+localStorage.getItem('idCliente') );
        this.setState({ compras: res.data });
        console.log(res.data)
    }*/


    render() {
        return (
            <h4>Ventana para consultar reportes(disponible solo para el admin)</h4>
        )
    }
}
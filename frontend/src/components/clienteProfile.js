import React, { Component } from 'react'
import { Link } from 'react-router-dom'
import axios from 'axios'

export default class clienteProfile extends Component {

    componentDidMount() {
       //this.getClientInfo()
       this.getHistory()
        
    }


    async getClientInfo(){
        const res = await axios.get('http://localhost:3300/api/costumer/info/get/'+localStorage.getItem('idCliente') );
        console.log(res)
    }

    async getHistory(){

        const res = await axios.get('http://localhost:3300/api/purchase/client/history/'+localStorage.getItem('idCliente') );
        //this.setState({ fornitures: res.data });
        console.log(res)
    }



    render() {
        return (
            <div>
                <h1>Profile del cliente</h1>
                <Link className="nav-link" to="/updateCliente">
                Modificar Cuenta 
                </Link>
            </div>
          
        )
    }
}
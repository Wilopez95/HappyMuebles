import React, { Component } from 'react'
import { Link } from 'react-router-dom'
import axios from 'axios'

export default class clienteProfile extends Component {

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
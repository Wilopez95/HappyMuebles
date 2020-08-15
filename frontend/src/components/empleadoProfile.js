import React, { Component } from 'react'
import { Link } from 'react-router-dom'
import axios from 'axios'

export default class empleadoProfile extends Component {

    render() {
        return (
            <div>
                <h1>Profile del empleado</h1>
                <Link className="nav-link" to="/updateEmpleado">
                    Modificar Cuenta
                </Link>
            </div>
        )
    }
}
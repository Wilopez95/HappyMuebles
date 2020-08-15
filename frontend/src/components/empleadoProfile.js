import React, { Component } from 'react'
import { Link } from 'react-router-dom'
import axios from 'axios'
import updateEmpleado from './updateEmpleado'


export default class empleadoProfile extends Component {

    render() {
        return (
            <div className="row">
                <div className="col-md-4">
                    <updateEmpleado/>
                </div>
                <div className="col-md-8">
                <h1 className="text-center">Historial de Ventas</h1>
                </div>
            </div>
        )
    }
}
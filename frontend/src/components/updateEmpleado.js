import React, { Component } from 'react'
import axios from 'axios'

export default class updateEmpleado extends Component {

    state = {
        username: ''
    }

    componentDidMount() {
        //this.getClientInfo()  
     }

    async getClientInfo(){
        const res = await axios.get('http://localhost:3300/api/costumer/info/get/'+localStorage.getItem('idCliente') );
        console.log(res)
    }

    render() {
        return (
            <div className="card cord-body">
                <h1 className="text-center">Actualizar perfil</h1>
                <form>
                        <div className="form-group">
                            <input type="text" className="form-control" placeholder="Nombre"/>
                        </div>
                        <div className="form-group">
                            <input type="text" className="form-control" placeholder="Tipo de Empleado"/>
                        </div>
                        <div className="form-group">
                            <input type="date" className="form-control" placeholder="Fecha de Contratacion"/>
                        </div>
                        <div className="form-group">
                            <input type="text" className="form-control" placeholder="Enlace de Foto"/>
                        </div>
                        <div className="form-group">
                            <input type="text" className="form-control" placeholder="Correo"/>
                        </div>
                        <div className="form-group">
                        <input type="password" className="form-control" placeholder="Contraseña"/>
                        </div>
                        <button className="btn btn-dark">Actualizar</button>
                   
                </form>
            </div>
            
        )
    }
}
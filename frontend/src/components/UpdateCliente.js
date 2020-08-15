import React, { Component } from 'react'
import axios from 'axios'

export default class UpdateCliente extends Component {

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
                            <input type="date" className="form-control" placeholder="Fecha de nacimiento"/>
                        </div>
                        <div className="form-group">
                            <input type="text" className="form-control" placeholder="Ubicacion"/>
                        </div>
                        <div className="form-group">
                            <input type="text" className="form-control" placeholder="Coreo"/>
                        </div>
                        <div className="form-group">
                        <input type="password" className="form-control" placeholder="Contraseña"/>
                        </div>

                        
                        <div className="form-group">
                            <p>¿Desea recibir información?</p>
                            <input type="checkbox"></input>
                        </div>
                        
                        <button className="btn btn-dark">Actualizar</button>
                   
                </form>
            </div>
            
        )
    }
}
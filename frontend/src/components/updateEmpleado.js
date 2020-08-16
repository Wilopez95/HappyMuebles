import React, { Component } from 'react'
import axios from 'axios'

export default class UpdateEmpleado extends Component {

    state = {
        tipoEmpleado: null,
        name: null,
        date: null,
        photo: null,
        email: null,
        password: null
    }

    componentDidMount() {
        //this.getClientInfo()  
     }

    async getClientInfo(){
        //const res = await axios.get('http://localhost:3300/api/costumer/info/get/'+localStorage.getItem('idCliente') );
        //console.log(res)
    }

    submit= async(e) => {
        e.preventDefault();
        var idEmpleado = localStorage.getItem('idEmpleado');
        console.log(idEmpleado)
        const newCal = {
            id:idEmpleado,
            tipoEmpleado: this.state.tipoEmpleado,
            name: this.state.name,
            date: this.state.date,
            photo:this.state.photo,
            email:this.state.email,
            password:this.state.password
        }
        const res = await axios.post('http://localhost:3300/api/account/updateEmpleado',newCal)
        console.log(newCal)
        console.log(res)
    }

    onInputChange = e => {
        this.setState({
            [e.target.name]: e.target.value
        })
    }

    render() {
        return (
            <div className="card cord-body">
                <h1 className="text-center">Actualizar perfil</h1>
                <form onSubmit={this.submit}>
                        <div className="form-group">
                            <input name="name" type="text" className="form-control" placeholder="Nombre" onChange={this.onInputChange}/>
                        </div>
                        <div className="form-group">
                            <input name="tipoEmpleado" type="text" className="form-control" placeholder="Tipo de Empleado" onChange={this.onInputChange}/>
                        </div>
                        <div className="form-group">
                            <input name="date" type="date" className="form-control" placeholder="Fecha de Contratacion" onChange={this.onInputChange}/>
                        </div>
                        <div className="form-group">
                            <input name="photo" type="text" className="form-control" placeholder="Enlace de Foto" onChange={this.onInputChange}/>
                        </div>
                        <div className="form-group">
                            <input name="email" type="text" className="form-control" placeholder="Correo" onChange={this.onInputChange}/>
                        </div>
                        <div className="form-group">
                        <input name="password" type="password" className="form-control" placeholder="Contraseña" onChange={this.onInputChange}/>
                        </div>
                        <button className="btn btn-dark">Actualizar</button>
                </form>
            </div>
            
        )
    }
}
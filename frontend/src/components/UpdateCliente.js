import React, { Component } from 'react'
import axios from 'axios'

export default class UpdateCliente extends Component {

    state = {
        name: null,
        birthdate: null,
        location:null,
        email:null,
        password:null,
        info:null
    }

    componentDidMount() {
        //this.getClientInfo()  
     }

    async getClientInfo(){
        const res = await axios.get('http://localhost:3300/api/costumer/info/get/'+localStorage.getItem('idCliente') );
        console.log(res)
    }

    submit= async(e) => {
        e.preventDefault();
        var idCliente = localStorage.getItem('idCliente');

        const newCal = {
            id:idCliente,
            name: this.state.name,
            birthdate: this.state.birthdate,
            location:this.state.location,
            email:this.state.email,
            password:this.state.password,
            info:this.state.info
        }
        const res = await axios.post('http://localhost:3300/api/account/updateCliente',newCal)
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
                            <input name="name"  type="text" className="form-control" placeholder="Nombre"  onChange={this.onInputChange}/>
                        </div>
                        <div className="form-group">
                            <input name="birthdate" type="date" className="form-control" placeholder="Fecha de nacimiento" onChange={this.onInputChange}/>
                        </div>
                        <div className="form-group">
                            <input name="location"  type="text" className="form-control" placeholder="Ubicacion" onChange={this.onInputChange}/>
                        </div>
                        <div className="form-group">
                            <input name="email"  type="text" className="form-control" placeholder="Email" onChange={this.onInputChange}/>
                        </div>
                        <div className="form-group">
                        <input name="password"  type="password" className="form-control" placeholder="Contraseña" onChange={this.onInputChange}/>
                        </div>

                        
                        <div className="form-group">
                            <p>¿Desea recibir información?</p>
                            <input name="info"  type="checkbox" onChange={this.onInputChange}></input>
                        </div>
                        
                        <button className="btn btn-dark">Actualizar</button>
                   
                </form>
            </div>
            
        )
    }
}
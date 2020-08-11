import React, { Component } from 'react'
import DatePicker from "react-datepicker";
import "react-datepicker/dist/react-datepicker.css";
import axios from 'axios'

export default class RegisterAccount extends Component {
    state = {
        startDate: new Date(),
        isChecked: false,
        info : '',
        username: '',
        email: '',
        password: '',
        ubicacion: '',
        fechaProvisional: ''


      };

      handleChecked = this.handleChecked.bind(this);
     
      handleChange = date => {
        this.setState({
          startDate: date,
        });
        console.log()
      };

      

      handleChecked () {
        this.setState({isChecked: !this.state.isChecked});
      }
    
    async componentDidMount() {
        const res = await axios.get('http://localhost:3300/api/fornitures/');
        this.setState({ fornitures: res.data });
    }


    onChangeUsername = (e) => {
        this.setState({
            username: e.target.value,
        })
        console.log(e.target.value)
    }
    onChangeEmail= (e) => {
        this.setState({
            email: e.target.value
        })
        console.log(e.target.value)
    }
    onChangePassword= (e) => {
        this.setState({
            password: e.target.value
        })
        console.log(e.target.value)
    }
    onChangeUbicacion= (e) => {
        this.setState({
            ubicacion: e.target.value
        })
        console.log(e.target.value)
    }
    onChangeFecha = (e) => {
        this.setState({
            fechaProvisional: e.target.value
        })
        console.log(e.target.value)
    }
    onChangeInfo = (e) => {
        this.setState({
            info: e.target.value
        })
        console.log(e.target.value)
    }


    onSubmit =  async e => {
        e.preventDefault();
        const res = await axios.post('http://localhost:3300/api/account/register/cliente',{
            email : this.state.email,
            password : this.state.password,
            info : this.setState.info,
            name : this.state.username,
            birthdate : this.state.fechaProvisional,
            location : this.state.ubicacion
        });
        console.log(res)
    }

    render() {
        return (
            <div className="col-md-6 offset-md-3 mt-5 mb-5">
            <div className="card card-body">
                <h4 className="text-center">Registrar Cliente</h4>
                <form onSubmit = {this.onSubmit}>
                    <div className="form-group">
                        <input
                            type="text"
                            className="form-control"
                            name="username"
                            placeholder="Nombre Usuario"
                            required="required"
                            onChange={this.onChangeUsername}
                        />			
                    </div>
                    <div className="form-group">
                        <input
                            type="text"
                            className="form-control"
                            name="email"
                            placeholder="Email"
                            required="required"
                            onChange = {this.onChangeEmail}
                        />
                    </div>
                    <div className="form-group">
                        <input
                            type="password"
                            className="form-control"
                            name="password"
                            placeholder="Password"
                            required="required"
                            onChange = {this.onChangePassword}
                        />
                    </div>
                    <div className="form-group">
                        <span>Fecha Cumpleaños: </span>
                        <DatePicker
                            selected={this.state.startDate}
                            onChange={this.handleChange}
                        />
                    </div>
                    <div className="form-group">
                        <span>Recibir informacion: </span>
                        <div>
                            <input type="checkbox" 
                            selected={this.state.isChecked}
                            onChange={ this.handleChecked }
                            />
                        </div>
                    </div>
                    <div className="form-group">
                        <input
                            type="text"
                            className="form-control"
                            name="ubicacion"
                            placeholder="Ubicacion Cliente"
                            required="required"
                            onChange = {this.onChangeUbicacion}
                        />
                    </div>
                    <div className="form-group">
                        <input
                            type="text"
                            className="form-control"
                            name="ubicacion"
                            placeholder="fecha"
                            required="required"
                            onChange = {this.onChangeFecha}
                        />
                    </div>
                    <div className="form-group">
                        <input
                            type="text"
                            className="form-control"
                            name="ubicacion"
                            placeholder="Enviar info"
                            required="required"
                            onChange = {this.onChangeInfo}
                        />
                    </div>
                    <button type="submit" className="btn btn-primary">
                         Registrar
                     </button>
                </form>
                
            </div>
            <div className="modal-footer">
                     ¿Nuevo en Happy Muebles? 
             </div>  
        </div>
        )
    }
}

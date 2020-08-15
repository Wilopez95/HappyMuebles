import React, { Component } from 'react'
import DatePicker from "react-datepicker";
import "react-datepicker/dist/react-datepicker.css";
import axios from 'axios'

export default class RegisterEmployee extends Component {


    state = {
        startDate: new Date(),
        isChecked: false,
        foto : '',
        name: '',
        email: '',
        password: '',
        fechaContratacion: ''


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
        if(this.state.isChecked){
            this.setState({info : 1})
        }
        else{
            this.setState({info : 2}) 
        }
      }
    
    async componentDidMount() {
        const res = await axios.get('http://localhost:3300/api/fornitures/');
        this.setState({ fornitures: res.data });
    }


    onChangeName = (e) => {
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
    onChangeFecha = (e) => {
        this.setState({
            fechaProvisional: e.target.value
        })
        console.log(e.target.value)
    }
    onChangeFoto = (e) => {
        this.setState({
            info: e.target.value
        })
        console.log(e.target.value)
    }


    onSubmit =  async e => {
        e.preventDefault();
        //ese endpoint hay que cambiarlo
        const res = await axios.post('http://localhost:3300/api/account/register/empleado',{
            email: this.state.email,
            password:this.state.password,
            foto: this.state.foto,
            name: this.state.name,
            date: this.state.fechaContratacion
        })
        console.log(res)
    }

    








    render(){
        return(
            <div className="col-md-6 offset-md-3 mt-5 mb-5">
            <div className="card card-body">
                <h4 className="text-center">Registrar Empleado</h4>
                <form onSubmit = {this.onSubmit}>
                    <div className="form-group">
                        <input
                            type="text"
                            className="form-control"
                            name="username"
                            placeholder="Nombre"
                            required="required"
                            onChange={this.onChangeName}
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
                        <span>Fecha Contratacion: </span>
                        <DatePicker
                            selected={this.state.startDate}
                            onChange={this.handleChange}
                        />
                    </div>
                    <div className="form-group">
                        <input
                            type="text"
                            className="form-control"
                            name="Foto"
                            placeholder="Foto"
                            required="required"
                            onChange = {this.onChangeFoto}
                        />
                    </div>
                    <div className="row">
                        <div className="col text-center">
                            <button type="submit" className="btn btn-primary">
                                Registrar
                            </button>
                        </div>
                    </div>

                </form>
                
            </div>
        </div>
        )
    }

}
import React, { Component } from 'react'
import { Link } from 'react-router-dom'
/*import logo from '../assets/logo.png'*/
import axios from 'axios'

export default class Login extends Component {

    
    state = {
        email: '',
        pass: ''
      };


      onChangeEmail= (e) => {
        this.setState({
            email: e.target.value
        })
        console.log(e.target.value)
    }

    onChangePassword= (e) => {
        this.setState({
            pass: e.target.value
        })
        console.log(e.target.value)
    }
      onSubmit =  async e => {
        e.preventDefault();
        const res = await axios.post('http://localhost:3300/api/account/login',{
          email:this.state.email,
          pass:this.state.pass
            
        })
        console.log(res)
        if(res.data !== ""){
            localStorage.setItem('idEmpleado',res.data[0].pkEmpleado)
            localStorage.setItem('idCliente',res.data[0].pkCliente)
        }else{
            console.log('no se puede logear')
        }

        window.location.href = "/"
    }

    render() {
        return (
           <div className="col-md-6 offset-md-3 mt-5 mb-5">
               <div className="card card-body">
                   <h4 className="text-center">Iniciar sesion</h4>
                    <div className="form-group">
                        <input type="text" className="form-control" name="username" placeholder="Email" required="required" onChange={this.onChangeEmail}/>			
                    </div>
                    <div className="form-group">
                        <input type="password" className="form-control" name="password" placeholder="Password" required="required"  onChange = {this.onChangePassword} />
                    </div>
                   <form onSubmit={this.onSubmit}>
                        <button type="submit" className="btn btn-dark">
                            Acceder
                        </button>
                   </form>
                   
               </div>
               <div className="modal-footer">
				        ¿Nuevo en Happy Muebles? 
                        <Link to="/register">
                        Registrate
                        </Link>
			    </div>  
           </div>
        )
    }
}

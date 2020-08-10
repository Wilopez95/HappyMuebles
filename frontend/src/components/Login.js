import React, { Component } from 'react'
import { Link } from 'react-router-dom'
import logo from '../assets/logo.png'

export default class Login extends Component {

    onSubmit=(e) =>{
        e.preventDefault()
    }

    render() {
        return (
           <div className="col-md-6 offset-md-3 mt-5 mb-5">
               <div className="card card-body">
                   <h4 className="text-center">Iniciar sesion</h4>
                    <div className="form-group">
                        <input type="text" class="form-control" name="username" placeholder="Username" required="required"/>			
                    </div>
                    <duv className="form-group">
                        <input type="password" class="form-control" name="password" placeholder="Password" required="required"/>
                    </duv>
                   <form onSubmit={this.onSubmit}>
                        <button type="submit" className="btn btn-dark">
                            Acceder
                        </button>
                   </form>
                   
               </div>
               <div className="modal-footer">
				        ¿Nuevo en Happy Muebles? 
                        <Link to="/">
                        Registrate
                        </Link>
			    </div>  
           </div>
        )
    }
}

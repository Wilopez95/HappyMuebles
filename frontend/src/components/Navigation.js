import React, { Component } from 'react';
import { Link } from 'react-router-dom'
import { Redirect } from 'react-router';

class Navigation extends Component {

    refreshPage() {
        localStorage.clear()
        window.location.href = "/"
      }

    render() {
        return (
            <nav className="navbar navbar-expand-lg navbar-dark bg-dark">
                <div className="container">
                    <Link className="navbar-brand" to="/">
                        Happy Muebles
                    </Link>
                    <button className="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                        <span className="navbar-toggler-icon"></span>
                    </button>
                    <div className="collapse navbar-collapse" id="navbarNav">
                        <ul className="navbar-nav ml-auto">
                            <li className="nav-item active">
                                <Link className="nav-link" to="">
                                    Home<span className="sr-only">(current)</span>
                                </Link>
                            </li>
                            <li className="nav-item">
                                <Link className="nav-link" to="/categories">
                                    Muebles
                                </Link>
                            </li>
                            <li className="nav-item">
                                {

                                   ( localStorage.getItem('idEmpleado') !== 'undefined' && localStorage.getItem('idEmpleado') !== null) ?
                                   <Link className="nav-link" to="/profileEmpleado">
                                   Perfil
                                  </Link>
                                   :
                                    
                                   ( localStorage.getItem('idCliente') !== 'undefined' && localStorage.getItem('idCliente') !== null) ?
                                    <Link className="nav-link" to="/profileCliente">
                                    Perfil
                                    </Link>
                                    :
                                   <Link className="nav-link" to="/login">
                                   Iniciar Sesión
                                  </Link>
                                }
                            </li>
                            <li>
                                {
                                   ( localStorage.getItem('idEmpleado') !== 'undefined' && localStorage.getItem('idEmpleado') !== null) ?
                                   <Link className="nav-link" to="/registerEmp">
                                   Registrar Empleado
                                   </Link>
                                   :
                                     <Link className="nav-link" to="/cart">
                                     Carrito
                                     </Link>

                                }
                            </li>
                            <li>
                            {
                                   ( localStorage.getItem('idEmpleado') !== 'undefined' && localStorage.getItem('idEmpleado') !== null) ?
                                   <Link className="nav-link" to="/reports">
                                   Reportes
                                   </Link>
                                   :
                                <div></div>

                                }

                            </li>
                            <li>
                                <button className="btn btn-dark" type="button"  onClick={this.refreshPage}>
                                    Salir
                                </button>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
        );
    }
}

export default Navigation;
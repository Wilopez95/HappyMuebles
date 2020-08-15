import React from 'react';
import {BrowserRouter as Router, Route} from 'react-router-dom'
import 'bootstrap/dist/css/bootstrap.min.css'
import './App.css';


import Navigation from './components/Navigation'
import Fornitures from './components/FornituresHomeList'
import Login from './components/Login'
import RegisterAcc from './components/RegisterAccount'
import Footer from './components/Footer'
import Categories from './components/Categories'
import addToCart from './components/addToCart'
import RegisterEmployee from './components/RegisterEmployee'
import Reportes from './components/Reportes'
import updateCliente from './components/UpdateCliente'
import clienteProfile from './components/clienteProfile'
import empleadoProfile from './components/empleadoProfile'
import updateEmpleado from './components/updateEmpleado'


function App() {
  return (
    <Router>
      <Navigation/>
      <div className="container p-4">
        <Route path="/" exact component={Fornitures} />
        <Route path="/login" component={Login} />
        <Route path="/register" component={RegisterAcc} />
        <Route path="/categories" component={Categories} />
        <Route path="/cart" component={addToCart}/>
        <Route path= "/registerEmp" component={RegisterEmployee}/>
        <Route path="/reports" component={Reportes}/>
        <Route path='/updateCliente' component={updateCliente}/>
        <Route path='/profileCliente' component={clienteProfile}/>
        <Route path='/profileEmpleado' component={empleadoProfile}/>
        <Route path='/updateEmpleado' component={updateEmpleado}/>
      </div>
      <Footer/>
    </Router>
  );
}

export default App;

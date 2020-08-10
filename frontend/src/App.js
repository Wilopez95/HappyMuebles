import React from 'react';
import {BrowserRouter as Router, Route} from 'react-router-dom'
import 'bootstrap/dist/css/bootstrap.min.css'
import './App.css';


import Navigation from './components/Navigation'
import Fornitures from './components/FornituresHomeList'
import Login from './components/Login'
import RegisterAcc from './components/RegisterAccount'
import Footer from './components/Footer'

function App() {
  return (
    <Router>
      <Navigation/>
      <div className="container p-4">
        <Route path="/" exact component={Fornitures} />
        <Route path="/login" component={Login} />
        <Route path="/register" component={RegisterAcc} />
        <Route path="/updateacc/:id" component={RegisterAcc} />
      </div>
      <Footer/>
    </Router>
  );
}

export default App;

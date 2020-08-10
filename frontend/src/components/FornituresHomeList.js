import React, { Component } from 'react'
import axios from 'axios'

export default class FornituresHomeList extends Component {

    state = {
        fornitures: []
    }

    async componentDidMount(){

        const res = await axios.get('http://localhost:3300/api/fornitures/');
        this.setState({fornitures: res.data});
        
    }

    viewMore =(id) => {
        console.log(id);
    }

    render() {
        return (
            <div className="row">
                {
                    this.state.fornitures.map(forniture => (
                        <div className="col-md-4 p-2" key={forniture.pkProducto}>
                            <div className="card">
                                <div className="card-body">
                                    <h1 className="text-center">{forniture.Nombre}</h1>      
                                    <img src={forniture.Foto} className="rounded mx-auto d-block"  alt=""></img>
                                    <p className="text-center">{forniture.Descripcion}</p>
                                    
                                    <div className="row">
                                        <div className="col-sm">
                                            <p className="text-center">{forniture.Precio}₡</p>
                                        </div>
                                        <div className="col-sm">
                                            <button className="btn btn-dark" onClick={()=> this.viewMore(forniture.pkProducto)}>Ver mas</button>
                                        </div>
                                        

                                    </div>
                                    
                                </div>
                            </div>
                        </div>
                    ))
                }
                
            </div>
        )
    }
}

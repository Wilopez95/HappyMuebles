import React, { Component } from 'react';
import '../Styles/FornitureView.css';




class FornitureVie extends Component {

    state = {
    }


    dispose = () => {
        this.props.toggle();

    }



    render() {
        return (
            <div className="main_conteiner">
                <div className="col-md-5 offset-md-1 view_content">
                    <h1 className="text-center">{this.props.prod.name}</h1>
                    <img src={this.props.prod.image} className="rounded mx-auto d-block img-sizes" alt=""></img>
                    <p className="text-center">{this.props.prod.description}</p>
                    <p className="text-center">₡{this.props.prod.price}</p>
                    <div className="row">
                        <div className="col-sm text-center">                         
                            <button className="btn btn-dark">Añadir al carrito</button>
                        </div>
                        <div className="col-sm text-center">
                            <button className="btn btn-dark" onClick={this.dispose}>Cerrar</button>
                        </div>
                    </div>
                </div>
            </div>
        );
    }
}

export default FornitureVie;
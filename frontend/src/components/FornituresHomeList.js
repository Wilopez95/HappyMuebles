import React, { Component } from 'react'
import FornitureVie from "./FornitureVie"
import axios from 'axios'
import '../Styles/FornituresStyles.css';

export default class FornituresHomeList extends Component {

    state = {
        fornitures: [],
        seen: false,
        product: {
            name: 'Juan',
            description: 'descripcion',
            image: 'image',
            type: 'type',
            price: 'price'
        }
    }

    async componentDidMount() {

        const res = await axios.get('http://localhost:3300/api/fornitures/');
        this.setState({ fornitures: res.data });

    }

    viewMore = (name,description,photo,detail,price) => {
        this.setState({
            product: {
                name: name,
                description: description,
                image: photo,
                type: detail,
                price: price
                
            }
        })
        this.setState({
            seen: !this.state.seen
        });
    };

    render() {
        return (
            <div>
                <div>
                    {this.state.seen ? <FornitureVie toggle={this.viewMore} prod={this.state.product}/> : null}
                </div>
                <div className="row">
                    {
                        this.state.fornitures.map(forniture => (
                            <div className="col-md-4 p-2" key={forniture.pkProducto}>
                                <div className="card">
                                    <div className="card-body">
                                        <h5 className="text-center">{forniture.Nombre}</h5>
                                        <img src={forniture.Foto} className="rounded mx-auto d-block img-sizes" alt=""></img>
                                        <p className="text-center">{forniture.Descripcion}</p>

                                        <div className="row">
                                            <div className="col-sm">
                                                <p className="text-center">{forniture.Precio}₡</p>
                                            </div>
                                            <div className="col-sm">
                                                <button className="btn btn-dark" onClick={() => this.viewMore(
                                                    forniture.Nombre,
                                                    forniture.Descripcion,
                                                    forniture.Foto,
                                                    forniture.Detalle,
                                                    forniture.Precio
                                                    )}>Ver mas</button>
                                            </div>


                                        </div>

                                    </div>
                                </div>
                            </div>
                        ))
                    }

                </div>

            </div>

        )
    }
}



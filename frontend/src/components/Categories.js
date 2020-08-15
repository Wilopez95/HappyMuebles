import React, { Component } from 'react'
import FornitureVie from "./FornitureVie"
import axios from 'axios'
import '../Styles/FornituresStyles.css';

export default class FornituresHomeList extends Component {

    state = {
        fornitures: [],
        Category: 1,
        seen: false,
        product: {
            name: 'Juan',
            description: 'descripcion',
            image: 'image',
            type: 'type',
            price: 'price'
        }
    }

    componentDidMount() {
        this.getData(1);

    }

    async getData(id) {
        const res = await axios.get('http://localhost:3300/api/fornitures/category/'+id);
        this.setState({ fornitures: res.data });
    }

    onChangeCategory = e => {
        console.log(e.target.value);
        this.setState({
            Category:e.target.value
        })

        this.getData(e.target.value);
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
        
        <div className="row">
            <div className="col-md-4">
                <div className="card card-body">
                    <form onSubmit={this.handleSubmit}>
                        <div className="form-group">
                            <h4 className="text-center">Filtros por Categoria</h4>
                        </div>
                        <div className="form-group">
                            <select value={this.state.value} onChange={this.onChangeCategory}>
                                <option value="1">Armario</option>
                                <option value="2">Alacena</option>
                                <option value="3">Cama</option>
                                <option value="4">Escritorio</option>
                                <option value="5">Libreria</option>
                                <option value="6">Comoda</option>
                                <option value="7">Comedor</option>
                                <option value="8">Mueble Cocina</option>
                                <option value="9">Terraza</option>
                                <option value="10">Oficina</option>
                            </select>
                        </div>
                        <div className="row">
                        </div>
                    </form>
                </div>
            </div>
            <div className="col-md-8">
            <div className="card-body">
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
                                        <img src={forniture.Foto} className="rounded mx-auto d-block img-sizes2" alt=""></img>
                                        <p className="text-center">{forniture.Descripcion}</p>

                                        <div className="row">
                                            <div className="col-sm">
                                                <p className="text-center">₡{forniture.Precio}</p>
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
            </div>
        </div>
        )
    }
}
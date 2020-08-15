import React, { Component } from 'react';
import '../Styles/CalificarCompra.css';
import axios from 'axios';


class CalificarCompra extends Component {

    state = {
        calificacion: {
            sercivio: '',
            producto: '',
            entrega: '',
            comentario: ''
        }
    }

    dispose = () => {
        this.props.toggle();
 
    }

    componentDidCatch(){

    }




     submit= async(e) => {
        e.preventDefault();
        const newCal = {
            id:this.props.prod,
            servicio: this.state.sercivio,
            producto: this.state.producto,
            entrega: this.state.entrega,
            comentario: this.state.comentario
        }
        const res = await axios.post('http://localhost:3300/api/purchase/calificaction',newCal)
        console.log(res)
    }

    onInputChange = e => {
        this.setState({
            [e.target.name]: e.target.value
        })
    }



    render() {
        return (
            
            <div className="col-md-5 offset-md-1 view_content">
                <h1>{this.props.prod}</h1>
                <h1 className="text-center">Calificar compra</h1>
                <form onSubmit={this.submit}>
                    <div className="form-group">
                        <input name="servicio" type="number" className="form-control" placeholder="Servicio" onChange={this.onInputChange}/>
                    </div>
                    <div className="form-group">
                        <input name="producto" type="number" className="form-control" placeholder="Producto" onChange={this.onInputChange}/>
                    </div>
                    <div className="form-group"> 
                        <input name="entrega" type="number" className="form-control" placeholder="Entrega" onChange={this.onInputChange}/>
                    </div>
                    <div className="form-group">
                        <textarea name="comentario" id="" cols="77"  placeholder="Comentario" onChange={this.onInputChange}></textarea>
                    </div>
                    <div className="row">
                        <div className="col-sm text-center">
                                <button className="btn btn-dark">Calificar</button>
                        </div>
                        <div className="col-sm text-center">
                         <button className="btn btn-dark"  onClick={this.dispose}>Cerrar</button>
                        </div>
                    </div>                 
                        
                    
                </form>
                
            </div>
        );
    }

}

export default CalificarCompra;
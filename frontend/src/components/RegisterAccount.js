import React, { Component } from 'react'
import DatePicker from "react-datepicker";
import "react-datepicker/dist/react-datepicker.css";

export default class RegisterAccount extends Component {
    state = {
        startDate: new Date(),
        isChecked: false
      };

      handleChecked = this.handleChecked.bind(this);
     
      handleChange = date => {
        this.setState({
          startDate: date,
        });
      };

      

      handleChecked () {
        this.setState({isChecked: !this.state.isChecked});
      }
    

    render() {
        return (
            <div className="col-md-6 offset-md-3 mt-5 mb-5">
            <div className="card card-body">
                <h4 className="text-center">Registrar Cliente</h4>
                 <div className="form-group">
                     <input type="text" class="form-control" name="username" placeholder="Nombre Usuario" required="required"/>			
                 </div>
                 <div className="form-group">
                     <input type="text" className="form-control" name="email" placeholder="Email" required="required"/>
                 </div>
                 <div className="form-group">
                     <input type="password" className="form-control" name="password" placeholder="Password" required="required"/>
                 </div>
                 <div className="form-group">
                     <span>Fecha Cumpleaños: </span>
                    <DatePicker
                        selected={this.state.startDate}
                        onChange={this.handleChange}
                    />
                 </div>
                 <div className="form-group">
                     <span>Recibir informacion: </span>
                     <div>
                        <input type="checkbox" 
                        selected={this.state.isChecked}
                        onChange={ this.handleChecked }
                        />
                    </div>
                 </div>
                 <div className="form-group">
                     <input type="text" className="form-control" name="ubicacion" placeholder="Ubicacion Cliente" required="required"/>
                 </div>
                <form>
                     <button type="submit" className="btn btn-dark">
                         Registrar
                     </button>
                </form>
                
            </div>
            <div className="modal-footer">
                     ¿Nuevo en Happy Muebles? 
             </div>  
        </div>
        )
    }
}

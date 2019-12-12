import React, {Component} from 'react';

export class RacketListView extends Component {
    constructor(props) {
        super(props);
        this.state = {
            name: '',
            manufacturer: '',
            release_year: ''
        };

        this.handleChange = this.handleChange.bind(this);
        this.handleSubmit = this.handleSubmit.bind(this);
    }
    componentWillMount() {
        this.props.getRacketList()
    }

    handleChange(event) {
        this.setState({
            [event.target.name]: event.target.value
        });
    }

    handleSubmit(event) {
        event.preventDefault();

        if (RegExp(/\w+/).test(this.state.name) && RegExp(/\w+/).test(this.state.manufacturer) && RegExp(/\d{4}/).test(this.state.release_year)) {

            this.props.registerNewRacket(this.state.name, this.state.manufacturer, this.state.release_year)
            this.state = {
                name: '',
                manufacturer: '',
                release_year: ''
            };

        } else {
            if (!RegExp(/\w+/).test(this.state.name)) {
                alert('Ungültiger Name (keine Sonderzeichen!)');
            }
            if (!RegExp(/\w+/).test(this.state.manufacturer)) {
                alert('Ungültiger Hersteller (keine Sonderzeichen!)');
            }
            if (!RegExp(/\d{4}/).test(this.state.release_year)) {
                alert('Im Feld des Erscheinungsjahrs muss ein gültiges Jahr bestehend aus 4 Ziffern eingeben werden.');
            }
        }
    }

    getItems() {
        if (this.props.rackets) {
            return this.props.rackets;
        }
        return [];
    }

    render() {
        return (
            <section className="main">
              <div>
                <p>Liste aller Schläger in der Datenbank</p>
                <label>
                  <b>Hersteller
                  </b>
                </label>
                < label >
                <b>Modellname
                </b>
                < /label>
                <label>
                  <b>Erscheinungsjahr</b>
                </label>
                < ul className="todo-list">
                {this.getItems().map(item => <li key={item.get('id')}>
                  <div>
                    <label>{item.get('manufacturer')}
                      -
                    </label>
                    <label>{item.get('name')}
                      -
                    </label>
                    <label>{item.get('release_year')}</label>
                  </div>
                </li>)
                }
                < /ul>
                <br></br>
                <p>Neuen Schläger hinzufügen:</p>
                <form onSubmit={this.handleSubmit}>
                  <label>
                    Name:
                    <input type="text" name='name' value={this.state.name} onChange={this.handleChange}/>
                  </label>
                  < label >
                  Hersteller :
                  <input type="text" name='manufacturer' value={this.state.manufacturer} onChange={this.handleChange}/>
                  < /label>
                  <label>
                    Erscheinungsjahr:
                    <input type="text" name='release_year' value={this.state.release_year} onChange={this.handleChange}/></label>
                  < input type="submit" value="Submit"/>
                </form>
              </div>
            </section>
          )
        }
      }
export default RacketListView

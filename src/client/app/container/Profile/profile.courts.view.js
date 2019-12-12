import React, { Component } from "react";

export class RacketListView extends Component {
  constructor(props) {
    super(props);
    this.state = {
      courts: []
    };
  }

  componentWillMount() {
    this.props.getCourtsStatus();
  }

  getItems() {
    if (this.props.courts) {
      return this.props.courts;
    }
    return [];
  }

  render() {
    return (
      <section className="main">
        <ul className="courtlist">
          {this.getItems().map(item => (
            <li key={item.get("id")}>
              <div>
                <label>
                  {item.get("court_no")}
                  -
                </label>
                <label>
                  {item.get("court_type")}
                  -
                </label>
                <label>
                  {item.get("court_surface")}
                  -
                </label>
                <label>{item.get("court_status_name")}</label>
              </div>
            </li>
          ))}
        </ul>
      </section>
    );
  }
}
export default RacketListView;

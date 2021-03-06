import React, { Component } from "react";
import _ from "lodash";

export class CourtsView extends Component {
  constructor(props) {
    super(props);
    this.state = {
      courtTypes: ["Freiplatz", "Halle"],
      courtSummary: {},
      courtStatusList: [
        { court_status_list_id: 1, court_status_name: "dummy1" },
        { court_status_list_id: 2, court_status_name: "dummy2" }
      ]
    };
  }

  componentDidMount() {
    this.props.getCourtsStatus();
    this.props.getCourtStatusList();
  }

  getCourts(courtType) {
    var clay = this.state.courtTypes[0];
    var carpet = this.state.courtTypes[1];

    if (this.props.courts) {
      if (_.isEqual(courtType, clay)) {
        // filter only the courts with surface equal clay
        return _.filter(this.props.courts, function(value, key) {
          if (_.isEqual(value.court_type, clay)) {
            return value;
          }
        });
      } else {
        // filter only the courts with surface equal carpet
        return _.filter(this.props.courts, function(value, key) {
          if (_.isEqual(value.court_type, carpet)) {
            return value;
          }
        });
      }
    }
    this.setState({
      courtSummary: this.getCourtsSummary()
    });
    return [];
  }

  getCourtsSummary() {
    if (this.props.courts) {
      return _.reduce(
        this.props.courts,
        function(result, value, key) {
          if (!_.has(result, value.court_type)) {
            result[value.court_type] = {};
          }
          if (!_.has(result[value.court_type], value.court_status_name)) {
            result[value.court_type][value.court_status_name] = 0;
          }
          if (!_.has(result[value.court_type], "sum")) {
            result[value.court_type].sum = 0;
          }
          result[value.court_type][value.court_status_name] =
            result[value.court_type][value.court_status_name] + 1;
          result[value.court_type].sum = result[value.court_type].sum + 1;
          return result;
        },
        {}
      );
    }
  }

  handleCourtUpdate = (
    courtId,
    courtStatusListId,
    courtStatusName,
    personNumber
  ) => {
    this.props.setCourtsStatus(
      courtId,
      courtStatusListId,
      courtStatusName,
      personNumber
    );
  };

  render() {
    return (
      <section className="main">
        <h2>Plätze</h2>
        {_.map(this.getCourtsSummary(), (value, key) => {
          return (
            <p key={key}>
              {key}: {value.Bespielbar}/{value.sum}
            </p>
          );
        })}
        {this.state.courtTypes.map(type => {
          return (
            <div key={type}>
              <h3>{type}</h3>
              <ul className="courtlist">
                {this.getCourts(type).map(court => {
                  return (
                    <li key={court.court_id}>
                      <CourtCard
                        courtNumber={court.court_no}
                        courtType={court.court_type}
                        courtSurface={court.court_surface}
                        courtStatusName={court.court_status_name}
                      />
                      {this.props.courtStatusList.map(status => {
                        return (
                          <a
                            key={status.court_status_list_id}
                            onClick={() => {
                              if (
                                !_.isEqual(
                                  court.court_status_name,
                                  status.court_status_name
                                )
                              ) {
                                this.handleCourtUpdate(
                                  court.court_id,
                                  status.court_status_list_id,
                                  status.court_status_name,
                                  this.props.profile.personNumber
                                );
                              }
                            }}
                          >
                            {" "}
                            {status.court_status_name}
                          </a>
                        );
                      })}
                    </li>
                  );
                })}
              </ul>
            </div>
          );
        })}
      </section>
    );
  }
}
export default CourtsView;

function CourtCard({ courtNumber, courtType, courtSurface, courtStatusName }) {
  return (
    <div>
      <label>
        {courtNumber}
        -
      </label>
      <label>
        {courtType}
        -
      </label>
      <label>
        {courtSurface}
        -
      </label>
      <label>{courtStatusName}</label>
    </div>
  );
}

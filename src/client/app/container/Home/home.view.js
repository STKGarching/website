import React, {Component} from 'react';
import ReactQuill from 'react-quill';
import 'react-quill/dist/quill.snow.css';

export class HomeView extends Component {
    constructor(props) {
      super(props)
      this.state = {blogItems: [{id: 0, text: '<h1>erster Eintrag</h1>', editable: true, theme: 'bubble'}]} // You can also pass a Quill Delta here
      //this.handleChange = (id) => (event) => this.handleChange(id).bind(this)
      this.AddBlogItem = this.AddBlogItem.bind(this)
    }

    handleChange(id,value)  {
      var bI = this.state.blogItems
      console.log(id)
      console.log(value)
      console.log(bI[id])
      bI[id].text = value
      this.setState({ blogItems: bI })
    }

    AddBlogItem() {
      
      var item = {id: this.state.blogItems.length, text: '<h1>zweiter Eintrag</h1>', editable: false, theme: 'snow'}
      var bI = this.state.blogItems
      bI.push(item)
      console.log(item)
      console.log(bI)
      this.setState({ blogItems: bI })
    }

    handleReadOnly = (id) => {
      var bI = this.state.blogItems
      bI[id].editable = !bI[id].editable 
      /*
      this.setState({ editable: !this.state.editable })
      if (this.state.theme == 'snow') {
        this.setState({ theme: 'bubble' })
      } else {
        this.setState({ theme: 'snow' })
      }
      */
     if (bI[id].theme == 'snow') {
        bI[id].theme = 'bubble'
      } else {
        bI[id].theme = 'snow' 
      }
      this.setState({ blogItems: bI })
    }
    getProfile() {
        return this.props.authentication.getIn(['profile','nickname'])
    }

    render() {
        return (
            <div>
              <h1>
                Willkommen auf der Website des STK Garching!
              </h1>
              {this.props.authentication.get('isAuthenticated') && (
                <div>
                  <p>Hallo <b>{this.getProfile()}</b></p>
                  <button onClick={this.AddBlogItem}>Hinzufügen</button>
                  <br></br>
                  {this.state.blogItems.map(item => {
                    console.log(item.id)
                    return(
                      <BlogItem 
                        key={item.id}
                        text={item.text}
                        editable={item.editable}
                        theme={item.theme}
                        handleChange={this.handleChange.bind(this,item.id)}
                        handleReadOnly={() => this.handleReadOnly(item.id)}/>
                    )
                  })}
                </div>
              )
              }
              {!this.props.authentication.get('isAuthenticated') && (
                <p>Du musst dich einloggen um dein Profil sehen zu können.
                </p>
              )
              }

            </div>

        )
    }

}
export default HomeView;

function BlogItem({
  text,
  editable,
  theme,
  handleChange,
  handleReadOnly
}) {
  return(
    <div>
      <button onClick={handleReadOnly}>Bearbeiten</button>
      <ReactQuill value={text} readOnly={editable} theme={theme} onChange={handleChange} />
    </div>
  )
}


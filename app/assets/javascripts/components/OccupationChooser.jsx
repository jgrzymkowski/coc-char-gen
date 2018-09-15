class OccupationChooser extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      occupation: null,
      occupationOptions: []
    }
  }

  render() {
    return (
      <div className="grid-x grid-padding-x align-center">
        <div className="cell small-12">
          {this._renderHiddenInputs()}
          <fieldset className="fieldset">
            <legend>Choose Occupation</legend>
            <div className="grid-x grid-margin-x align-center">
              <div className="cell small-12 medium-4">
                {this._renderOccupationSelect()}
              </div>
              <div className="cell small-12 medium-4"> </div>
              <div className="cell small-12 medium-4"> </div>
            </div>
            { this.state.occupation ? this._renderOccupation() : this._renderInstructions() }
          </fieldset>
        </div>
      </div>
    )
  }

  _renderInstructions() {
    return (
      <div className="callout secondary">
        First, choose your occupation. This should align with your "profession" (chosen previously). Each occupation has a set of skills associated with it.  Some professions also provide optional skills.
      </div>
    )
  }

  _renderOccupation() {
    const { occupation, occupationOptions } = this.state
    return (
      <div className="grid-x grid-margin-x align-center">
        <div className="cell small-12 medium-4">
          <table>
            <tbody>
              <tr><td><strong>Description: </strong></td></tr>
              <tr><td>{occupation.description}</td></tr>
              <tr><td><strong>Reccomended Stats: </strong></td></tr>
              <tr><td>{occupation.recommended_stats}</td></tr>
              <tr><td><strong>Number of Bonds: </strong>{ occupation.bonds }</td></tr>
            </tbody>
          </table>
        </div>
        <div className="cell small-12 medium-4">
          <strong>Included Skills: </strong>
          {_.map(_.get(occupation, 'skills') || [], (skill) => {
            return <div key={skill.id} className="occupation-skill selected">{skill.skill} + {skill.percentage}%</div>
            })}
          </div>
          <div className="cell small-12 medium-4">
            <strong>Optional Skills: </strong> Choose {occupation.choose}
            {_.map(_.get(occupation, 'options') || [], (skill) => {
              return (
                <div
                  key={skill.id}
                  onClick={(e) => this._onClickOption(skill.id)}
                  className={`occupation-skill selectable ${_.includes(occupationOptions, skill.id) ? 'selected' : ''}`} >
                  {skill.skill} + {skill.percentage}%
                </div>
                )
            })}
          </div>
        </div>
    )
  }

  _onClickOption(skillId) {
    const { occupation, occupationOptions } = this.state
    let newOptions
    if(_.includes(occupationOptions, skillId)) {
      newOptions = _.without(occupationOptions, skillId)
    } else {
      newOptions = _.clone(occupationOptions)
      newOptions.push(skillId)
      if(newOptions.length > occupation.choose) {
        newOptions.shift()
      }
    }
    this.setState({ occupationOptions: newOptions }, () => {
      this.props.setOccupationOptions(_.map(newOptions, (skillId) => {
        return _.find(occupation.options, { id: skillId })
      }))
    })
  }

  _renderOccupationSelect() {
    return (
      <select onChange={e => this._onChangeOccupation(e)}>
        <option>---Choose Occupation---</option>
        {_.map(this.props.occupationSkills, (occSkill) => {
          return <option key={occSkill.id} value={occSkill.id}>{occSkill.name}</option>
          })}
        </select>
    )
  }

  _onChangeOccupation(event) {
    const occupation = Dg.OccupationSkills[event.target.value]
    this.props.setOccupation(occupation)
    this.setState({ occupation, occupationOptions: [] })
  }

  _renderHiddenInputs() {
    const { occupation, occupationOptions } = this.state
    return (
      <div>
        <input
          type="hidden"
          name="dg_skill_set[occupation_options]"
          id="dg_skill_set_occupation_options"
          value={occupationOptions || ''} />
        <input
          type="hidden"
          name="dg_skill_set[occupation]"
          id="dg_skill_set_occupation"
          value={_.get(occupation, 'id') || ''} />
      </div>
    )
  }
}

OccupationChooser.propTypes = {
  occupationSkills: PropTypes.object,
  setOccupation: PropTypes.func,
  setOccupationOptions: PropTypes.func
}

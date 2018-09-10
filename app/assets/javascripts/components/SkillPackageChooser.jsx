class SkillPackageChooser extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      skillPackage: null
    }
  }

  render() {
    return (
      <div className="grid-x grid-padding-x align-center">
        {this._renderHiddenInputs()}
        <div className="cell small-12">
          <fieldset className="fieldset">
            <legend>Choose Skill Package</legend>
            <div className="grid-x grid-margin-x align-center">
              <div className="cell small-12 medium-4">
                {this._renderSkillPackageSelect()}
              </div>
              <div className="cell small-12 medium-4"> </div>
              <div className="cell small-12 medium-4"> </div>
            </div>
            { this.state.skillPackage ? this._renderSkillPackage() : this._renderInstructions() }
          </fieldset>
        </div>
      </div>
    )
  }

  _renderSkillPackageSelect() {
    return (
      <select onChange={e => this._onChangeSkillPackage(e)}>
        <option>---Choose Skill Package---</option>
        {_.map(this.props.skillPackages, (skillPackage) => {
          return <option key={skillPackage.id} value={skillPackage.id}>{skillPackage.label}</option>
          })}
        </select>
    )
  }

  _onChangeSkillPackage(event) {
    const { skillPackages, setSkillPackage } = this.props
    const skillPackage = skillPackages[event.target.value]
    setSkillPackage(skillPackage)
    this.setState({ skillPackage })
  }

  _renderInstructions() {
    return (
      <div className="callout secondary">
        Then, choose your bonus skill package. These are additional skills that are not necessarily associated with your occupation. These skills might have come from a prior career or personal hobby.
      </div>
    )
  }

  _renderSkillPackage() {
    const { skillPackage } = this.state
    return (
      <div className="grid-x grid-margin-x align-center">
        <div className="cell small-12 medium-4"> </div>
        <div className="cell small-12 medium-4">
          <strong>Included Skills: </strong>
          {_.map(_.get(skillPackage, 'skills') || [], (skill, i) => {
            return <div key={skill.id} className="occupation-skill selected">{skill.label} + 20%</div>
            })}
          </div>
          <div className="cell small-12 medium-4"> </div>
        </div>
    )
  }

  _renderHiddenInputs() {
    const { skillPackage } = this.state
    return (
      <div>
        <input
          type="hidden"
          name="dg_skill_set[skill_package]"
          id="dg_skill_set_occupation_skill_package"
          value={_.get(skillPackage, 'id') || ''} />
      </div>
    )
  }
}

SkillPackageChooser.propTypes = {
  skillPackages: PropTypes.object,
  setSkillPackage: PropTypes.func
}

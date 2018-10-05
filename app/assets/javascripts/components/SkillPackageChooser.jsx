class SkillPackageChooser extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      skillPackage: null,
      skillPackageOptions: []
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
    const { skillPackages, setSkillPackage, setSkillPackageOptions } = this.props
    const skillPackage = skillPackages[event.target.value]
    let skillPackageOptions = []
    if(skillPackage) {
      _.times(8 - skillPackage.skills.length, () => skillPackageOptions.push(''))
    }
    setSkillPackage(skillPackage)
    setSkillPackageOptions(skillPackageOptions)
    this.setState({ skillPackage, skillPackageOptions })
  }

  _renderInstructions() {
    return (
      <div className="callout secondary">
        Then, choose your bonus skill package. These are additional skills that are not necessarily associated with your occupation. These skills might have come from a prior career or personal hobby.
      </div>
    )
  }

  _renderSkillPackage() {
    const { skillPackage, skillPackageOptions } = this.state
    return (
      <div className="grid-x grid-margin-x align-center">
        <div className="cell small-12 medium-4"> </div>
        <div className="cell small-12 medium-4">
          <strong>Included Skills: </strong>
          {_.map(_.get(skillPackage, 'skills') || [], (skill, i) => {
            return <div key={skill.id} className="occupation-skill selected">{skill.label} + 20%</div>
          })}
          {_.map(skillPackageOptions, (id, index) => this._renderSkillPackageOption(id, index))}
        </div>
        <div className="cell small-12 medium-4"> </div>
      </div>
    )
  }

  _renderSkillPackageOption(id, index) {
    return (
      <select
        value={id}
        key={index}
        className={`occupation-skill-option ${_.isEmpty(id) ? '' : 'selected'}`}
        onChange={(event) => this._onChangeSkillPackageOption(event, index)}>
        <option key="null" value=''>---Choose Option---</option>
        {_.map(this.props.baseSkills, (skill) => {
          return <option key={skill.id} value={skill.id}>{skill.label}</option>
        })}
      </select>
    )
  }

  _onChangeSkillPackageOption(event, index) {
    const { setSkillPackageOptions } = this.props
    const optionValue = event.target.value
    const skillPackageOptions = _.clone(this.state.skillPackageOptions)
    _.set(skillPackageOptions, index, optionValue)
    this.setState({ skillPackageOptions })
    setSkillPackageOptions(skillPackageOptions)
  }

  _renderHiddenInputs() {
    const { skillPackage, skillPackageOptions } = this.state
    return (
      <div>
        <input
          type="hidden"
          name="dg_skill_set[bonus_skill_package]"
          id="dg_skill_set_bonus_skill_package"
          value={_.get(skillPackage, 'id') || ''} />
        <input
          type="hidden"
          name="dg_skill_set[bonus_skill_package_options]"
          id="dg_skill_set_bonus_skill_package_options"
          value={JSON.stringify(skillPackageOptions)} />
      </div>
    )
  }
}

SkillPackageChooser.propTypes = {
  baseSkills: PropTypes.object,
  skillPackages: PropTypes.object,
  setSkillPackage: PropTypes.func,
  setSkillPackageOptions: PropTypes.func
}

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
      <div className="skill-package-chooser grid-x grid-padding-x align-center">
        <div className="cell small-12">
          <div className="clearfix">
            <div className="float-left">
              <h4>Choose Skill Package</h4>
            </div>
            <div className="float-right">
              <button type="button" className="button" data-close="">Done</button>
            </div>
          </div>
        </div>
        <div className="cell small-12">
        <div className="callout primary">
          What did your Agent do before their current profession? What skills have they
          picked up through hobbies or other experiences? Choose a skill package. Each skill
          will add 20% to your current score (to a maximum of 80%).
        </div>
        </div>
        <div className="cell small-8">
          {this._renderSkillPackageSelect()}
          { this.state.skillPackage ? this._renderSkillPackage() : null }
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

  _renderSkillPackage() {
    const { skillPackage, skillPackageOptions } = this.state
    return (
      <div>
        <strong>Included Skills: </strong>
        {_.map(_.get(skillPackage, 'skills') || [], (skill, i) => {
          return <div key={skill.id} className="occupation-skill selected">{skill.label} + 20%</div>
          })}
          {_.map(skillPackageOptions, (id, index) => this._renderSkillPackageOption(id, index))}
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
}

SkillPackageChooser.propTypes = {
  baseSkills: PropTypes.object,
  skillPackages: PropTypes.object,
  setSkillPackage: PropTypes.func,
  setSkillPackageOptions: PropTypes.func
}

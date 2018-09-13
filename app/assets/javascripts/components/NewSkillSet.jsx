const _findSkills = function(props, state) {
  let skills = []
  _.each(props.baseSkills, (baseSkill) => {
    if(baseSkill.id.match(/_1/)) {
      // art/craft/etc header
      skills.push({
        id: baseSkill.id.split(/_1/)[0],
        label: baseSkill.label.split(/ 1/)[0],
        basePercentage: null,
        additions: [],
      })
    }

    let additions = []
    const occupationSkill = _.find(_.get(state.occupation, 'skills') || [], { id: baseSkill.id })
    if(occupationSkill) {
      additions.push(occupationSkill.percentage)
    }

    const occupationSkillOption = _.find(state.occupationOptions || [], { id: baseSkill.id })
    if(occupationSkillOption) {
      additions.push(occupationSkillOption.percentage)
    }

    const skillPackageSkill = _.find(_.get(state.skillPackage, 'skills') || [], { id: baseSkill.id })
    if(skillPackageSkill) {
      additions.push(20)
    }

    let label = baseSkill.label
    if(baseSkill.id.match(/_\d/)) {
      if(_.isEmpty(additions)) {
        label = ''
      }
    }

    skills.push({
      id: baseSkill.id,
      label,
      basePercentage: baseSkill.base,
      additions,
    })
  })

  return skills
}

class NewSkillSet extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      skills: _findSkills(props, {}),
      occupation: null,
      skillPackage: null
    }
  }

  render() {
    const { occupationSkills, skillPackages } = this.props
    const { skills } = this.state
    return (
      <div className="new-skills">
        <OccupationChooser
          occupationSkills={occupationSkills}
          setOccupation={(occupation) => this._setOccupation(occupation)}
          setOccupationOptions={(occupationOptions) => this._setOccupationOptions(occupationOptions)} />
        <SkillPackageChooser
          skillPackages={skillPackages}
          setSkillPackage={(skillPackage) => this._setSkillPackage(skillPackage)} />
        <SkillTable skills={skills} />
      </div>
    )
  }

  _updateSkills() {
    this.setState({ skills: _findSkills(this.props, this.state) })
  }

  _setOccupation(occupation) {
    this.setState({ occupation }, this._updateSkills)
  }

  _setOccupationOptions(occupationOptions) {
    this.setState({ occupationOptions }, this._updateSkills)
  }

  _setSkillPackage(skillPackage) {
    this.setState({ skillPackage }, this._updateSkills)
  }
}

NewSkillSet.propTypes = {
  baseSkills: PropTypes.object
}

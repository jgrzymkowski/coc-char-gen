const _findSkills = function(props, occupation, skillPackage) {
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
    const occupationSkill = _.find(_.get(occupation, 'skills') || [], { id: baseSkill.id })
    if(occupationSkill) {
      additions.push(occupationSkill.percentage)
    }

    const skillPackageSkill = _.find(_.get(skillPackage, 'skills') || [], { id: baseSkill.id })
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
      skills: _findSkills(props),
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
          setOccupation={(occupation) => this._setOccupation(occupation)} />
        <SkillPackageChooser
          skillPackages={skillPackages}
          setSkillPackage={(skillPackage) => this._setSkillPackage(skillPackage)} />
        <SkillTable skills={skills} />
      </div>
    )
  }

  _setOccupation(occupation) {
    this.setState({
      occupation,
      skills: _findSkills(this.props, occupation, this.state.skillPackage)
    })
  }

  _setSkillPackage(skillPackage) {
    this.setState({
      skillPackage,
      skills: _findSkills(this.props, this.state.occupation, skillPackage)
    })
  }
}

NewSkillSet.propTypes = {
  baseSkills: PropTypes.object
}

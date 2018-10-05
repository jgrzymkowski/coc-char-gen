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

    const skillPackageOption = _.includes(state.skillPackageOptions || [], baseSkill.id)
    if(skillPackageOption) {
      additions.push(20)
    }

    let label = baseSkill.label
    if(baseSkill.id.match(/_\d/)) {
      if(_.isEmpty(additions)) {
        label = ''
      } else if(_.has(state.specifiedSkills, baseSkill.id)) {
        label = _.get(state.specifiedSkills, baseSkill.id, '')
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
      skillPackage: null,
    }
  }

  render() {
    const { baseSkills, occupationSkills, skillPackages, authenticityToken } = this.props
    const { skills, specifiedSkills } = this.state
    return (
      <div className="new-skills">
        <form
          method="post"
          action={`/dg/characters/${this.props.characterId}/skill_sets`} >


          <input
            type="hidden"
            name="authenticity_token"
            value={authenticityToken} />

          <div className="large reveal" id="occupation-modal" data-reveal>
            <OccupationChooser
              occupationSkills={occupationSkills}
              setOccupation={(occupation) => this._setOccupation(occupation)}
              setOccupationOptions={(occupationOptions) => this._setOccupationOptions(occupationOptions)} />
          </div>
          <p>
            <button type="button" className="button" data-open="occupation-modal">
              Select Occupation
            </button>
          </p>

          <div className="large reveal" id="skill-package-modal" data-reveal>
            <SkillPackageChooser
              baseSkills={baseSkills}
              skillPackages={skillPackages}
              setSkillPackage={(skillPackage) => this._setSkillPackage(skillPackage)}
              setSkillPackageOptions={(skillPackageOptions) => this._setSkillPackageOptions(skillPackageOptions)} />
          </div>
          <p>
            <button type="button" className="button" data-open="skill-package-modal">
              Select Skill Package
            </button>
          </p>

          <div className="large reveal" id="specified-skill-modal" data-reveal>
            <SpecifiedSkillChooser
              skills={skills}
              baseSkills={baseSkills}
              specifiedSkills={specifiedSkills}
              setSpecifiedSkills={(specifiedSkills) => this._setSpecifiedSkills(specifiedSkills)}/>
          </div>
          <p>
            <button type="button" className="button" data-open="specified-skill-modal">
              Select Specific Skills
            </button>
          </p>

          {this._renderSumbit()}
          <NewSkillTable skills={skills} />
        </form>
      </div>
    )
  }

  _renderSumbit() {
    return (
      <div className="clearfix">
        <div className="float-right">
          <a className="button secondary" href={`/dg/characters/${this.props.characterId}`}>Cancel</a>
          <button type="submit" className="button">Save</button>
        </div>
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

  _setSkillPackageOptions(skillPackageOptions) {
    this.setState({ skillPackageOptions }, this._updateSkills)
  }

  _setSpecifiedSkills(specifiedSkills) {
    this.setState({ specifiedSkills }, this._updateSkills)
  }
}

NewSkillSet.propTypes = {
  characterId: PropTypes.number,
  baseSkills: PropTypes.object,
  authenticityToken: PropTypes.string
}

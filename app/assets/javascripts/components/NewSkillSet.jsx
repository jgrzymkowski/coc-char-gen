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
    const { skills } = this.state
    return (
      <div className="new-skills">
        <form
          method="post"
          action={`/dg/characters/${this.props.characterId}/skill_sets`} >


          <div className="occupation-chooser grid-x grid-padding-x align-center">
            <div className="cell small-12 medium-3 skill-fields">
              {this._renderHiddenInputs()}

              {this._renderOccupationChooser()}
              {this._renderSkillPackageChooser()}
              {this._renderSpecifiedSkills()}
              {this._renderSumbit()}
            </div>
            <div className="cell small-12 medium-9">
              <NewSkillTable skills={skills} />
            </div>
          </div>
        </form>
      </div>
    )
  }

  _renderOccupationChooser() {
    const { occupationSkills } = this.props
    const { occupation } = this.state
    const chosen = !!occupation
    return (
      <div className="skill-option">
        <div className="large reveal" id="occupation-modal" data-reveal>
          <OccupationChooser
            occupationSkills={occupationSkills}
            setOccupation={(occupation) => this._setOccupation(occupation)}
            setOccupationOptions={(occupationOptions) => this._setOccupationOptions(occupationOptions)} />
        </div>
        <strong>Choose Occupation</strong>
        <div className={`selectable set-skill-option ${chosen ? 'selected' : ''}`} data-open="occupation-modal">
          {chosen ? occupation.name : 'Select Occupation'}
        </div>
      </div>
    )
  }

  _renderSkillPackageChooser() {
    const { baseSkills, skillPackages } = this.props
    const { skillPackage } = this.state
    const chosen = !!skillPackage
    return (
      <div className="skill-option">
        <div className="reveal" id="skill-package-modal" data-reveal>
          <SkillPackageChooser
            baseSkills={baseSkills}
            skillPackages={skillPackages}
            setSkillPackage={(skillPackage) => this._setSkillPackage(skillPackage)}
            setSkillPackageOptions={(skillPackageOptions) => this._setSkillPackageOptions(skillPackageOptions)} />
        </div>
        <strong>Choose Skill Package</strong>
        <div className={`selectable set-skill-option ${chosen ? 'selected' : ''}`} data-open="skill-package-modal">
          {chosen ? skillPackage.label : 'Select Skill Package'}
        </div>
      </div>
    )
  }

  _renderSpecifiedSkills() {
    const { baseSkills } = this.props
    const { skills, occupation, skillPackage, specifiedSkills } = this.state
    const chosen = occupation &&
      skillPackage &&
      !_.isEmpty(specifiedSkills) &&
      _.every(_.values(specifiedSkills), (val) => !_.isEmpty(val))
    return (
      <div className="skill-option">
        <div className="reveal" id="specified-skill-modal" data-reveal>
          <SpecifiedSkillChooser
            skills={skills}
            baseSkills={baseSkills}
            specifiedSkills={specifiedSkills}
            setSpecifiedSkills={(specifiedSkills) => this._setSpecifiedSkills(specifiedSkills)}/>
        </div>
        <strong>Choose Specific Skills</strong>
        <div className={`selectable set-skill-option ${chosen ? 'selected' : ''}`} data-open="specified-skill-modal">
          {chosen ? 'Selected' : 'Select Specific Skills'}
        </div>
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

  _renderHiddenInputs() {
    const { authenticityToken } = this.props
    const { occupation, occupationOptions, skillPackage, skillPackageOptions, specifiedSkills } = this.state
    return (
      <div>
        <input
          type="hidden"
          name="authenticity_token"
          value={authenticityToken} />
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
        <input
          type="hidden"
          name="dg_skill_set[bonus_skill_package]"
          id="dg_skill_set_bonus_skill_package"
          value={_.get(skillPackage, 'id') || ''} />
        <input
          type="hidden"
          name="dg_skill_set[bonus_skill_package_options]"
          id="dg_skill_set_bonus_skill_package_options"
          value={JSON.stringify(skillPackageOptions) || ''} />
      {_.map(specifiedSkills, (value, id) => {
        return (
          <input
            key={id}
            type="hidden"
            name={`dg_skill_set[${id}_text]`}
            id={`dg_skill_set_${id}_text`}
            value={value} />
          )
      })}
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
    if(!_.isEqual(specifiedSkills, this.state.specifiedSkills)) {
      this.setState({ specifiedSkills }, this._updateSkills)
    }
  }
}

NewSkillSet.propTypes = {
  characterId: PropTypes.number,
  baseSkills: PropTypes.object,
  authenticityToken: PropTypes.string
}

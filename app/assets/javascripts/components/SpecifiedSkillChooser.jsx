const _getState = (props) => {
  const emptySkills = _.reduce(props.skills, (mem, skill) => {
    const percentage = _.reduce(skill.additions, (sum, add) => sum + add, skill.basePercentage)
    if(percentage > 0 && skill.id.match(/_\d/)) {
      mem[skill.id] = ''
    }
    return mem
  }, {})
  const filteredSkills = _.pick(props.specifiedSkills, _.keys(emptySkills))
  return { specifiedSkills: _.merge({}, emptySkills, filteredSkills) }
}

class SpecifiedSkillChooser extends React.Component {
  constructor(props) {
    super(props)
    this.state = _getState(props)
  }

  componentWillReceiveProps(newProps) {
    this.setState(_getState(newProps))
  }

  render() {
    const { skills, baseSkills } = this.props
    const { specifiedSkills } = this.state
    if(_.isEmpty(specifiedSkills)) {
      return null
    } else {
      return (
        <div className="grid-x grid-padding-x">
          <div className="cell small-12">
            {this._renderHiddenInputs()}
            <fieldset className="fieldset">
              <legend>Choose Specific Skills</legend>
              <div className="grid-x grid-margin-x">
                <div className="cell small-12 medium-4">
                  {_.map(specifiedSkills, (value, id) => {
                    return (
                      <div key={id}>
                        <label htmlFor={`${id}-input`}>{baseSkills[id].label}</label>
                        <input
                          onChange={this._updateSpecifiedSkill(id)}
                          type="text"
                          id={`${id}-input`}
                          name={`${id}-input`}
                          value={value} />

                      </div>
                      )
                  })}
                </div>
              </div>
            </fieldset>
          </div>
        </div>
      )
    }
  }

  _updateSpecifiedSkill(id) {
    return (event) => {
      let specifiedSkills = _.clone(this.state.specifiedSkills)
      specifiedSkills[id] = event.target.value
      this.props.setSpecifiedSkills(specifiedSkills)
    }
  }

  _renderHiddenInputs() {
    return <div>
      {_.map(this.state.specifiedSkills, (value, id) => {
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
  }
}

NewSkillSet.propTypes = {
  baseSkills: PropTypes.object,
  skills: PropTypes.arrayOf(PropTypes.object),
  specifiedSkills: PropTypes.object,
  setSpecifiedSkills: PropTypes.func
}


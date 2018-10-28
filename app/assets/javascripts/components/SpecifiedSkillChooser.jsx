const _getState = (props) => {
  const emptySkills = _.reduce(props.skills, (mem, skill) => {
    const percentage = _.reduce(skill.additions, (sum, add) => sum + add, skill.basePercentage)
    if(percentage > 0 && skill.id.match(/_\d/)) {
      mem[skill.id] = ''
    }
    return mem
  }, {})
  const filteredSkills = _.pick(props.specifiedSkills, _.keys(emptySkills))
  const specifiedSkills = _.merge({}, emptySkills, filteredSkills)
  props.setSpecifiedSkills(specifiedSkills)
  return { specifiedSkills }
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
    const { specifiedSkills } = this.state
    return (
      <div className="grid-x grid-padding-x">
        <div className="cell small-12">
          <div className="clearfix">
            <div className="float-left">
              <h4>Choose Specified Skills</h4>
            </div>
            <div className="float-right">
              <button type="button" className="button" data-close="">Done</button>
            </div>
          </div>
          {_.isEmpty(specifiedSkills) ?
            this._renderNoSpecifiedSkills() :
            this._renderSpecifiedSkillInputs()}
          </div>
        </div>
    )
  }

  _renderNoSpecifiedSkills() {
    return <div className="callout primary">
      You have no skills to specify
    </div>
  }

  _renderSpecifiedSkillInputs() {
    const { skills, baseSkills } = this.props
    const { specifiedSkills } = this.state
    return (
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
    )
  }

  _updateSpecifiedSkill(id) {
    return (event) => {
      let specifiedSkills = _.clone(this.state.specifiedSkills)
      specifiedSkills[id] = event.target.value
      this.props.setSpecifiedSkills(specifiedSkills)
    }
  }
}

NewSkillSet.propTypes = {
  baseSkills: PropTypes.object,
  skills: PropTypes.arrayOf(PropTypes.object),
  specifiedSkills: PropTypes.object,
  setSpecifiedSkills: PropTypes.func
}

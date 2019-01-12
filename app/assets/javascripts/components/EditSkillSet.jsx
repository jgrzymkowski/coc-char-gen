class EditSkillSet extends React.Component {
  render() {
    const { baseSkills } = this.props
    const tableLength = Math.ceil(baseSkills.length/3)
    return (
      <div className="grid-x grid-padding-x align-center skill-set">
        {this._renderTable(baseSkills.slice(0, tableLength ))}
        {this._renderTable(baseSkills.slice(tableLength, tableLength*2))}
        {this._renderTable(baseSkills.slice(tableLength*2, tableLength*3))}
      </div>
    )
  }

  _renderTable(baseSkills) {
    const { skillSet } = this.props
    return (
      <div className="cell small-12 medium-4 large-4">
        <table>
          <tbody>
            {_.map(baseSkills, (baseSkill) => {
              return (
                <EditSkillTableRow
                  key={baseSkill.id}
                  label={this._skillLabel(baseSkill)}
                  attribute={baseSkill.id}
                  value={skillSet[baseSkill.id]} />
                )
            })}
          </tbody>
        </table>
      </div>
    )
  }

  _skillLabel(skill) {
    if(skill.id.match(/_\d/)) {
      if(skill.percentage == 0 ) {
        return ''
      } else {
        return skill.label
      }
    } else {
      return skill.label
    }
  }
}

EditSkillSet.propTypes = {
  characterId: PropTypes.number,
  authenticityToken: PropTypes.string,
  baseSkills: PropTypes.arrayOf(PropTypes.object),
  skillSet: PropTypes.object
}

class NewSkillTable extends React.Component {
  render() {
    const { skills } = this.props
    const tableLength = Math.ceil(skills.length/3)
    return (
      <div className="grid-x grid-padding-x align-center skill-set">
        {this._renderTable(skills.slice(0, tableLength ))}
        {this._renderTable(skills.slice(tableLength, tableLength*2))}
        {this._renderTable(skills.slice(tableLength*2, tableLength*3))}
      </div>
    )
  }

  _renderTable(skills) {
    return (
      <div className="cell small-12 medium-4 large-4">
        <table>
          <tbody>
            {_.map(skills, (skill) => {
              return (
                <NewSkillTableRow
                  key={skill.id}
                  label={this._skillLabel(skill)}
                  attribute={skill.id}
                  basePercentage={skill.basePercentage}
                  additions={skill.additions} />
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

NewSkillTable.propTypes = {
  skills: PropTypes.arrayOf(PropTypes.object)
}

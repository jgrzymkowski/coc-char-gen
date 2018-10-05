class SkillTable extends React.Component {
  render() {
    const { baseSkills } = this.props
    const skillIds = _.keys(baseSkills)
    const tableLength = Math.ceil(skillIds.length/3)
    return (
      <div className="grid-x grid-padding-x align-center skill-set">
        {this._renderTable(skillIds.slice(0, tableLength ))}
        {this._renderTable(skillIds.slice(tableLength, tableLength*2))}
        {this._renderTable(skillIds.slice(tableLength*2, tableLength*3))}
      </div>
    )
  }

  _renderTable(skillIds) {
    const { skillSet, baseSkills } = this.props
    return (
      <div className="cell small-12 medium-4 large-4">
        <table>
          <tbody>
            {_.map(skillIds, (skillId) => {
              return (
                <tr key={skillId}>
                  <td>
                    {baseSkills[skillId].label}
                  </td>
                  <td>
                    {skillSet[skillId]}%
                  </td>
                </tr>
                )
            })}
          </tbody>
        </table>
      </div>
    )
  }
}

SkillTable.propTypes = {
  skillSet: PropTypes.object,
  baseSkills: PropTypes.object,
}

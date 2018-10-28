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
              const label = (skillId.match(/_\d/) ? _.get(skillSet, `${skillId}_text`) : baseSkills[skillId].label)
              let percentage = skillSet[skillId]
              if(label && !percentage) {
                percentage = 0
              }
              return (
                <tr key={skillId}>
                  <td>
                    {label}&nbsp;
                  </td>
                  <td>
                    {!_.isNil(percentage) ? `${percentage}%` : ''}
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

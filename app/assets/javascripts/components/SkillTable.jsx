class SkillTable extends React.Component {
  render() {
    const { baseSkills, skillSet } = this.props

    const labelAndPercentages = _.compact(_.map(baseSkills, (baseSkill, skillId) => {
      const label = (skillId.match(/_\d/) ? _.get(skillSet, `${skillId}_text`) : baseSkill.label)
      if(_.isEmpty(label)) {
        return null
      }
      let percentage = skillSet[skillId] || 0
      return [label, percentage]
    }))
    const tableLength = Math.ceil(labelAndPercentages.length/3)
    return (
      <div className="grid-x grid-padding-x align-center skill-set">
        {this._renderTable(labelAndPercentages.slice(0, tableLength ))}
        {this._renderTable(labelAndPercentages.slice(tableLength, tableLength*2))}
        {this._renderTable(labelAndPercentages.slice(tableLength*2, tableLength*3))}
      </div>
    )
  }

  _renderTable(labelAndPercentages) {
    return (
      <div className="cell small-12 medium-4 large-4">
        <table>
          <tbody>
            {_.map(labelAndPercentages, (labelAndPercentage) => {
              return (
                <tr key={labelAndPercentage[0]}>
                  <td>
                    {labelAndPercentage[0]}&nbsp;
                  </td>
                  <td>
                    {labelAndPercentage[1]}
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
